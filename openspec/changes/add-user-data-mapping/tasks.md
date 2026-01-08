# Tasks: Add User Data Mapping

## Phase 1: Update Entities

- [x] **1.1** Add `userId` field to `MoodEntry` entity
  - File: `lib/features/home/domain/entities/mood_entry.dart`
  - Add `final String? userId` field
  - Update constructor, copyWith, props
  - Verify: Entity compiles

- [x] **1.2** Add `userId` field to `ActivityEntry` entity
  - File: `lib/features/home/domain/entities/activity_entry.dart`
  - Add `final String? userId` field
  - Update constructor, copyWith, props
  - Verify: Entity compiles

- [x] **1.3** Add `userId` field to `GratitudeEntry` entity
  - File: `lib/features/wellness/domain/entities/gratitude_entry.dart`
  - Add `final String? userId` field
  - Update constructor, copyWith, props
  - Verify: Entity compiles

## Phase 2: Update Models

- [x] **2.1** Add `userId` to `MoodEntryModel`
  - File: `lib/features/home/data/models/mood_entry_model.dart`
  - Add `@HiveField(5) final String? userId`
  - Update `fromJson`: read `json['user_id']`
  - Update `toJson`: write `'user_id': userId`
  - Update `toEntity` and `fromEntity`
  - Verify: Model compiles

- [x] **2.2** Add `userId` to `ActivityEntryModel`
  - File: `lib/features/home/data/models/activity_entry_model.dart`
  - Add `@HiveField(5) final String? userId`
  - Update JSON serialization with `user_id`
  - Update entity conversions
  - Verify: Model compiles

- [x] **2.3** Add `userId` to `GratitudeEntryModel`
  - File: `lib/features/wellness/data/models/gratitude_entry_model.dart`
  - Add `@HiveField(3) final String? userId`
  - Update JSON serialization with `user_id`
  - Update entity conversions
  - Verify: Model compiles

- [x] **2.4** Run `dart run build_runner build --delete-conflicting-outputs`
  - Regenerate Hive adapters
  - Verify: No build errors

## Phase 3: Update Data Sources

- [x] **3.1** Update `MoodRemoteDataSource` to filter by userId
  - File: `lib/features/home/data/datasources/mood_remote_data_source.dart`
  - Add `userId` parameter to `getMoods()`, `getMoodsByDate()`
  - Filter queries by `user_id` when userId provided
  - Include `user_id` in `addMood()` insert
  - Verify: Data source compiles

- [x] **3.2** Update `ActivityRemoteDataSource` to filter by userId
  - File: `lib/features/home/data/datasources/activity_remote_data_source.dart`
  - Add `userId` parameter to query methods
  - Include `user_id` in insert methods
  - Verify: Data source compiles

- [x] **3.3** Update `GratitudeRemoteDataSource` to filter by userId
  - File: `lib/features/wellness/data/datasources/gratitude_remote_data_source.dart`
  - Add `userId` parameter to query methods
  - Include `user_id` in insert methods
  - Verify: Data source compiles

- [x] **3.4** Update `SettingsRemoteDataSource` to use userId
  - File: `lib/features/settings/data/datasources/settings_remote_data_source.dart`
  - Query settings by `user_id`
  - Upsert settings with `user_id`
  - Verify: Data source compiles

## Phase 4: Update Repositories

- [x] **4.1** Update `MoodRepository` interface
  - File: `lib/features/home/domain/repositories/mood_repository.dart`
  - Add `userId` parameter to methods
  - Verify: Interface compiles

- [x] **4.2** Update `MoodRepositoryImpl`
  - File: `lib/features/home/data/repositories/mood_repository_impl.dart`
  - Pass `userId` to data source methods
  - Verify: Repository compiles

- [x] **4.3** Update `ActivityRepository` interface and impl
  - Files: `domain/repositories/` and `data/repositories/`
  - Add `userId` parameter throughout
  - Verify: Compiles

- [x] **4.4** Update `GratitudeRepository` interface and impl
  - Files: `domain/repositories/` and `data/repositories/`
  - Add `userId` parameter throughout
  - Verify: Compiles

- [x] **4.5** Update `SettingsRepository` interface and impl
  - Files: `domain/repositories/` and `data/repositories/`
  - Add `userId` parameter throughout
  - Verify: Compiles

## Phase 5: Update Providers

- [x] **5.1** Update mood providers to inject userId
  - File: `lib/features/home/presentation/providers/home_provider.dart`
  - Watch `currentUserProvider` to get userId
  - Pass `userId` to repository methods
  - Verify: Provider generates correctly

- [x] **5.2** Update activity providers to inject userId
  - File: `lib/features/home/presentation/providers/home_provider.dart`
  - Watch `currentUserProvider` to get userId
  - Pass `userId` to repository methods
  - Verify: Provider generates correctly

- [x] **5.3** Update gratitude providers to inject userId
  - File: `lib/features/wellness/presentation/providers/wellness_provider.dart`
  - Watch `currentUserProvider` to get userId
  - Pass `userId` to repository methods
  - Verify: Provider generates correctly

- [x] **5.4** Update settings providers to inject userId
  - File: `lib/features/settings/presentation/providers/settings_provider.dart`
  - Watch `currentUserProvider` to get userId
  - Pass `userId` to repository methods
  - Verify: Provider generates correctly

- [x] **5.5** Run `dart run build_runner build`
  - Regenerate providers
  - Verify: No build errors

- [x] **5.6** Update insights providers to inject userId
  - File: `lib/features/insights/presentation/providers/insights_provider.dart`
  - Watch `currentUserProvider` to get userId
  - Pass `userId` to repository methods
  - Updated StatsRepository, StatsRemoteDataSource, and StatsRepositoryImpl
  - Verify: Provider generates correctly

- [x] **5.7** Update activity stats provider to inject userId
  - File: `lib/features/activity/presentation/providers/activity_stats_provider.dart`
  - Watch `currentUserProvider` to get userId
  - Pass `userId` to repository methods
  - Verify: Provider generates correctly

## Phase 6: Validation

- [x] **6.1** Run `flutter analyze`
  - Fix any warnings or errors
  - Verify: No issues found

- [ ] **6.2** Test anonymous user flow (manual testing required)
  - Create mood without login
  - Verify data saved with `user_id = null`
  - Verify data loads correctly

- [ ] **6.3** Test authenticated user flow (manual testing required)
  - Login and create mood
  - Verify data saved with correct `user_id`
  - Verify only user's data loads
  - Logout and verify anonymous data separate

---

## Dependencies

| Task | Depends On |
|------|-----------|
| 2.x | 1.x (entities) |
| 2.4 | 2.1-2.3 |
| 3.x | 2.x (models) |
| 4.x | 3.x (data sources) |
| 5.x | 4.x (repositories) |
| 5.5 | 5.1-5.4 |
| 6.x | 5.5 |

## Parallelizable Work

- Tasks 1.1, 1.2, 1.3 can run in parallel
- Tasks 2.1, 2.2, 2.3 can run in parallel
- Tasks 3.1, 3.2, 3.3, 3.4 can run in parallel
- Tasks 4.1-4.5 can run in parallel
- Tasks 5.1-5.4 can run in parallel
