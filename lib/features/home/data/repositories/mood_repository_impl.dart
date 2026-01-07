import '../../../../core/enums/mood_score.dart';
import '../../domain/entities/mood_entry.dart';
import '../../domain/repositories/mood_repository.dart';
import '../datasources/mood_remote_data_source.dart';
import '../models/mood_entry_model.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodRemoteDataSource remoteDataSource;

  MoodRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MoodEntry>> getMoods() async {
    final models = await remoteDataSource.getMoods();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<MoodEntry>> getMoodsByDate(DateTime date) async {
    final models = await remoteDataSource.getMoods();
    return models
        .where((m) {
          final moodDate = DateTime.parse(m.timestamp);
          return moodDate.year == date.year &&
              moodDate.month == date.month &&
              moodDate.day == date.day;
        })
        .map((m) => m.toEntity())
        .toList();
  }

  @override
  Future<MoodEntry> addMood({required MoodScore score, String? note}) async {
    final model = MoodEntryModel(
      id: '',
      score: score.value,
      note: note,
      timestamp: DateTime.now().toIso8601String(),
    );
    final result = await remoteDataSource.addMood(model);
    return result.toEntity();
  }

  @override
  Future<void> deleteMood(String id) async {
    await remoteDataSource.deleteMood(id);
  }
}
