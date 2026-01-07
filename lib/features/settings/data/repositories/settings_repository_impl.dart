import '../../domain/entities/user_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_remote_data_source.dart';
import '../models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource remoteDataSource;

  SettingsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserSettings> getSettings() async {
    final model = await remoteDataSource.getSettings();
    return model.toEntity();
  }

  @override
  Future<UserSettings> updateSettings(UserSettings settings) async {
    final model = SettingsModel.fromEntity(settings);
    final result = await remoteDataSource.updateSettings(model);
    return result.toEntity();
  }
}
