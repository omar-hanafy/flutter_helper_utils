![](https://raw.githubusercontent.com/omar-hanafy/flutter_helper_utils/9bb44613da240f408d02a6e745f92e5f88050265/logo.svg)

The [flutter_helper_utils](https://pub.dev/packages/flutter_helper_utils) is a valuable tool for developers who want to speed up their development process. It offers various [extensions](https://dart.dev/language/extension-methods) and helper methods that can make development more efficient.

## **Why I Created This Package**

Hey there! As developers, we all know that writing repeated or boilerplate code can really slow down the development process. That's why I wanted to share all the helper methods and [extensions](https://dart.dev/language/extension-methods) I've created in my previous projects within this package.

For instance, instead of calling `MediaQuery.of(context);` to get the MediaQuery of a specific context, this package makes it as easy as using `context.mq;`.

Or if you want to safeley cast dynamic list to list of strings you can use `ConvertObject.tryToList<String>(dynamicList);`

If you want to learn more about extensions, click [here](https://dart.dev/language/extension-methods).

## Installation

To use this package, add `flutter_helper_utils` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_helper_utils: ^1.2.0
```

Then, run `flutter pub get` in your terminal.
```bash
flutter pub get
```

## Usage

After installation, import the package in your dart file:

```dart
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
```

You can now use any of the helper methods or extensions provided by the package. Some examples include:

### `Navigation` extension

```dart
// Navigate to a new screen and remove all previous screens from the stack.
context.pushReplacementNamed('/home');

// Navigate to a new screen and remove it from the stack after it's closed.
context.pushNamedAndRemoveUntil('/login', ModalRoute.withName('/home'));

// Navigate to a new screen and pass/recieve data from/to it.
final data = await context.pushNamed<String?>('/details', arguments: {'id': 123});

// push, pushReplacement, popPage, popUntil and canPop are also available.
```

### `MediaQuery` extension

```dart
// Get the MediaQuery of a specific context.
final mediaQuery = context.mq;

// Get the screen width, height, and size.
final screenWidth = context.widthPx;
final screenHeight = context.heightPx;
final screenSize = context.sizePx;

// Check if the screen is in landscape mode.
final isLandscape = context.isLandscape;

// Check if the screen is in portrait mode.
final isPortrait = context.isPortrait;
```

### `Platform` extension

```dart
// Check the current platform using `Platform`.
final isMobile = Platform.isMobile;
final isIOS = Platform.isIOS;
final isAndroid = Platform.isAndroid;
final isDesktop = Platform.isDesktop;

// or using `BuildContext`.
final isMobile = context.isMobile;
final isIOS = context.isIOS;
final isAndroid = context.isAndroid;
final isDesktop = context.isDesktop;
```

### `Theme` extension

```dart
// Get the ThemeData of a specific context.
final theme = context.themeData;

// Get the accent color from the current theme.
final accentColor = context.themeData.accentColor;

// Get the text theme from the current theme.
final textTheme = context.textTheme;

// Get the running device system brightness.
final brightness = context.sysBrightness;

// Check if the current brightness is dark.
final brightness = context.isDark; // or `isLight`
```

### `Color` extension

```dart
// check whether the string is a hex color or not;
bool isHex = '#FF0000'.isHexColor; // true;

// Get a color from a hexadecimal string
Color color = '#FF0000'.toColor;

// Get a hexadecimal string from Color
String hexadecimal = color.toHex(leadingHashSign: false); // FF0000
```

### `DateTime` extension

```dart
// Parsing a string to DateTime using null safety
DateTime? dateTime = '2022-04-27'.tryToDateTime;

// Parsing a string to DateTime
DateTime dateTime2 = '2022-04-27'.toDateTime;

final now = DateTime.now();

// Adds 1 day to current date
DateTime tomorrow = now.addDays(1); // addHours also available

// Returns the day after current date
DateTime nextDay = now.nextDay;

// Returns true if the current date is yesterday
bool isYesterday = now.isYesterday; // false

// Returns true if the current date is today
bool isToday = now.isToday; // true

// Returns the previous month from the current date
DateTime previousMonth = now.previousMonth;

// Getting small month name from month number
String smallMonthName = now.month.toSmallMonthName; // e.g Mar

// Getting full month name from month number
String fullMonthName = now.month.toFullMonthName; // e.g March
```

### `Duration` extension

```dart
const duration = Duration(hours: 1, minutes: 30);

// Adds the Duration to the current DateTime and returns a DateTime in the future.
DateTime futureDate = duration.fromNow;

// Subtracts the Duration from the current DateTime and returns a DateTime in the past
DateTime pastDate = duration.ago;

// run async delay
await duration.delay<void>(); 

```

### `int, double, and num` extension

```dart
final int number = 100;

// convert numbers to greeks.
  // e.g 1000 => 1k
  //     20000 => 20k
  //     1000000 => 1M
String greeks = number.asGreeks; // 10k

// Easy way to make Durations from numbers.
Duration seconds = number.asSeconds; //  Duration(seconds: 100)
  
int numberOfDigits = number.numberOfDigits; // 3

// Return this number time two (tripled, quadrupled, and squared are also available).
int doubled = number.doubled; // 200
```

### `String` extension:

```dart
String text = 'hello there!';

// wrap string at the specified index
String wrappedString = text.wrapString(2);

// capitalize the first letter of the string
String capitalized = text.capitalizeFirstLetter; // 'Hello there!'

// convert the string to PascalCase ('camelCase' and 'Title Case' also available)
String pascalCase = text.toPascalCase; // 'HelloThere'.

// check if the string is alphanumeric
bool isAlphanumeric = text.isAlphanumeric; // false

// convert to one line string
String twoLineString = 'ab'
  										 'cd';
String oneLine = text.toOneLine; // abcd

// check if the string is null or empty
bool isEmptyOrNull = text.isEmptyOrNull;

// check if the string is a valid username 
bool isValidUsername = text.isValidUsername; // 'isValidPhoneNumber', isValidEmail, isValidHTML, and more are also available

// convert string to double or return null
double? tryToDouble = text.tryToDouble; // tryToInt also available

// limit the string from the start
String? limitFromStart = text.limitFromStart(3); // limitFromEnd also available

```

### `Align` extension

```dart
// Align an icon to the bottom right of a container. 
Container(
  height: 100,
  width: 100,
  color: Colors.grey,
  child: Icon(Icons.favorite),
).alignAtBottomRight(),
// alignAtBottomCenter, alignAtCenterRight, and alignAtTopRight are also available
```

### `List` extension

```dart
// convert and list of widgets to Column, Row, ListView, or stack.
final list = <Widget>[];

final column = list.toColumnWidget(
  mainAxisAlignment: MainAxisAlignment.center,
);

final listBuilder = list.toListViewBuilder(
  // itemCount: 1, // default to list.length. 
  itemBuilder: (context, index) => Container(
    color: context.themeData.primaryColor,
    width: context.widthPx,
    height: 100,
  ),
);
```

### `Padding` extension

```dart
// Add padding to all sides of a widget
AnyWidget(
  child: Text('Hello, world!'),
).paddingAll(12);

// Add padding to only the top and bottom of a widget
AnyWidget(
  child: Text('Hello, world!'),
).paddingSymmetric(v: 12, h: 15);
// paddingAll, paddingLTRB, paddingSymmetric, and paddingOnly are also available.
```

## `ConvertObject` Class

The `ConvertObject` class provides a set of static methods for converting objects to different data types in Dart. It can convert objects to `String`, `int`, `double`, `DateTime`, `bool`, `List`, `Set`, and `Map` data types.

#### Why?

While Dart provides some built-in conversion tools, such as `toString`, `int.parse()`, and `DateTime.parse()`, these methods do not always provide detailed error messages or stack traces when errors occur during conversion.

The `ConvertObject` class, on the other hand, not only provides an efficient way to convert objects, but it also helps to handle any errors that may occur during the conversion process. Specifically, the class includes a `ParsingException` class that provides detailed explanations of any errors that occur during conversion, including where the error occurred in the code (line number) and a stack trace for debugging purposes.

This class can be particularly useful when dealing with JSON data from an API that needs to be parsed into a Dart object. With the conversion methods provided in the `ConvertObject` class, we can efficiently and effectively handle conversions and ensure our code is robust and reliable 😄.

### Convert any Object to numbers or Return Null

The `tryToDouble` and `tryToInt` methods of the `ConvertObject` class can be used to convert any object to an `int` or return null if the object is null or conversions throws any exceptions.

```dart
var value = '10.5';
var intValue = ConvertObject.tryToInt(value); // return 10

var doubleValue = ConvertObject.toDouble(value); // returns 10.5
```

### Convert any Object to bool

The `toBool` method of the `ConvertObject` class can be used to convert any object to a `bool`. If the object is null, the method returns `false` by default.

* return true if
  * object is bool and equal to true.
  * object is string and equal to 'yes' or 'true'.
  * object is num, int, or double and is larger than zero.

```dart
var value = 'true';
var boolValue = ConvertObject.toBool(value); // tryToBool also available. It's used to return null (not false) if object is null.
```

### Convert any Object to DateTime

The `toDateTime` method of the `ConvertObject` class can be used to convert any object to a `DateTime`. If the object is null, a `ParsingException` is thrown

* `toInt`, `toDouble`, `toNum`, `toBool`, and `toString1` are also available.

```dart
var value = '2022-05-06';
DateTime date = ConvertObject.toDateTime(value);
```

### Convert any Object to List

The `toList` method of the `ConvertObject` class can be used to convert any object to a `List`. It can be useful when we want to cast a list of type to a list of another type. If the object is null, a `ParsingException` is thrown.

```dart
List<String> strings = ["1", "2", "3"];
List<int> numbers = ConvertObject.toList<int>(value); // returns <int>[1, 2, 3];
// tryToList also available
```

### Convert any Object to Map

The `toMap` method of the `ConvertObject` class can be used to convert any object to a `Map`. If the object is null, a `ParsingException` is thrown. If the object is not a `Map` data type, a `ParsingException` is also thrown.

```dart
Map<String, String> value = {'key': 'value'};
Map<String, dynamic> mapValue = ConvertObject.tryToMap<String, dynamic>(value); // tryToMap also availbale.
```

Here is a table explaining each method in the `ConvertObject` class:

| Method Name                                    | Description                                                                                                         |
|------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| `toString1(dynamic object) => String`          | Converts any object to a `String` if the object is not null. Throws a `ParsingException` if the object is null.     |
| `tryToString(dynamic object) => String?`       | Converts any object to a `String` or returns null if the object is null.                                            |
| `toNum(dynamic object) => num`                 | Converts any object to a `num`. Throws a `ParsingException` if the object is null or if the conversion fails.       |
| `tryToNum(dynamic object) => num?`             | Converts any object to a `num` or returns null if the object is null or if the conversion fails.                    |
| `toInt(dynamic object) => int`                 | Converts any object to an `int`. Throws a `ParsingException` if the object is null or if the conversion fails.      |
| `tryToInt(dynamic object) => int?`             | Converts any object to an `int` or returns null if the object is null or if the conversion fails.                   |
| `toDouble(dynamic object) => double`           | Converts any object to a `double`. Throws a `ParsingException` if the object is null or if the conversion fails.    |
| `tryToDouble(dynamic object) => double?`       | Converts any object to a `double` or returns null if the object is null or if the conversion fails.                 |
| `toBool(dynamic object) => bool`               | Converts any object to a `bool`. Returns `false` by default.                                                        |
| `tryToBool(dynamic object) => bool?`           | Converts any object to a `bool` or returns null if the conversion fails. Returns `false` by default.                |
| `toDateTime(dynamic object) => DateTime`       | Converts any object to a `DateTime`. Throws a `ParsingException` if the object is null or if the conversion fails.  |
| `tryToDateTime(dynamic object) => DateTime?`   | Converts any object to a `DateTime` or returns null if the object is null or if the conversion fails.               |
| `toMap<K, V>(dynamic object) => Map<K, V>`     | Converts any object to a `Map<K, V>`. Throws a `ParsingException` if the object is null or if the conversion fails. |
| `tryToMap<K, V>(dynamic object) => Map<K, V>?` | Converts any object to a `Map<K, V>` or returns null if the object is null or if the conversion fails.              |
| `toSet<T>(dynamic object) => Set<T>`           | Converts any object to a `Set<T>`. Throws a `ParsingException` if the object is null or if the conversion fails.    |
| `tryToSet<T>(dynamic object) => Set<T>?`       | Converts any object to a `Set<T>` or returns null if the object is null or if the conversion fails.                 |
| `toList<T>(dynamic object) => List<T>`         | Converts any object to a `List<T>`. Throws a `ParsingException` if the object is null or if the conversion fails.   |
| `tryToList<T>(dynamic object) => List<T>?`     | Converts any object to a `List<T>` or returns null if the object is null or if the conversion fails.                |

## Exceptions

The `ConvertObject` class throws a `ParsingException` if there is an error while converting an object. This exception provides information about the type of the object and the method used for conversion.

## Contributions

Contributions to this package are welcome. If you have any suggestions, issues, or feature requests, please create a pull request on the [repository](https://github.com/omar-hanafy/flutter_helper_utils).

## License

`flutter_helper_utils` is available under the [BSD 3-Clause License.](https://opensource.org/license/bsd-3-clause/)

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
