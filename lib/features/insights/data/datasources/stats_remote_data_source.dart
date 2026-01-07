import 'dart:math';

import '../models/stats_model.dart';

abstract class StatsRemoteDataSource {
  Future<MonthlyStatsModel> getMonthlyStats(int year, int month);
  Future<WeeklyCorrelationModel> getWeeklyCorrelation();
}

class StatsRemoteDataSourceImpl implements StatsRemoteDataSource {
  final _random = Random(42); // Fixed seed for consistent mock data

  @override
  Future<MonthlyStatsModel> getMonthlyStats(int year, int month) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Generate mock daily stats for the month
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final dailyStats = <int, DayMoodStatsModel>{};

    int totalMoods = 0;
    int totalExercise = 0;
    double moodSum = 0;

    for (int day = 1; day <= daysInMonth; day++) {
      // ~70% chance of having data for each day
      if (_random.nextDouble() < 0.7) {
        final moodCount = _random.nextInt(3) + 1; // 1-3 moods per day
        final avgMood = 2.5 + _random.nextDouble() * 2.5; // 2.5-5.0 range
        final exercise = _random.nextInt(60); // 0-59 minutes
        final date = DateTime(year, month, day).toIso8601String();

        dailyStats[day] = DayMoodStatsModel(
          date: date,
          moodCount: moodCount,
          averageMood: avgMood,
          exerciseMinutes: exercise,
        );

        totalMoods += moodCount;
        totalExercise += exercise;
        moodSum += avgMood;
      }
    }

    final avgMood = dailyStats.isEmpty ? 0.0 : moodSum / dailyStats.length;

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
    await Future.delayed(const Duration(milliseconds: 300));

    // Mock weekly correlation data showing mood vs exercise pattern
    final days = [
      DayCorrelationModel(
        dayName: 'Mon',
        moodScore: 3.2,
        exerciseMinutes: 15,
      ),
      DayCorrelationModel(
        dayName: 'Tue',
        moodScore: 3.8,
        exerciseMinutes: 30,
      ),
      DayCorrelationModel(
        dayName: 'Wed',
        moodScore: 4.2,
        exerciseMinutes: 45,
      ),
      DayCorrelationModel(
        dayName: 'Thu',
        moodScore: 3.5,
        exerciseMinutes: 20,
      ),
      DayCorrelationModel(
        dayName: 'Fri',
        moodScore: 4.5,
        exerciseMinutes: 60,
      ),
      DayCorrelationModel(
        dayName: 'Sat',
        moodScore: 4.8,
        exerciseMinutes: 50,
      ),
      DayCorrelationModel(
        dayName: 'Sun',
        moodScore: 4.0,
        exerciseMinutes: 25,
      ),
    ];

    return WeeklyCorrelationModel(
      days: days,
      correlationScore: 0.72,
      insight: 'You tend to feel 23% happier on days when you exercise more than 30 minutes.',
    );
  }
}
