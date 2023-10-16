## DateTime Extensions

### tryToDateTime
Safely attempts to convert a string to a DateTime object. Returns null if the conversion fails.
```dart
String? dateStr = "2023-01-01";
print(dateStr.tryToDateTime);  // Output: DateTime object or null
```

### toDateTime
Converts a string to a DateTime object. Throws an exception if the conversion fails.
```dart
String dateStr = "2023-01-01";
print(dateStr.toDateTime);  // Output: DateTime object
```

### dateFormat
Returns a DateFormat object based on the string format provided.
```dart
String format = "yMd";
print(format.dateFormat);  // Output: DateFormat object
```

### toDateWithFormat
Converts a string to a DateTime object using a specific format.
```dart
String dateStr = "1-2-2023";
print(dateStr.toDateWithFormat("d-M-y"));  // Output: DateTime object
```

### tryToDateWithFormat
Safely attempts to convert a string to a DateTime object using a specific format. Returns null if the conversion fails.
```dart
String? dateStr = "1-2-2023";
print(dateStr.tryToDateWithFormat("d-M-y"));  // Output: DateTime object or null
```

### timestampToDate
Converts a timestamp string to a DateTime object.
```dart
String timestamp = "1635530400000";
print(timestamp.timestampToDate);  // Output: DateTime object
```

### toSmallMonthName and toFullMonthName
Convert an integer representing a month to its abbreviated or full name.
```dart
int month = 1;
print(month.toSmallMonthName);  // Output: "Jan"
print(month.toFullMonthName);  // Output: "January"
```

### toSmallDayName and toFullDayName
Convert an integer representing a day of the week to its abbreviated or full name.
```dart
int day = 1;
print(day.toSmallDayName);  // Output: "Mon"
print(day.toFullDayName);  // Output: "Monday"
```

### timestampToDate (numeric)
Converts a numeric timestamp to a DateTime object.
```dart
int timestamp = 1635530400000;
print(timestamp.timestampToDate);  // Output: DateTime object
```

### local
Returns a new DateTime object representing the local date and time.
```dart
DateTime? date = DateTime.utc(2023, 1, 1);
print(date.local);  // Output: DateTime object in local time
```

### toUtcIso
Returns an ISO-8601 string representation of the UTC date.
```dart
DateTime? date = DateTime.utc(2023, 1, 1);
print(date.toUtcIso);  // Output: "2023-01-01T00:00:00.000Z"
```

### isTomorrow

Checks if the date is tomorrow.
```dart
DateTime date = DateTime.now().add(Duration(days: 1));
print(date.isTomorrow);  // Output: true
```

### isToday
Checks if the date is today.
```dart
DateTime date = DateTime.now();
print(date.isToday);  // Output: true
```

### isYesterday
Checks if the date was yesterday.
```dart
DateTime date = DateTime.now().subtract(Duration(days: 1));
print(date.isYesterday);  // Output: true
```

### isPresent
Checks if the date is in the future.
```dart
DateTime date = DateTime.now().add(Duration(days: 1));
print(date.isPresent);  // Output: true
```

### isPast
Checks if the date is in the past.
```dart
DateTime date = DateTime.now().subtract(Duration(days: 1));
print(date.isPast);  // Output: true
```

### isInPastWeek
Checks if the date is within the last week.
```dart
DateTime date = DateTime.now().subtract(Duration(days: 3));
print(date.isInPastWeek);  // Output: true
```

### isInThisYear
Checks if the date is in the current year.
```dart
DateTime date = DateTime.now();
print(date.isInThisYear);  // Output: true
```

### isFirstDayOfMonth
Checks if the date is the first day of the month.
```dart
DateTime date = DateTime(DateTime.now().year, DateTime.now().month, 1);
print(date.isFirstDayOfMonth);  // Output: true
```

### isLastDayOfMonth
Checks if the date is the last day of the month.
```dart
DateTime date = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
print(date.isLastDayOfMonth);  // Output: true
```

### isLeapYear
Checks if the year of the date is a leap year.
```dart
DateTime date = DateTime(2024, 1, 1);
print(date.isLeapYear);  // Output: true
```

### tryFormat, format
Safely attempts to format the date into a string using the given format.
```dart
DateTime date = DateTime.now();
print(date.tryFormat("yMd"));  // Output: "2023-01-01" or null
print(date.format("yMd"));  // Output: "2023-01-01"
```

### passedDuration
Gets the duration that has passed since the date.
```dart
DateTime date = DateTime.now().subtract(Duration(days: 1));
print(date.passedDuration);  // Output: Duration object
```

### remainingDuration
Gets the duration remaining until the date.
```dart
DateTime date = DateTime.now().add(Duration(days: 1));
print(date.remainingDuration);  // Output: Duration object
```

### passedDays
Gets the number of days that have passed since the date.
```dart
DateTime date = DateTime.now().subtract(Duration(days: 1));
print(date.passedDays);  // Output: 1
```

### remainingDays
Gets the number of days remaining until the date.
```dart
DateTime date = DateTime.now().add(Duration(days: 1));
print(date.remainingDays);  // Output: 1
```

### + (Addition)
Adds a Duration to the DateTime object.
```dart
DateTime date = DateTime.now();
Duration duration = Duration(days: 1);
print(date + duration);  // Output: DateTime object
```

### - (Subtraction)
Subtracts a Duration from the DateTime object.
```dart
DateTime date = DateTime.now();
Duration duration = Duration(days: 1);
print(date - duration);  // Output: DateTime object
```

### isAtSameYearAs
Checks if the given DateTime object is in the same year as the current DateTime object. This function does not account for timezones.
```dart
DateTime dateTime1 = DateTime(2022, 6, 15);
DateTime dateTime2 = DateTime(2022, 1, 5);
print(dateTime1.isAtSameYearAs(dateTime2)); // Output: true
```

### isAtSameMonthAs
Checks if the given DateTime object is in the same month and year as the current DateTime object. This function does not account for timezones.
```dart
DateTime dateTime1 = DateTime(2022, 6, 15);
DateTime dateTime2 = DateTime(2022, 6

, 5);
print(dateTime1.isAtSameMonthAs(dateTime2)); // Output: true
```

### isAtSameDayAs
Checks if the given DateTime object is on the same day, month, and year as the current DateTime object. This function does not account for timezones.
```dart
DateTime dateTime1 = DateTime(2022, 6, 15);
DateTime dateTime2 = DateTime(2022, 6, 15);
print(dateTime1.isAtSameDayAs(dateTime2)); // Output: true
```

### isAtSameHourAs
Checks if the given DateTime object is at the same hour, day, month, and year as the current DateTime object. This function does not account for timezones.
```dart
DateTime dateTime1 = DateTime(2022, 6, 15, 12);
DateTime dateTime2 = DateTime(2022, 6, 15, 12);
print(dateTime1.isAtSameHourAs(dateTime2)); // Output: true
```

### isAtSameMinuteAs, isAtSameSecondAs, isAtSameMillisecondAs, isAtSameMicrosecondAs
These methods provide finer granularity checks, ranging from minutes to microseconds.

### startOfDay, startOfMonth, startOfYear
These methods return a new DateTime object representing the start of the day, month, or year of the original DateTime object.

```dart
DateTime dateTime = DateTime(2022, 6, 15, 12, 30);
print(dateTime.startOfDay); // Output: 2022-06-15 00:00:00.000
```

### tomorrow, yesterday
These methods return a new DateTime object representing the next or previous day.
```dart
DateTime dateTime = DateTime(2022, 6, 15);
print(dateTime.tomorrow); // Output: 2022-06-16 00:00:00.000
print(dateTime.yesterday); // Output: 2022-06-14 00:00:00.000
```

### addOrRemoveYears, addOrRemoveMonth, addOrRemoveDay, addOrRemoveMinutes, addOrRemoveSeconds
These methods allow you to add or remove a certain time unit from the DateTime object. To remove, pass a negative number.
```dart
DateTime dateTime = DateTime(2022, 6, 15);
print(dateTime.addOrRemoveYears(1)); // Output: 2023-06-15 00:00:00.000
```

### min, max
Returns the smaller or larger date between the current and another DateTime object.
```dart
DateTime dateTime1 = DateTime(2022, 6, 15);
DateTime dateTime2 = DateTime(2021, 6, 15);
print(dateTime1.min(dateTime2)); // Output: 2021-06-15 00:00:00.000
```

### addDays, addHours
These methods add a certain number of days or hours to the DateTime object.
```dart
DateTime dateTime = DateTime(2022, 6, 15);
print(dateTime.addDays(1)); // Output: 2022-06-16 00:00:00.000
```
