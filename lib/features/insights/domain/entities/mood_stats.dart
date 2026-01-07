import 'package:equatable/equatable.dart';

class DayMoodStats extends Equatable {
  final DateTime date;
  final double? averageMood;
  final int moodCount;
  final int exerciseMinutes;

  const DayMoodStats({
    required this.date,
    this.averageMood,
    this.moodCount = 0,
    this.exerciseMinutes = 0,
  });

  @override
  List<Object?> get props => [date, averageMood, moodCount, exerciseMinutes];
}

class MonthlyStats extends Equatable {
  final int year;
  final int month;
  final double averageMood;
  final Map<int, DayMoodStats> dailyStats;
  final int totalMoods;
  final int totalExerciseMinutes;

  const MonthlyStats({
    required this.year,
    required this.month,
    required this.averageMood,
    required this.dailyStats,
    required this.totalMoods,
    required this.totalExerciseMinutes,
  });

  @override
  List<Object?> get props => [
        year,
        month,
        averageMood,
        dailyStats,
        totalMoods,
        totalExerciseMinutes,
      ];
}

class WeeklyCorrelation extends Equatable {
  final List<DayCorrelation> days;
  final double? correlationScore;
  final String? insight;

  const WeeklyCorrelation({
    required this.days,
    this.correlationScore,
    this.insight,
  });

  @override
  List<Object?> get props => [days, correlationScore, insight];
}

class DayCorrelation extends Equatable {
  final String dayName;
  final double? moodScore;
  final int exerciseMinutes;

  const DayCorrelation({
    required this.dayName,
    this.moodScore,
    this.exerciseMinutes = 0,
  });

  @override
  List<Object?> get props => [dayName, moodScore, exerciseMinutes];
}
