import 'package:equatable/equatable.dart';

class GratitudeEntry extends Equatable {
  final int id;
  final List<String> items;
  final DateTime date;

  const GratitudeEntry({
    required this.id,
    required this.items,
    required this.date,
  });

  GratitudeEntry copyWith({
    int? id,
    List<String>? items,
    DateTime? date,
  }) {
    return GratitudeEntry(
      id: id ?? this.id,
      items: items ?? this.items,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [id, items, date];
}
