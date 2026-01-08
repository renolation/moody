# Design: Integrate Supabase Backend

## Architecture Decision

### The Problem

Currently, remote data sources directly depend on Hive:

```dart
class MoodRemoteDataSourceImpl implements MoodRemoteDataSource {
  Box<MoodEntryModel> get _box => Hive.box<MoodEntryModel>(boxName);
  // Tightly coupled to Hive
}
```

This makes it impossible to swap backends without rewriting every data source.

### The Solution: Backend Service Abstraction

Introduce a `BackendService` interface that abstracts all database operations:

```
RemoteDataSource → BackendService (abstract) → SupabaseService / HiveService
```

This follows the **Dependency Inversion Principle** - high-level modules don't depend on low-level modules; both depend on abstractions.

---

## Core Services Structure

```
lib/core/services/
├── backend_service.dart           # Abstract interface
├── supabase_service.dart          # Supabase implementation
├── hive_backend_service.dart      # Hive implementation (offline)
└── backend_service_provider.dart  # Riverpod provider for DI
```

---

## BackendService Interface

```dart
abstract class BackendService {
  /// Get all records from a table
  Future<List<Map<String, dynamic>>> getAll(String table, {String? orderBy, bool ascending = false});

  /// Get a single record by ID
  Future<Map<String, dynamic>?> getById(String table, dynamic id);

  /// Insert a new record, returns the created record with ID
  Future<Map<String, dynamic>> insert(String table, Map<String, dynamic> data);

  /// Update an existing record
  Future<Map<String, dynamic>> update(String table, dynamic id, Map<String, dynamic> data);

  /// Delete a record
  Future<void> delete(String table, dynamic id);

  /// Query with filters (e.g., get moods by date)
  Future<List<Map<String, dynamic>>> query(
    String table, {
    Map<String, dynamic>? equalFilters,
    Map<String, dynamic>? greaterThan,
    Map<String, dynamic>? lessThan,
    String? orderBy,
    bool ascending = false,
    int? limit,
  });

  /// Check if service is available
  Future<bool> isAvailable();
}
```

---

## SupabaseService Implementation

```dart
class SupabaseService implements BackendService {
  final SupabaseClient _client;

  SupabaseService(this._client);

  @override
  Future<List<Map<String, dynamic>>> getAll(String table, {String? orderBy, bool ascending = false}) async {
    var query = _client.from(table).select();
    if (orderBy != null) {
      query = query.order(orderBy, ascending: ascending);
    }
    return await query;
  }

  @override
  Future<Map<String, dynamic>> insert(String table, Map<String, dynamic> data) async {
    final response = await _client.from(table).insert(data).select().single();
    return response;
  }

  // ... other methods
}
```

---

## HiveBackendService Implementation

```dart
class HiveBackendService implements BackendService {
  // Table name → Hive box mapping
  final Map<String, Box<dynamic>> _boxes = {};

  @override
  Future<List<Map<String, dynamic>>> getAll(String table, {String? orderBy, bool ascending = false}) async {
    final box = _boxes[table];
    if (box == null) throw Exception('Box not found: $table');

    final values = box.values.map((v) => v.toJson() as Map<String, dynamic>).toList();

    if (orderBy != null) {
      values.sort((a, b) {
        final aVal = a[orderBy];
        final bVal = b[orderBy];
        return ascending ? aVal.compareTo(bVal) : bVal.compareTo(aVal);
      });
    }
    return values;
  }

  // ... other methods
}
```

---

## Updated Remote Data Source Pattern

Before:
```dart
class MoodRemoteDataSourceImpl implements MoodRemoteDataSource {
  Box<MoodEntryModel> get _box => Hive.box<MoodEntryModel>(boxName);

  @override
  Future<List<MoodEntryModel>> getMoods() async {
    return _box.values.toList();
  }
}
```

After:
```dart
class MoodRemoteDataSourceImpl implements MoodRemoteDataSource {
  final BackendService _backend;
  static const String tableName = 'moods';

  MoodRemoteDataSourceImpl(this._backend);

  @override
  Future<List<MoodEntryModel>> getMoods() async {
    final data = await _backend.getAll(tableName, orderBy: 'timestamp');
    return data.map((json) => MoodEntryModel.fromJson(json)).toList();
  }
}
```

---

## Dependency Injection with Riverpod

```dart
// core/services/backend_service_provider.dart

@riverpod
BackendService backendService(Ref ref) {
  // Use Supabase by default
  return SupabaseService(Supabase.instance.client);

  // To switch to Hive (offline mode):
  // return HiveBackendService();
}

// In remote data source providers:
@riverpod
MoodRemoteDataSource moodRemoteDataSource(Ref ref) {
  return MoodRemoteDataSourceImpl(ref.watch(backendServiceProvider));
}
```

---

## Supabase Table Schema

### moods
```sql
CREATE TABLE moods (
  id BIGSERIAL PRIMARY KEY,
  score INTEGER NOT NULL CHECK (score >= 1 AND score <= 5),
  note TEXT,
  tags TEXT[] DEFAULT '{}',
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  user_id UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### activities
```sql
CREATE TABLE activities (
  id BIGSERIAL PRIMARY KEY,
  type TEXT NOT NULL,
  duration INTEGER NOT NULL,
  intensity INTEGER DEFAULT 2,
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  user_id UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### gratitude_entries
```sql
CREATE TABLE gratitude_entries (
  id BIGSERIAL PRIMARY KEY,
  items TEXT[] NOT NULL,
  date DATE NOT NULL,
  user_id UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### quotes
```sql
CREATE TABLE quotes (
  id BIGSERIAL PRIMARY KEY,
  text TEXT NOT NULL,
  author TEXT
);
```

### sounds
```sql
CREATE TABLE sounds (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  icon TEXT NOT NULL,
  asset_path TEXT NOT NULL,
  is_premium BOOLEAN DEFAULT FALSE
);
```

### user_settings
```sql
CREATE TABLE user_settings (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID UNIQUE REFERENCES auth.users(id),
  user_name TEXT DEFAULT 'User',
  user_email TEXT,
  is_vip BOOLEAN DEFAULT FALSE,
  health_sync_enabled BOOLEAN DEFAULT FALSE,
  daily_quote_hour INTEGER DEFAULT 9,
  daily_quote_minute INTEGER DEFAULT 0,
  mood_reminder_hour INTEGER DEFAULT 20,
  mood_reminder_minute INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

## Migration Strategy

1. **Phase 1**: Add BackendService abstraction, keep Hive as default
2. **Phase 2**: Implement SupabaseService
3. **Phase 3**: Update data sources to use BackendService
4. **Phase 4**: Switch default to Supabase, keep Hive for offline

---

## Benefits

1. **Testability**: Mock BackendService easily in tests
2. **Flexibility**: Swap backends with one provider change
3. **Offline Support**: Fall back to Hive when network unavailable
4. **Clean Architecture**: Data sources don't know about specific backends
5. **Future-Proof**: Add Firebase, REST API, GraphQL without touching data sources
