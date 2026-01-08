import '../../domain/entities/gratitude_entry.dart';
import '../../domain/repositories/gratitude_repository.dart';
import '../datasources/gratitude_remote_data_source.dart';
import '../models/gratitude_entry_model.dart';

class GratitudeRepositoryImpl implements GratitudeRepository {
  final GratitudeRemoteDataSource remoteDataSource;

  GratitudeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<GratitudeEntry>> getEntries({String? userId}) async {
    final models = await remoteDataSource.getEntries(userId: userId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<GratitudeEntry?> getTodayEntry({String? userId}) async {
    final entries = await getEntries(userId: userId);
    final today = DateTime.now();

    try {
      return entries.firstWhere(
        (e) =>
            e.date.year == today.year &&
            e.date.month == today.month &&
            e.date.day == today.day,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<GratitudeEntry> addEntry(List<String> items, {String? userId}) async {
    final id = await remoteDataSource.getNextId();
    final model = GratitudeEntryModel(
      id: id,
      items: items,
      date: DateTime.now(),
      userId: userId,
    );
    final result = await remoteDataSource.addEntry(model);
    return result.toEntity();
  }
}
