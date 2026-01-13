import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get timeOfDayGreeting {
    final hour = this.hour;
    if (hour >= 5 && hour < 12) return 'Good morning';
    if (hour >= 12 && hour < 17) return 'Good afternoon';
    if (hour >= 17 && hour < 21) return 'Good evening';
    return 'Good night';
  }

  String get formattedTime => DateFormat('h:mm a').format(this);

  String get formattedDate => DateFormat('MMM d, y').format(this);

  String get formattedMonthYear => DateFormat('MMMM yyyy').format(this);

  String get shortMonthYear => DateFormat('MMM yyyy').format(this);

  String get dayOfWeek => DateFormat('EEEE').format(this);

  String get shortDayOfWeek => DateFormat('EEE').format(this);

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  DateTime get startOfMonth => DateTime(year, month, 1);

  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  int get daysInMonth => DateTime(year, month + 1, 0).day;

  int get weekdayStartingMonday => weekday;

  /// Serializes DateTime to ISO8601 string with timezone offset.
  /// Example: 2024-01-13T10:00:00+07:00
  String toIso8601StringWithOffset() {
    final offset = timeZoneOffset;
    final hours = offset.inHours.abs().toString().padLeft(2, '0');
    final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final sign = offset.isNegative ? '-' : '+';
    final offsetStr = '$sign$hours:$minutes';

    // Format: YYYY-MM-DDTHH:MM:SS+HH:MM
    final y = year.toString().padLeft(4, '0');
    final m = month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');
    final h = hour.toString().padLeft(2, '0');
    final min = minute.toString().padLeft(2, '0');
    final s = second.toString().padLeft(2, '0');

    return '$y-$m-${d}T$h:$min:$s$offsetStr';
  }

  /// Converts a UTC DateTime to local time.
  DateTime toLocalTime() {
    if (isUtc) {
      return toLocal();
    }
    return this;
  }
}

/// Static utility for parsing timestamps with timezone handling.
class DateTimeParser {
  /// Parses an ISO8601 string and converts to local time.
  /// Handles: UTC (Z suffix), offset (+/-HH:MM), and plain timestamps.
  static DateTime parseToLocal(String timestamp) {
    final parsed = DateTime.parse(timestamp);
    // DateTime.parse returns UTC if the string has 'Z' or offset
    // Convert to local for consistent comparison with DateTime.now()
    return parsed.toLocal();
  }
}
