import '../entities/sound.dart';

abstract class SoundRepository {
  Future<List<Sound>> getSounds();
}
