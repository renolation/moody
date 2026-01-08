// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insights_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statsRemoteDataSourceHash() =>
    r'6e9ea2f1f55a9f5b157d53ea71035d5153a3d3e3';

/// See also [statsRemoteDataSource].
@ProviderFor(statsRemoteDataSource)
final statsRemoteDataSourceProvider =
    AutoDisposeProvider<StatsRemoteDataSource>.internal(
      statsRemoteDataSource,
      name: r'statsRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$statsRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsRemoteDataSourceRef =
    AutoDisposeProviderRef<StatsRemoteDataSource>;
String _$statsRepositoryHash() => r'fd8fa1add5e0de669cafbdb09a555282077dadbe';

/// See also [statsRepository].
@ProviderFor(statsRepository)
final statsRepositoryProvider = AutoDisposeProvider<StatsRepository>.internal(
  statsRepository,
  name: r'statsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatsRepositoryRef = AutoDisposeProviderRef<StatsRepository>;
String _$selectedMonthHash() => r'1a0aa98508e3029d9dd0fd4ab78935f19081f66e';

/// See also [SelectedMonth].
@ProviderFor(SelectedMonth)
final selectedMonthProvider =
    AutoDisposeNotifierProvider<SelectedMonth, DateTime>.internal(
      SelectedMonth.new,
      name: r'selectedMonthProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedMonthHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedMonth = AutoDisposeNotifier<DateTime>;
String _$monthlyStatsNotifierHash() =>
    r'aab9f87abf5f71d128336f1ad54a070e6cbd1910';

/// See also [MonthlyStatsNotifier].
@ProviderFor(MonthlyStatsNotifier)
final monthlyStatsNotifierProvider =
    AsyncNotifierProvider<MonthlyStatsNotifier, MonthlyStats>.internal(
      MonthlyStatsNotifier.new,
      name: r'monthlyStatsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$monthlyStatsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MonthlyStatsNotifier = AsyncNotifier<MonthlyStats>;
String _$weeklyCorrelationNotifierHash() =>
    r'fe044023828b1092c491d1c509723b1c1af67f39';

/// See also [WeeklyCorrelationNotifier].
@ProviderFor(WeeklyCorrelationNotifier)
final weeklyCorrelationNotifierProvider =
    AsyncNotifierProvider<
      WeeklyCorrelationNotifier,
      WeeklyCorrelation
    >.internal(
      WeeklyCorrelationNotifier.new,
      name: r'weeklyCorrelationNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$weeklyCorrelationNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WeeklyCorrelationNotifier = AsyncNotifier<WeeklyCorrelation>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
