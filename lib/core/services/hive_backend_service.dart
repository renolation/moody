import 'package:hive_ce/hive.dart';

import 'backend_service.dart';
import '../../features/home/data/models/mood_entry_model.dart';
import '../../features/home/data/models/activity_entry_model.dart';
import '../../features/wellness/data/models/quote_model.dart';
import '../../features/wellness/data/models/gratitude_entry_model.dart';
import '../../features/wellness/data/models/sound_model.dart';
import '../../features/settings/data/models/user_settings_model.dart';
import '../../features/user/data/models/user_model.dart';

/// Hive implementation of [BackendService].
///
/// Provides CRUD operations using Hive for offline storage.
/// Maintains backward compatibility with existing Hive data.
class HiveBackendService implements BackendService {
  // Box name mappings
  static const String moodsTable = 'moods';
  static const String activitiesTable = 'activities';
  static const String quotesTable = 'quotes';
  static const String gratitudeTable = 'gratitude';
  static const String soundsTable = 'sounds';
  static const String settingsTable = 'settings';
  static const String usersTable = 'users';

  /// Get the Hive box for a given table name.
  Box<dynamic> _getBox(String table) {
    switch (table) {
      case moodsTable:
        return Hive.box<MoodEntryModel>(moodsTable);
      case activitiesTable:
        return Hive.box<ActivityEntryModel>(activitiesTable);
      case quotesTable:
        return Hive.box<QuoteModel>(quotesTable);
      case gratitudeTable:
        return Hive.box<GratitudeEntryModel>(gratitudeTable);
      case soundsTable:
        return Hive.box<SoundModel>(soundsTable);
      case settingsTable:
        return Hive.box<UserSettingsModel>(settingsTable);
      case usersTable:
        return Hive.box<UserModel>(usersTable);
      default:
        throw BackendException('Unknown table: $table');
    }
  }

  /// Convert a Hive object to JSON.
  Map<String, dynamic> _toJson(dynamic value) {
    if (value is MoodEntryModel) return value.toJson();
    if (value is ActivityEntryModel) return value.toJson();
    if (value is QuoteModel) return value.toJson();
    if (value is GratitudeEntryModel) return value.toJson();
    if (value is SoundModel) return value.toJson();
    if (value is UserSettingsModel) return value.toJson();
    if (value is UserModel) return value.toJson();
    throw BackendException('Unknown model type: ${value.runtimeType}');
  }

  /// Create a model from JSON for a given table.
  dynamic _fromJson(String table, Map<String, dynamic> json) {
    switch (table) {
      case moodsTable:
        return MoodEntryModel.fromJson(json);
      case activitiesTable:
        return ActivityEntryModel.fromJson(json);
      case quotesTable:
        return QuoteModel.fromJson(json);
      case gratitudeTable:
        return GratitudeEntryModel.fromJson(json);
      case soundsTable:
        return SoundModel.fromJson(json);
      case settingsTable:
        return UserSettingsModel.fromJson(json);
      case usersTable:
        return UserModel.fromJson(json);
      default:
        throw BackendException('Unknown table: $table');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(
    String table, {
    String? orderBy,
    bool ascending = false,
  }) async {
    try {
      final box = _getBox(table);
      final values = box.values.map((v) => _toJson(v)).toList();

      if (orderBy != null && values.isNotEmpty) {
        values.sort((a, b) {
          final aVal = a[orderBy];
          final bVal = b[orderBy];
          if (aVal == null && bVal == null) return 0;
          if (aVal == null) return ascending ? -1 : 1;
          if (bVal == null) return ascending ? 1 : -1;

          int comparison;
          if (aVal is Comparable && bVal is Comparable) {
            comparison = aVal.compareTo(bVal);
          } else {
            comparison = aVal.toString().compareTo(bVal.toString());
          }
          return ascending ? comparison : -comparison;
        });
      }

      return values;
    } catch (e) {
      throw BackendException('Failed to get all from $table: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getById(String table, dynamic id) async {
    try {
      final box = _getBox(table);

      for (final value in box.values) {
        final json = _toJson(value);
        if (json['id'] == id) {
          return json;
        }
      }

      return null;
    } catch (e) {
      throw BackendException('Failed to get by id from $table: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    try {
      final box = _getBox(table);

      // Generate ID if not provided
      if (data['id'] == null) {
        final maxId = box.values.isEmpty
            ? 0
            : box.values
                .map((v) => _toJson(v)['id'] as int? ?? 0)
                .reduce((a, b) => a > b ? a : b);
        data = {...data, 'id': maxId + 1};
      }

      final model = _fromJson(table, data);
      await box.add(model);

      return data;
    } catch (e) {
      throw BackendException('Failed to insert into $table: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> update(
    String table,
    dynamic id,
    Map<String, dynamic> data,
  ) async {
    try {
      final box = _getBox(table);

      // Find the item by ID
      int? keyToUpdate;
      for (final key in box.keys) {
        final value = box.get(key);
        final json = _toJson(value);
        if (json['id'] == id) {
          keyToUpdate = key as int;
          break;
        }
      }

      if (keyToUpdate == null) {
        throw BackendException('Item with id $id not found in $table');
      }

      // Merge with existing data
      final existingJson = _toJson(box.get(keyToUpdate));
      final updatedJson = {...existingJson, ...data, 'id': id};
      final model = _fromJson(table, updatedJson);

      await box.put(keyToUpdate, model);

      return updatedJson;
    } catch (e) {
      if (e is BackendException) rethrow;
      throw BackendException('Failed to update in $table: $e');
    }
  }

  @override
  Future<void> delete(String table, dynamic id) async {
    try {
      final box = _getBox(table);

      // Find the item by ID
      dynamic keyToDelete;
      for (final key in box.keys) {
        final value = box.get(key);
        final json = _toJson(value);
        if (json['id'] == id) {
          keyToDelete = key;
          break;
        }
      }

      if (keyToDelete != null) {
        await box.delete(keyToDelete);
      }
    } catch (e) {
      throw BackendException('Failed to delete from $table: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> query(
    String table, {
    Map<String, dynamic>? equalFilters,
    Map<String, dynamic>? greaterThan,
    Map<String, dynamic>? lessThan,
    Map<String, dynamic>? greaterThanOrEqual,
    Map<String, dynamic>? lessThanOrEqual,
    String? orderBy,
    bool ascending = false,
    int? limit,
  }) async {
    try {
      var results = await getAll(table, orderBy: orderBy, ascending: ascending);

      // Apply equality filters
      if (equalFilters != null) {
        results = results.where((item) {
          return equalFilters.entries.every((filter) {
            return item[filter.key] == filter.value;
          });
        }).toList();
      }

      // Apply greater than filters
      if (greaterThan != null) {
        results = results.where((item) {
          return greaterThan.entries.every((filter) {
            final value = item[filter.key];
            if (value == null) return false;
            if (value is Comparable && filter.value is Comparable) {
              return value.compareTo(filter.value) > 0;
            }
            return false;
          });
        }).toList();
      }

      // Apply less than filters
      if (lessThan != null) {
        results = results.where((item) {
          return lessThan.entries.every((filter) {
            final value = item[filter.key];
            if (value == null) return false;
            if (value is Comparable && filter.value is Comparable) {
              return value.compareTo(filter.value) < 0;
            }
            return false;
          });
        }).toList();
      }

      // Apply greater than or equal filters
      if (greaterThanOrEqual != null) {
        results = results.where((item) {
          return greaterThanOrEqual.entries.every((filter) {
            final value = item[filter.key];
            if (value == null) return false;
            if (value is Comparable && filter.value is Comparable) {
              return value.compareTo(filter.value) >= 0;
            }
            return false;
          });
        }).toList();
      }

      // Apply less than or equal filters
      if (lessThanOrEqual != null) {
        results = results.where((item) {
          return lessThanOrEqual.entries.every((filter) {
            final value = item[filter.key];
            if (value == null) return false;
            if (value is Comparable && filter.value is Comparable) {
              return value.compareTo(filter.value) <= 0;
            }
            return false;
          });
        }).toList();
      }

      // Apply limit
      if (limit != null && results.length > limit) {
        results = results.take(limit).toList();
      }

      return results;
    } catch (e) {
      if (e is BackendException) rethrow;
      throw BackendException('Failed to query $table: $e');
    }
  }

  @override
  Future<bool> isAvailable() async {
    // Hive is always available as it's local storage
    return true;
  }
}
