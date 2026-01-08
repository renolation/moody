import 'package:hive_ce/hive.dart';

import '../../../../core/enums/mood_score.dart';
import '../../domain/entities/mood_entry.dart';

part 'mood_entry_model.g.dart';

@HiveType(typeId: 0)
class MoodEntryModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int score;

  @HiveField(2)
  final String? note;

  @HiveField(3)
  final List<String> tags;

  @HiveField(4)
  final DateTime timestamp;

  @HiveField(5)
  final String? userId;

  MoodEntryModel({
    required this.id,
    required this.score,
    this.note,
    this.tags = const [],
    required this.timestamp,
    this.userId,
  });

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) {
    return MoodEntryModel(
      id: json['id'] as int,
      score: json['score'] as int,
      note: json['note'] as String?,
      tags: (json['tags'] as List?)?.cast<String>() ?? [],
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'score': score,
      'note': note,
      'tags': tags,
      'timestamp': timestamp.toIso8601String(),
      'user_id': userId,
    };
  }

  MoodEntry toEntity() {
    return MoodEntry(
      id: id,
      userId: userId,
      score: MoodScore.values.firstWhere((e) => e.value == score),
      note: note,
      tags: tags,
      timestamp: timestamp,
    );
  }

  factory MoodEntryModel.fromEntity(MoodEntry entity) {
    return MoodEntryModel(
      id: entity.id,
      userId: entity.userId,
      score: entity.score.value,
      note: entity.note,
      tags: entity.tags,
      timestamp: entity.timestamp,
    );
  }
}
