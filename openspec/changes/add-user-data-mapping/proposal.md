# Proposal: Add User Data Mapping

## Summary

Link all user-generated data (moods, activities, gratitude, settings) to the authenticated user via `userId`. This enables proper data isolation between users while maintaining offline-first functionality for anonymous users.

## Problem

Currently, the app stores data without user association:
- All moods, activities, and gratitude entries are global (no `userId`)
- When multiple users share a device or sync to cloud, data is mixed
- No way to query "my data" vs "all data"
- Database already has `user_id` columns but app doesn't use them

## Solution

1. **Add `userId` field** to all user-owned entities and models:
   - `MoodEntry` / `MoodEntryModel`
   - `ActivityEntry` / `ActivityEntryModel`
   - `GratitudeEntry` / `GratitudeEntryModel`
   - `UserSettings` / `UserSettingsModel`

2. **Update data sources** to:
   - Accept optional `userId` parameter for filtering
   - Include `userId` when inserting records
   - Filter queries by `userId` when user is authenticated

3. **Update repositories** to:
   - Get current user from auth provider
   - Pass `userId` to data sources

4. **Offline mode behavior**:
   - Anonymous users: `userId = null`, data stored locally only
   - Authenticated users: `userId = auth.user.id`, data synced to cloud

## Scope

### In Scope
- Add `userId` to entities: MoodEntry, ActivityEntry, GratitudeEntry
- Add `userId` to models with JSON/Hive serialization
- Update data sources to filter by userId
- Update repositories to inject userId from auth
- Maintain backward compatibility for existing local data

### Out of Scope
- Migration of existing data to new user
- Multi-device sync conflict resolution
- Quotes and Sounds (shared/global content)

## Dependencies

- Requires: `add-supabase-auth` (completed)
- Database: `user_id` columns already exist in tables
