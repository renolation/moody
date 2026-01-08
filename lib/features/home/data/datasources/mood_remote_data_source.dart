import '../../../../core/services/backend_service.dart';
import '../models/mood_entry_model.dart';

/// Remote data source for mood entries using BackendService abstraction.
abstract class MoodRemoteDataSource {
  Future<List<MoodEntryModel>> getMoods({String? userId});
  Future<List<MoodEntryModel>> getMoodsByDate(DateTime date, {String? userId});
  Future<MoodEntryModel> addMood(MoodEntryModel mood);
  Future<void> deleteMood(int id);
  Future<int> getNextId();
  Future<void> initializeMoods(List<MoodEntryModel> moods);
}

class MoodRemoteDataSourceImpl implements MoodRemoteDataSource {
  static const String tableName = 'moods';

  final BackendService _backend;

  MoodRemoteDataSourceImpl(this._backend);

  @override
  Future<List<MoodEntryModel>> getMoods({String? userId}) async {
    final data = await _backend.query(
      tableName,
      equalFilters: {'user_id': userId},
      orderBy: 'timestamp',
    );
    return data.map((json) => MoodEntryModel.fromJson(json)).toList();
  }

  @override
  Future<List<MoodEntryModel>> getMoodsByDate(DateTime date, {String? userId}) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final data = await _backend.query(
      tableName,
      equalFilters: {'user_id': userId},
      greaterThanOrEqual: {'timestamp': startOfDay.toIso8601String()},
      lessThan: {'timestamp': endOfDay.toIso8601String()},
      orderBy: 'timestamp',
    );
    return data.map((json) => MoodEntryModel.fromJson(json)).toList();
  }

  @override
  Future<MoodEntryModel> addMood(MoodEntryModel mood) async {
    final data = await _backend.insert(tableName, mood.toJson());
    return MoodEntryModel.fromJson(data);
  }

  @override
  Future<void> deleteMood(int id) async {
    await _backend.delete(tableName, id);
  }

  @override
  Future<int> getNextId() async {
    final data = await _backend.getAll(tableName);
    if (data.isEmpty) return 1;
    final maxId = data
        .map((e) => e['id'] as int? ?? 0)
        .reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  @override
  Future<void> initializeMoods(List<MoodEntryModel> moods) async {
    final existing = await _backend.getAll(tableName);
    if (existing.isEmpty) {
      for (final mood in moods) {
        await _backend.insert(tableName, mood.toJson());
      }
    }
  }
}
