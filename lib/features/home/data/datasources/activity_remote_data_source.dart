import 'package:hive_ce/hive.dart';

import '../models/activity_entry_model.dart';

/// Remote data source using Hive as API simulator
/// TODO: Replace Hive implementation with real API calls when backend is ready
abstract class ActivityRemoteDataSource {
  Future<List<ActivityEntryModel>> getActivities();
  Future<List<ActivityEntryModel>> getActivitiesByDate(DateTime date);
  Future<ActivityEntryModel> addActivity(ActivityEntryModel activity);
  Future<void> deleteActivity(int id);
  Future<int> getNextId();
  Future<void> initializeActivities(List<ActivityEntryModel> activities);
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  static const String boxName = 'activities';

  Box<ActivityEntryModel> get _box => Hive.box<ActivityEntryModel>(boxName);

  @override
  Future<List<ActivityEntryModel>> getActivities() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _box.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  @override
  Future<List<ActivityEntryModel>> getActivitiesByDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _box.values.where((a) {
      return a.timestamp.year == date.year &&
          a.timestamp.month == date.month &&
          a.timestamp.day == date.day;
    }).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  @override
  Future<ActivityEntryModel> addActivity(ActivityEntryModel activity) async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _box.put(activity.id, activity);
    return activity;
  }

  @override
  Future<void> deleteActivity(int id) async {
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
  Future<void> initializeActivities(List<ActivityEntryModel> activities) async {
    if (_box.isEmpty) {
      for (final activity in activities) {
        await _box.put(activity.id, activity);
      }
    }
  }
}
