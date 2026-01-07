import '../models/sound_model.dart';

abstract class SoundRemoteDataSource {
  Future<List<SoundModel>> getSounds();
}

class SoundRemoteDataSourceImpl implements SoundRemoteDataSource {
  // Mock data simulating API response
  static final List<SoundModel> _defaultSounds = [
    SoundModel(
      id: 'rain',
      name: 'Rain',
      icon: 'water_drop',
      assetPath: 'assets/sounds/rain.mp3',
    ),
    SoundModel(
      id: 'forest',
      name: 'Forest',
      icon: 'forest',
      assetPath: 'assets/sounds/forest.mp3',
    ),
    SoundModel(
      id: 'ocean',
      name: 'Ocean Waves',
      icon: 'waves',
      assetPath: 'assets/sounds/ocean.mp3',
    ),
    SoundModel(
      id: 'fire',
      name: 'Fireplace',
      icon: 'local_fire_department',
      assetPath: 'assets/sounds/fire.mp3',
    ),
    SoundModel(
      id: 'wind',
      name: 'Wind',
      icon: 'air',
      assetPath: 'assets/sounds/wind.mp3',
    ),
    SoundModel(
      id: 'birds',
      name: 'Birds',
      icon: 'flutter_dash',
      assetPath: 'assets/sounds/birds.mp3',
    ),
    SoundModel(
      id: 'thunder',
      name: 'Thunder',
      icon: 'thunderstorm',
      assetPath: 'assets/sounds/thunder.mp3',
      isPremium: true,
    ),
    SoundModel(
      id: 'stream',
      name: 'Stream',
      icon: 'water',
      assetPath: 'assets/sounds/stream.mp3',
      isPremium: true,
    ),
  ];

  @override
  Future<List<SoundModel>> getSounds() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_defaultSounds);
  }
}
