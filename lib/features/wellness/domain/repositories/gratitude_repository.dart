import '../entities/gratitude_entry.dart';

abstract class GratitudeRepository {
  Future<List<GratitudeEntry>> getEntries({String? userId});
  Future<GratitudeEntry?> getTodayEntry({String? userId});
  Future<GratitudeEntry> addEntry(List<String> items, {String? userId});
}
