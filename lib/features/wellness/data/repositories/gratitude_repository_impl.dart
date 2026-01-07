import '../../domain/entities/gratitude_entry.dart';
import '../../domain/repositories/gratitude_repository.dart';
import '../datasources/gratitude_remote_data_source.dart';
import '../models/gratitude_entry_model.dart';

class GratitudeRepositoryImpl implements GratitudeRepository {
  final GratitudeRemoteDataSource remoteDataSource;

  GratitudeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<GratitudeEntry>> getEntries() async {
    final models = await remoteDataSource.getEntries();
    final entries = models.map((m) => m.toEntity()).toList();
    entries.sort((a, b) => b.date.compareTo(a.date));
    return entries;
  }

  @override
  Future<GratitudeEntry?> getTodayEntry() async {
    final entries = await getEntries();
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
  Future<GratitudeEntry> addEntry(List<String> items) async {
    final model = GratitudeEntryModel(
      id: '',
      items: items,
      date: DateTime.now().toIso8601String(),
    );
    final result = await remoteDataSource.addEntry(model);
    return result.toEntity();
  }
}
