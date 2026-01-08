import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:supabase_flutter/supabase_flutter.dart' as supabase show User;

import '../../domain/entities/user.dart';
import 'auth_exception.dart';
import 'auth_service.dart';

/// Supabase implementation of [AuthService].
///
/// Provides email/password authentication using Supabase Auth.
class SupabaseAuthService implements AuthService {
  final SupabaseClient _client;

  SupabaseAuthService(this._client);

  /// Create a SupabaseAuthService using the default Supabase instance.
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

  /// Map Supabase User to app User entity.
  User _mapToUser(supabase.User supabaseUser) {
    return User(
      id: supabaseUser.id,
      email: supabaseUser.email ?? '',
      name: supabaseUser.userMetadata?['name'] as String? ??
          supabaseUser.email?.split('@').first ??
          'User',
      avatarUrl: supabaseUser.userMetadata?['avatar_url'] as String?,
      createdAt: DateTime.parse(supabaseUser.createdAt),
    );
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw AuthException('Sign in failed', 'invalid_credentials');
      }

      return _mapToUser(response.user!);
    } on AuthApiException catch (e) {
      throw AuthException(e.message, e.code);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(e.toString());
    }
  }

  @override
  Future<User> signUpWithEmail(String email, String password, String name) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        throw AuthException('Sign up failed');
      }

      return _mapToUser(response.user!);
    } on AuthApiException catch (e) {
      throw AuthException(e.message, e.code);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on AuthApiException catch (e) {
      throw AuthException(e.message, e.code);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } on AuthApiException catch (e) {
      throw AuthException(e.message, e.code);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(e.toString());
    }
  }
}
