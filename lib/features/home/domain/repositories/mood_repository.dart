import '../../../../core/enums/mood_score.dart';
import '../entities/mood_entry.dart';

abstract class MoodRepository {
  Future<List<MoodEntry>> getMoods();
  Future<List<MoodEntry>> getMoodsByDate(DateTime date);
  Future<MoodEntry> addMood({required MoodScore score, String? note});
  Future<void> deleteMood(String id);
}
