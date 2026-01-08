import '../../domain/entities/mood_stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../datasources/stats_remote_data_source.dart';

class StatsRepositoryImpl implements StatsRepository {
  final StatsRemoteDataSource remoteDataSource;

  StatsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MonthlyStats> getMonthlyStats(int year, int month, {String? userId}) async {
    final model = await remoteDataSource.getMonthlyStats(year, month, userId: userId);
    return model.toEntity();
  }

  @override
  Future<WeeklyCorrelation> getWeeklyCorrelation({String? userId}) async {
    final model = await remoteDataSource.getWeeklyCorrelation(userId: userId);
    return model.toEntity();
  }
}
