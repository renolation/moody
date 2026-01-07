import '../models/settings_model.dart';

abstract class SettingsRemoteDataSource {
  Future<SettingsModel> getSettings();
  Future<SettingsModel> updateSettings(SettingsModel settings);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  // In-memory storage simulating API database
  SettingsModel _settings = SettingsModel();

  @override
  Future<SettingsModel> getSettings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _settings;
  }

  @override
  Future<SettingsModel> updateSettings(SettingsModel settings) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _settings = settings;
    return _settings;
  }
}
