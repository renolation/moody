import '../../../../core/enums/activity_type.dart';
import '../entities/activity_entry.dart';

abstract class ActivityRepository {
  Future<List<ActivityEntry>> getActivities({String? userId});
  Future<List<ActivityEntry>> getActivitiesByDate(DateTime date, {String? userId});
  Future<ActivityEntry> addActivity({required ActivityType type, int duration = 30, String? userId});
  Future<void> deleteActivity(int id);
}
