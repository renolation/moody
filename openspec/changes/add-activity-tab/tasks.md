# Tasks: Add Activity Tab

## Phase 1: Navigation Setup

- [x] **1.1** Update `app_shell.dart` to add Activity tab at index 1
  - Add `_NavItem` for Activity with `directions_run` icon
  - Update index calculations for Insights (2), Wellness (3), Settings (4)
  - Verify: All 5 tabs visible and tappable

- [x] **1.2** Add `/activity` route to `app_router.dart`
  - Create placeholder `ActivityScreen` widget
  - Add route inside ShellRoute at index 1
  - Verify: Navigating to Activity tab shows placeholder

## Phase 2: Feature Structure

- [x] **2.1** Create `features/activity/` folder structure
  - `presentation/screens/activity_screen.dart`
  - `presentation/widgets/` (empty for now)
  - `presentation/providers/activity_stats_provider.dart`
  - Verify: Files created, no import errors

- [x] **2.2** Create `ActivityStats` model class
  - Fields: `todayMinutes`, `goalMinutes`, `topActivity`, `topActivityPercentage`, `moodLiftPercentage`, `recentActivities`
  - Verify: Model compiles with Equatable

## Phase 3: State Management

- [x] **3.1** Create `ActivityStatsNotifier` provider
  - Extend `AsyncNotifier<ActivityStats>`
  - Inject `ActivityRepository` and `MoodRepository`
  - Compute today's minutes from activities
  - Verify: Provider returns mock stats

- [x] **3.2** Implement top activity calculation
  - Group activities by type for current week
  - Calculate percentage of most frequent
  - Verify: Returns correct top activity

- [x] **3.3** Implement mood lift calculation
  - Compare avg mood on exercise days vs non-exercise days
  - Return percentage difference
  - Verify: Returns reasonable correlation value

## Phase 4: UI Components

- [x] **4.1** Create `ActivityProgressRing` widget
  - SVG circular progress with gradient stroke
  - Center text: minutes + goal
  - Follow `docs/ui/activity_screen/code.html` styling
  - Verify: Ring displays 75% progress visually

- [x] **4.2** Create `TopActivityCard` widget
  - GlassPanel with bar_chart icon
  - "TOP ACTIVITY" label + activity name
  - Horizontal progress bar
  - Verify: Card matches design mockup

- [x] **4.3** Create `MoodLiftInsightCard` widget
  - Glowing GlassPanel variant (yellow border/shadow)
  - "INSIGHT" badge
  - Trending up icon + "Mood Lift: +X%"
  - Verify: Glow effect visible

- [x] **4.4** Create `RecentMovementList` widget
  - Header row with "SEE ALL" button
  - List of activity items with icon, name, duration, time
  - Verify: Shows last 5 activities

## Phase 5: Screen Assembly

- [x] **5.1** Build `ActivityScreen` layout
  - SafeArea + SingleChildScrollView
  - Header with back button + title + calendar icon
  - Hero section with ActivityProgressRing
  - Grid row with TopActivityCard + MoodLiftInsightCard
  - RecentMovementList at bottom
  - Verify: Full screen matches design mockup

- [x] **5.2** Connect screen to providers
  - Watch `activityStatsProvider`
  - Handle loading/error states
  - Verify: Real data displays from Hive

## Phase 6: Polish & Validation

- [x] **6.1** Add haptic feedback on interactions
  - Tab selection, card taps
  - Verify: Haptics trigger on iOS/Android

- [x] **6.2** Run `flutter analyze` - fix any issues
  - Verify: No warnings or errors

- [ ] **6.3** Manual QA on device
  - Test all 5 nav tabs
  - Verify data updates after adding activity from Home
  - Verify: Smooth transitions, correct data

---

## Dependencies

| Task | Depends On |
|------|-----------|
| 1.2 | 1.1 |
| 2.1 | 1.2 |
| 3.1 | 2.1, 2.2 |
| 3.2, 3.3 | 3.1 |
| 4.x | 2.1 |
| 5.1 | 4.1, 4.2, 4.3, 4.4 |
| 5.2 | 5.1, 3.3 |
| 6.x | 5.2 |

## Parallelizable Work

- Tasks 4.1, 4.2, 4.3, 4.4 can run in parallel
- Tasks 3.2, 3.3 can run in parallel after 3.1
