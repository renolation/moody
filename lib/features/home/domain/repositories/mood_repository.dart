import '../../../../core/enums/mood_score.dart';
import '../entities/mood_entry.dart';

abstract class MoodRepository {
  Future<List<MoodEntry>> getMoods({String? userId});
  Future<List<MoodEntry>> getMoodsByDate(DateTime date, {String? userId});
  Future<MoodEntry> addMood({required MoodScore score, String? note, String? userId});
  Future<void> deleteMood(int id);
}
