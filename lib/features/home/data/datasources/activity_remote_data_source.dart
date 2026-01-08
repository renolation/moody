import '../../../../core/services/backend_service.dart';
import '../models/activity_entry_model.dart';

/// Remote data source for activity entries using BackendService abstraction.
abstract class ActivityRemoteDataSource {
  Future<List<ActivityEntryModel>> getActivities();
  Future<List<ActivityEntryModel>> getActivitiesByDate(DateTime date);
  Future<ActivityEntryModel> addActivity(ActivityEntryModel activity);
  Future<void> deleteActivity(int id);
  Future<int> getNextId();
  Future<void> initializeActivities(List<ActivityEntryModel> activities);
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  static const String tableName = 'activities';

  final BackendService _backend;

  ActivityRemoteDataSourceImpl(this._backend);

  @override
  Future<List<ActivityEntryModel>> getActivities() async {
    final data = await _backend.getAll(tableName, orderBy: 'timestamp');
    return data.map((json) => ActivityEntryModel.fromJson(json)).toList();
  }

  @override
  Future<List<ActivityEntryModel>> getActivitiesByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final data = await _backend.query(
      tableName,
      greaterThanOrEqual: {'timestamp': startOfDay.toIso8601String()},
      lessThan: {'timestamp': endOfDay.toIso8601String()},
      orderBy: 'timestamp',
    );
    return data.map((json) => ActivityEntryModel.fromJson(json)).toList();
  }

  @override
  Future<ActivityEntryModel> addActivity(ActivityEntryModel activity) async {
    final data = await _backend.insert(tableName, activity.toJson());
    return ActivityEntryModel.fromJson(data);
  }

  @override
  Future<void> deleteActivity(int id) async {
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
  Future<void> initializeActivities(List<ActivityEntryModel> activities) async {
    final existing = await _backend.getAll(tableName);
    if (existing.isEmpty) {
      for (final activity in activities) {
        await _backend.insert(tableName, activity.toJson());
      }
    }
  }
}
