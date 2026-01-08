import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/backend_service_provider.dart';
import '../../../user/presentation/providers/user_provider.dart';
import '../../domain/entities/quote.dart';
import '../../domain/entities/gratitude_entry.dart';
import '../../domain/entities/sound.dart';
import '../../domain/repositories/quote_repository.dart';
import '../../domain/repositories/gratitude_repository.dart';
import '../../domain/repositories/sound_repository.dart';
import '../../data/datasources/quote_remote_data_source.dart';
import '../../data/datasources/gratitude_remote_data_source.dart';
import '../../data/datasources/sound_remote_data_source.dart';
import '../../data/repositories/quote_repository_impl.dart';
import '../../data/repositories/gratitude_repository_impl.dart';
import '../../data/repositories/sound_repository_impl.dart';

part 'wellness_provider.g.dart';

// Data Sources
@riverpod
QuoteRemoteDataSource quoteRemoteDataSource(Ref ref) {
  final backend = ref.watch(backendServiceProvider);
  return QuoteRemoteDataSourceImpl(backend);
}

@riverpod
GratitudeRemoteDataSource gratitudeRemoteDataSource(Ref ref) {
  final backend = ref.watch(backendServiceProvider);
  return GratitudeRemoteDataSourceImpl(backend);
}

@riverpod
SoundRemoteDataSource soundRemoteDataSource(Ref ref) {
  final backend = ref.watch(backendServiceProvider);
  return SoundRemoteDataSourceImpl(backend);
}

// Repositories
@riverpod
QuoteRepository quoteRepository(Ref ref) {
  return QuoteRepositoryImpl(
    remoteDataSource: ref.watch(quoteRemoteDataSourceProvider),
  );
}

@riverpod
GratitudeRepository gratitudeRepository(Ref ref) {
  return GratitudeRepositoryImpl(
    remoteDataSource: ref.watch(gratitudeRemoteDataSourceProvider),
  );
}

@riverpod
SoundRepository soundRepository(Ref ref) {
  return SoundRepositoryImpl(
    remoteDataSource: ref.watch(soundRemoteDataSourceProvider),
  );
}

// State Providers
@riverpod
class Quotes extends _$Quotes {
  @override
  Future<List<Quote>> build() async {
    final repository = ref.watch(quoteRepositoryProvider);
    return repository.getQuotes();
  }

  Future<void> toggleFavorite(int id) async {
    final repository = ref.read(quoteRepositoryProvider);
    await repository.toggleFavorite(id);
    ref.invalidateSelf();
  }
}

@riverpod
class GratitudeEntries extends _$GratitudeEntries {
  @override
  Future<List<GratitudeEntry>> build() async {
    final repository = ref.watch(gratitudeRepositoryProvider);
    final user = ref.watch(currentUserProvider).valueOrNull;
    return repository.getEntries(userId: user?.id);
  }

  Future<void> addEntry(List<String> items) async {
    final repository = ref.read(gratitudeRepositoryProvider);
    final user = ref.read(currentUserProvider).valueOrNull;
    await repository.addEntry(items, userId: user?.id);
    ref.invalidateSelf();
  }

  Future<GratitudeEntry?> getTodayEntry() async {
    final repository = ref.read(gratitudeRepositoryProvider);
    final user = ref.read(currentUserProvider).valueOrNull;
    return repository.getTodayEntry(userId: user?.id);
  }
}

@riverpod
Future<List<Sound>> sounds(Ref ref) async {
  final repository = ref.watch(soundRepositoryProvider);
  return repository.getSounds();
}

@riverpod
class CurrentlyPlaying extends _$CurrentlyPlaying {
  @override
  int? build() => null;

  void play(int soundId) {
    state = soundId;
  }

  void stop() {
    state = null;
  }

  void toggle(int soundId) {
    if (state == soundId) {
      state = null;
    } else {
      state = soundId;
    }
  }
}

@riverpod
class BreathingSession extends _$BreathingSession {
  @override
  BreathingState build() {
    return const BreathingState();
  }

  void start() {
    state = state.copyWith(isActive: true, currentPhase: BreathingPhase.inhale);
  }

  void nextPhase() {
    final nextPhase = switch (state.currentPhase) {
      BreathingPhase.inhale => BreathingPhase.hold,
      BreathingPhase.hold => BreathingPhase.exhale,
      BreathingPhase.exhale => BreathingPhase.inhale,
      null => BreathingPhase.inhale,
    };
    state = state.copyWith(currentPhase: nextPhase);
  }

  void stop() {
    state = const BreathingState();
  }
}

enum BreathingPhase { inhale, hold, exhale }

class BreathingState {
  final bool isActive;
  final BreathingPhase? currentPhase;
  final int cycleCount;

  const BreathingState({
    this.isActive = false,
    this.currentPhase,
    this.cycleCount = 0,
  });

  BreathingState copyWith({
    bool? isActive,
    BreathingPhase? currentPhase,
    int? cycleCount,
  }) {
    return BreathingState(
      isActive: isActive ?? this.isActive,
      currentPhase: currentPhase ?? this.currentPhase,
      cycleCount: cycleCount ?? this.cycleCount,
    );
  }

  int get phaseDuration => switch (currentPhase) {
        BreathingPhase.inhale => 4,
        BreathingPhase.hold => 7,
        BreathingPhase.exhale => 8,
        null => 0,
      };

  String get phaseLabel => switch (currentPhase) {
        BreathingPhase.inhale => 'Inhale',
        BreathingPhase.hold => 'Hold',
        BreathingPhase.exhale => 'Exhale',
        null => 'Ready',
      };
}
