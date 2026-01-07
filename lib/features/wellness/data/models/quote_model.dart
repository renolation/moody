import 'package:hive_ce/hive.dart';

import '../../domain/entities/quote.dart';

part 'quote_model.g.dart';

@HiveType(typeId: 2)
class QuoteModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final String? author;

  @HiveField(3)
  final bool isFavorite;

  QuoteModel({
    required this.id,
    required this.text,
    this.author,
    this.isFavorite = false,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'] as int,
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

  factory QuoteModel.fromEntity(Quote entity) {
    return QuoteModel(
      id: entity.id,
      text: entity.text,
      author: entity.author,
      isFavorite: entity.isFavorite,
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
