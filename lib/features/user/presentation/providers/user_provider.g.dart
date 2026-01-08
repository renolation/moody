// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRemoteDataSourceHash() =>
    r'0f18762c231ae37207192542594711f4b22be440';

/// Provides UserRemoteDataSource.
///
/// Copied from [userRemoteDataSource].
@ProviderFor(userRemoteDataSource)
final userRemoteDataSourceProvider =
    AutoDisposeProvider<UserRemoteDataSource>.internal(
      userRemoteDataSource,
      name: r'userRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserRemoteDataSourceRef = AutoDisposeProviderRef<UserRemoteDataSource>;
String _$userRepositoryHash() => r'bcdf0718d6e048bec2e3321db1595c5263baa8d2';

/// Provides UserRepository.
///
/// Copied from [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = AutoDisposeProvider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserRepositoryRef = AutoDisposeProviderRef<UserRepository>;
String _$currentUserHash() => r'4416767209586d5284e50e6a44877734d2899d60';

/// Manages the current user authentication state.
///
/// Listens to Supabase auth state changes via stream.
/// Returns null when not logged in (offline mode with Hive).
/// Returns User when logged in (sync mode with Supabase).
///
/// Copied from [CurrentUser].
@ProviderFor(CurrentUser)
final currentUserProvider =
    AutoDisposeStreamNotifierProvider<CurrentUser, User?>.internal(
      CurrentUser.new,
      name: r'currentUserProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentUserHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentUser = AutoDisposeStreamNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
