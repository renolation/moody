import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/enums/mood_score.dart';
import '../../../../core/enums/activity_type.dart';
import '../../../../core/services/backend_service_provider.dart';
import '../../domain/entities/mood_entry.dart';
import '../../domain/entities/activity_entry.dart';
import '../../domain/entities/journey_item.dart';
import '../../domain/repositories/mood_repository.dart';
import '../../domain/repositories/activity_repository.dart';
import '../../data/datasources/mood_remote_data_source.dart';
import '../../data/datasources/activity_remote_data_source.dart';
import '../../data/repositories/mood_repository_impl.dart';
import '../../data/repositories/activity_repository_impl.dart';

part 'home_provider.g.dart';

// Data Sources
@riverpod
MoodRemoteDataSource moodRemoteDataSource(Ref ref) {
  final backend = ref.watch(backendServiceProvider);
  return MoodRemoteDataSourceImpl(backend);
}

@riverpod
ActivityRemoteDataSource activityRemoteDataSource(Ref ref) {
  final backend = ref.watch(backendServiceProvider);
  return ActivityRemoteDataSourceImpl(backend);
}

// Repositories
@riverpod
MoodRepository moodRepository(Ref ref) {
  return MoodRepositoryImpl(
    remoteDataSource: ref.watch(moodRemoteDataSourceProvider),
  );
}

@riverpod
ActivityRepository activityRepository(Ref ref) {
  return ActivityRepositoryImpl(
    remoteDataSource: ref.watch(activityRemoteDataSourceProvider),
  );
}

// State Providers
@riverpod
class TodayMoods extends _$TodayMoods {
  @override
  Future<List<MoodEntry>> build() async {
    final repository = ref.watch(moodRepositoryProvider);
    return repository.getMoodsByDate(DateTime.now());
  }

  Future<void> addMood(MoodScore score, {String? note}) async {
    final repository = ref.read(moodRepositoryProvider);
    await repository.addMood(score: score, note: note);
    ref.invalidateSelf();
  }

  Future<void> removeMood(int id) async {
    final repository = ref.read(moodRepositoryProvider);
    await repository.deleteMood(id);
    ref.invalidateSelf();
  }
}

@riverpod
class TodayActivities extends _$TodayActivities {
  @override
  Future<List<ActivityEntry>> build() async {
    final repository = ref.watch(activityRepositoryProvider);
    return repository.getActivitiesByDate(DateTime.now());
  }

  Future<void> addActivity(ActivityType type, {int duration = 30}) async {
    final repository = ref.read(activityRepositoryProvider);
    await repository.addActivity(type: type, duration: duration);
    ref.invalidateSelf();
  }

  Future<void> removeActivity(int id) async {
    final repository = ref.read(activityRepositoryProvider);
    await repository.deleteActivity(id);
    ref.invalidateSelf();
  }
}

@riverpod
Future<List<JourneyItem>> todayJourney(Ref ref) async {
  final moodsAsync = ref.watch(todayMoodsProvider);
  final activitiesAsync = ref.watch(todayActivitiesProvider);

  final moods = moodsAsync.valueOrNull ?? [];
  final activities = activitiesAsync.valueOrNull ?? [];

  final journeyItems = <JourneyItem>[];

  for (final mood in moods) {
    journeyItems.add(JourneyItem.fromMood(
      id: mood.id,
      score: mood.score,
      timestamp: mood.timestamp,
      note: mood.note,
    ));
  }

  for (final activity in activities) {
    journeyItems.add(JourneyItem.fromActivity(
      id: activity.id,
      activityType: activity.type,
      duration: activity.duration,
      timestamp: activity.timestamp,
    ));
  }

  journeyItems.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  return journeyItems;
}

@riverpod
class SelectedMood extends _$SelectedMood {
  @override
  MoodScore? build() => null;

  void select(MoodScore? score) {
    state = score;
  }

  void clear() {
    state = null;
  }
}

@riverpod
String dailyQuote(Ref ref) {
  final quotes = [
    '"Peace is a journey of a thousand breaths."',
    '"The present moment is filled with joy and happiness."',
    '"Feelings are just visitors, let them come and go."',
    '"Within you, there is a stillness and a sanctuary."',
    '"Breathe. Let go. This moment is all you have."',
  ];
  final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
  return quotes[dayOfYear % quotes.length];
}
