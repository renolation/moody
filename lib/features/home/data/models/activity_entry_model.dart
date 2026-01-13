import 'package:hive_ce/hive.dart';

import '../../../../core/enums/activity_type.dart';
import '../../../../core/extensions/date_time_extensions.dart';
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

  @HiveField(5)
  final String? userId;

  ActivityEntryModel({
    required this.id,
    required this.type,
    required this.duration,
    this.intensity = 2,
    required this.timestamp,
    this.userId,
  });

  factory ActivityEntryModel.fromJson(Map<String, dynamic> json) {
    return ActivityEntryModel(
      id: json['id'] as int,
      type: json['type'] as String,
      duration: json['duration'] as int,
      intensity: json['intensity'] as int? ?? 2,
      timestamp: DateTimeParser.parseToLocal(json['timestamp'] as String),
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'duration': duration,
      'intensity': intensity,
      'timestamp': timestamp.toIso8601StringWithOffset(),
      'user_id': userId,
    };
  }

  ActivityEntry toEntity() {
    return ActivityEntry(
      id: id,
      userId: userId,
      type: ActivityType.values.firstWhere((e) => e.name == type),
      duration: duration,
      intensity: intensity,
      timestamp: timestamp,
    );
  }

  factory ActivityEntryModel.fromEntity(ActivityEntry entity) {
    return ActivityEntryModel(
      id: entity.id,
      userId: entity.userId,
      type: entity.type.name,
      duration: entity.duration,
      intensity: entity.intensity,
      timestamp: entity.timestamp,
    );
  }
}
