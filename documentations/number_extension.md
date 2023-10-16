## `number_extension` in `flutter_helper_utils`

### `isSuccessHttpResCode`

Checks if the numeric HTTP status code represents a successful response. Currently, 200 and 201 are considered successful.

```dart
final isSuccess = 200.isSuccessHttpResCode;  // true
```

### `toHttpResStatus`

Converts the numeric HTTP status code to its corresponding `HttpResStatus` enum.

```dart
final status = 404.toHttpResStatus;  // HttpResStatus.notFound
```

### `tryToInt`

Safely converts a nullable number to an integer.

```dart
final integer = someNum?.tryToInt();  
```

### `tryToDouble`

Safely converts a nullable number to a double.

```dart
final doubleValue = someNum?.tryToDouble();  
```

### `percentage`

Calculates the percentage this number represents out of a total.

```dart
final perc = someNum?.percentage(100);  // Calculates percentage
```

### `isNegative` & `isPositive`

Checks if the number is negative or positive.

```dart
final bool neg = someNum?.isNegative;
final bool pos = someNum?.isPositive;
```

### `isZeroOrNull`

Checks if the number is zero or null.

```dart
final zeroOrNull = someNum?.isZeroOrNull;  // true or false
```

### `asBool`

Evaluates the truthiness of a nullable number based on whether it's greater than 0.

```dart
final bool truthy = someNum?.asBool;  // true or false
```

### `isZero`

Checks if the number is zero.

```dart
final bool zero = someNum.isZero;  // true or false
```

### `numberOfDigits`

Returns the number of digits in the number.

```dart
final digits = someNum.numberOfDigits;  // Returns count of digits
```

### `removeTrailingZero`

Removes trailing zeros from the number when converted to a string.

```dart
final str = someNum.removeTrailingZero; // "12" for 12.00, "12.34" for 12.34
```

### `roundToFiftyOrHundred`

Rounds the number up to the nearest fifty or hundred.

```dart
final rounded = someNum.roundToFiftyOrHundred; // 150 for 123, 200 for 190
```

### `roundToTenth`

Rounds the number up to the nearest tenth.

```dart
final rounded = someNum.roundToTenth; // 20 for 18, 30 for 26
```

### `tenth`

Returns one-tenth of the number.

```dart
final part = someNum.tenth; // 2 for 20, 1.2 for 12
```

### `fourth`

Returns one-fourth of the number.

```dart
final part = someNum.fourth; // 5 for 20, 3 for 12
```

### `third`

Returns one-third of the number.

```dart
final part = someNum.third; // 6.666... for 20, 4 for 12
```

### `half`

Returns half of the number.

```dart
final part = someNum.half; // 10 for 20, 6 for 12
```

### `asGreeks`

Converts the number into a more human-readable format using Greek symbols for large numbers.

```dart
final greek = someNum.asGreeks; // "1.5M" for 1500000, "2.5B" for 2500000000
```

### `delay`

Utility to delay code execution or callback for a number of seconds.

```dart
await someNum.delay();  // Delays for 'someNum' seconds
```

### `daysDelay`

Utility to delay code execution or callback for a number of days.

```dart
await someNum.daysDelay;  // Delays for 'someNum' days
```

### `hoursDelay`

Utility to delay code execution or callback for a number of hours.

```dart
await someNum.hoursDelay;  // Delays for 'someNum' hours
```

### `minDelay`

Utility to delay code execution or callback for a number of minutes.

```dart
await someNum.minDelay;  // Delays for 'someNum' minutes
```

### `secDelay`

Utility to delay code execution or callback for a number of seconds.

```dart
await someNum.secDelay;  // Delays for 'someNum' seconds
```

### `millisecondsDelay`

Utility to delay code execution or callback for a number of milliseconds.

```dart
await someNum.millisecondsDelay;  // Delays for 'someNum' milliseconds
```

### `asMilliseconds`, `asSeconds`, `asMinutes`, `asHours`, `asDays`

Utilities to convert the number into a Duration object for various time units.

```dart
final ms = someNum.asMilliseconds; // Converts to Duration in milliseconds
final sec = someNum.asSeconds; // Converts to Duration in seconds
final min = someNum.asMinutes; // Converts to Duration in minutes
final hr = someNum.asHours; // Converts to Duration in hours
final days = someNum.asDays; // Converts to Duration in days
```

### `until`

Utility to generate a sequence of numbers from this number to the specified end number.

```dart
final sequence = someNum.until(10);  // [someNum, someNum+1, ..., 9]
```

### `inRangeOf(min, max)`

Clamps the number within the given range.

- `min`: Minimum allowed value.
- `max`: Maximum allowed value.

Throws Exception if either `min` or `max` is null.
Throws ArgumentError if `min` is greater than `max`.

```dart
var num = 5;
print(num.inRangeOf(1, 10)); // Output: 5
```

### `absolute`

Returns the absolute value of the number.

```dart
var num = -5;
print(num.absolute); // Output: 5
```

### `doubled`

Doubles the value of the number.

```dart
var num = 5;
print(num.doubled); // Output: 10
```

### `tripled`

Triples the value of the number.

```dart
var num = 5;
print(num.tripled); // Output: 15
```

### `quadrupled`

Quadruples the value of the number.

```dart
var num = 5;
print(num.quadrupled); // Output: 20
```

### `squared`

Squares the value of the number.

```dart
var num = 5;
print(num.squared); // Output: 25
```
