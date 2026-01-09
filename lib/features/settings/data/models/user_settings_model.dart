import 'package:hive_ce/hive.dart';

import '../../domain/entities/user_settings.dart';

part 'user_settings_model.g.dart';

@HiveType(typeId: 5)
class UserSettingsModel extends HiveObject {
  @HiveField(0)
  final String userName;

  @HiveField(1)
  final String? userEmail;

  @HiveField(2)
  final bool isVip;

  @HiveField(3)
  final bool healthSyncEnabled;

  @HiveField(4)
  final int dailyQuoteHour;

  @HiveField(5)
  final int dailyQuoteMinute;

  @HiveField(6)
  final int moodReminderHour;

  @HiveField(7)
  final int moodReminderMinute;

  @HiveField(8)
  final String theme;

  @HiveField(9)
  final int walkingDuration;

  @HiveField(10)
  final int runningDuration;

  @HiveField(11)
  final int yogaDuration;

  @HiveField(12)
  final int gymDuration;

  @HiveField(13)
  final int cyclingDuration;

  UserSettingsModel({
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

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      userName: json['user_name'] as String? ?? 'Alex',
      userEmail: json['user_email'] as String?,
      isVip: json['is_vip'] as bool? ?? false,
      healthSyncEnabled: json['health_sync_enabled'] as bool? ?? false,
      dailyQuoteHour: json['daily_quote_hour'] as int? ?? 8,
      dailyQuoteMinute: json['daily_quote_minute'] as int? ?? 0,
      moodReminderHour: json['mood_reminder_hour'] as int? ?? 21,
      moodReminderMinute: json['mood_reminder_minute'] as int? ?? 0,
      theme: json['theme'] as String? ?? 'dark',
      walkingDuration: json['walking_duration'] as int? ?? 30,
      runningDuration: json['running_duration'] as int? ?? 30,
      yogaDuration: json['yoga_duration'] as int? ?? 30,
      gymDuration: json['gym_duration'] as int? ?? 45,
      cyclingDuration: json['cycling_duration'] as int? ?? 30,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': userName,
      'user_email': userEmail,
      'is_vip': isVip,
      'health_sync_enabled': healthSyncEnabled,
      'daily_quote_hour': dailyQuoteHour,
      'daily_quote_minute': dailyQuoteMinute,
      'mood_reminder_hour': moodReminderHour,
      'mood_reminder_minute': moodReminderMinute,
      'theme': theme,
      'walking_duration': walkingDuration,
      'running_duration': runningDuration,
      'yoga_duration': yogaDuration,
      'gym_duration': gymDuration,
      'cycling_duration': cyclingDuration,
    };
  }

  UserSettings toEntity() {
    return UserSettings(
      userName: userName,
      userEmail: userEmail,
      isVip: isVip,
      healthSyncEnabled: healthSyncEnabled,
      dailyQuoteHour: dailyQuoteHour,
      dailyQuoteMinute: dailyQuoteMinute,
      moodReminderHour: moodReminderHour,
      moodReminderMinute: moodReminderMinute,
      theme: theme,
      walkingDuration: walkingDuration,
      runningDuration: runningDuration,
      yogaDuration: yogaDuration,
      gymDuration: gymDuration,
      cyclingDuration: cyclingDuration,
    );
  }

  factory UserSettingsModel.fromEntity(UserSettings entity) {
    return UserSettingsModel(
      userName: entity.userName,
      userEmail: entity.userEmail,
      isVip: entity.isVip,
      healthSyncEnabled: entity.healthSyncEnabled,
      dailyQuoteHour: entity.dailyQuoteHour,
      dailyQuoteMinute: entity.dailyQuoteMinute,
      moodReminderHour: entity.moodReminderHour,
      moodReminderMinute: entity.moodReminderMinute,
      theme: entity.theme,
      walkingDuration: entity.walkingDuration,
      runningDuration: entity.runningDuration,
      yogaDuration: entity.yogaDuration,
      gymDuration: entity.gymDuration,
      cyclingDuration: entity.cyclingDuration,
    );
  }
}
