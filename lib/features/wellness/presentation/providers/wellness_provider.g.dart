// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wellness_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quoteRemoteDataSourceHash() =>
    r'059166684ba3767ea5175eaf78db624e39a3e0d1';

/// See also [quoteRemoteDataSource].
@ProviderFor(quoteRemoteDataSource)
final quoteRemoteDataSourceProvider =
    AutoDisposeProvider<QuoteRemoteDataSource>.internal(
      quoteRemoteDataSource,
      name: r'quoteRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$quoteRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuoteRemoteDataSourceRef =
    AutoDisposeProviderRef<QuoteRemoteDataSource>;
String _$gratitudeRemoteDataSourceHash() =>
    r'22373cba60132c9b26f4821d20d01257496d5efa';

/// See also [gratitudeRemoteDataSource].
@ProviderFor(gratitudeRemoteDataSource)
final gratitudeRemoteDataSourceProvider =
    AutoDisposeProvider<GratitudeRemoteDataSource>.internal(
      gratitudeRemoteDataSource,
      name: r'gratitudeRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gratitudeRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GratitudeRemoteDataSourceRef =
    AutoDisposeProviderRef<GratitudeRemoteDataSource>;
String _$soundRemoteDataSourceHash() =>
    r'754899468df27bc11af4101679d197fc711bb22a';

/// See also [soundRemoteDataSource].
@ProviderFor(soundRemoteDataSource)
final soundRemoteDataSourceProvider =
    AutoDisposeProvider<SoundRemoteDataSource>.internal(
      soundRemoteDataSource,
      name: r'soundRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$soundRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SoundRemoteDataSourceRef =
    AutoDisposeProviderRef<SoundRemoteDataSource>;
String _$quoteRepositoryHash() => r'446117646b17069908701b5ae3ba79605bc19c26';

/// See also [quoteRepository].
@ProviderFor(quoteRepository)
final quoteRepositoryProvider = AutoDisposeProvider<QuoteRepository>.internal(
  quoteRepository,
  name: r'quoteRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$quoteRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuoteRepositoryRef = AutoDisposeProviderRef<QuoteRepository>;
String _$gratitudeRepositoryHash() =>
    r'0b48cc0ab7673944b89e1f51ec559936b4bfaf6a';

/// See also [gratitudeRepository].
@ProviderFor(gratitudeRepository)
final gratitudeRepositoryProvider =
    AutoDisposeProvider<GratitudeRepository>.internal(
      gratitudeRepository,
      name: r'gratitudeRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gratitudeRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GratitudeRepositoryRef = AutoDisposeProviderRef<GratitudeRepository>;
String _$soundRepositoryHash() => r'68a5af53e83d7be5ee06d3e3877aedb83f253da9';

/// See also [soundRepository].
@ProviderFor(soundRepository)
final soundRepositoryProvider = AutoDisposeProvider<SoundRepository>.internal(
  soundRepository,
  name: r'soundRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$soundRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SoundRepositoryRef = AutoDisposeProviderRef<SoundRepository>;
String _$soundsHash() => r'431fa32a31aacd7a5e0143a073bbbcfb84d90743';

/// See also [sounds].
@ProviderFor(sounds)
final soundsProvider = AutoDisposeFutureProvider<List<Sound>>.internal(
  sounds,
  name: r'soundsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$soundsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SoundsRef = AutoDisposeFutureProviderRef<List<Sound>>;
String _$quotesHash() => r'c3238e19c09ffadd10d9e41c8bbea1a9f67bc311';

/// See also [Quotes].
@ProviderFor(Quotes)
final quotesProvider =
    AutoDisposeAsyncNotifierProvider<Quotes, List<Quote>>.internal(
      Quotes.new,
      name: r'quotesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$quotesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Quotes = AutoDisposeAsyncNotifier<List<Quote>>;
String _$gratitudeEntriesHash() => r'aeb80cdc66b2a99b801221bf58651879a847cd5c';

/// See also [GratitudeEntries].
@ProviderFor(GratitudeEntries)
final gratitudeEntriesProvider =
    AutoDisposeAsyncNotifierProvider<
      GratitudeEntries,
      List<GratitudeEntry>
    >.internal(
      GratitudeEntries.new,
      name: r'gratitudeEntriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gratitudeEntriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GratitudeEntries = AutoDisposeAsyncNotifier<List<GratitudeEntry>>;
String _$currentlyPlayingHash() => r'b52ea407a5ad61f463dba03c0af77fe7b97c6b30';

/// See also [CurrentlyPlaying].
@ProviderFor(CurrentlyPlaying)
final currentlyPlayingProvider =
    AutoDisposeNotifierProvider<CurrentlyPlaying, int?>.internal(
      CurrentlyPlaying.new,
      name: r'currentlyPlayingProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentlyPlayingHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentlyPlaying = AutoDisposeNotifier<int?>;
String _$breathingSessionHash() => r'06ce230abad7380a1120d0206e6b9b04dc360d53';

/// See also [BreathingSession].
@ProviderFor(BreathingSession)
final breathingSessionProvider =
    AutoDisposeNotifierProvider<BreathingSession, BreathingState>.internal(
      BreathingSession.new,
      name: r'breathingSessionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$breathingSessionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BreathingSession = AutoDisposeNotifier<BreathingState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
