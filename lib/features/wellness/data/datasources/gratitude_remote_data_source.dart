import 'package:hive_ce/hive.dart';

import '../models/gratitude_entry_model.dart';

/// Remote data source using Hive as API simulator
/// TODO: Replace Hive implementation with real API calls when backend is ready
abstract class GratitudeRemoteDataSource {
  Future<List<GratitudeEntryModel>> getEntries();
  Future<GratitudeEntryModel> addEntry(GratitudeEntryModel entry);
  Future<void> deleteEntry(int id);
  Future<int> getNextId();
  Future<void> initializeEntries(List<GratitudeEntryModel> entries);
}

class GratitudeRemoteDataSourceImpl implements GratitudeRemoteDataSource {
  static const String boxName = 'gratitude';

  Box<GratitudeEntryModel> get _box => Hive.box<GratitudeEntryModel>(boxName);

  @override
  Future<List<GratitudeEntryModel>> getEntries() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<GratitudeEntryModel> addEntry(GratitudeEntryModel entry) async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _box.put(entry.id, entry);
    return entry;
  }

  @override
  Future<void> deleteEntry(int id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _box.delete(id);
  }

  @override
  Future<int> getNextId() async {
    if (_box.isEmpty) return 1;
    final maxId = _box.values.map((e) => e.id).reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  @override
  Future<void> initializeEntries(List<GratitudeEntryModel> entries) async {
    if (_box.isEmpty) {
      for (final entry in entries) {
        await _box.put(entry.id, entry);
      }
    }
  }
}
