import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/backend_service_provider.dart';
import '../../data/datasources/user_remote_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/services/auth_exception.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import 'auth_provider.dart';

part 'user_provider.g.dart';

/// Provides UserRemoteDataSource.
@riverpod
UserRemoteDataSource userRemoteDataSource(Ref ref) {
  final backend = ref.watch(backendServiceProvider);
  return UserRemoteDataSourceImpl(backend);
}

/// Provides UserRepository.
@riverpod
UserRepository userRepository(Ref ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  return UserRepositoryImpl(remoteDataSource);
}

/// Manages the current user authentication state.
///
/// Listens to Supabase auth state changes via stream.
/// Returns null when not logged in (offline mode with Hive).
/// Returns User when logged in (sync mode with Supabase).
@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  Stream<User?> build() {
    final authService = ref.watch(authServiceProvider);

    // Also check for initial state
    final initialUser = authService.currentUser;
    if (initialUser != null) {
      // Emit initial user immediately
      return Stream.value(initialUser).asyncExpand((_) {
        return authService.authStateChanges;
      });
    }

    return authService.authStateChanges;
  }

  /// Sign in with email and password.
  ///
  /// Throws [AuthException] on failure.
  Future<void> signIn(String email, String password) async {
    final authService = ref.read(authServiceProvider);
    await authService.signInWithEmail(email, password);
    // State automatically updates via stream
  }

  /// Sign up with email, password, and name.
  ///
  /// Throws [AuthException] on failure.
  Future<void> signUp(String email, String password, String name) async {
    final authService = ref.read(authServiceProvider);
    await authService.signUpWithEmail(email, password, name);
    // State automatically updates via stream
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    final authService = ref.read(authServiceProvider);
    await authService.signOut();
    // State automatically updates via stream
  }

  /// Send password reset email.
  ///
  /// Throws [AuthException] on failure.
  Future<void> resetPassword(String email) async {
    final authService = ref.read(authServiceProvider);
    await authService.resetPassword(email);
  }
}
