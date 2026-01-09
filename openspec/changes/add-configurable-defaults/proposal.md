# Proposal: Add Configurable Defaults

## Change ID
`add-configurable-defaults`

## Summary
Move hardcoded activity type default durations and user settings defaults from Flutter code to the database. Each user can customize their own activity durations in settings. New users automatically get a settings row with sensible defaults.

## Problem Statement
Currently, activity types (walking, running, yoga, gym, cycling) with their default durations are hardcoded in a Flutter enum. User settings defaults (daily quote time, mood reminder time, theme, etc.) are also hardcoded in Dart. This means:
- Users cannot customize quick-log durations per activity type
- Changing defaults requires a new app release
- New users don't get a settings row until they modify something

## Proposed Solution

### 1. Extend Settings Table with Activity Durations
Add activity duration columns to the `settings` table (per-user customization):
- `walking_duration` (int) - default 30 minutes
- `running_duration` (int) - default 30 minutes
- `yoga_duration` (int) - default 30 minutes
- `gym_duration` (int) - default 45 minutes
- `cycling_duration` (int) - default 30 minutes

### 2. Default Settings Trigger
Create a database trigger on `users` table that automatically inserts a default `settings` row when a new user is created, including:
- All existing settings with defaults (theme, notifications, etc.)
- Activity durations with defaults (30/45 min)

### 3. Flutter Integration
- Update UserSettings entity with activity duration fields
- Quick-log uses user's configured duration from settings
- Settings screen allows editing activity durations
- Fall back to hardcoded values if settings unavailable

## Scope
- Database: Alter settings table + trigger + backfill
- Flutter: Update settings entity/model/provider, update activity logging

## Out of Scope
- Admin UI for editing global defaults
- Adding/removing activity types dynamically

## Success Criteria
- New users automatically get settings row with all defaults
- Quick-log uses user's configured activity duration
- Users can customize activity durations in settings
- App works offline with fallback values
