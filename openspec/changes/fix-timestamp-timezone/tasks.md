## 1. Core Utility

- [x] 1.1 Create `DateTimeExtensions` in `lib/core/extensions/date_time_extensions.dart`
  - Add `toIso8601StringWithOffset()` method to serialize with timezone
  - Add `parseToLocal()` static method to parse and convert to local time

## 2. Activity Model

- [x] 2.1 Update `ActivityEntryModel.toJson()` to use `toIso8601StringWithOffset()`
- [x] 2.2 Update `ActivityEntryModel.fromJson()` to use `parseToLocal()`

## 3. Mood Model

- [x] 3.1 Update `MoodEntryModel.toJson()` to use `toIso8601StringWithOffset()`
- [x] 3.2 Update `MoodEntryModel.fromJson()` to use `parseToLocal()`

## 4. Data Sources - Date Filtering

- [x] 4.1 Update `ActivityRemoteDataSourceImpl.getActivitiesByDate()` to convert date boundaries to UTC
- [x] 4.2 Update `MoodRemoteDataSourceImpl.getMoodsByDate()` to convert date boundaries to UTC

## 5. Verification

- [x] 5.1 Remove debug logs from `home_provider.dart`
- [ ] 5.2 Manual test: Log activity and verify overlap detection works correctly
