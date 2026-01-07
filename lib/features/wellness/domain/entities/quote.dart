class Quote {
  final String id;
  final String text;
  final String? author;
  final bool isFavorite;

  const Quote({
    required this.id,
    required this.text,
    this.author,
    this.isFavorite = false,
  });

  Quote copyWith({
    String? id,
    String? text,
    String? author,
    bool? isFavorite,
  }) {
    return Quote(
      id: id ?? this.id,
      text: text ?? this.text,
      author: author ?? this.author,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
