import '../entities/gratitude_entry.dart';

abstract class GratitudeRepository {
  Future<List<GratitudeEntry>> getEntries();
  Future<GratitudeEntry?> getTodayEntry();
  Future<GratitudeEntry> addEntry(List<String> items);
}
