import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/mood_stats.dart';
import '../../domain/repositories/stats_repository.dart';
import '../../data/datasources/stats_remote_data_source.dart';
import '../../data/repositories/stats_repository_impl.dart';

part 'insights_provider.g.dart';

// Data Sources
@riverpod
StatsRemoteDataSource statsRemoteDataSource(Ref ref) {
  return StatsRemoteDataSourceImpl();
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

@riverpod
Future<MonthlyStats> monthlyStats(Ref ref) async {
  final selectedMonth = ref.watch(selectedMonthProvider);
  final repository = ref.watch(statsRepositoryProvider);
  return repository.getMonthlyStats(selectedMonth.year, selectedMonth.month);
}

@riverpod
Future<WeeklyCorrelation> weeklyCorrelation(Ref ref) async {
  final repository = ref.watch(statsRepositoryProvider);
  return repository.getWeeklyCorrelation();
}
