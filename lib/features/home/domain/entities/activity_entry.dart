import 'package:equatable/equatable.dart';

import '../../../../core/enums/activity_type.dart';

class ActivityEntry extends Equatable {
  final int id;
  final ActivityType type;
  final int duration; // in minutes
  final int intensity; // 1-3
  final DateTime timestamp;

  const ActivityEntry({
    required this.id,
    required this.type,
    required this.duration,
    this.intensity = 2,
    required this.timestamp,
  });

  ActivityEntry copyWith({
    int? id,
    ActivityType? type,
    int? duration,
    int? intensity,
    DateTime? timestamp,
  }) {
    return ActivityEntry(
      id: id ?? this.id,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      intensity: intensity ?? this.intensity,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [id, type, duration, intensity, timestamp];
}
