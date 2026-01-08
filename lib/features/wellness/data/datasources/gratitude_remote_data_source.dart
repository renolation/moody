import '../../../../core/services/backend_service.dart';
import '../models/gratitude_entry_model.dart';

/// Remote data source for gratitude entries using BackendService abstraction.
abstract class GratitudeRemoteDataSource {
  Future<List<GratitudeEntryModel>> getEntries({String? userId});
  Future<GratitudeEntryModel> addEntry(GratitudeEntryModel entry);
  Future<void> deleteEntry(int id);
  Future<int> getNextId();
  Future<void> initializeEntries(List<GratitudeEntryModel> entries);
}

class GratitudeRemoteDataSourceImpl implements GratitudeRemoteDataSource {
  static const String tableName = 'gratitude';

  final BackendService _backend;

  GratitudeRemoteDataSourceImpl(this._backend);

  @override
  Future<List<GratitudeEntryModel>> getEntries({String? userId}) async {
    final data = await _backend.query(
      tableName,
      equalFilters: {'user_id': userId},
      orderBy: 'date',
    );
    return data.map((json) => GratitudeEntryModel.fromJson(json)).toList();
  }

  @override
  Future<GratitudeEntryModel> addEntry(GratitudeEntryModel entry) async {
    final data = await _backend.insert(tableName, entry.toJson());
    return GratitudeEntryModel.fromJson(data);
  }

  @override
  Future<void> deleteEntry(int id) async {
    await _backend.delete(tableName, id);
  }

  @override
  Future<int> getNextId() async {
    final data = await _backend.getAll(tableName);
    if (data.isEmpty) return 1;
    final maxId = data
        .map((e) => e['id'] as int? ?? 0)
        .reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  @override
  Future<void> initializeEntries(List<GratitudeEntryModel> entries) async {
    final existing = await _backend.getAll(tableName);
    if (existing.isEmpty) {
      for (final entry in entries) {
        await _backend.insert(tableName, entry.toJson());
      }
    }
  }
}
