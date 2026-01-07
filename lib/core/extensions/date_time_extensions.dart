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
}
