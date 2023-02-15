import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {

  static String timeFormat12Hours = "hh:mm a";
  static String halfMonthDateFormat = "dd-MMM-yyyy";
  static String fullMonthDateFormat = "dd-MMMM-yyyy";

  String getToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var givenDate = DateTime(year, month, day);
    if (today == givenDate) {
      return "Today";
    } else {
      return getYesterday();
    }
  }

  String getYesterday() {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    var givenDate = DateTime(year, month, day);
    if (yesterday == givenDate) {
      return "Yesterday";
    } else {
      return dateWithHalfMonthName();
    }
  }

  String getTomorrow() {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day + 1);
    var givenDate = DateTime(year, month, day);
    if (yesterday == givenDate) {
      return "Tomorrow";
    } else {
      return dateWithHalfMonthName();
    }
  }

  /// get time into 12 hour format
  String getTimeIn12Hours() {
    return DateFormat(timeFormat12Hours).format(this);
  }

  /// get date in string with half month name
  String dateWithHalfMonthName({String? format}) {
    final DateFormat formatter = DateFormat(format??halfMonthDateFormat);
    return formatter.format(this);
  }

  /// get date in string with half month name
  String dateWithFullMonthName({String? format}) {
    final DateFormat formatter = DateFormat(format??fullMonthDateFormat);
    return formatter.format(this);
  }

  /// Returns true if given date is today
  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return DateTime(year, month, day) == today;
  }

  /// Returns true if given date is yesterday
  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    return DateTime(year, month, day) == yesterday;
  }

  /// Returns true if given date is tomorrow
  bool get isTomorrow {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    return DateTime(year, month, day) == tomorrow;
  }
}

/// return current time in milliseconds
int currentMillisecondsTimeStamp() => DateTime.now().millisecondsSinceEpoch;

/// return current timestamp
int currentTimeStamp() {
  return (DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt();
}

/// return true if given year is an leap year
bool leapYear(int year) {
  bool leapYear = false;

  bool leap = ((year % 100 == 0) && (year % 400 != 0));
  if (leap == true) {
    leapYear = false;
  } else if (year % 4 == 0) {
    leapYear = true;
  }

  return leapYear;
}

/// returns number of days in given month
int daysInMonth(int monthNum, int year) {
  List<int> monthLength = [];

  monthLength[0] = 31;
  monthLength[2] = 31;
  monthLength[4] = 31;
  monthLength[6] = 31;
  monthLength[7] = 31;
  monthLength[9] = 31;
  monthLength[11] = 31;
  monthLength[3] = 30;
  monthLength[8] = 30;
  monthLength[5] = 30;
  monthLength[10] = 30;

  if (leapYear(year)) {
    monthLength[1] = 29;
  } else {
    monthLength[1] = 28;
  }

  return monthLength[monthNum - 1];
}
