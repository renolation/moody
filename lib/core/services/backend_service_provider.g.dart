// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$backendServiceHash() => r'8976de62f6236ee63b98efb93a81b96ae08ef1c2';

/// Provides the active [BackendService] implementation.
///
/// Switches between backends based on user login state:
/// - Not logged in (null): Use [HiveBackendService] for local-only storage
/// - Logged in (User): Use [SupabaseService] for cloud sync
///
/// This implements the offline-first approach where users can use the app
/// fully without creating an account. Login is only required for cloud sync.
///
/// Copied from [backendService].
@ProviderFor(backendService)
final backendServiceProvider = AutoDisposeProvider<BackendService>.internal(
  backendService,
  name: r'backendServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$backendServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BackendServiceRef = AutoDisposeProviderRef<BackendService>;
String _$hiveBackendServiceHash() =>
    r'da83c38ad8940b2f57a150efe7c2a57b9236b91d';

/// Provides [HiveBackendService] for local storage operations.
///
/// Use this when you specifically need local storage
/// (e.g., caching, offline fallback).
///
/// Copied from [hiveBackendService].
@ProviderFor(hiveBackendService)
final hiveBackendServiceProvider =
    AutoDisposeProvider<HiveBackendService>.internal(
      hiveBackendService,
      name: r'hiveBackendServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$hiveBackendServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HiveBackendServiceRef = AutoDisposeProviderRef<HiveBackendService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
