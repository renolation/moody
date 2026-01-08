# Tasks: Integrate Supabase Backend

## Phase 1: Setup & Dependencies

- [x] **1.1** Add `supabase_flutter` to pubspec.yaml
  - Run `flutter pub add supabase_flutter`
  - Verify: Package installed successfully

- [x] **1.2** Initialize Supabase in `main.dart`
  - Add `Supabase.initialize()` before `runApp()`
  - Use provided URL and anon key
  - Verify: App starts without Supabase errors

## Phase 2: Backend Service Abstraction

- [x] **2.1** Create `core/services/` directory structure
  - Create `backend_service.dart` (abstract interface)
  - Verify: File created with CRUD method signatures

- [x] **2.2** Implement `BackendService` abstract class
  - Methods: `getAll`, `getById`, `insert`, `update`, `delete`, `query`, `isAvailable`
  - Include generic query filters (equal, greaterThan, lessThan)
  - Verify: Interface compiles

- [x] **2.3** Create `SupabaseService` implementation
  - Implement all BackendService methods using Supabase client
  - Handle Supabase exceptions gracefully
  - Verify: Can perform CRUD on test table

- [x] **2.4** Create `HiveBackendService` implementation
  - Implement BackendService using Hive boxes
  - Maintain backward compatibility with existing Hive data
  - Verify: Existing app data still loads

- [x] **2.5** Create `backend_service_provider.dart`
  - @riverpod provider for BackendService
  - Default to SupabaseService
  - Verify: Provider generates correctly

## Phase 3: Update Remote Data Sources

- [x] **3.1** Update `MoodRemoteDataSourceImpl`
  - Inject BackendService via constructor
  - Replace Hive calls with BackendService calls
  - Verify: Moods load from backend

- [x] **3.2** Update `ActivityRemoteDataSourceImpl`
  - Inject BackendService via constructor
  - Replace Hive calls with BackendService calls
  - Verify: Activities load from backend

- [x] **3.3** Update `GratitudeRemoteDataSourceImpl`
  - Inject BackendService via constructor
  - Replace Hive calls with BackendService calls
  - Verify: Gratitude entries load from backend

- [x] **3.4** Update `QuoteRemoteDataSourceImpl`
  - Inject BackendService via constructor
  - Replace Hive calls with BackendService calls
  - Verify: Quotes load from backend

- [x] **3.5** Update `SoundRemoteDataSourceImpl`
  - Inject BackendService via constructor
  - Replace Hive calls with BackendService calls
  - Verify: Sounds load from backend

- [x] **3.6** Update `SettingsRemoteDataSourceImpl`
  - Inject BackendService via constructor
  - Replace Hive calls with BackendService calls
  - Verify: Settings load from backend

- [x] **3.7** Update `StatsRemoteDataSourceImpl`
  - Inject BackendService via constructor
  - Replace Hive calls with BackendService calls
  - Verify: Stats calculate from backend data

## Phase 4: Update Providers

- [x] **4.1** Update `home_provider.dart` data source providers
  - Inject BackendService into MoodRemoteDataSourceImpl
  - Inject BackendService into ActivityRemoteDataSourceImpl
  - Verify: Home screen loads data

- [x] **4.2** Update `wellness_provider.dart` data source providers
  - Inject BackendService into QuoteRemoteDataSourceImpl
  - Inject BackendService into SoundRemoteDataSourceImpl
  - Inject BackendService into GratitudeRemoteDataSourceImpl
  - Verify: Wellness features work

- [x] **4.3** Update `settings_provider.dart` data source providers
  - Inject BackendService into SettingsRemoteDataSourceImpl
  - Verify: Settings screen works

- [x] **4.4** Update `insights_provider.dart` data source providers
  - Inject BackendService into StatsRemoteDataSourceImpl
  - Verify: Insights screen works

## Phase 5: Database Setup (Manual)

- [x] **5.1** Create Supabase tables
  - Create `moods` table with schema from design.md
  - Create `activities` table
  - Create `gratitude_entries` table
  - Create `quotes` table (seed with initial data)
  - Create `sounds` table (seed with initial data)
  - Create `user_settings` table
  - SQL script: `supabase/setup_all.sql`
  - Verify: Tables visible in Supabase dashboard

- [x] **5.2** Set up Row Level Security (RLS)
  - Enable RLS on all tables
  - Add policies for anonymous access (temporary)
  - Verify: CRUD operations work from app

## Phase 6: Validation

- [x] **6.1** Run `flutter analyze` - fix any issues
  - Verify: No warnings or errors

- [x] **6.2** Run `dart run build_runner build`
  - Verify: All providers generate correctly

- [ ] **6.3** Test full app flow
  - Test mood logging (create, read, delete)
  - Test activity logging
  - Test gratitude entries
  - Test settings persistence
  - Verify: All features work with Supabase

- [ ] **6.4** Test offline fallback (optional)
  - Switch provider to HiveBackendService
  - Verify: App works offline with local data

---

## Dependencies

| Task | Depends On |
|------|-----------|
| 1.2 | 1.1 |
| 2.2 | 2.1 |
| 2.3 | 2.2, 1.2 |
| 2.4 | 2.2 |
| 2.5 | 2.3, 2.4 |
| 3.x | 2.5 |
| 4.x | 3.x |
| 5.x | (parallel with 2-4) |
| 6.x | 4.x, 5.x |

## Parallelizable Work

- Tasks 2.3 and 2.4 can run in parallel (both implement BackendService)
- Tasks 3.1-3.7 can run in parallel (independent data sources)
- Tasks 4.1-4.4 can run in parallel (independent providers)
- Phase 5 (database setup) can run in parallel with Phase 2-4
