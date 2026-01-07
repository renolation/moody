import 'package:hive_ce/hive.dart';

import '../models/mood_entry_model.dart';

/// Remote data source using Hive as API simulator
/// TODO: Replace Hive implementation with real API calls when backend is ready
abstract class MoodRemoteDataSource {
  Future<List<MoodEntryModel>> getMoods();
  Future<List<MoodEntryModel>> getMoodsByDate(DateTime date);
  Future<MoodEntryModel> addMood(MoodEntryModel mood);
  Future<void> deleteMood(int id);
  Future<int> getNextId();
  Future<void> initializeMoods(List<MoodEntryModel> moods);
}

class MoodRemoteDataSourceImpl implements MoodRemoteDataSource {
  static const String boxName = 'moods';

  Box<MoodEntryModel> get _box => Hive.box<MoodEntryModel>(boxName);

  @override
  Future<List<MoodEntryModel>> getMoods() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    return _box.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  @override
  Future<List<MoodEntryModel>> getMoodsByDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _box.values.where((m) {
      return m.timestamp.year == date.year &&
          m.timestamp.month == date.month &&
          m.timestamp.day == date.day;
    }).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  @override
  Future<MoodEntryModel> addMood(MoodEntryModel mood) async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _box.put(mood.id, mood);
    return mood;
  }

  @override
  Future<void> deleteMood(int id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _box.delete(id);
  }

  @override
  Future<int> getNextId() async {
    if (_box.isEmpty) return 1;
    final maxId = _box.values.map((e) => e.id).reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  @override
  Future<void> initializeMoods(List<MoodEntryModel> moods) async {
    if (_box.isEmpty) {
      for (final mood in moods) {
        await _box.put(mood.id, mood);
      }
    }
  }
}
