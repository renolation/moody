# Design: Add Configurable Defaults

## Architecture Overview

```
┌─────────────────────────────────────────────────────┐
│                    Supabase DB                       │
├─────────────────────────────────────────────────────┤
│  users table                                         │
│     │                                                │
│     ▼ TRIGGER: on_user_created_settings              │
│  settings table (extended)                           │
│     - user_id, user_name, theme, is_vip...          │
│     - walking_duration, running_duration...    NEW   │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│                    Flutter App                       │
├─────────────────────────────────────────────────────┤
│  UserSettings entity (extended with durations)       │
│  SettingsProvider → Quick-log duration lookup        │
│  Settings Screen → Edit activity durations           │
└─────────────────────────────────────────────────────┘
```

## Database Schema Changes

### Settings Table - New Columns
```sql
ALTER TABLE settings
ADD COLUMN walking_duration INT NOT NULL DEFAULT 30,
ADD COLUMN running_duration INT NOT NULL DEFAULT 30,
ADD COLUMN yoga_duration INT NOT NULL DEFAULT 30,
ADD COLUMN gym_duration INT NOT NULL DEFAULT 45,
ADD COLUMN cycling_duration INT NOT NULL DEFAULT 30;
```

### Default Settings Trigger
```sql
CREATE OR REPLACE FUNCTION create_default_settings()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO settings (
    user_id,
    user_name,
    is_vip,
    health_sync_enabled,
    daily_quote_hour,
    daily_quote_minute,
    mood_reminder_hour,
    mood_reminder_minute,
    theme,
    walking_duration,
    running_duration,
    yoga_duration,
    gym_duration,
    cycling_duration
  ) VALUES (
    NEW.id,
    COALESCE(NEW.name, split_part(NEW.email, '@', 1)),
    false,      -- is_vip
    false,      -- health_sync_enabled
    8,          -- daily_quote_hour
    0,          -- daily_quote_minute
    21,         -- mood_reminder_hour
    0,          -- mood_reminder_minute
    'dark',     -- theme
    30,         -- walking_duration
    30,         -- running_duration
    30,         -- yoga_duration
    45,         -- gym_duration
    30          -- cycling_duration
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_user_created_settings ON users;
CREATE TRIGGER on_user_created_settings
  AFTER INSERT ON users
  FOR EACH ROW EXECUTE FUNCTION create_default_settings();
```

## Flutter Changes

### UserSettings Entity (Extended)
```dart
class UserSettings extends Equatable {
  // Existing fields
  final String userName;
  final bool isVip;
  final bool healthSyncEnabled;
  final int dailyQuoteHour;
  final int dailyQuoteMinute;
  final int moodReminderHour;
  final int moodReminderMinute;
  final String theme;

  // NEW: Activity duration fields
  final int walkingDuration;
  final int runningDuration;
  final int yogaDuration;
  final int gymDuration;
  final int cyclingDuration;

  const UserSettings({
    // ... existing defaults ...
    this.walkingDuration = 30,
    this.runningDuration = 30,
    this.yogaDuration = 30,
    this.gymDuration = 45,
    this.cyclingDuration = 30,
  });

  int getDurationForActivity(ActivityType type) {
    return switch (type) {
      ActivityType.walking => walkingDuration,
      ActivityType.running => runningDuration,
      ActivityType.yoga => yogaDuration,
      ActivityType.gym => gymDuration,
      ActivityType.cycling => cyclingDuration,
    };
  }
}
```

### Quick-Log Integration
```dart
// In TodayActivities provider
Future<void> addActivity(ActivityType type) async {
  final settings = ref.read(settingsProvider).valueOrNull;
  final duration = settings?.getDurationForActivity(type)
                   ?? type.defaultDuration; // fallback to enum

  await repository.addActivity(type: type, duration: duration, userId: user?.id);
}
```

## Data Flow

### New User Registration
1. User signs up via Supabase Auth
2. `on_auth_user_created` trigger creates `users` row
3. `on_user_created_settings` trigger creates `settings` row with ALL defaults
4. App fetches settings → user sees configured defaults immediately

### Quick-Log Activity
1. User taps Walk button
2. App reads `settingsProvider.walkingDuration` (e.g., 30)
3. Creates activity with that duration
4. If settings unavailable, falls back to enum default

### User Customizes Duration
1. User opens Settings → Activity Durations section
2. Changes Walking from 30 to 45 minutes
3. `settingsProvider.updateWalkingDuration(45)` called
4. Next quick-log uses 45 minutes

## Offline Handling

### Strategy: Dart Defaults as Fallback
- If `settingsProvider` has no data (error/offline), use hardcoded defaults in entity
- Enum still has `defaultDuration` as ultimate fallback
- No separate caching needed (settings already cached by existing flow)

## Migration Strategy

### Existing Users Without Settings
```sql
-- Backfill settings for users without a row
INSERT INTO settings (user_id, user_name, walking_duration, running_duration, yoga_duration, gym_duration, cycling_duration, ...)
SELECT
  u.id,
  COALESCE(u.name, split_part(u.email, '@', 1)),
  30, 30, 30, 45, 30, ...
FROM users u
LEFT JOIN settings s ON s.user_id = u.id
WHERE s.id IS NULL;
```

### Existing Users With Settings (add new columns)
- ALTER TABLE adds columns with DEFAULT values
- Existing rows automatically get default durations
- No data migration needed

## Trade-offs

### Chosen: Per-User Settings
**Pros:**
- Users can customize their defaults
- Single table (no join needed)
- Leverages existing settings infrastructure

**Cons:**
- More columns in settings table
- Adding new activity types requires schema change

### Alternative: Separate activity_types Table
**Pros:**
- Cleaner separation of concerns
- Easier to add new activity types

**Cons:**
- Extra table and join
- Users can't customize without another table
- More complex for simple use case
