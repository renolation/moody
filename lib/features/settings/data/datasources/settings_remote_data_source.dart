import '../../../../core/services/backend_service.dart';
import '../models/user_settings_model.dart';

/// Remote data source for user settings using BackendService abstraction.
abstract class SettingsRemoteDataSource {
  Future<UserSettingsModel> getSettings({String? userId});
  Future<UserSettingsModel> updateSettings(UserSettingsModel settings, {String? userId});
  Future<void> initializeSettings(UserSettingsModel settings, {String? userId});
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  static const String tableName = 'settings';

  final BackendService _backend;

  SettingsRemoteDataSourceImpl(this._backend);

  @override
  Future<UserSettingsModel> getSettings({String? userId}) async {
    final data = await _backend.query(
      tableName,
      equalFilters: {'user_id': userId},
      limit: 1,
    );
    if (data.isNotEmpty) {
      return UserSettingsModel.fromJson(data.first);
    }
    return UserSettingsModel();
  }

  @override
  Future<UserSettingsModel> updateSettings(UserSettingsModel settings, {String? userId}) async {
    final existing = await _backend.query(
      tableName,
      equalFilters: {'user_id': userId},
      limit: 1,
    );
    final json = settings.toJson();
    json['user_id'] = userId;

    if (existing.isNotEmpty) {
      final existingId = existing.first['id'];
      final updated = await _backend.update(tableName, existingId, json);
      return UserSettingsModel.fromJson(updated);
    } else {
      final created = await _backend.insert(tableName, json);
      return UserSettingsModel.fromJson(created);
    }
  }

  @override
  Future<void> initializeSettings(UserSettingsModel settings, {String? userId}) async {
    final existing = await _backend.query(
      tableName,
      equalFilters: {'user_id': userId},
      limit: 1,
    );
    if (existing.isEmpty) {
      final json = settings.toJson();
      json['user_id'] = userId;
      await _backend.insert(tableName, json);
    }
  }
}
