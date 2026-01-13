# Change: Fix Timestamp Timezone Handling

## Why

Activity overlap detection fails because timestamps are stored without timezone info. When the backend returns timestamps, they're parsed as UTC but compared against local `DateTime.now()`. For a user in GMT+7:
- Activity logged at 10:00 local → stored as `2024-01-13T10:00:00` → parsed as 10:00 UTC (= 17:00 local)
- User tries to log at 10:10 local → `DateTime.now()` = 10:10 local
- Comparison fails: 10:10 local is NOT before 17:00 local

## What Changes

- App sends timestamps with timezone offset (e.g., `2024-01-13T10:00:00+07:00`)
- When parsing timestamps from backend, convert to local time for accurate comparison
- Affects all timestamp serialization/deserialization across activities and moods

## Impact

- Affected specs: `timestamp-handling` (new capability)
- Affected code:
  - `lib/features/home/data/models/activity_entry_model.dart` - toJson/fromJson
  - `lib/features/home/data/models/mood_entry_model.dart` - toJson/fromJson
  - `lib/features/home/data/datasources/activity_remote_data_source.dart` - date filtering
  - `lib/features/home/data/datasources/mood_remote_data_source.dart` - date filtering
