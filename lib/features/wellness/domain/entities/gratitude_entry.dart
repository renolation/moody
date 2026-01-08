import 'package:equatable/equatable.dart';

class GratitudeEntry extends Equatable {
  final int id;
  final String? userId;
  final List<String> items;
  final DateTime date;

  const GratitudeEntry({
    required this.id,
    this.userId,
    required this.items,
    required this.date,
  });

  GratitudeEntry copyWith({
    int? id,
    String? userId,
    List<String>? items,
    DateTime? date,
  }) {
    return GratitudeEntry(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [id, userId, items, date];
}
