import '../../../../core/enums/mood_score.dart';
import '../../domain/entities/mood_entry.dart';

class MoodEntryModel {
  final String id;
  final int score;
  final String? note;
  final String timestamp;

  MoodEntryModel({
    required this.id,
    required this.score,
    this.note,
    required this.timestamp,
  });

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) {
    return MoodEntryModel(
      id: json['id'] as String,
      score: json['score'] as int,
      note: json['note'] as String?,
      timestamp: json['timestamp'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'score': score,
      'note': note,
      'timestamp': timestamp,
    };
  }

  MoodEntry toEntity() {
    return MoodEntry(
      id: id,
      score: MoodScore.values.firstWhere((e) => e.value == score),
      note: note,
      timestamp: DateTime.parse(timestamp),
    );
  }

  factory MoodEntryModel.fromEntity(MoodEntry entity) {
    return MoodEntryModel(
      id: entity.id,
      score: entity.score.value,
      note: entity.note,
      timestamp: entity.timestamp.toIso8601String(),
    );
  }
}
