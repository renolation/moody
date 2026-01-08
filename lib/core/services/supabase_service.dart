import 'package:supabase_flutter/supabase_flutter.dart';

import 'backend_service.dart';

/// Supabase implementation of [BackendService].
///
/// Provides CRUD operations using Supabase as the backend.
class SupabaseService implements BackendService {
  final SupabaseClient _client;

  SupabaseService(this._client);

  /// Create a SupabaseService using the default Supabase instance.
  factory SupabaseService.instance() {
    return SupabaseService(Supabase.instance.client);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(
    String table, {
    String? orderBy,
    bool ascending = false,
  }) async {
    try {
      final query = _client.from(table).select();

      final List<dynamic> response;
      if (orderBy != null) {
        response = await query.order(orderBy, ascending: ascending);
      } else {
        response = await query;
      }

      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw BackendException('Failed to get all from $table: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>?> getById(String table, dynamic id) async {
    try {
      final response = await _client
          .from(table)
          .select()
          .eq('id', id)
          .maybeSingle();

      return response;
    } on PostgrestException catch (e) {
      throw BackendException('Failed to get by id from $table: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _client
          .from(table)
          .insert(data)
          .select()
          .single();

      return response;
    } on PostgrestException catch (e) {
      throw BackendException('Failed to insert into $table: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> update(
    String table,
    dynamic id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _client
          .from(table)
          .update(data)
          .eq('id', id)
          .select()
          .single();

      return response;
    } on PostgrestException catch (e) {
      throw BackendException('Failed to update in $table: ${e.message}');
    }
  }

  @override
  Future<void> delete(String table, dynamic id) async {
    try {
      await _client.from(table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      throw BackendException('Failed to delete from $table: ${e.message}');
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
      PostgrestFilterBuilder<List<Map<String, dynamic>>> filterQuery =
          _client.from(table).select();

      // Apply equality filters
      if (equalFilters != null) {
        for (final entry in equalFilters.entries) {
          filterQuery = filterQuery.eq(entry.key, entry.value);
        }
      }

      // Apply greater than filters
      if (greaterThan != null) {
        for (final entry in greaterThan.entries) {
          filterQuery = filterQuery.gt(entry.key, entry.value);
        }
      }

      // Apply less than filters
      if (lessThan != null) {
        for (final entry in lessThan.entries) {
          filterQuery = filterQuery.lt(entry.key, entry.value);
        }
      }

      // Apply greater than or equal filters
      if (greaterThanOrEqual != null) {
        for (final entry in greaterThanOrEqual.entries) {
          filterQuery = filterQuery.gte(entry.key, entry.value);
        }
      }

      // Apply less than or equal filters
      if (lessThanOrEqual != null) {
        for (final entry in lessThanOrEqual.entries) {
          filterQuery = filterQuery.lte(entry.key, entry.value);
        }
      }

      // Apply ordering and limit, then execute
      final List<dynamic> response;
      if (orderBy != null && limit != null) {
        response = await filterQuery.order(orderBy, ascending: ascending).limit(limit);
      } else if (orderBy != null) {
        response = await filterQuery.order(orderBy, ascending: ascending);
      } else if (limit != null) {
        response = await filterQuery.limit(limit);
      } else {
        response = await filterQuery;
      }

      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw BackendException('Failed to query $table: ${e.message}');
    }
  }

  @override
  Future<bool> isAvailable() async {
    try {
      // Try a simple query to check connectivity
      await _client.from('moods').select().limit(1);
      return true;
    } catch (_) {
      return false;
    }
  }
}
