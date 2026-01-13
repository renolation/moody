# Change: Add Activity Overlap Validation

## Why

Users can currently log multiple activities that overlap in time (e.g., logging a 30-minute walk at 10:00 AM, then trying to log another activity at 10:10 AM while the first is still "in progress"). This leads to illogical data where activities are recorded during impossible time windows.

## What Changes

- Add validation logic to prevent logging new activities when an ongoing activity's time window hasn't completed
- Display user-friendly feedback showing why the activity cannot be logged and when they can try again
- Calculate overlap based on `lastActivity.timestamp + lastActivity.duration`

## Impact

- Affected specs: `activity-logging` (new capability)
- Affected code:
  - `lib/features/home/presentation/providers/home_provider.dart` - TodayActivities notifier
  - `lib/features/home/presentation/widgets/quick_log_bar.dart` - UI feedback
  - New: `lib/features/home/domain/exceptions/activity_overlap_exception.dart`
