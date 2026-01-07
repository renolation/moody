import 'package:hive_ce/hive.dart';

import '../../../home/data/models/mood_entry_model.dart';
import '../../../home/data/models/activity_entry_model.dart';
import '../models/stats_model.dart';

/// Remote data source using Hive as API simulator
/// TODO: Replace Hive implementation with real API calls when backend is ready
abstract class StatsRemoteDataSource {
  Future<MonthlyStatsModel> getMonthlyStats(int year, int month);
  Future<WeeklyCorrelationModel> getWeeklyCorrelation();
}

class StatsRemoteDataSourceImpl implements StatsRemoteDataSource {
  Box<MoodEntryModel> get _moodBox => Hive.box<MoodEntryModel>('moods');
  Box<ActivityEntryModel> get _activityBox =>
      Hive.box<ActivityEntryModel>('activities');

  @override
  Future<MonthlyStatsModel> getMonthlyStats(int year, int month) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final daysInMonth = DateTime(year, month + 1, 0).day;
    final dailyStats = <int, DayMoodStatsModel>{};

    int totalMoods = 0;
    int totalExercise = 0;
    double moodSum = 0;
    int daysWithData = 0;

    // Get all moods and activities for the month
    final moods = _moodBox.values.where((m) {
      return m.timestamp.year == year && m.timestamp.month == month;
    }).toList();

    final activities = _activityBox.values.where((a) {
      return a.timestamp.year == year && a.timestamp.month == month;
    }).toList();

    for (int day = 1; day <= daysInMonth; day++) {
      final dayMoods = moods.where((m) => m.timestamp.day == day).toList();
      final dayActivities =
          activities.where((a) => a.timestamp.day == day).toList();

      if (dayMoods.isNotEmpty || dayActivities.isNotEmpty) {
        final moodCount = dayMoods.length;
        final avgMood = dayMoods.isEmpty
            ? 0.0
            : dayMoods.map((m) => m.score).reduce((a, b) => a + b) /
                dayMoods.length;
        final exerciseMinutes =
            dayActivities.fold(0, (sum, a) => sum + a.duration);

        dailyStats[day] = DayMoodStatsModel(
          date: DateTime(year, month, day).toIso8601String(),
          moodCount: moodCount,
          averageMood: avgMood.toDouble(),
          exerciseMinutes: exerciseMinutes,
        );

        totalMoods += moodCount;
        totalExercise += exerciseMinutes;
        if (dayMoods.isNotEmpty) {
          moodSum += avgMood;
          daysWithData++;
        }
      }
    }

    final avgMood = daysWithData == 0 ? 0.0 : moodSum / daysWithData;

    return MonthlyStatsModel(
      year: year,
      month: month,
      dailyStats: dailyStats,
      totalMoods: totalMoods,
      totalExerciseMinutes: totalExercise,
      averageMood: avgMood,
    );
  }

  @override
  Future<WeeklyCorrelationModel> getWeeklyCorrelation() async {
    await Future.delayed(const Duration(milliseconds: 200));

    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final days = <DayCorrelationModel>[];
    int daysWithMood = 0;
    int daysWithExercise = 0;

    for (int i = 0; i < 7; i++) {
      final date = startOfWeek.add(Duration(days: i));
      final dayMoods = _moodBox.values.where((m) {
        return m.timestamp.year == date.year &&
            m.timestamp.month == date.month &&
            m.timestamp.day == date.day;
      }).toList();

      final dayActivities = _activityBox.values.where((a) {
        return a.timestamp.year == date.year &&
            a.timestamp.month == date.month &&
            a.timestamp.day == date.day;
      }).toList();

      final avgMood = dayMoods.isEmpty
          ? null
          : dayMoods.map((m) => m.score).reduce((a, b) => a + b) /
              dayMoods.length;
      final exerciseMinutes =
          dayActivities.fold(0, (sum, a) => sum + a.duration);

      days.add(DayCorrelationModel(
        dayName: dayNames[i],
        moodScore: avgMood?.toDouble(),
        exerciseMinutes: exerciseMinutes,
      ));

      if (avgMood != null) {
        daysWithMood++;
      }
      if (exerciseMinutes > 0) {
        daysWithExercise++;
      }
    }

    // Generate insight based on data
    String? insight;
    double? correlationScore;

    if (daysWithMood >= 3 && daysWithExercise >= 2) {
      // Simple correlation: compare mood on exercise days vs non-exercise days
      double moodOnExerciseDays = 0;
      int exerciseDays = 0;
      double moodOnRestDays = 0;
      int restDays = 0;

      for (final day in days) {
        if (day.moodScore != null) {
          if (day.exerciseMinutes > 0) {
            moodOnExerciseDays += day.moodScore!;
            exerciseDays++;
          } else {
            moodOnRestDays += day.moodScore!;
            restDays++;
          }
        }
      }

      if (exerciseDays > 0 && restDays > 0) {
        final avgMoodExercise = moodOnExerciseDays / exerciseDays;
        final avgMoodRest = moodOnRestDays / restDays;
        final improvement =
            ((avgMoodExercise - avgMoodRest) / avgMoodRest * 100).round();

        if (improvement > 0) {
          insight = 'You feel $improvement% better on days when you exercise.';
          correlationScore = 0.5 + (improvement / 100).clamp(0.0, 0.5);
        }
      }
    }

    return WeeklyCorrelationModel(
      days: days,
      correlationScore: correlationScore,
      insight: insight,
    );
  }
}
