/// Exception thrown when a new activity overlaps with an ongoing activity.
class ActivityOverlapException implements Exception {
  final String message;
  final DateTime ongoingActivityEnd;

  ActivityOverlapException({
    required this.message,
    required this.ongoingActivityEnd,
  });

  @override
  String toString() => 'ActivityOverlapException: $message';

  /// Returns a user-friendly message with remaining time.
  String get friendlyMessage {
    final remaining = ongoingActivityEnd.difference(DateTime.now());
    final minutes = remaining.inMinutes;

    if (minutes <= 0) {
      return message;
    }

    return '$message (${minutes}m remaining)';
  }
}
