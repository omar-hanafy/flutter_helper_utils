import 'dart:developer';

import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:intl/intl.dart';

extension DateString on String? {
  /// Parse string to [DateTime] using null Safety
  DateTime? get tryToDateTime {
    try {
      return DateTime.tryParse('$this');
    } catch (e, s) {
      log(
        'toDateTime() Unsupported object type: exception message -> $e',
        stackTrace: s,
      );
      return null;
    }
  }

  /// Parse string to [DateTime]
  DateTime get toDateTime => DateTime.parse(this!);

  DateFormat get dateFormat => DateFormat(this);

  /// Parse string to [DateTime] but with a specific format, e.g, 'd-M-y'.
  DateTime toDateWithFormat(String format) => format.dateFormat.parse(this!);

  /// Parse string to nullable [DateTime] but with a specific format, e.g, 'd-M-y'.
  DateTime? tryToDateWithFormat(String format) =>
      isEmptyOrNull ? null : format.dateFormat.parse(this!);

  DateTime get timestampToDate => DateTime.fromMillisecondsSinceEpoch(toInt);
}

extension ToDate on num {
  String get toSmallMonthName => DateTime(0, toInt()).format('MMM');

  String get toFullMonthName => DateTime(0, toInt()).format('MMMM');

  String get toFullDayName => DateTime(0, 0, toInt()).format('EEEE');

  String get toSmallDayName => DateTime(0, 0, toInt()).format('EEE');

  DateTime get timestampToDate => DateTime.fromMillisecondsSinceEpoch(toInt());
}

extension NullableDateExtensions on DateTime? {
  DateTime? get local => this?.toLocal();

  String? get toUtcIso => this?.toUtc().toIso8601String();

  bool get isTomorrow {
    if (isNull) return false;
    final nowDate = DateTime.now();
    return this!.year == nowDate.year &&
        this!.month == nowDate.month &&
        this!.day == nowDate.day + 1;
  }

  /// return true if the date is today
  bool get isToday {
    if (isNull) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentDate = DateTime(this!.year, this!.month, this!.day);
    return today.isAtSameMomentAs(currentDate);
  }

  bool get isYesterday {
    if (isNull) return false;
    final nowDate = DateTime.now();
    return this!.year == nowDate.year &&
        this!.month == nowDate.month &&
        this!.day == nowDate.day - 1;
  }

  bool get isPresent => isNotNull && this!.isAfter(DateTime.now());

  bool get isPast => isNotNull && this!.isBefore(DateTime.now());

  bool get isInPastWeek {
    if (isNull) return false;
    final now = DateTime.now();
    return now.dateOnly.previousWeek.isBefore(this!) && now.isAfter(this!);
  }

  bool get isInThisYear => isNotNull && this!.year == DateTime.now().year;

  bool get isFirstDayOfMonth =>
      isNotNull && DatesHelper.isSameDay(this!.firstDayOfMonth, this!);

  bool get isLastDayOfMonth =>
      isNotNull && DatesHelper.isSameDay(this!.lastDayOfMonth, this!);

  bool get isLeapYear {
    if (isNull) return false;
    return (this!.year % 4 == 0) &&
        ((this!.year % 100 != 0) || (this!.year % 400 == 0));
  }

  Duration? get passedDuration =>
      isNull ? null : DateTime.now().difference(this!);

  String? tryFormat(String format) =>
      isNotNull ? format.dateFormat.format(this!) : null;

  int? get remainingDays =>
      isNotNull ? DatesHelper.diffInDays(to: this!) : null;

  int? get passedDays => isNotNull
      ? DatesHelper.diffInDays(from: DateTime.now(), to: this!)
      : null;
}

extension DateExtensions on DateTime {
  DateTime get local => toLocal();

  String format(String format) => format.dateFormat.format(this);

  String get toUtcIso => toUtc().toIso8601String();

  /// Adds this DateTime and Duration and returns the sum as a new DateTime object.
  DateTime operator +(Duration duration) => add(duration);

  /// Subtracts the Duration from this DateTime returns the difference as a new DateTime object.
  DateTime operator -(Duration duration) => subtract(duration);

  Duration get passedDuration => DateTime.now().difference(this);

  int get passedDays => DatesHelper.diffInDays(from: DateTime.now(), to: this);

  Duration get remainingDuration => difference(DateTime.now());

  int get remainingDays => DatesHelper.diffInDays(to: this);

  /// Returns true if [other] is in the same year as [this].
  ///
  /// Does not account for timezones.
  bool isAtSameYearAs(DateTime other) => year == other.year;

  /// Returns true if [other] is in the same month as [this].
  ///
  /// This means the exact month, including year.
  ///
  /// Does not account for timezones.
  bool isAtSameMonthAs(DateTime other) =>
      isAtSameYearAs(other) && month == other.month;

  /// Returns true if [other] is on the same day as [this].
  ///
  /// This means the exact day, including year and month.
  ///
  /// Does not account for timezones.
  bool isAtSameDayAs(DateTime other) =>
      isAtSameMonthAs(other) && day == other.day;

  /// Returns true if [other] is at the same hour as [this].
  ///
  /// This means the exact hour, including year, month and day.
  ///
  /// Does not account for timezones.
  bool isAtSameHourAs(DateTime other) =>
      isAtSameDayAs(other) && hour == other.hour;

  /// Returns true if [other] is at the same minute as [this].
  ///
  /// This means the exact minute, including year, month, day and hour.
  ///
  /// Does not account for timezones.
  bool isAtSameMinuteAs(DateTime other) =>
      isAtSameHourAs(other) && minute == other.minute;

  /// Returns true if [other] is at the same second as [this].
  ///
  /// This means the exact second, including year, month, day, hour and minute.
  ///
  /// Does not account for timezones.
  bool isAtSameSecondAs(DateTime other) =>
      isAtSameMinuteAs(other) && second == other.second;

  /// Returns true if [other] is at the same millisecond as [this].
  ///
  /// This means the exact millisecond,
  /// including year, month, day, hour, minute and second.
  ///
  /// Does not account for timezones.
  bool isAtSameMillisecondAs(DateTime other) =>
      isAtSameSecondAs(other) && millisecond == other.millisecond;

  /// Returns true if [other] is at the same microsecond as [this].
  ///
  /// This means the exact microsecond,
  /// including year, month, day, hour, minute, second and millisecond.
  ///
  /// Does not account for timezones.
  bool isAtSameMicrosecondAs(DateTime other) =>
      isAtSameMillisecondAs(other) && microsecond == other.microsecond;

  ///  Start time of Date times
  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get startOfMonth => DateTime(year, month);

  DateTime get startOfYear => DateTime(year);

  /// next day
  DateTime get tomorrow => DateTime(year, month, day + 1);

  /// last day
  DateTime get yesterday => DateTime(year, month, day - 1);

  /// Current date (Same as [Date.now])
  static DateTime get today => DateTime.now();

  /// Returns a [DateTime] with the date of the original, but time set to
  /// midnight.
  DateTime get dateOnly => DateTime(year, month, day);

  /// The list of days in a given month
  List<DateTime> get daysInMonth {
    final first = firstDayOfMonth;
    final daysBefore = first.weekday;
    final firstToDisplay = first.subtract(Duration(days: daysBefore));
    final last = lastDayOfMonth;

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    final lastToDisplay = last.add(Duration(days: daysAfter));
    return DatesHelper.daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  /// The day previous this [DateTime]
  DateTime get previousDay => addDays(-1);

  /// The day after this [DateTime]
  DateTime get nextDay => addDays(1);

  DateTime get previousWeek => subtract(const Duration(days: 7));

  DateTime get nextWeek => add(const Duration(days: 7));

  DateTime get firstDayOfWeek {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    final day = DateTime.utc(year, month, this.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    final decreaseNum = day.weekday % 7;
    return subtract(Duration(days: decreaseNum));
  }

  DateTime get lastDayOfWeek {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    final day = DateTime.utc(year, month, this.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    final increaseNum = day.weekday % 7;
    return day.add(Duration(days: 7 - increaseNum));
  }

  DateTime get previousMonth {
    var year = this.year;
    var month = this.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  DateTime get nextMonth {
    var year = this.year;
    var month = this.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  DateTime get firstDayOfMonth => DateTime(year, month);

  /// The last day of a given month
  DateTime get lastDayOfMonth {
    final beginningNextMonth =
        (month < 12) ? DateTime(year, month + 1) : DateTime(year + 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  /// to add years to a [DateTime] add a positive number
  /// to remove years pass a negative number
  DateTime addOrRemoveYears(int years) {
    return DateTime(year + years, month, day, minute, second);
  }

  /// to add month to a [DateTime] add a positive number
  /// to remove years pass a negative number
  DateTime addOrRemoveMonth(int months) {
    return DateTime(year, month + months, day, minute, second);
  }

  /// to add days to a [DateTime] add a positive number
  /// to remove days pass a negative number
  DateTime addOrRemoveDay(int days) {
    return DateTime(year, month, day + days, minute, second);
  }

  /// to add min to a [DateTime] add a positive number
  /// to remove min pass a negative number
  DateTime addOrRemoveMinutes(int min) {
    return DateTime(year, month, day, minute + min, second);
  }

  /// to add sec to a [DateTime] add a positive number
  /// to remove sec pass a negative number
  DateTime addOrRemoveSeconds(int sec) {
    return DateTime(year, month, day, minute, second + sec);
  }

  /// return the smaller date between
  DateTime min(DateTime that) =>
      (millisecondsSinceEpoch < that.millisecondsSinceEpoch) ? this : that;

  DateTime max(DateTime that) =>
      (millisecondsSinceEpoch > that.millisecondsSinceEpoch) ? this : that;

  /// Add a certain amount of days to this date
  DateTime addDays(int amount) => DateTime(
        year,
        month,
        day + amount,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );

  /// Add a certain amount of hours to this date
  DateTime addHours(int amount) => DateTime(
        year,
        month,
        day,
        hour + amount,
        minute,
        second,
        millisecond,
        microsecond,
      );
}

abstract class DatesHelper {
  // Whether or not two times are on the same hour.
  static bool isSameHour(DateTime a, DateTime b) =>
      a.difference(b).inMinutes < 60;

  // Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    final t1 = DateTime.utc(a.year, a.month, a.day);
    final t2 = DateTime.utc(b.year, b.month, b.day);
    final diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) return false;
    final t1IsBefore = t1.isBefore(t2);
    final min = t1IsBefore ? t1 : t2;
    final max = t1IsBefore ? t2 : t1;
    return max.weekday % 7 - min.weekday % 7 >= 0;
  }

  /// Returns the absolute value of the difference in days between two dates.
  /// The difference is calculated by comparing only the year, month, and day values of the dates.
  /// The hour, minute, second, and millisecond values are ignored.
  /// For example, if date1 is August 22nd at 11 p.m. and date2 is August 24th at 12 a.m. midnight,
  /// the difference in days is 2, not a fraction of a day.
  static int diffInDays({required DateTime to, DateTime? from}) {
    final f = from ?? DateTime.now();
    return DateTime(to.year, to.month, to.day)
        .difference(DateTime(f.year, f.month, f.day))
        .inDays;
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.isBefore(end)) {
      yield i;
      i = i.add(const Duration(days: 1));
      final timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }
}
