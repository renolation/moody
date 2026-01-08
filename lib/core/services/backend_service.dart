/// Abstract interface for backend database operations.
///
/// This abstraction allows swapping between different backend implementations
/// (Supabase, Hive, Firebase, etc.) without modifying data source code.
abstract class BackendService {
  /// Get all records from a table.
  ///
  /// [table] - The table/collection name.
  /// [orderBy] - Optional column to order by.
  /// [ascending] - Sort direction (default: false = descending).
  Future<List<Map<String, dynamic>>> getAll(
    String table, {
    String? orderBy,
    bool ascending = false,
  });

  /// Get a single record by ID.
  ///
  /// Returns null if the record is not found.
  Future<Map<String, dynamic>?> getById(String table, dynamic id);

  /// Insert a new record.
  ///
  /// Returns the created record with its ID.
  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  );

  /// Update an existing record.
  ///
  /// Returns the updated record.
  Future<Map<String, dynamic>> update(
    String table,
    dynamic id,
    Map<String, dynamic> data,
  );

  /// Delete a record by ID.
  Future<void> delete(String table, dynamic id);

  /// Query records with filters.
  ///
  /// [equalFilters] - Exact match filters (column: value).
  /// [greaterThan] - Greater than filters (column: value).
  /// [lessThan] - Less than filters (column: value).
  /// [greaterThanOrEqual] - Greater than or equal filters.
  /// [lessThanOrEqual] - Less than or equal filters.
  /// [orderBy] - Column to order by.
  /// [ascending] - Sort direction.
  /// [limit] - Maximum number of records to return.
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
  });

  /// Check if the backend service is available.
  Future<bool> isAvailable();
}

/// Exception thrown when a backend operation fails.
class BackendException implements Exception {
  final String message;
  final dynamic originalError;

  BackendException(this.message, [this.originalError]);

  @override
  String toString() => 'BackendException: $message';
}
