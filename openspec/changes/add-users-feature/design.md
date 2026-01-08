# Design: Add Users Feature

## Architecture Decision

### The Problem

The app needs to support two modes:
1. **Offline Mode**: No account, all data in Hive (default)
2. **Sync Mode**: Logged in, data syncs to Supabase

Users should never be forced to create an account to use the app.

### The Solution: Offline-First with Optional Sync

```
┌─────────────────────────────────────────────────────────┐
│                     User State                          │
│           (null = offline, User = logged in)            │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│               BackendService Provider                   │
│      (returns HiveBackendService or SupabaseService)    │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│                  Remote Data Sources                    │
│        (unaware of which backend is being used)         │
└─────────────────────────────────────────────────────────┘
```

---

## Key Design: Dynamic Backend Selection

The `backendServiceProvider` will check user login state and return the appropriate backend:

```dart
@riverpod
BackendService backendService(Ref ref) {
  final currentUser = ref.watch(currentUserProvider).valueOrNull;

  if (currentUser != null) {
    // User is logged in - use Supabase for cloud sync
    return SupabaseService.instance();
  } else {
    // No user - use Hive for local-only storage
    return HiveBackendService();
  }
}
```

**Benefits:**
- All existing data sources work unchanged
- Single point of backend switching
- Reactive: UI updates when user logs in/out

---

## User Entity

```dart
class User extends Equatable {
  final String id;           // UUID
  final String email;        // Unique identifier for login
  final String name;         // Display name
  final String? avatarUrl;   // Profile picture
  final DateTime createdAt;  // Account creation

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    required this.createdAt,
  });
}
```

---

## User State Management

```dart
@riverpod
class CurrentUser extends _$CurrentUser {
  static const String _localUserKey = 'current_user';

  @override
  Future<User?> build() async {
    // Check if user is stored locally (persisted login)
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_localUserKey);

    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null; // Not logged in
  }

  /// Login and persist user
  Future<void> login(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localUserKey, jsonEncode(user.toJson()));
    state = AsyncData(user);
  }

  /// Logout and clear persisted user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_localUserKey);
    state = const AsyncData(null);
  }
}
```

---

## Data Flow Scenarios

### Scenario 1: New User (No Account)
1. User opens app
2. `currentUserProvider` returns `null`
3. `backendServiceProvider` returns `HiveBackendService`
4. All data stored locally in Hive
5. User can use full app functionality

### Scenario 2: User Logs In
1. User creates account or logs in
2. `currentUserProvider` returns `User`
3. `backendServiceProvider` returns `SupabaseService`
4. All data now syncs to cloud
5. Local Hive data can be migrated (future feature)

### Scenario 3: User Logs Out
1. User logs out
2. `currentUserProvider` returns `null`
3. `backendServiceProvider` returns `HiveBackendService`
4. Data returns to local-only mode

---

## Supabase Schema

```sql
-- Table: users
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  "avatarUrl" TEXT,
  "createdAt" TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- RLS Policies (users can only see their own data)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- For now: allow all operations (tighten when adding auth)
CREATE POLICY "users_select" ON users FOR SELECT USING (true);
CREATE POLICY "users_insert" ON users FOR INSERT WITH CHECK (true);
CREATE POLICY "users_update" ON users FOR UPDATE USING (true);
CREATE POLICY "users_delete" ON users FOR DELETE USING (true);
```

---

## UserModel (Hive + JSON)

```dart
@HiveType(typeId: 6)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String? avatarUrl;

  @HiveField(4)
  final DateTime createdAt;

  // fromJson, toJson, toEntity, fromEntity methods
}
```

---

## Future Considerations

### Data Migration (Out of Scope)
When a user logs in for the first time, they may have local Hive data. Future feature could:
1. Detect existing Hive data
2. Ask user if they want to upload to cloud
3. Migrate data to Supabase

### Multi-Device Sync (Out of Scope)
With user accounts in place, future features could:
1. Real-time sync between devices
2. Conflict resolution
3. Offline queue for pending changes

---

## Benefits

1. **Zero Friction**: App works immediately, no signup required
2. **User Choice**: Login only when they want cloud sync
3. **Clean Architecture**: Backend switching is transparent
4. **Future-Ready**: Foundation for auth, sync, multi-user
