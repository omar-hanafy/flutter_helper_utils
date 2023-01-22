import 'dart:developer';

extension DateString on String {
  /// Parse string to [DateTime]
  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      log('toDateTime() Unsupported object type: exception message -> $e');
      return null;
    }
  }
}

extension DateInt on int {
  Duration toMilliseconds() => Duration(milliseconds: this);

  Duration toSeconds() => Duration(seconds: this);

  Duration toMinutes() => Duration(minutes: this);

  Duration toHours() => Duration(hours: this);

  Duration toDays() => Duration(days: this);
}

extension DateExtensions on DateTime {
  /// Adds this DateTime and Duration and returns the sum as a new DateTime object.
  DateTime operator +(Duration duration) => add(duration);

  /// Subtracts the Duration from this DateTime returns the difference as a new DateTime object.
  DateTime operator -(Duration duration) => subtract(duration);

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
  bool disAtSameMinuteAs(DateTime other) =>
      isAtSameHourAs(other) && minute == other.minute;

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

  bool get isYesterday {
    final nowDate = DateTime.now();
    return year == nowDate.year &&
        month == nowDate.month &&
        day == nowDate.day - 1;
  }

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
    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  bool get isFirstDayOfMonth => isSameDay(firstDayOfMonth, this);

  bool get isLastDayOfMonth => isSameDay(lastDayOfMonth, this);

  DateTime get firstDayOfMonth => DateTime(year, month);

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

  /// The last day of a given month
  DateTime get lastDayOfMonth {
    final beginningNextMonth =
        (month < 12) ? DateTime(year, month + 1) : DateTime(year + 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
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

  DateTime get previousWeek => subtract(const Duration(days: 7));

  DateTime get nextWeek => add(const Duration(days: 7));

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

  bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    // ignore: parameter_assignments
    a = DateTime.utc(a.year, a.month, a.day);
    // ignore: parameter_assignments
    b = DateTime.utc(b.year, b.month, b.day);

    final diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    final min = a.isBefore(b) ? a : b;
    final max = a.isBefore(b) ? b : a;
    final result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  /// Whether or not two times are on the same day.
  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// return true if the date is today
  bool isToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentDate = DateTime(year, month, day);
    return today.isAtSameMomentAs(currentDate);
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

  ///  Start time of Date times
  DateTime startOfDay() => DateTime(year, month, day);

  DateTime startOfMonth() => DateTime(year, month);

  DateTime startOfYear() => DateTime(year);

  /// next day
  DateTime tomorrow() => DateTime(year, month, day + 1);

  /// last day
  DateTime yesterday() => DateTime(year, month, day - 1);

  /// return the smaller date between
  DateTime min(DateTime that) =>
      (millisecondsSinceEpoch < that.millisecondsSinceEpoch) ? this : that;

  DateTime max(DateTime that) =>
      (millisecondsSinceEpoch > that.millisecondsSinceEpoch) ? this : that;

  bool get isLeapYear =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  /// Current date (Same as [Date.now])
  static DateTime get today => DateTime.now();

  /// Returns a [DateTime] with the date of the original, but time set to
  /// midnight.
  DateTime get dateOnly => DateTime(year, month, day);

  bool get isTomorrow {
    final nowDate = DateTime.now();
    return year == nowDate.year &&
        month == nowDate.month &&
        day == nowDate.day + 1;
  }

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

  /// The day after this [DateTime]
  DateTime get nextDay => addDays(1);

  /// The day previous this [DateTime]
  DateTime get previousDay => addDays(-1);
}
