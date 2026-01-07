import '../../domain/entities/user_settings.dart';

class SettingsModel {
  final String userName;
  final String? userEmail;
  final bool isVip;
  final bool healthSyncEnabled;
  final int dailyQuoteHour;
  final int dailyQuoteMinute;
  final int moodReminderHour;
  final int moodReminderMinute;
  final String theme;

  SettingsModel({
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

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
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

  factory SettingsModel.fromEntity(UserSettings entity) {
    return SettingsModel(
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
