import '../entities/quote.dart';

abstract class QuoteRepository {
  Future<List<Quote>> getQuotes();
  Future<Quote> getDailyQuote();
  Future<void> toggleFavorite(String id);
}
