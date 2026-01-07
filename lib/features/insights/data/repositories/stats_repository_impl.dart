import '../../domain/entities/mood_stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../datasources/stats_remote_data_source.dart';

class StatsRepositoryImpl implements StatsRepository {
  final StatsRemoteDataSource remoteDataSource;

  StatsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MonthlyStats> getMonthlyStats(int year, int month) async {
    final model = await remoteDataSource.getMonthlyStats(year, month);
    return model.toEntity();
  }

  @override
  Future<WeeklyCorrelation> getWeeklyCorrelation() async {
    final model = await remoteDataSource.getWeeklyCorrelation();
    return model.toEntity();
  }
}
