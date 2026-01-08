import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/services/auth_service.dart';
import '../../data/services/supabase_auth_service.dart';

part 'auth_provider.g.dart';

/// Provides the [AuthService] instance.
///
/// Uses [SupabaseAuthService] for real authentication.
@riverpod
AuthService authService(Ref ref) {
  return SupabaseAuthService.instance();
}
