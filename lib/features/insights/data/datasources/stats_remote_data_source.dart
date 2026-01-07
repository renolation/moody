import '../models/stats_model.dart';

abstract class StatsRemoteDataSource {
  Future<MonthlyStatsModel> getMonthlyStats(int year, int month);
  Future<WeeklyCorrelationModel> getWeeklyCorrelation();
}

class StatsRemoteDataSourceImpl implements StatsRemoteDataSource {
  @override
  Future<MonthlyStatsModel> getMonthlyStats(int year, int month) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Mock data - in real app this would come from API aggregating mood data
    return MonthlyStatsModel(
      year: year,
      month: month,
      dailyStats: {},
      totalMoods: 0,
      totalExerciseMinutes: 0,
      averageMood: 0.0,
    );
  }

  @override
  Future<WeeklyCorrelationModel> getWeeklyCorrelation() async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Mock data - in real app this would come from API
    return WeeklyCorrelationModel(
      days: [
        DayCorrelationModel(dayName: 'Mon', moodScore: null, exerciseMinutes: 0),
        DayCorrelationModel(dayName: 'Tue', moodScore: null, exerciseMinutes: 0),
        DayCorrelationModel(dayName: 'Wed', moodScore: null, exerciseMinutes: 0),
        DayCorrelationModel(dayName: 'Thu', moodScore: null, exerciseMinutes: 0),
        DayCorrelationModel(dayName: 'Fri', moodScore: null, exerciseMinutes: 0),
        DayCorrelationModel(dayName: 'Sat', moodScore: null, exerciseMinutes: 0),
        DayCorrelationModel(dayName: 'Sun', moodScore: null, exerciseMinutes: 0),
      ],
      correlationScore: null,
      insight: 'Log more moods and activities to see your correlation insights.',
    );
  }
}
