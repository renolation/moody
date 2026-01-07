import '../../domain/entities/sound.dart';
import '../../domain/repositories/sound_repository.dart';
import '../datasources/sound_remote_data_source.dart';

class SoundRepositoryImpl implements SoundRepository {
  final SoundRemoteDataSource remoteDataSource;

  SoundRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Sound>> getSounds() async {
    final models = await remoteDataSource.getSounds();
    return models.map((m) => m.toEntity()).toList();
  }
}
