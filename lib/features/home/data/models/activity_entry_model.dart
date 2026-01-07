import '../../../../core/enums/activity_type.dart';
import '../../domain/entities/activity_entry.dart';

class ActivityEntryModel {
  final String id;
  final String type;
  final int duration;
  final String timestamp;

  ActivityEntryModel({
    required this.id,
    required this.type,
    required this.duration,
    required this.timestamp,
  });

  factory ActivityEntryModel.fromJson(Map<String, dynamic> json) {
    return ActivityEntryModel(
      id: json['id'] as String,
      type: json['type'] as String,
      duration: json['duration'] as int,
      timestamp: json['timestamp'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'duration': duration,
      'timestamp': timestamp,
    };
  }

  ActivityEntry toEntity() {
    return ActivityEntry(
      id: id,
      type: ActivityType.values.firstWhere((e) => e.name == type),
      duration: duration,
      timestamp: DateTime.parse(timestamp),
    );
  }

  factory ActivityEntryModel.fromEntity(ActivityEntry entity) {
    return ActivityEntryModel(
      id: entity.id,
      type: entity.type.name,
      duration: entity.duration,
      timestamp: entity.timestamp.toIso8601String(),
    );
  }
}
