---
title: DateTime Helper
---

# DateTime Helper

## `isSameHour`

Determines whether two given `DateTime` objects fall within the same hour.

```dart
final sameHour = DatesHelper.isSameHour(dateTime1, dateTime2);
```

## `isSameDay`

Checks if two `DateTime` objects belong to the same day.

```dart
final sameDay = DatesHelper.isSameDay(dateTime1, dateTime2);
```

## `isSameWeek`

Determines whether two `DateTime` objects fall within the same week.

```dart
final sameWeek = DatesHelper.isSameWeek(dateTime1, dateTime2);
```

## `diffInDays`

Calculates the absolute difference in days between two dates.

```dart
final daysDifference = DatesHelper.diffInDays(to: targetDate, from: referenceDate);
```

## `daysInRange`

Generates a sequence of `DateTime` objects representing each day within a specified date range.

```dart
final dateRange = DatesHelper.daysInRange(startDate, endDate);
```

There is a lot of other helpers in the [DateTime Extension](/documentation/date-time-extension)