import '../../domain/entities/quote.dart';

class QuoteModel {
  final String id;
  final String text;
  final String? author;
  final bool isFavorite;

  QuoteModel({
    required this.id,
    required this.text,
    this.author,
    this.isFavorite = false,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'] as String,
      text: json['text'] as String,
      author: json['author'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'author': author,
      'isFavorite': isFavorite,
    };
  }

  Quote toEntity() {
    return Quote(
      id: id,
      text: text,
      author: author,
      isFavorite: isFavorite,
    );
  }

  QuoteModel copyWith({bool? isFavorite}) {
    return QuoteModel(
      id: id,
      text: text,
      author: author,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
