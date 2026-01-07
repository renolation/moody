import '../entities/mood_stats.dart';

abstract class StatsRepository {
  Future<MonthlyStats> getMonthlyStats(int year, int month);
  Future<WeeklyCorrelation> getWeeklyCorrelation();
}
