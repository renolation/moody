import '../../../../core/enums/mood_score.dart';

class MoodEntry {
  final String id;
  final MoodScore score;
  final String? note;
  final List<String> tags;
  final DateTime timestamp;

  const MoodEntry({
    required this.id,
    required this.score,
    this.note,
    this.tags = const [],
    required this.timestamp,
  });

  MoodEntry copyWith({
    String? id,
    MoodScore? score,
    String? note,
    List<String>? tags,
    DateTime? timestamp,
  }) {
    return MoodEntry(
      id: id ?? this.id,
      score: score ?? this.score,
      note: note ?? this.note,
      tags: tags ?? this.tags,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
