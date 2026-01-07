import 'package:hive_ce/hive.dart';

import '../models/sound_model.dart';

/// Remote data source using Hive as API simulator
/// TODO: Replace Hive implementation with real API calls when backend is ready
abstract class SoundRemoteDataSource {
  Future<List<SoundModel>> getSounds();
  Future<void> initializeSounds(List<SoundModel> sounds);
}

class SoundRemoteDataSourceImpl implements SoundRemoteDataSource {
  static const String boxName = 'sounds';

  Box<SoundModel> get _box => Hive.box<SoundModel>(boxName);

  @override
  Future<List<SoundModel>> getSounds() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _box.values.toList();
  }

  @override
  Future<void> initializeSounds(List<SoundModel> sounds) async {
    if (_box.isEmpty) {
      for (final sound in sounds) {
        await _box.put(sound.id, sound);
      }
    }
  }
}
