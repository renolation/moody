import '../../../../core/enums/activity_type.dart';
import '../entities/activity_entry.dart';

abstract class ActivityRepository {
  Future<List<ActivityEntry>> getActivities();
  Future<List<ActivityEntry>> getActivitiesByDate(DateTime date);
  Future<ActivityEntry> addActivity({required ActivityType type, int duration = 30});
  Future<void> deleteActivity(String id);
}
