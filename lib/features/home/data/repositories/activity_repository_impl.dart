import '../../../../core/enums/activity_type.dart';
import '../../domain/entities/activity_entry.dart';
import '../../domain/repositories/activity_repository.dart';
import '../datasources/activity_remote_data_source.dart';
import '../models/activity_entry_model.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource remoteDataSource;

  ActivityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ActivityEntry>> getActivities() async {
    final models = await remoteDataSource.getActivities();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<ActivityEntry>> getActivitiesByDate(DateTime date) async {
    final models = await remoteDataSource.getActivitiesByDate(date);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<ActivityEntry> addActivity({
    required ActivityType type,
    int duration = 30,
  }) async {
    final id = await remoteDataSource.getNextId();
    final model = ActivityEntryModel(
      id: id,
      type: type.name,
      duration: duration,
      timestamp: DateTime.now(),
    );
    final result = await remoteDataSource.addActivity(model);
    return result.toEntity();
  }

  @override
  Future<void> deleteActivity(int id) async {
    await remoteDataSource.deleteActivity(id);
  }
}
