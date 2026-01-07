import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/quote_remote_data_source.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;

  QuoteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Quote>> getQuotes() async {
    final models = await remoteDataSource.getQuotes();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Quote> getDailyQuote() async {
    final quotes = await getQuotes();
    final dayOfYear = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    return quotes[dayOfYear % quotes.length];
  }

  @override
  Future<void> toggleFavorite(String id) async {
    await remoteDataSource.toggleFavorite(id);
  }
}
