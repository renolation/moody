import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'backend_service.dart';
import 'supabase_service.dart';
import 'hive_backend_service.dart';
import '../../features/user/presentation/providers/user_provider.dart';

part 'backend_service_provider.g.dart';

/// Provides the active [BackendService] implementation.
///
/// Switches between backends based on user login state:
/// - Not logged in (null): Use [HiveBackendService] for local-only storage
/// - Logged in (User): Use [SupabaseService] for cloud sync
///
/// This implements the offline-first approach where users can use the app
/// fully without creating an account. Login is only required for cloud sync.
@riverpod
BackendService backendService(Ref ref) {
  final currentUser = ref.watch(currentUserProvider).valueOrNull;

  if (currentUser != null) {
    // User is logged in - use Supabase for cloud sync
    return SupabaseService.instance();
  } else {
    // No user (default) - use Hive for local-only storage
    return HiveBackendService();
  }
}

/// Provides [HiveBackendService] for local storage operations.
///
/// Use this when you specifically need local storage
/// (e.g., caching, offline fallback).
@riverpod
HiveBackendService hiveBackendService(Ref ref) {
  return HiveBackendService();
}
