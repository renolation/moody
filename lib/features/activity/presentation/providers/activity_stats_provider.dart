import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/enums/activity_type.dart';
import '../../../home/domain/entities/activity_entry.dart';
import '../../../home/domain/entities/mood_entry.dart';
import '../../../home/presentation/providers/home_provider.dart';

part 'activity_stats_provider.g.dart';

class ActivityStats extends Equatable {
  final int todayMinutes;
  final int goalMinutes;
  final ActivityType? topActivity;
  final double topActivityPercentage;
  final double moodLiftPercentage;
  final bool hasEnoughDataForInsight;
  final List<ActivityEntry> recentActivities;

  const ActivityStats({
    required this.todayMinutes,
    this.goalMinutes = 60,
    this.topActivity,
    this.topActivityPercentage = 0,
    this.moodLiftPercentage = 0,
    this.hasEnoughDataForInsight = false,
    this.recentActivities = const [],
  });

  @override
  List<Object?> get props => [
        todayMinutes,
        goalMinutes,
        topActivity,
        topActivityPercentage,
        moodLiftPercentage,
        hasEnoughDataForInsight,
        recentActivities,
      ];
}

@riverpod
class ActivityStatsNotifier extends _$ActivityStatsNotifier {
  @override
  Future<ActivityStats> build() async {
    final activityRepo = ref.watch(activityRepositoryProvider);
    final moodRepo = ref.watch(moodRepositoryProvider);

    final activities = await activityRepo.getActivities();
    final moods = await moodRepo.getMoods();

    return _computeStats(activities, moods);
  }

  ActivityStats _computeStats(
    List<ActivityEntry> activities,
    List<MoodEntry> moods,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekAgo = today.subtract(const Duration(days: 7));

    // Today's minutes
    final todayActivities = activities.where((a) {
      final actDate = DateTime(a.timestamp.year, a.timestamp.month, a.timestamp.day);
      return actDate == today;
    });
    final todayMinutes = todayActivities.fold<int>(0, (sum, a) => sum + a.duration);

    // This week's activities for top activity calculation
    final weekActivities = activities.where((a) => a.timestamp.isAfter(weekAgo)).toList();

    // Calculate top activity
    ActivityType? topActivity;
    double topActivityPercentage = 0;

    if (weekActivities.isNotEmpty) {
      final activityCounts = <ActivityType, int>{};
      for (final activity in weekActivities) {
        activityCounts[activity.type] = (activityCounts[activity.type] ?? 0) + 1;
      }

      final sortedActivities = activityCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      if (sortedActivities.isNotEmpty) {
        topActivity = sortedActivities.first.key;
        topActivityPercentage = sortedActivities.first.value / weekActivities.length;
      }
    }

    // Calculate mood lift
    final moodLiftResult = _calculateMoodLift(activities, moods);

    // Recent activities (last 5)
    final recentActivities = activities.take(5).toList();

    return ActivityStats(
      todayMinutes: todayMinutes,
      goalMinutes: 60,
      topActivity: topActivity,
      topActivityPercentage: topActivityPercentage,
      moodLiftPercentage: moodLiftResult.percentage,
      hasEnoughDataForInsight: moodLiftResult.hasEnoughData,
      recentActivities: recentActivities,
    );
  }

  ({double percentage, bool hasEnoughData}) _calculateMoodLift(
    List<ActivityEntry> activities,
    List<MoodEntry> moods,
  ) {
    if (moods.length < 3) {
      return (percentage: 0, hasEnoughData: false);
    }

    // Get unique dates with exercise
    final exerciseDays = <DateTime>{};
    for (final activity in activities) {
      exerciseDays.add(DateTime(
        activity.timestamp.year,
        activity.timestamp.month,
        activity.timestamp.day,
      ));
    }

    if (exerciseDays.length < 3) {
      return (percentage: 0, hasEnoughData: false);
    }

    // Calculate average mood on exercise days vs non-exercise days
    double exerciseDayMoodSum = 0;
    int exerciseDayMoodCount = 0;
    double nonExerciseDayMoodSum = 0;
    int nonExerciseDayMoodCount = 0;

    for (final mood in moods) {
      final moodDate = DateTime(
        mood.timestamp.year,
        mood.timestamp.month,
        mood.timestamp.day,
      );

      if (exerciseDays.contains(moodDate)) {
        exerciseDayMoodSum += mood.score.value;
        exerciseDayMoodCount++;
      } else {
        nonExerciseDayMoodSum += mood.score.value;
        nonExerciseDayMoodCount++;
      }
    }

    if (exerciseDayMoodCount == 0 || nonExerciseDayMoodCount == 0) {
      return (percentage: 0, hasEnoughData: false);
    }

    final avgMoodWithExercise = exerciseDayMoodSum / exerciseDayMoodCount;
    final avgMoodWithoutExercise = nonExerciseDayMoodSum / nonExerciseDayMoodCount;

    if (avgMoodWithoutExercise == 0) {
      return (percentage: 0, hasEnoughData: false);
    }

    final moodLift = ((avgMoodWithExercise - avgMoodWithoutExercise) / avgMoodWithoutExercise) * 100;

    return (percentage: moodLift, hasEnoughData: true);
  }
}
