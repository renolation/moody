import '../entities/user_settings.dart';

abstract class SettingsRepository {
  Future<UserSettings> getSettings({String? userId});
  Future<UserSettings> updateSettings(UserSettings settings, {String? userId});
}
