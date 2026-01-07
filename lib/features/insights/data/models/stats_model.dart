import '../../domain/entities/mood_stats.dart';

class DayMoodStatsModel {
  final String date;
  final double? averageMood;
  final int moodCount;
  final int exerciseMinutes;

  DayMoodStatsModel({
    required this.date,
    this.averageMood,
    this.moodCount = 0,
    this.exerciseMinutes = 0,
  });

  factory DayMoodStatsModel.fromJson(Map<String, dynamic> json) {
    return DayMoodStatsModel(
      date: json['date'] as String,
      averageMood: (json['averageMood'] as num?)?.toDouble(),
      moodCount: json['moodCount'] as int? ?? 0,
      exerciseMinutes: json['exerciseMinutes'] as int? ?? 0,
    );
  }

  DayMoodStats toEntity() {
    return DayMoodStats(
      date: DateTime.parse(date),
      averageMood: averageMood,
      moodCount: moodCount,
      exerciseMinutes: exerciseMinutes,
    );
  }
}

class MonthlyStatsModel {
  final int year;
  final int month;
  final double averageMood;
  final Map<int, DayMoodStatsModel> dailyStats;
  final int totalMoods;
  final int totalExerciseMinutes;

  MonthlyStatsModel({
    required this.year,
    required this.month,
    required this.averageMood,
    required this.dailyStats,
    required this.totalMoods,
    required this.totalExerciseMinutes,
  });

  factory MonthlyStatsModel.fromJson(Map<String, dynamic> json) {
    final dailyStatsMap = <int, DayMoodStatsModel>{};
    if (json['dailyStats'] != null) {
      (json['dailyStats'] as Map).forEach((key, value) {
        dailyStatsMap[int.parse(key.toString())] =
            DayMoodStatsModel.fromJson(value as Map<String, dynamic>);
      });
    }

    return MonthlyStatsModel(
      year: json['year'] as int,
      month: json['month'] as int,
      averageMood: (json['averageMood'] as num).toDouble(),
      dailyStats: dailyStatsMap,
      totalMoods: json['totalMoods'] as int,
      totalExerciseMinutes: json['totalExerciseMinutes'] as int,
    );
  }

  MonthlyStats toEntity() {
    return MonthlyStats(
      year: year,
      month: month,
      averageMood: averageMood,
      dailyStats: dailyStats.map((k, v) => MapEntry(k, v.toEntity())),
      totalMoods: totalMoods,
      totalExerciseMinutes: totalExerciseMinutes,
    );
  }
}

class DayCorrelationModel {
  final String dayName;
  final double? moodScore;
  final int exerciseMinutes;

  DayCorrelationModel({
    required this.dayName,
    this.moodScore,
    this.exerciseMinutes = 0,
  });

  factory DayCorrelationModel.fromJson(Map<String, dynamic> json) {
    return DayCorrelationModel(
      dayName: json['dayName'] as String,
      moodScore: (json['moodScore'] as num?)?.toDouble(),
      exerciseMinutes: json['exerciseMinutes'] as int? ?? 0,
    );
  }

  DayCorrelation toEntity() {
    return DayCorrelation(
      dayName: dayName,
      moodScore: moodScore,
      exerciseMinutes: exerciseMinutes,
    );
  }
}

class WeeklyCorrelationModel {
  final List<DayCorrelationModel> days;
  final double? correlationScore;
  final String? insight;

  WeeklyCorrelationModel({
    required this.days,
    this.correlationScore,
    this.insight,
  });

  factory WeeklyCorrelationModel.fromJson(Map<String, dynamic> json) {
    return WeeklyCorrelationModel(
      days: (json['days'] as List)
          .map((e) => DayCorrelationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      correlationScore: (json['correlationScore'] as num?)?.toDouble(),
      insight: json['insight'] as String?,
    );
  }

  WeeklyCorrelation toEntity() {
    return WeeklyCorrelation(
      days: days.map((d) => d.toEntity()).toList(),
      correlationScore: correlationScore,
      insight: insight,
    );
  }
}
