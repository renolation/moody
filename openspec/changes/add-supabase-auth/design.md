# Design: Add Supabase Authentication

## Architecture Decision

### The Problem

The current auth implementation is mock-only:
- Creates fake User objects with timestamp IDs
- Stores user JSON in SharedPreferences
- No actual authentication or security
- No session management

### The Solution: Supabase Auth Integration

Supabase provides a complete auth solution with:
- Email/password authentication
- Automatic JWT token management
- Session persistence
- Password reset via email

---

## AuthService Design

```dart
/// Abstract interface for authentication operations.
abstract class AuthService {
  /// Stream of auth state changes (user or null).
  Stream<User?> get authStateChanges;

  /// Currently authenticated user (null if not signed in).
  User? get currentUser;

  /// Sign in with email and password.
  Future<User> signInWithEmail(String email, String password);

  /// Sign up with email, password, and display name.
  Future<User> signUpWithEmail(String email, String password, String name);

  /// Sign out the current user.
  Future<void> signOut();

  /// Send password reset email.
  Future<void> resetPassword(String email);
}
```

---

## SupabaseAuthService Implementation

```dart
class SupabaseAuthService implements AuthService {
  final SupabaseClient _client;

  SupabaseAuthService(this._client);

  factory SupabaseAuthService.instance() {
    return SupabaseAuthService(Supabase.instance.client);
  }

  @override
  Stream<User?> get authStateChanges {
    return _client.auth.onAuthStateChange.map((event) {
      final supabaseUser = event.session?.user;
      if (supabaseUser == null) return null;
      return _mapToUser(supabaseUser);
    });
  }

  @override
  User? get currentUser {
    final supabaseUser = _client.auth.currentUser;
    if (supabaseUser == null) return null;
    return _mapToUser(supabaseUser);
  }

  User _mapToUser(SupabaseUser supabaseUser) {
    return User(
      id: supabaseUser.id,
      email: supabaseUser.email ?? '',
      name: supabaseUser.userMetadata?['name'] ??
            supabaseUser.email?.split('@').first ?? 'User',
      avatarUrl: supabaseUser.userMetadata?['avatar_url'],
      createdAt: DateTime.parse(supabaseUser.createdAt),
    );
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user == null) {
      throw AuthException('Sign in failed');
    }
    return _mapToUser(response.user!);
  }

  @override
  Future<User> signUpWithEmail(String email, String password, String name) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    if (response.user == null) {
      throw AuthException('Sign up failed');
    }
    return _mapToUser(response.user!);
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }
}
```

---

## Updated User Provider

```dart
@riverpod
AuthService authService(Ref ref) {
  return SupabaseAuthService.instance();
}

@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  Stream<User?> build() {
    final authService = ref.watch(authServiceProvider);
    return authService.authStateChanges;
  }

  Future<void> signIn(String email, String password) async {
    final authService = ref.read(authServiceProvider);
    await authService.signInWithEmail(email, password);
    // State automatically updates via stream
  }

  Future<void> signUp(String email, String password, String name) async {
    final authService = ref.read(authServiceProvider);
    await authService.signUpWithEmail(email, password, name);
    // State automatically updates via stream
  }

  Future<void> signOut() async {
    final authService = ref.read(authServiceProvider);
    await authService.signOut();
    // State automatically updates via stream
  }

  Future<void> resetPassword(String email) async {
    final authService = ref.read(authServiceProvider);
    await authService.resetPassword(email);
  }
}
```

---

## Error Handling

```dart
class AuthException implements Exception {
  final String message;
  final String? code;

  AuthException(this.message, [this.code]);

  /// Map Supabase auth errors to user-friendly messages.
  static String friendlyMessage(dynamic error) {
    if (error is AuthException) {
      switch (error.code) {
        case 'invalid_credentials':
          return 'Invalid email or password';
        case 'user_already_exists':
          return 'An account with this email already exists';
        case 'weak_password':
          return 'Password is too weak';
        default:
          return error.message;
      }
    }
    return 'An unexpected error occurred';
  }
}
```

---

## Data Flow

### Sign In Flow
1. User enters email/password
2. Auth screen calls `currentUserProvider.signIn()`
3. `SupabaseAuthService.signInWithEmail()` called
4. Supabase validates credentials and returns session
5. `authStateChanges` stream emits new user
6. `currentUserProvider` state updates automatically
7. `backendServiceProvider` switches to Supabase
8. UI navigates back to settings

### Sign Out Flow
1. User taps logout
2. Settings screen calls `currentUserProvider.signOut()`
3. `SupabaseAuthService.signOut()` called
4. Supabase clears session
5. `authStateChanges` stream emits null
6. `currentUserProvider` state updates to null
7. `backendServiceProvider` switches to Hive
8. UI shows "Sign in to sync" card

---

## Benefits

1. **Secure**: Real authentication with encrypted passwords
2. **Automatic**: Session management handled by Supabase
3. **Reactive**: Stream-based state updates UI automatically
4. **Persistent**: Session survives app restarts
5. **Extensible**: Easy to add OAuth providers later
