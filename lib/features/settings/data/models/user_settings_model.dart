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
  });

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      userName: json['userName'] as String? ?? 'Alex',
      userEmail: json['userEmail'] as String?,
      isVip: json['isVip'] as bool? ?? false,
      healthSyncEnabled: json['healthSyncEnabled'] as bool? ?? false,
      dailyQuoteHour: json['dailyQuoteHour'] as int? ?? 8,
      dailyQuoteMinute: json['dailyQuoteMinute'] as int? ?? 0,
      moodReminderHour: json['moodReminderHour'] as int? ?? 21,
      moodReminderMinute: json['moodReminderMinute'] as int? ?? 0,
      theme: json['theme'] as String? ?? 'dark',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'isVip': isVip,
      'healthSyncEnabled': healthSyncEnabled,
      'dailyQuoteHour': dailyQuoteHour,
      'dailyQuoteMinute': dailyQuoteMinute,
      'moodReminderHour': moodReminderHour,
      'moodReminderMinute': moodReminderMinute,
      'theme': theme,
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
    );
  }
}
