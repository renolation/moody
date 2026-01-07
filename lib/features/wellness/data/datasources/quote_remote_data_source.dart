import 'package:hive_ce/hive.dart';

import '../models/quote_model.dart';

/// Remote data source using Hive as API simulator
/// TODO: Replace Hive implementation with real API calls when backend is ready
abstract class QuoteRemoteDataSource {
  Future<List<QuoteModel>> getQuotes();
  Future<QuoteModel> getQuoteOfTheDay();
  Future<void> toggleFavorite(int id);
  Future<void> initializeQuotes(List<QuoteModel> quotes);
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  static const String boxName = 'quotes';

  Box<QuoteModel> get _box => Hive.box<QuoteModel>(boxName);

  @override
  Future<List<QuoteModel>> getQuotes() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _box.values.toList();
  }

  @override
  Future<QuoteModel> getQuoteOfTheDay() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final quotes = _box.values.toList();
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
    await Future.delayed(const Duration(milliseconds: 200));
    final quote = _box.get(id);
    if (quote != null) {
      final updated = quote.copyWith(isFavorite: !quote.isFavorite);
      await _box.put(id, updated);
    }
  }

  @override
  Future<void> initializeQuotes(List<QuoteModel> quotes) async {
    if (_box.isEmpty) {
      for (final quote in quotes) {
        await _box.put(quote.id, quote);
      }
    }
  }
}
