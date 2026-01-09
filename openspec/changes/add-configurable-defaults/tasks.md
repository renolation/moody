# Tasks: Add Configurable Defaults

## Phase 1: Database Setup

- [x] **1.1** Add activity duration columns to settings table
  - SQL: ALTER TABLE settings ADD COLUMN walking_duration, running_duration, yoga_duration, gym_duration, cycling_duration
  - All INT NOT NULL DEFAULT (30 for most, 45 for gym)
  - Verify: `\d settings` shows new columns

- [x] **1.2** Create default settings trigger function
  - Function: `create_default_settings()` inserts complete settings row
  - Include all existing fields + new duration fields
  - Use SECURITY DEFINER
  - Verify: Function created successfully

- [x] **1.3** Create trigger on users table
  - Trigger: `on_user_created_settings` AFTER INSERT on users
  - Drop existing trigger if any to avoid conflicts
  - Verify: Trigger created

- [x] **1.4** Backfill settings for existing users without settings row
  - Insert settings for users in `users` table without matching `settings` row
  - Use same defaults as trigger
  - Verify: All users have a settings row

- [x] **1.5** Test trigger with new user
  - Create test user in users table
  - Verify: Settings row auto-created with all defaults
  - Verify: Activity durations have correct values

## Phase 2: Flutter Entity & Model Updates

- [x] **2.1** Add activity duration fields to `UserSettings` entity
  - File: `lib/features/settings/domain/entities/user_settings.dart`
  - Add: walkingDuration, runningDuration, yogaDuration, gymDuration, cyclingDuration
  - Add: `getDurationForActivity(ActivityType type)` method
  - Defaults: 30, 30, 30, 45, 30
  - Update copyWith and props
  - Verify: Entity compiles

- [x] **2.2** Add activity duration fields to `UserSettingsModel`
  - File: `lib/features/settings/data/models/user_settings_model.dart`
  - Add fields with @HiveField annotations
  - Update fromJson: read walking_duration, etc.
  - Update toJson: write walking_duration, etc.
  - Update toEntity/fromEntity
  - Verify: Model compiles

- [x] **2.3** Run `dart run build_runner build`
  - Regenerate Hive adapters
  - Verify: No build errors

## Phase 3: Flutter Provider Updates

- [x] **3.1** Add duration update methods to Settings provider
  - File: `lib/features/settings/presentation/providers/settings_provider.dart`
  - Add: updateWalkingDuration(int), updateRunningDuration(int), etc.
  - Or: updateActivityDuration(ActivityType, int)
  - Verify: Provider compiles

- [x] **3.2** Update `TodayActivities.addActivity` to use settings duration
  - File: `lib/features/home/presentation/providers/home_provider.dart`
  - Read duration from settingsProvider using getDurationForActivity()
  - Fall back to type.defaultDuration if settings unavailable
  - Verify: Provider compiles

- [x] **3.3** Run `dart run build_runner build`
  - Regenerate providers
  - Verify: No build errors

## Phase 4: Settings UI

- [x] **4.1** Add Activity Durations section to Settings screen
  - File: `lib/features/settings/presentation/screens/settings_screen.dart`
  - New section: "ACTIVITY DEFAULTS"
  - Show duration picker for each activity type
  - Display current value, allow editing
  - Verify: UI renders correctly

- [x] **4.2** Create duration picker widget
  - Reusable widget for selecting minutes (15, 30, 45, 60, 90, etc.)
  - Or number input with validation
  - Verify: Widget works

- [x] **4.3** Connect UI to provider
  - Call settingsProvider.updateActivityDuration() on change
  - Show current values from settings
  - Verify: Changes persist

## Phase 5: Validation

- [x] **5.1** Run `flutter analyze`
  - Fix any warnings or errors
  - Verify: No issues found

- [ ] **5.2** Test new user flow
  - Register new user
  - Verify: Settings row created with all defaults
  - Verify: Settings screen shows default durations

- [ ] **5.3** Test quick-log with custom duration
  - Change walking duration to 45 in settings
  - Quick-log a walk
  - Verify: Activity created with 45 minutes

- [ ] **5.4** Test offline fallback
  - Disable network
  - Quick-log activity
  - Verify: Uses cached settings or enum default

---

## Dependencies

| Task | Depends On |
|------|-----------|
| 1.2 | 1.1 |
| 1.3 | 1.2 |
| 1.4 | 1.3 |
| 1.5 | 1.3 |
| 2.2 | 2.1 |
| 2.3 | 2.2 |
| 3.1 | 2.3 |
| 3.2 | 3.1 |
| 3.3 | 3.2 |
| 4.1 | 3.3 |
| 4.3 | 4.1, 4.2 |
| 5.1 | 4.3 |
| 5.x | 5.1 |

## Parallelizable Work

- Phase 1 (database) can be done independently
- Tasks 2.1, 2.2 must be sequential
- Tasks 4.1, 4.2 can run in parallel
- Testing tasks are sequential
