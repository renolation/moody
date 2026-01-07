import 'package:equatable/equatable.dart';

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
  });

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
      ];
}
