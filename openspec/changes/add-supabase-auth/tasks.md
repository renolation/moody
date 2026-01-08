# Tasks: Add Supabase Authentication

## Phase 1: Auth Service Layer

- [x] **1.1** Create `AuthException` class
  - File: `features/user/data/services/auth_exception.dart`
  - Include error code and friendly message mapping
  - Verify: Class compiles

- [x] **1.2** Create `AuthService` abstract interface
  - File: `features/user/data/services/auth_service.dart`
  - Methods: authStateChanges, currentUser, signInWithEmail, signUpWithEmail, signOut, resetPassword
  - Verify: Interface compiles

- [x] **1.3** Create `SupabaseAuthService` implementation
  - File: `features/user/data/services/supabase_auth_service.dart`
  - Map Supabase User to app User entity
  - Handle auth errors appropriately
  - Verify: Service compiles

## Phase 2: Provider Updates

- [x] **2.1** Create `authServiceProvider`
  - File: `features/user/presentation/providers/auth_provider.dart`
  - Provide singleton SupabaseAuthService
  - Verify: Provider generates correctly

- [x] **2.2** Update `currentUserProvider` to use auth stream
  - File: `features/user/presentation/providers/user_provider.dart`
  - Change from Future to Stream-based
  - Add signIn, signUp, signOut, resetPassword methods
  - Remove SharedPreferences dependency
  - Verify: Provider generates correctly

- [x] **2.3** Run `dart run build_runner build`
  - Generate updated providers
  - Verify: No build errors

## Phase 3: UI Updates

- [x] **3.1** Update auth screen for sign in
  - Call `currentUserProvider.signIn()` instead of mock
  - Show loading state during auth
  - Display user-friendly error messages
  - Verify: Sign in works

- [x] **3.2** Update auth screen for sign up
  - Call `currentUserProvider.signUp()` with name
  - Verify: Sign up works

- [x] **3.3** Add password reset flow
  - Show dialog to enter email
  - Call `currentUserProvider.resetPassword()`
  - Show success message
  - Verify: Reset email sends

- [x] **3.4** Update settings screen logout
  - Call `currentUserProvider.signOut()` instead of mock
  - Verify: Logout works

## Phase 4: Validation

- [x] **4.1** Run `flutter analyze`
  - Fix any warnings or errors
  - Verify: No issues found

- [ ] **4.2** Test full auth flow
  - Sign up new user
  - Sign out
  - Sign in existing user
  - Password reset
  - Verify: All flows work

---

## Dependencies

| Task | Depends On |
|------|-----------|
| 1.2 | 1.1 |
| 1.3 | 1.2 |
| 2.1 | 1.3 |
| 2.2 | 2.1 |
| 2.3 | 2.2 |
| 3.x | 2.3 |
| 4.x | 3.x |

## Parallelizable Work

- Tasks 1.1, 1.2 can run sequentially (small files)
- Phase 3 tasks (3.1-3.4) can run in parallel after 2.3
- Phase 4 depends on all Phase 3 tasks
