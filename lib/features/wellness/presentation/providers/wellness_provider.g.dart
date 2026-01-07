// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wellness_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quoteRemoteDataSourceHash() =>
    r'abc7a7562f9d6d099b1a5d95116812eaf2ddbba4';

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
    r'6295e968431570d29c2e370798edb1ae4026bba1';

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
    r'8a0f7b569830d3cb45fd72a872557fa630de03c0';

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
String _$gratitudeEntriesHash() => r'13c34b7f3821cda7979a4b17933bf21453d8c9fc';

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
