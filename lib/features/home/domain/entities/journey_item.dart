import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/activity_type.dart';
import '../../../../core/enums/mood_score.dart';

enum JourneyItemType { mood, activity }

class JourneyItem extends Equatable {
  final int id;
  final JourneyItemType type;
  final DateTime timestamp;
  final String title;
  final IconData icon;
  final int? moodScore;
  final ActivityType? activityType;
  final int? duration;

  const JourneyItem({
    required this.id,
    required this.type,
    required this.timestamp,
    required this.title,
    required this.icon,
    this.moodScore,
    this.activityType,
    this.duration,
  });

  factory JourneyItem.fromMood({
    required int id,
    required MoodScore score,
    required DateTime timestamp,
    String? note,
  }) {
    final title = note ?? score.label;
    return JourneyItem(
      id: id,
      type: JourneyItemType.mood,
      timestamp: timestamp,
      title: title,
      icon: score.icon,
      moodScore: score.value,
    );
  }

  factory JourneyItem.fromActivity({
    required int id,
    required ActivityType activityType,
    required int duration,
    required DateTime timestamp,
  }) {
    return JourneyItem(
      id: id,
      type: JourneyItemType.activity,
      timestamp: timestamp,
      title: '${duration}m ${activityType.label}',
      icon: activityType.icon,
      activityType: activityType,
      duration: duration,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        timestamp,
        title,
        icon,
        moodScore,
        activityType,
        duration,
      ];
}
