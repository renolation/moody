# Integrate Supabase Backend

## Summary

Integrate Supabase as the primary backend service while maintaining clean architecture principles. Create an abstracted `BackendService` layer that allows seamless swapping between Supabase, Hive (offline), or any future backend without modifying the app structure.

## Motivation

Currently, all remote data sources use Hive as an "API simulator." To enable:
- Real cloud sync across devices
- User authentication (future)
- Real-time data updates
- Scalable backend infrastructure

We need to integrate Supabase while preserving the ability to:
- Work offline with local Hive storage
- Swap backends easily (Firebase, custom REST API, etc.)
- Maintain testability with mock implementations

## Scope

### In Scope
- Create abstract `BackendService` interface in `core/services/`
- Create `SupabaseService` implementation with CRUD operations
- Create `HiveService` implementation (offline fallback)
- Update all 7 remote data sources to use `BackendService`:
  - `MoodRemoteDataSource`
  - `ActivityRemoteDataSource`
  - `GratitudeRemoteDataSource`
  - `QuoteRemoteDataSource`
  - `SoundRemoteDataSource`
  - `SettingsRemoteDataSource`
  - `StatsRemoteDataSource`
- Initialize Supabase in `main.dart`
- Add `supabase_flutter` dependency

### Out of Scope
- User authentication (separate feature)
- Real-time subscriptions (future enhancement)
- Offline-first sync strategy (future enhancement)
- Database migrations/schema versioning

## Supabase Configuration

```dart
url: 'https://blhtrhpejkintvxxmfrq.supabase.co'
anonKey: 'sb_publishable_04xGwF1Cf4LVISNU55hm9w_NkrE6Do_'
```

## Technical Approach

### Clean Architecture Layering

```
┌─────────────────────────────────────────────┐
│  Presentation Layer (UI, Providers)         │
├─────────────────────────────────────────────┤
│  Domain Layer (Entities, Repositories)      │
├─────────────────────────────────────────────┤
│  Data Layer (Models, DataSources, RepoImpl) │
├─────────────────────────────────────────────┤
│  Core Services (BackendService abstraction) │  ← NEW
├─────────────────────────────────────────────┤
│  Infrastructure (Supabase, Hive, etc.)      │  ← NEW
└─────────────────────────────────────────────┘
```

### Backend Service Pattern

```dart
// Abstract interface - swap implementations freely
abstract class BackendService {
  Future<List<Map<String, dynamic>>> getAll(String table);
  Future<Map<String, dynamic>?> getById(String table, dynamic id);
  Future<Map<String, dynamic>> insert(String table, Map<String, dynamic> data);
  Future<Map<String, dynamic>> update(String table, dynamic id, Map<String, dynamic> data);
  Future<void> delete(String table, dynamic id);
  Future<List<Map<String, dynamic>>> query(String table, Map<String, dynamic> filters);
}
```

### Supabase Tables Required

| Table | Columns |
|-------|---------|
| `moods` | id, score, note, tags, timestamp, user_id |
| `activities` | id, type, duration, intensity, timestamp, user_id |
| `gratitude_entries` | id, items, date, user_id |
| `quotes` | id, text, author |
| `sounds` | id, name, icon, asset_path, is_premium |
| `user_settings` | id, user_name, user_email, is_vip, health_sync_enabled, ... |

## Acceptance Criteria

- [ ] `BackendService` abstract interface created in `core/services/`
- [ ] `SupabaseService` implements `BackendService` with full CRUD
- [ ] `HiveService` implements `BackendService` for offline use
- [ ] All remote data sources use injected `BackendService`
- [ ] Supabase initialized in `main.dart`
- [ ] App works with Supabase backend (requires tables created)
- [ ] App can fall back to Hive when Supabase unavailable
- [ ] Switching backend requires only provider change, no data source edits
