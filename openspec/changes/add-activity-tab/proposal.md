# Add Activity Tab to Navigation

## Summary

Add a dedicated **Activity & Movement** tab to the bottom navigation bar, providing users with a focused dashboard to track physical activities and visualize their correlation with mood.

## Motivation

Currently, activity logging is accessible only through quick-log buttons on the Home screen. Users lack:
- A dedicated view to see their movement progress against daily goals
- Visual insights on how exercise correlates with mood improvement
- A comprehensive history of recent activities

The design mockup in `docs/ui/activity_screen/` demonstrates the desired UX with glassmorphism styling consistent with the app's aesthetic.

## Scope

### In Scope
- Add new "Activity" tab to bottom navigation (5 tabs total)
- Create `ActivityScreen` with:
  - Hero circular progress ring showing minutes moved vs. daily goal (default 60 min)
  - Two-column insight cards grid:
    - **Top Activity** card with activity breakdown bar
    - **Mood Lift** insight card with correlation percentage (glowing style)
  - **Recent Movement** list with activity items (icon, name, duration, category, time)
- Create `ActivityStatsNotifier` provider for aggregating weekly data
- Reuse existing `ActivityRepository` and `ActivityEntry` domain entities

### Out of Scope
- Activity editing/deletion from this screen (existing functionality in Home)
- Health app sync (Apple Health / Google Fit) - separate feature
- VIP-only analytics (correlation charts already in Insights tab)
- Custom daily goal setting (future enhancement)

## Design Reference

- **Visual mockup:** `docs/ui/activity_screen/screen.png`
- **HTML/Tailwind reference:** `docs/ui/activity_screen/code.html`
- **CLAUDE.md section:** "Activity & Movement Screen (Detail View)"

## Technical Approach

1. **Navigation:** Insert Activity tab at index 1 (between Home and Insights)
2. **Feature structure:** Create new `features/activity/` folder with presentation layer only (reuse home's domain/data layers)
3. **State:** New `ActivityStatsNotifier` (@riverpod AsyncNotifier) computing:
   - Total minutes this week
   - Top activity type with percentage
   - Mood lift delta (average mood after exercise vs. sedentary days)
4. **UI Components:**
   - `ActivityProgressRing` - SVG-based circular progress with gradient stroke
   - `TopActivityCard` - glassmorphism card with activity breakdown
   - `MoodLiftInsightCard` - glowing insight card with yellow accent
   - `RecentMovementList` - list of ActivityEntry items

## Acceptance Criteria

- [ ] Bottom nav shows 5 tabs: Home, Activity, Insights, Wellness, Settings
- [ ] Activity tab displays circular ring with current day's minutes vs. 60 min goal
- [ ] Top Activity card shows most frequent activity type with progress bar
- [ ] Mood Lift card shows correlation insight with glowing effect
- [ ] Recent Movement list shows last 5-7 activities with proper formatting
- [ ] Screen follows glassmorphism dark theme from design reference
- [ ] Navigation state persists correctly when switching tabs
