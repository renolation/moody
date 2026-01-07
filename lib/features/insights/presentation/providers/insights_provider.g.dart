// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insights_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statsRemoteDataSourceHash() =>
    r'8517137a65519765b16b914ee50eac817d9cf8ce';

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
String _$monthlyStatsHash() => r'fee6dba0ebd882a4b9d8b97dfc0871f5bb44a051';

/// See also [monthlyStats].
@ProviderFor(monthlyStats)
final monthlyStatsProvider = AutoDisposeFutureProvider<MonthlyStats>.internal(
  monthlyStats,
  name: r'monthlyStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$monthlyStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MonthlyStatsRef = AutoDisposeFutureProviderRef<MonthlyStats>;
String _$weeklyCorrelationHash() => r'c0ec951bed0055b29c32dd6633e95297d59a1325';

/// See also [weeklyCorrelation].
@ProviderFor(weeklyCorrelation)
final weeklyCorrelationProvider =
    AutoDisposeFutureProvider<WeeklyCorrelation>.internal(
      weeklyCorrelation,
      name: r'weeklyCorrelationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$weeklyCorrelationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeeklyCorrelationRef = AutoDisposeFutureProviderRef<WeeklyCorrelation>;
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
