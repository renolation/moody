import '../../../../core/enums/mood_score.dart';
import '../../domain/entities/mood_entry.dart';
import '../../domain/repositories/mood_repository.dart';
import '../datasources/mood_remote_data_source.dart';
import '../models/mood_entry_model.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodRemoteDataSource remoteDataSource;

  MoodRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MoodEntry>> getMoods({String? userId}) async {
    final models = await remoteDataSource.getMoods(userId: userId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<MoodEntry>> getMoodsByDate(DateTime date, {String? userId}) async {
    final models = await remoteDataSource.getMoodsByDate(date, userId: userId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<MoodEntry> addMood({required MoodScore score, String? note, String? userId}) async {
    final id = await remoteDataSource.getNextId();
    final model = MoodEntryModel(
      id: id,
      score: score.value,
      note: note,
      timestamp: DateTime.now(),
      userId: userId,
    );
    final result = await remoteDataSource.addMood(model);
    return result.toEntity();
  }

  @override
  Future<void> deleteMood(int id) async {
    await remoteDataSource.deleteMood(id);
  }
}
