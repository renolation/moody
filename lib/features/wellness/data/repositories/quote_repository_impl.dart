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
    final model = await remoteDataSource.getQuoteOfTheDay();
    return model.toEntity();
  }

  @override
  Future<void> toggleFavorite(int id) async {
    await remoteDataSource.toggleFavorite(id);
  }
}
