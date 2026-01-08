import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/backend_service_provider.dart';
import '../../../user/presentation/providers/user_provider.dart';
import '../../domain/entities/mood_stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../../data/datasources/stats_remote_data_source.dart';
import '../../data/repositories/stats_repository_impl.dart';

part 'insights_provider.g.dart';

// Data Sources
@riverpod
StatsRemoteDataSource statsRemoteDataSource(Ref ref) {
  final backend = ref.watch(backendServiceProvider);
  return StatsRemoteDataSourceImpl(backend);
}

// Repositories
@riverpod
StatsRepository statsRepository(Ref ref) {
  return StatsRepositoryImpl(
    remoteDataSource: ref.watch(statsRemoteDataSourceProvider),
  );
}

// State Providers
@riverpod
class SelectedMonth extends _$SelectedMonth {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void selectMonth(int year, int month) {
    state = DateTime(year, month);
  }

  void previousMonth() {
    state = DateTime(state.year, state.month - 1);
  }

  void nextMonth() {
    state = DateTime(state.year, state.month + 1);
  }
}

@Riverpod(keepAlive: true)
class MonthlyStatsNotifier extends _$MonthlyStatsNotifier {
  @override
  Future<MonthlyStats> build() async {
    ref.keepAlive();
    final selectedMonth = ref.watch(selectedMonthProvider);
    final repository = ref.watch(statsRepositoryProvider);
    final user = ref.watch(currentUserProvider).valueOrNull;
    return repository.getMonthlyStats(selectedMonth.year, selectedMonth.month, userId: user?.id);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

@Riverpod(keepAlive: true)
class WeeklyCorrelationNotifier extends _$WeeklyCorrelationNotifier {
  @override
  Future<WeeklyCorrelation> build() async {
    ref.keepAlive();
    final repository = ref.watch(statsRepositoryProvider);
    final user = ref.watch(currentUserProvider).valueOrNull;
    return repository.getWeeklyCorrelation(userId: user?.id);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
