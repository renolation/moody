class GratitudeEntry {
  final String id;
  final List<String> items;
  final DateTime date;

  const GratitudeEntry({
    required this.id,
    required this.items,
    required this.date,
  });

  GratitudeEntry copyWith({
    String? id,
    List<String>? items,
    DateTime? date,
  }) {
    return GratitudeEntry(
      id: id ?? this.id,
      items: items ?? this.items,
      date: date ?? this.date,
    );
  }
}
