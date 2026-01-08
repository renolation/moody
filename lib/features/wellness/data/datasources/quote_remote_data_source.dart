import '../../../../core/services/backend_service.dart';
import '../models/quote_model.dart';

/// Remote data source for quotes using BackendService abstraction.
abstract class QuoteRemoteDataSource {
  Future<List<QuoteModel>> getQuotes();
  Future<QuoteModel> getQuoteOfTheDay();
  Future<void> toggleFavorite(int id);
  Future<void> initializeQuotes(List<QuoteModel> quotes);
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  static const String tableName = 'quotes';

  final BackendService _backend;

  QuoteRemoteDataSourceImpl(this._backend);

  @override
  Future<List<QuoteModel>> getQuotes() async {
    final data = await _backend.getAll(tableName);
    return data.map((json) => QuoteModel.fromJson(json)).toList();
  }

  @override
  Future<QuoteModel> getQuoteOfTheDay() async {
    final data = await _backend.getAll(tableName);
    final quotes = data.map((json) => QuoteModel.fromJson(json)).toList();

    if (quotes.isEmpty) {
      return QuoteModel(
        id: 0,
        text: 'Every day is a fresh start.',
        author: 'Unknown',
      );
    }

    // Use day of year as index for consistent daily quote
    final dayOfYear =
        DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    return quotes[dayOfYear % quotes.length];
  }

  @override
  Future<void> toggleFavorite(int id) async {
    final existing = await _backend.getById(tableName, id);
    if (existing != null) {
      final isFavorite = existing['is_favorite'] as bool? ?? false;
      await _backend.update(tableName, id, {'is_favorite': !isFavorite});
    }
  }

  @override
  Future<void> initializeQuotes(List<QuoteModel> quotes) async {
    final existing = await _backend.getAll(tableName);
    if (existing.isEmpty) {
      for (final quote in quotes) {
        await _backend.insert(tableName, quote.toJson());
      }
    }
  }
}
