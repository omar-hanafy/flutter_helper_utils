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
  flutter_helper_utils: ^1.1.6
```

Then, run `flutter packages get` in your terminal.

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

## Contributions

Contributions to this package are welcome. If you have any suggestions, issues, or feature requests, please create a pull request on the [repository](https://github.com/omar-hanafy/flutter_helper_utils).

## License

`flutter_helper_utils` is available under the [BSD 3-Clause License.](https://opensource.org/license/bsd-3-clause/)

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
