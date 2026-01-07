import 'package:hive_ce/hive.dart';

import '../../../../core/enums/activity_type.dart';
import '../../domain/entities/activity_entry.dart';

part 'activity_entry_model.g.dart';

@HiveType(typeId: 1)
class ActivityEntryModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final int duration;

  @HiveField(3)
  final int intensity;

  @HiveField(4)
  final DateTime timestamp;

  ActivityEntryModel({
    required this.id,
    required this.type,
    required this.duration,
    this.intensity = 2,
    required this.timestamp,
  });

  factory ActivityEntryModel.fromJson(Map<String, dynamic> json) {
    return ActivityEntryModel(
      id: json['id'] as int,
      type: json['type'] as String,
      duration: json['duration'] as int,
      intensity: json['intensity'] as int? ?? 2,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'duration': duration,
      'intensity': intensity,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  ActivityEntry toEntity() {
    return ActivityEntry(
      id: id,
      type: ActivityType.values.firstWhere((e) => e.name == type),
      duration: duration,
      intensity: intensity,
      timestamp: timestamp,
    );
  }

  factory ActivityEntryModel.fromEntity(ActivityEntry entity) {
    return ActivityEntryModel(
      id: entity.id,
      type: entity.type.name,
      duration: entity.duration,
      intensity: entity.intensity,
      timestamp: entity.timestamp,
    );
  }
}
