import 'package:hive_ce/hive.dart';

import '../models/user_settings_model.dart';

/// Remote data source using Hive as API simulator
/// TODO: Replace Hive implementation with real API calls when backend is ready
abstract class SettingsRemoteDataSource {
  Future<UserSettingsModel> getSettings();
  Future<UserSettingsModel> updateSettings(UserSettingsModel settings);
  Future<void> initializeSettings(UserSettingsModel settings);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  static const String boxName = 'settings';
  static const String settingsKey = 'user_settings';

  Box<UserSettingsModel> get _box => Hive.box<UserSettingsModel>(boxName);

  @override
  Future<UserSettingsModel> getSettings() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _box.get(settingsKey) ?? UserSettingsModel();
  }

  @override
  Future<UserSettingsModel> updateSettings(UserSettingsModel settings) async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _box.put(settingsKey, settings);
    return settings;
  }

  @override
  Future<void> initializeSettings(UserSettingsModel settings) async {
    if (_box.get(settingsKey) == null) {
      await _box.put(settingsKey, settings);
    }
  }
}
