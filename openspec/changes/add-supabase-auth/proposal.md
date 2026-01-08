# Add Supabase Authentication

## Summary

Replace the mock authentication with real Supabase Auth service. This enables secure email/password authentication with proper session management, password reset, and automatic auth state synchronization.

## Motivation

**Current State:**
- Auth screen creates mock User objects
- User state is manually persisted in SharedPreferences
- No real authentication or security

**Benefits of Supabase Auth:**
- Secure email/password authentication
- Automatic session management and token refresh
- Password reset via email
- Auth state persists across app restarts
- Foundation for future OAuth providers (Google, Apple)

## Scope

### In Scope
- Create `AuthService` class wrapping Supabase Auth
- Create `authServiceProvider` for dependency injection
- Update `currentUserProvider` to listen to Supabase auth state
- Update auth screen to use real sign in/sign up
- Implement password reset flow
- Handle auth errors with user-friendly messages

### Out of Scope
- OAuth providers (Google, Apple Sign In)
- Email verification flow
- Profile picture upload
- Two-factor authentication

## Technical Approach

### AuthService Interface

```dart
abstract class AuthService {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<User> signInWithEmail(String email, String password);
  Future<User> signUpWithEmail(String email, String password, String name);
  Future<void> signOut();
  Future<void> resetPassword(String email);
}
```

### Auth State Flow

```
┌─────────────────────────────────────────────────────────┐
│              Supabase Auth State Stream                  │
│         (automatically manages session/tokens)           │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│               currentUserProvider                        │
│     (listens to auth state, maps to User entity)        │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│               backendServiceProvider                     │
│   (switches Hive/Supabase based on auth state)          │
└─────────────────────────────────────────────────────────┘
```

## Acceptance Criteria

- [ ] `AuthService` created with Supabase implementation
- [ ] `authServiceProvider` provides singleton instance
- [ ] `currentUserProvider` listens to Supabase auth state
- [ ] Sign in with email/password works
- [ ] Sign up with email/password works
- [ ] Sign out clears session
- [ ] Password reset sends email
- [ ] Auth errors show user-friendly messages
- [ ] Session persists across app restarts
- [ ] `flutter analyze` passes with no errors
