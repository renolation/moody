# Add Users Feature

## Summary

Add a `users` table and feature layer to support **optional** user accounts for cloud sync. The app works fully offline with Hive by default. Users only need to login/register if they want to sync data across devices.

## Motivation

**Offline-First Philosophy:**
- App works 100% without internet or account
- All data stored locally in Hive
- Login is optional, only for cloud sync
- No friction for new users

**Benefits of Optional Account:**
- Sync data across devices
- Cloud backup
- Future social features

## Scope

### In Scope
- Create `User` domain entity in `features/user/`
- Create `UserModel` Hive data model
- Create `UserRepository` and implementation
- Create `UserRemoteDataSource` using BackendService
- Create Riverpod providers for user state
- Add `users` table to Supabase schema
- Implement logic: no login = Hive, logged in = Supabase

### Out of Scope
- Authentication UI (login/signup screens)
- OAuth providers (Google, Apple)
- Password reset flow
- Email verification

## Technical Approach

### Offline-First Data Flow

```
┌─────────────────────────────────────────────────────────┐
│                      App Start                          │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
              ┌────────────────────────┐
              │  Is User Logged In?    │
              └────────────────────────┘
                    │            │
                   NO           YES
                    │            │
                    ▼            ▼
         ┌──────────────┐  ┌──────────────┐
         │ Use Hive     │  │ Use Supabase │
         │ (Local Only) │  │ (Cloud Sync) │
         └──────────────┘  └──────────────┘
```

### User Entity Fields
| Field | Type | Description |
|-------|------|-------------|
| `id` | String (UUID) | Unique identifier |
| `email` | String | User's email (unique) |
| `name` | String | Display name |
| `avatarUrl` | String? | Profile picture URL |
| `createdAt` | DateTime | Account creation timestamp |

### Backend Selection Logic

```dart
@riverpod
BackendService backendService(Ref ref) {
  final currentUser = ref.watch(currentUserProvider).valueOrNull;

  if (currentUser != null) {
    // Logged in: use Supabase for cloud sync
    return SupabaseService.instance();
  } else {
    // Not logged in: use Hive for local storage
    return HiveBackendService();
  }
}
```

### Architecture
```
features/user/
├── domain/
│   ├── entities/user.dart
│   └── repositories/user_repository.dart
├── data/
│   ├── models/user_model.dart
│   ├── datasources/user_remote_data_source.dart
│   └── repositories/user_repository_impl.dart
└── presentation/
    └── providers/user_provider.dart
```

## Acceptance Criteria

- [ ] `User` entity created with proper Equatable implementation
- [ ] `UserModel` with Hive adapter and JSON serialization
- [ ] `UserRepository` interface and implementation
- [ ] `UserRemoteDataSource` using BackendService abstraction
- [ ] Riverpod providers for current user state
- [ ] BackendService switches based on login state
- [ ] App works fully offline without login
- [ ] Supabase `users` table created with RLS
- [ ] `flutter analyze` passes with no errors
