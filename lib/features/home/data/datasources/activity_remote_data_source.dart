import 'package:uuid/uuid.dart';

import '../models/activity_entry_model.dart';

abstract class ActivityRemoteDataSource {
  Future<List<ActivityEntryModel>> getActivities();
  Future<ActivityEntryModel> addActivity(ActivityEntryModel activity);
  Future<void> deleteActivity(String id);
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  final _uuid = const Uuid();

  // In-memory storage simulating API database
  final List<ActivityEntryModel> _activities = [];

  @override
  Future<List<ActivityEntryModel>> getActivities() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_activities);
  }

  @override
  Future<ActivityEntryModel> addActivity(ActivityEntryModel activity) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final newActivity = ActivityEntryModel(
      id: _uuid.v4(),
      type: activity.type,
      duration: activity.duration,
      timestamp: activity.timestamp,
    );
    _activities.add(newActivity);
    return newActivity;
  }

  @override
  Future<void> deleteActivity(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _activities.removeWhere((a) => a.id == id);
  }
}
