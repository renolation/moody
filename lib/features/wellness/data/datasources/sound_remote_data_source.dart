import '../../../../core/services/backend_service.dart';
import '../models/sound_model.dart';

/// Remote data source for sounds using BackendService abstraction.
abstract class SoundRemoteDataSource {
  Future<List<SoundModel>> getSounds();
  Future<void> initializeSounds(List<SoundModel> sounds);
}

class SoundRemoteDataSourceImpl implements SoundRemoteDataSource {
  static const String tableName = 'sounds';

  final BackendService _backend;

  SoundRemoteDataSourceImpl(this._backend);

  @override
  Future<List<SoundModel>> getSounds() async {
    final data = await _backend.getAll(tableName);
    return data.map((json) => SoundModel.fromJson(json)).toList();
  }

  @override
  Future<void> initializeSounds(List<SoundModel> sounds) async {
    final existing = await _backend.getAll(tableName);
    if (existing.isEmpty) {
      for (final sound in sounds) {
        await _backend.insert(tableName, sound.toJson());
      }
    }
  }
}
