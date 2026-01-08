# Design: Add Activity Tab

## Architecture Decision

### Option A: New Feature Folder (Recommended)
Create `features/activity/` with only presentation layer, importing domain/data from `features/home/`.

```
lib/features/activity/
├── presentation/
│   ├── screens/
│   │   └── activity_screen.dart
│   ├── widgets/
│   │   ├── activity_progress_ring.dart
│   │   ├── top_activity_card.dart
│   │   ├── mood_lift_insight_card.dart
│   │   └── recent_movement_list.dart
│   └── providers/
│       └── activity_stats_provider.dart
```

**Pros:**
- Clean separation of Activity tab UI from Home
- Follows feature-first architecture
- Easy to extend with full domain/data layers later

**Cons:**
- Cross-feature import (activity → home) creates coupling

### Option B: Extend Home Feature
Add Activity screen directly under `features/home/presentation/screens/`.

**Pros:**
- No cross-feature imports
- Activity data already lives in Home

**Cons:**
- Home feature becomes bloated
- Harder to isolate Activity tab changes

**Decision:** Go with **Option A** for cleaner feature separation.

---

## Navigation Tab Order

Current: `Home | Insights | Wellness | Settings`

Proposed: `Home | Activity | Insights | Wellness | Settings`

**Rationale:**
- Activity is a daily-use feature, should be near Home
- Insights (analytics) logically follows Activity data
- Settings remains at the end

---

## State Management

### ActivityStatsNotifier

```dart
@riverpod
class ActivityStatsNotifier extends _$ActivityStatsNotifier {
  @override
  Future<ActivityStats> build() async {
    final activities = await ref.watch(activityRepositoryProvider).getActivities();
    return _computeStats(activities);
  }
}

class ActivityStats {
  final int todayMinutes;
  final int goalMinutes; // Default 60
  final ActivityType? topActivity;
  final double topActivityPercentage;
  final double moodLiftPercentage;
  final List<ActivityEntry> recentActivities;
}
```

### Mood Lift Calculation

Compare average mood score on days with exercise vs. days without:

```
moodLift = (avgMoodWithExercise - avgMoodWithoutExercise) / avgMoodWithoutExercise * 100
```

This requires cross-referencing `MoodRepository` data, making it an aggregate computation.

---

## UI Components

### ActivityProgressRing

- SVG-based circular progress (like design reference)
- Gradient stroke: primary (#13daec) → sage (#8da399)
- Animated on load
- Center displays: large number + "min" + "OF X MIN GOAL"

### TopActivityCard

- Standard `GlassPanel` widget
- Bar chart icon with primary color background
- "TOP ACTIVITY" label + activity name
- Horizontal progress bar showing percentage

### MoodLiftInsightCard

- Special glowing variant of GlassPanel
- Yellow/gold accent colors (#fde047)
- "INSIGHT" badge in corner
- Trending up icon
- "Mood Lift: +X%" headline

### RecentMovementList

- Header: "Recent Movement" + "SEE ALL" button
- List of GlassPanel items with:
  - Activity icon (direction_walk, self_improvement, etc.)
  - Activity name + time
  - Duration + category tag

---

## Dependencies

- Existing: `ActivityRepository`, `ActivityEntry`, `ActivityType`, `MoodRepository`
- New: `fl_chart` (already in pubspec) for potential ring animation
- Widgets: Reuse `GlassPanel` from core/widgets

---

## Testing Strategy

1. **Unit tests:** `ActivityStatsNotifier` computation logic
2. **Widget tests:** Each UI component in isolation
3. **Integration test:** Full Activity screen with mock data
