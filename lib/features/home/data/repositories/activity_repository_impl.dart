import '../../../../core/enums/activity_type.dart';
import '../../domain/entities/activity_entry.dart';
import '../../domain/repositories/activity_repository.dart';
import '../datasources/activity_remote_data_source.dart';
import '../models/activity_entry_model.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource remoteDataSource;

  ActivityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ActivityEntry>> getActivities({String? userId}) async {
    final models = await remoteDataSource.getActivities(userId: userId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<ActivityEntry>> getActivitiesByDate(DateTime date, {String? userId}) async {
    final models = await remoteDataSource.getActivitiesByDate(date, userId: userId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<ActivityEntry> addActivity({
    required ActivityType type,
    int duration = 30,
    String? userId,
  }) async {
    final id = await remoteDataSource.getNextId();
    final model = ActivityEntryModel(
      id: id,
      type: type.name,
      duration: duration,
      timestamp: DateTime.now(),
      userId: userId,
    );
    final result = await remoteDataSource.addActivity(model);
    return result.toEntity();
  }

  @override
  Future<void> deleteActivity(int id) async {
    await remoteDataSource.deleteActivity(id);
  }
}
