import '../../domain/entities/gratitude_entry.dart';

class GratitudeEntryModel {
  final String id;
  final List<String> items;
  final String date;

  GratitudeEntryModel({
    required this.id,
    required this.items,
    required this.date,
  });

  factory GratitudeEntryModel.fromJson(Map<String, dynamic> json) {
    return GratitudeEntryModel(
      id: json['id'] as String,
      items: List<String>.from(json['items'] as List),
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items,
      'date': date,
    };
  }

  GratitudeEntry toEntity() {
    return GratitudeEntry(
      id: id,
      items: items,
      date: DateTime.parse(date),
    );
  }
}
