// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$moodRemoteDataSourceHash() =>
    r'95fd17e644e04afe8ded7d27a4c9a288d4980614';

/// See also [moodRemoteDataSource].
@ProviderFor(moodRemoteDataSource)
final moodRemoteDataSourceProvider =
    AutoDisposeProvider<MoodRemoteDataSource>.internal(
      moodRemoteDataSource,
      name: r'moodRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$moodRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MoodRemoteDataSourceRef = AutoDisposeProviderRef<MoodRemoteDataSource>;
String _$activityRemoteDataSourceHash() =>
    r'813162dd2b494ccc81642336e778aadaa5885f5f';

/// See also [activityRemoteDataSource].
@ProviderFor(activityRemoteDataSource)
final activityRemoteDataSourceProvider =
    AutoDisposeProvider<ActivityRemoteDataSource>.internal(
      activityRemoteDataSource,
      name: r'activityRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activityRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActivityRemoteDataSourceRef =
    AutoDisposeProviderRef<ActivityRemoteDataSource>;
String _$moodRepositoryHash() => r'5f69ecf349c684fdf14aab29ecb80015b0c4b2c0';

/// See also [moodRepository].
@ProviderFor(moodRepository)
final moodRepositoryProvider = AutoDisposeProvider<MoodRepository>.internal(
  moodRepository,
  name: r'moodRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$moodRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MoodRepositoryRef = AutoDisposeProviderRef<MoodRepository>;
String _$activityRepositoryHash() =>
    r'41a8c45464db348b1a778eb1afdc67dc9abaea44';

/// See also [activityRepository].
@ProviderFor(activityRepository)
final activityRepositoryProvider =
    AutoDisposeProvider<ActivityRepository>.internal(
      activityRepository,
      name: r'activityRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activityRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActivityRepositoryRef = AutoDisposeProviderRef<ActivityRepository>;
String _$todayJourneyHash() => r'66be4029b4d87517c84f0846a198dff65e5060c0';

/// See also [todayJourney].
@ProviderFor(todayJourney)
final todayJourneyProvider =
    AutoDisposeFutureProvider<List<JourneyItem>>.internal(
      todayJourney,
      name: r'todayJourneyProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todayJourneyHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayJourneyRef = AutoDisposeFutureProviderRef<List<JourneyItem>>;
String _$dailyQuoteHash() => r'772f47ef98ed62cec569796c657b8c4f58d22f01';

/// See also [dailyQuote].
@ProviderFor(dailyQuote)
final dailyQuoteProvider = AutoDisposeProvider<String>.internal(
  dailyQuote,
  name: r'dailyQuoteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyQuoteHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DailyQuoteRef = AutoDisposeProviderRef<String>;
String _$todayMoodsHash() => r'ff2627b23bcf04613559ee8c2d9cdd31a79ab729';

/// See also [TodayMoods].
@ProviderFor(TodayMoods)
final todayMoodsProvider =
    AutoDisposeAsyncNotifierProvider<TodayMoods, List<MoodEntry>>.internal(
      TodayMoods.new,
      name: r'todayMoodsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todayMoodsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodayMoods = AutoDisposeAsyncNotifier<List<MoodEntry>>;
String _$todayActivitiesHash() => r'3dcd148bebf7e877fa641542de58b6566ed120c4';

/// See also [TodayActivities].
@ProviderFor(TodayActivities)
final todayActivitiesProvider =
    AutoDisposeAsyncNotifierProvider<
      TodayActivities,
      List<ActivityEntry>
    >.internal(
      TodayActivities.new,
      name: r'todayActivitiesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todayActivitiesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodayActivities = AutoDisposeAsyncNotifier<List<ActivityEntry>>;
String _$selectedMoodHash() => r'1c99f23c0f46451cd70674b631a8f46dfd5b84ea';

/// See also [SelectedMood].
@ProviderFor(SelectedMood)
final selectedMoodProvider =
    AutoDisposeNotifierProvider<SelectedMood, MoodScore?>.internal(
      SelectedMood.new,
      name: r'selectedMoodProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedMoodHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedMood = AutoDisposeNotifier<MoodScore?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
