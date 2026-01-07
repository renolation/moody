import 'package:uuid/uuid.dart';

import '../models/gratitude_entry_model.dart';

abstract class GratitudeRemoteDataSource {
  Future<List<GratitudeEntryModel>> getEntries();
  Future<GratitudeEntryModel> addEntry(GratitudeEntryModel entry);
}

class GratitudeRemoteDataSourceImpl implements GratitudeRemoteDataSource {
  final _uuid = const Uuid();

  // In-memory storage simulating API database
  final List<GratitudeEntryModel> _entries = [];

  @override
  Future<List<GratitudeEntryModel>> getEntries() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_entries);
  }

  @override
  Future<GratitudeEntryModel> addEntry(GratitudeEntryModel entry) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final newEntry = GratitudeEntryModel(
      id: _uuid.v4(),
      items: entry.items,
      date: entry.date,
    );
    _entries.add(newEntry);
    return newEntry;
  }
}
