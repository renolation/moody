import 'package:equatable/equatable.dart';

import '../../../../core/enums/mood_score.dart';

class MoodEntry extends Equatable {
  final int id;
  final String? userId;
  final MoodScore score;
  final String? note;
  final List<String> tags;
  final DateTime timestamp;

  const MoodEntry({
    required this.id,
    this.userId,
    required this.score,
    this.note,
    this.tags = const [],
    required this.timestamp,
  });

  MoodEntry copyWith({
    int? id,
    String? userId,
    MoodScore? score,
    String? note,
    List<String>? tags,
    DateTime? timestamp,
  }) {
    return MoodEntry(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      score: score ?? this.score,
      note: note ?? this.note,
      tags: tags ?? this.tags,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [id, userId, score, note, tags, timestamp];
}
