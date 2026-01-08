import 'package:hive_ce/hive.dart';

import '../../domain/entities/gratitude_entry.dart';

part 'gratitude_entry_model.g.dart';

@HiveType(typeId: 3)
class GratitudeEntryModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final List<String> items;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String? userId;

  GratitudeEntryModel({
    required this.id,
    required this.items,
    required this.date,
    this.userId,
  });

  factory GratitudeEntryModel.fromJson(Map<String, dynamic> json) {
    return GratitudeEntryModel(
      id: json['id'] as int,
      items: List<String>.from(json['items'] as List),
      date: DateTime.parse(json['date'] as String),
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items,
      'date': date.toIso8601String(),
      'user_id': userId,
    };
  }

  GratitudeEntry toEntity() {
    return GratitudeEntry(
      id: id,
      userId: userId,
      items: items,
      date: date,
    );
  }

  factory GratitudeEntryModel.fromEntity(GratitudeEntry entity) {
    return GratitudeEntryModel(
      id: entity.id,
      userId: entity.userId,
      items: entity.items,
      date: entity.date,
    );
  }
}
