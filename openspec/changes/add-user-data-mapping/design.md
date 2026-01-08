# Design: User Data Mapping

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         UI Layer                                │
│  (Widgets watch providers, unaware of userId)                   │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Provider Layer                             │
│  - Watches currentUserProvider                                  │
│  - Passes userId to repositories                                │
│  - moodProvider, activityProvider, gratitudeProvider            │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                     Repository Layer                            │
│  - Receives userId from provider                                │
│  - Passes to data source methods                                │
│  - MoodRepository, ActivityRepository, GratitudeRepository      │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Data Source Layer                            │
│  - Filters queries by user_id                                   │
│  - Includes user_id on insert                                   │
│  - MoodRemoteDataSource, ActivityRemoteDataSource, etc.         │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                     Backend Service                             │
│  - Supabase (cloud) or Hive (local)                            │
│  - Database has user_id columns                                 │
└─────────────────────────────────────────────────────────────────┘
```

## Data Flow

### Authenticated User
1. User logs in → `currentUserProvider` emits `User(id: "uuid-123")`
2. `moodProvider` reads `currentUserProvider.value?.id`
3. Repository calls `dataSource.getMoods(userId: "uuid-123")`
4. Data source queries: `SELECT * FROM moods WHERE user_id = 'uuid-123'`
5. Insert includes: `INSERT INTO moods (..., user_id) VALUES (..., 'uuid-123')`

### Anonymous User (Offline Mode)
1. No login → `currentUserProvider` emits `null`
2. `moodProvider` gets `userId = null`
3. Repository calls `dataSource.getMoods(userId: null)`
4. Data source queries: `SELECT * FROM moods WHERE user_id IS NULL`
5. Insert includes: `INSERT INTO moods (..., user_id) VALUES (..., NULL)`

## Entity Changes

### Before
```dart
class MoodEntry {
  final int id;
  final MoodScore score;
  final String? note;
  final DateTime timestamp;
}
```

### After
```dart
class MoodEntry {
  final int id;
  final String? userId;  // NEW: null for anonymous
  final MoodScore score;
  final String? note;
  final DateTime timestamp;
}
```

## Model Changes

### JSON Mapping
```dart
// toJson
{
  'id': id,
  'user_id': userId,  // snake_case for database
  'score': score,
  ...
}

// fromJson
userId: json['user_id'] as String?,
```

### Hive Mapping
```dart
@HiveField(5)  // New field index
final String? userId;
```

## Repository Interface Changes

### Before
```dart
abstract class MoodRepository {
  Future<List<MoodEntry>> getMoods();
  Future<MoodEntry> addMood({required MoodScore score, String? note});
}
```

### After
```dart
abstract class MoodRepository {
  Future<List<MoodEntry>> getMoods({String? userId});
  Future<MoodEntry> addMood({
    required MoodScore score,
    String? note,
    String? userId,
  });
}
```

## Provider Integration

```dart
@riverpod
Future<List<MoodEntry>> moods(Ref ref) async {
  final user = ref.watch(currentUserProvider).valueOrNull;
  final repository = ref.watch(moodRepositoryProvider);
  return repository.getMoods(userId: user?.id);
}
```

## Backward Compatibility

- Existing local data has `userId = null`
- Anonymous users continue to see their existing data
- When user logs in, they see only their cloud data
- Local anonymous data remains accessible when logged out

## Trade-offs

| Approach | Pros | Cons |
|----------|------|------|
| Filter at data source | Clean separation, DB-level filtering | More parameters to pass |
| Filter at repository | Simpler data source | Business logic in wrong layer |
| Filter at provider | Minimal changes | Too much logic in provider |

**Decision:** Filter at data source layer for clean separation and DB-level optimization.
