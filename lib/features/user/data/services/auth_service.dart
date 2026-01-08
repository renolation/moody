import '../../domain/entities/user.dart';

/// Abstract interface for authentication operations.
///
/// This abstraction allows swapping between different auth providers
/// (Supabase, Firebase, etc.) without modifying UI code.
abstract class AuthService {
  /// Stream of auth state changes.
  ///
  /// Emits the current [User] when signed in, or null when signed out.
  Stream<User?> get authStateChanges;

  /// Currently authenticated user.
  ///
  /// Returns null if not signed in.
  User? get currentUser;

  /// Sign in with email and password.
  ///
  /// Throws [AuthException] on failure.
  Future<User> signInWithEmail(String email, String password);

  /// Sign up with email, password, and display name.
  ///
  /// Throws [AuthException] on failure.
  Future<User> signUpWithEmail(String email, String password, String name);

  /// Sign out the current user.
  Future<void> signOut();

  /// Send password reset email.
  ///
  /// Throws [AuthException] on failure.
  Future<void> resetPassword(String email);
}
