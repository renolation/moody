import '../models/quote_model.dart';

abstract class QuoteRemoteDataSource {
  Future<List<QuoteModel>> getQuotes();
  Future<void> toggleFavorite(String id);
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  // Mock data simulating API response
  final List<QuoteModel> _quotes = [
    QuoteModel(
      id: '1',
      text: '"Peace is a journey of a thousand breaths."',
      author: 'Unknown',
    ),
    QuoteModel(
      id: '2',
      text: '"The present moment is filled with joy and happiness. If you are attentive, you will see it."',
      author: 'Thich Nhat Hanh',
    ),
    QuoteModel(
      id: '3',
      text: '"Feelings are just visitors, let them come and go."',
      author: 'Mooji',
    ),
    QuoteModel(
      id: '4',
      text: '"Within you, there is a stillness and a sanctuary to which you can retreat at any time."',
      author: 'Hermann Hesse',
    ),
    QuoteModel(
      id: '5',
      text: '"Breathe. Let go. And remind yourself that this very moment is the only one you know you have for sure."',
      author: 'Oprah Winfrey',
    ),
    QuoteModel(
      id: '6',
      text: '"Almost everything will work again if you unplug it for a few minutes, including you."',
      author: 'Anne Lamott',
    ),
    QuoteModel(
      id: '7',
      text: '"You don\'t have to control your thoughts. You just have to stop letting them control you."',
      author: 'Dan Millman',
    ),
  ];

  @override
  Future<List<QuoteModel>> getQuotes() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_quotes);
  }

  @override
  Future<void> toggleFavorite(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _quotes.indexWhere((q) => q.id == id);
    if (index != -1) {
      _quotes[index] = _quotes[index].copyWith(
        isFavorite: !_quotes[index].isFavorite,
      );
    }
  }
}
