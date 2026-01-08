import '../../../../core/services/backend_service.dart';
import '../models/user_settings_model.dart';

/// Remote data source for user settings using BackendService abstraction.
abstract class SettingsRemoteDataSource {
  Future<UserSettingsModel> getSettings();
  Future<UserSettingsModel> updateSettings(UserSettingsModel settings);
  Future<void> initializeSettings(UserSettingsModel settings);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  static const String tableName = 'settings';
  static const int defaultSettingsId = 1;

  final BackendService _backend;

  SettingsRemoteDataSourceImpl(this._backend);

  @override
  Future<UserSettingsModel> getSettings() async {
    final data = await _backend.getById(tableName, defaultSettingsId);
    if (data != null) {
      return UserSettingsModel.fromJson(data);
    }
    return UserSettingsModel();
  }

  @override
  Future<UserSettingsModel> updateSettings(UserSettingsModel settings) async {
    final existing = await _backend.getById(tableName, defaultSettingsId);
    final json = settings.toJson();
    json['id'] = defaultSettingsId;

    if (existing != null) {
      final updated = await _backend.update(tableName, defaultSettingsId, json);
      return UserSettingsModel.fromJson(updated);
    } else {
      final created = await _backend.insert(tableName, json);
      return UserSettingsModel.fromJson(created);
    }
  }

  @override
  Future<void> initializeSettings(UserSettingsModel settings) async {
    final existing = await _backend.getById(tableName, defaultSettingsId);
    if (existing == null) {
      final json = settings.toJson();
      json['id'] = defaultSettingsId;
      await _backend.insert(tableName, json);
    }
  }
}
