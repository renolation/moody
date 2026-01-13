## 1. Domain Layer

- [x] 1.1 Create `ActivityOverlapException` class in `lib/features/home/domain/exceptions/`
  - Include `message` and `ongoingActivityEnd` fields
  - Add `friendlyMessage` getter to format remaining time

## 2. State Management

- [x] 2.1 Modify `TodayActivities.addActivity()` in `home_provider.dart`
  - Fetch current activities from state
  - Find most recent activity by timestamp
  - Calculate end time: `lastActivity.timestamp.add(Duration(minutes: lastActivity.duration))`
  - If `DateTime.now()` is before end time, throw `ActivityOverlapException`

## 3. UI Layer

- [x] 3.1 Update `QuickLogBar._logActivity()` to handle `ActivityOverlapException`
  - Wrap call in try/catch
  - Show SnackBar with `friendlyMessage`
  - Add error haptic feedback

- [x] 3.2 Update `_DurationPicker.onSelect()` callback to handle overlap errors
  - Wrap call in try/catch
  - Show SnackBar before closing bottom sheet
  - Add error haptic feedback

## 4. Verification

- [ ] 4.1 Manual testing: log activity, then attempt to log another within duration window
- [ ] 4.2 Manual testing: verify activity logs successfully after previous activity window ends
