import 'package:uuid/uuid.dart';

import '../models/mood_entry_model.dart';

abstract class MoodRemoteDataSource {
  Future<List<MoodEntryModel>> getMoods();
  Future<MoodEntryModel> addMood(MoodEntryModel mood);
  Future<void> deleteMood(String id);
}

class MoodRemoteDataSourceImpl implements MoodRemoteDataSource {
  final _uuid = const Uuid();

  // In-memory storage simulating API database
  final List<MoodEntryModel> _moods = [];

  @override
  Future<List<MoodEntryModel>> getMoods() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_moods);
  }

  @override
  Future<MoodEntryModel> addMood(MoodEntryModel mood) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final newMood = MoodEntryModel(
      id: _uuid.v4(),
      score: mood.score,
      note: mood.note,
      timestamp: mood.timestamp,
    );
    _moods.add(newMood);
    return newMood;
  }

  @override
  Future<void> deleteMood(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _moods.removeWhere((m) => m.id == id);
  }
}
