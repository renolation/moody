import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/backend_service_provider.dart';
import '../../domain/entities/user_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../data/datasources/settings_remote_data_source.dart';
import '../../data/repositories/settings_repository_impl.dart';

part 'settings_provider.g.dart';

// Data Sources
@riverpod
SettingsRemoteDataSource settingsRemoteDataSource(Ref ref) {
  final backend = ref.watch(backendServiceProvider);
  return SettingsRemoteDataSourceImpl(backend);
}

// Repositories
@riverpod
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepositoryImpl(
    remoteDataSource: ref.watch(settingsRemoteDataSourceProvider),
  );
}

// State Providers
@riverpod
class Settings extends _$Settings {
  @override
  Future<UserSettings> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    return repository.getSettings();
  }

  Future<void> updateUserName(String name) async {
    final current = state.valueOrNull ?? const UserSettings();
    final updated = current.copyWith(userName: name);
    await _updateSettings(updated);
  }

  Future<void> updateUserEmail(String? email) async {
    final current = state.valueOrNull ?? const UserSettings();
    final updated = current.copyWith(userEmail: email);
    await _updateSettings(updated);
  }

  Future<void> toggleHealthSync(bool enabled) async {
    final current = state.valueOrNull ?? const UserSettings();
    final updated = current.copyWith(healthSyncEnabled: enabled);
    await _updateSettings(updated);
  }

  Future<void> updateDailyQuoteTime(int hour, int minute) async {
    final current = state.valueOrNull ?? const UserSettings();
    final updated = current.copyWith(
      dailyQuoteHour: hour,
      dailyQuoteMinute: minute,
    );
    await _updateSettings(updated);
  }

  Future<void> updateMoodReminderTime(int hour, int minute) async {
    final current = state.valueOrNull ?? const UserSettings();
    final updated = current.copyWith(
      moodReminderHour: hour,
      moodReminderMinute: minute,
    );
    await _updateSettings(updated);
  }

  Future<void> setVipStatus(bool isVip) async {
    final current = state.valueOrNull ?? const UserSettings();
    final updated = current.copyWith(isVip: isVip);
    await _updateSettings(updated);
  }

  Future<void> _updateSettings(UserSettings settings) async {
    final repository = ref.read(settingsRepositoryProvider);
    await repository.updateSettings(settings);
    ref.invalidateSelf();
  }
}

@riverpod
bool isVip(Ref ref) {
  final settings = ref.watch(settingsProvider);
  return settings.valueOrNull?.isVip ?? false;
}
