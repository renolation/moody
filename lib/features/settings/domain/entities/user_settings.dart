import 'package:equatable/equatable.dart';

import '../../../../core/enums/activity_type.dart';

class UserSettings extends Equatable {
  final String userName;
  final String? userEmail;
  final bool isVip;
  final bool healthSyncEnabled;
  final int dailyQuoteHour;
  final int dailyQuoteMinute;
  final int moodReminderHour;
  final int moodReminderMinute;
  final String theme;
  // Activity duration defaults (in minutes)
  final int walkingDuration;
  final int runningDuration;
  final int yogaDuration;
  final int gymDuration;
  final int cyclingDuration;

  const UserSettings({
    this.userName = 'Alex',
    this.userEmail,
    this.isVip = false,
    this.healthSyncEnabled = false,
    this.dailyQuoteHour = 8,
    this.dailyQuoteMinute = 0,
    this.moodReminderHour = 21,
    this.moodReminderMinute = 0,
    this.theme = 'dark',
    this.walkingDuration = 30,
    this.runningDuration = 30,
    this.yogaDuration = 30,
    this.gymDuration = 45,
    this.cyclingDuration = 30,
  });

  int getDurationForActivity(ActivityType type) {
    return switch (type) {
      ActivityType.walking => walkingDuration,
      ActivityType.running => runningDuration,
      ActivityType.yoga => yogaDuration,
      ActivityType.gym => gymDuration,
      ActivityType.cycling => cyclingDuration,
    };
  }

  UserSettings copyWith({
    String? userName,
    String? userEmail,
    bool? isVip,
    bool? healthSyncEnabled,
    int? dailyQuoteHour,
    int? dailyQuoteMinute,
    int? moodReminderHour,
    int? moodReminderMinute,
    String? theme,
    int? walkingDuration,
    int? runningDuration,
    int? yogaDuration,
    int? gymDuration,
    int? cyclingDuration,
  }) {
    return UserSettings(
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      isVip: isVip ?? this.isVip,
      healthSyncEnabled: healthSyncEnabled ?? this.healthSyncEnabled,
      dailyQuoteHour: dailyQuoteHour ?? this.dailyQuoteHour,
      dailyQuoteMinute: dailyQuoteMinute ?? this.dailyQuoteMinute,
      moodReminderHour: moodReminderHour ?? this.moodReminderHour,
      moodReminderMinute: moodReminderMinute ?? this.moodReminderMinute,
      theme: theme ?? this.theme,
      walkingDuration: walkingDuration ?? this.walkingDuration,
      runningDuration: runningDuration ?? this.runningDuration,
      yogaDuration: yogaDuration ?? this.yogaDuration,
      gymDuration: gymDuration ?? this.gymDuration,
      cyclingDuration: cyclingDuration ?? this.cyclingDuration,
    );
  }

  @override
  List<Object?> get props => [
        userName,
        userEmail,
        isVip,
        healthSyncEnabled,
        dailyQuoteHour,
        dailyQuoteMinute,
        moodReminderHour,
        moodReminderMinute,
        theme,
        walkingDuration,
        runningDuration,
        yogaDuration,
        gymDuration,
        cyclingDuration,
      ];
}
