<table style="border:none;">
  <tr style="border:none;">
    <td style="vertical-align:top; border:none;">
      <h1 style="border:none;" "min-width:400px;">Flutter Helper Utils</h1>
      <p style="min-width:400px;">Make Flutter development easier with Flutter Helper Utils! This toolkit is packed with helper methods and extensions that boost your productivity and help you write less code and build apps faster.</p>
    </td>
    <td style="vertical-align:top; border:none;">
      <a href="https://flutter-helper-utils.web.app/" target="blank">
        <img src="https://raw.githubusercontent.com/omar-hanafy/flutter_helper_utils/main/dash-tools.png" alt="Flutter Helper Utils Logo" style="max-width:400;"/>
      </a>
    </td>
  </tr>
</table>

## Table of Contents

- [Getting Started](https://flutter-helper-utils.web.app/documentation/getting-started.html)
- [Featured](#featured)
- [Extensions](#extensions)

# Featured

## [Converting Objects](https://flutter-helper-utils.web.app/documentation/convert-object.html):

Convert objects to various types, such as `int`, `double`, `bool`, `String`, `List`, `Set` and `Map`, They are handy
when working with data from APIs, where you often encounter dynamic types. They offer simple and flexible methods to
perform accurate type conversions. Here is a sample:

### **Before**:

Map = {score: "12.4"};

```dart

int score = double.parse(map['key']).toInt();
```

Notice that we need to parse to double first then to int.

### **With Package**:

```dart

int score = toInt(map['key']);
```

[More Details here](https://flutter-helper-utils.web.app/documentation/convert-object.html)

## ValueNotifier Supercharged

**ValueNotifier** is a simple class in **Flutter** that allows you to store a value and notify any listeners when the value changes.

in this package, I've made this feature event better!

Starting from version 4.0.0, you can use a new set of extensions, helper methods, and specialized notifiers for better data handling:

- Instantly create notifiers from any value with the intuitive `.notifier` extension (e.g.,`10.notifier`)
- Specific data types using our type-safe notifiers like `ListNotifer`,  `BoolNotifier`, `IntNotifier`, etc.
- use the `.listenableBuilder`extension on `ValueNotifier` instance which creates a `ValueListenableBuilder` under the hood with shorter/simpler syntax.

**Example:**

```dart
final counter = 0.notifier;
counter.listenableBuilder((count) => Text('$count'));

counter.increment(); // Increment the counter easily
```

For more info about ValueNotifier check the [official flutter documentation](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html)

# Extensions

Our package provides a variety of extensions on Dart and Flutter's built-in types. Below are the categories of available
extensions, sorted by their functionalities:

## Core Data Types

### [String Extensions](https://flutter-helper-utils.web.app/documentation/string-extension.html)

* [`isNumeric`](https://flutter-helper-utils.web.app/documentation/string-extension.html#isnumeric) - Checks if the
  string is numeric.
* [`isAlphabet`](https://flutter-helper-utils.web.app/documentation/string-extension.html#isalphabet) - Checks if the
  string consists only of alphabets.
* [`hasCapitalLetter`](https://flutter-helper-utils.web.app/documentation/string-extension.html#hascapitalletter) -
  Checks if the string contains at least one capital letter.
* [`isBool`](https://flutter-helper-utils.web.app/documentation/string-extension.html#isbool) - Checks if the string is
  a boolean value.
* [`removeWhiteSpaces`](https://flutter-helper-utils.web.app/documentation/string-extension.html#removewhitespaces) -
  Removes all space from the string.
* [`textSize`](https://flutter-helper-utils.web.app/documentation/string-extension.html#textsize) - Returns the size of
  the text using TextPainter.
* [`wrapString`](https://flutter-helper-utils.web.app/documentation/string-extension.html#wrapstring) - Adds a new line
  to the string after a specified number of words.
* [`equalsIgnoreCase`](https://flutter-helper-utils.web.app/documentation/string-extension.html#equalsignorecase) -
  Compares two strings for equality, ignoring case.
* [`removeSurrounding`](https://flutter-helper-utils.web.app/documentation/string-extension.html#removesurrounding) -
  Removes a specified delimiter from both ends of the string, if present.
* [`replaceAfter`](https://flutter-helper-utils.web.app/documentation/string-extension.html#replaceafter) - Replaces
  part of the string after the first occurrence of a given delimiter.
* [View All String Extensions](https://flutter-helper-utils.web.app/documentation/string-extension.html)

### [Number Extensions](https://flutter-helper-utils.web.app/documentation/number-extension.html)

* [`isSuccessHttpResCode`](https://flutter-helper-utils.web.app/documentation/number-extension.html#issuccesshttprescode) -
  Checks if the numeric HTTP status code represents a successful response.
* [`toHttpResStatus`](https://flutter-helper-utils.web.app/documentation/number-extension.html#tohttpresstatus) -
  Converts the numeric HTTP status code to its corresponding HttpResStatus enum.
* [`tryToInt`](https://flutter-helper-utils.web.app/documentation/number-extension.html#trytoint) - Safely converts a
  nullable number to an integer.
* [`tryToDouble`](https://flutter-helper-utils.web.app/documentation/number-extension.html#trytodouble) - Safely
  converts a nullable number to a double.
* [`percentage`](https://flutter-helper-utils.web.app/documentation/number-extension.html#percentage) - Calculates the
  percentage this number represents out of a total.
* [`isNegative & isPositive`](https://flutter-helper-utils.web.app/documentation/number-extension.html#isnegative--ispositive) -
  Checks if the number is negative or positive.
* [`isZeroOrNull`](https://flutter-helper-utils.web.app/documentation/number-extension.html#iszeroornull) - Checks if
  the number is zero or null.
* [`asBool`](https://flutter-helper-utils.web.app/documentation/number-extension.html#asbool) - Evaluates the truthiness
  of a nullable number based on whether it's greater than 0.
* [`isZero`](https://flutter-helper-utils.web.app/documentation/number-extension.html#iszero) - Checks if the number is
  zero.
* [`numberOfDigits`](https://flutter-helper-utils.web.app/documentation/number-extension.html#numberofdigits) - Returns
  the number of digits in the number.
* [View All Number Extensions](https://flutter-helper-utils.web.app/documentation/number-extension.html)

### [Boolean Extensions](https://flutter-helper-utils.web.app/documentation/bool-extension.html)

* [`isTrue` & `isFalse`](https://flutter-helper-utils.web.app/documentation/bool-extension.html#istrue-isfalse-null-safety) -
  Checks if the Boolean values considering null safety.
* [`val`](https://flutter-helper-utils.web.app/documentation/bool-extension.html#val) - Returns the Boolean value or
  false if it is null.
* [`binary`](https://flutter-helper-utils.web.app/documentation/bool-extension.html#binary) - Returns 1 if the Boolean
  is true and zero if it is false or null.
* [`binaryText`](https://flutter-helper-utils.web.app/documentation/bool-extension.html#binarytext) - Returns '1' if the
  Boolean is true and '0' if it is false or null.

### [DateTime Extensions](https://flutter-helper-utils.web.app/documentation/date-time-extension.html)

* [`format & tryFormat`](https://flutter-helper-utils.web.app/documentation/date-time-extension.html#format-and-tryformat) -
  format a DateTime object as a string using a specified format (e.g. "yyyy-MM-dd"), while tryFormat attempts to do the
  same but returns null if unsuccessful.
* [`tryToDateTime`](https://flutter-helper-utils.web.app/documentation/date-time-extension.html#format) - Safely
  attempts to convert a string to a DateTime object. Returns null if the conversion fails.
* [`toDateTime`](https://flutter-helper-utils.web.app/documentation/date-time-extension.html#todatetime) - Converts a
  string to a DateTime object. Throw an exception if the conversion fails.
* [`dateFormat`](https://flutter-helper-utils.web.app/documentation/date-time-extension.html#dateformat) - Returns a
  DateFormat object based on the string format provided.
* [`toDateWithFormat`](https://flutter-helper-utils.web.app/documentation/date-time-extension.html#todatewithformat) -
  Converts a string to a DateTime object using a specific format.
* [`tryToDateWithFormat`](https://flutter-helper-utils.web.app/documentation/date-time-extension.html#trytodatewithformat) -
  Safely attempts to convert a string to a DateTime object using a specific format. Returns null if the conversion
  fails.
* [`timestampToDate`](https://flutter-helper-utils.web.app/documentation/date-time-extension.html#timestamptodate) -
  Converts a timestamp string to a DateTime object.
* [`toSmallMonthName & toFullMonthName`](https://flutter-helper-utils.web.app/documentation/date-time-extension.html#tosmallmonthname-and-tofullmonthname) -
  Convert an integer representing a month to its abbreviated name.
* [`toSmallDayName & toFullDayName`](https://flutter-helper-utils.web.app/documentation/date-time-extension.html#tosmalldayname-and-tofulldayname) -
  Convert an integer representing a day of the week to its abbreviated name.
* [View All DateTime Extensions](https://flutter-helper-utils.web.app/documentation/date-time-extension.html)

### [Duration Extensions](https://flutter-helper-utils.web.app/documentation/duration-extension.html)

* [`delayed`](https://flutter-helper-utils.web.app/documentation/duration-extension.html#delayed) - Utility to delay
  some code execution.
* [`fromNow`](https://flutter-helper-utils.web.app/documentation/duration-extension.html#fromnow) - Adds the Duration to
  the current DateTime and gives a future time.
* [`ago`](https://flutter-helper-utils.web.app/documentation/duration-extension.html#ago) - Subtracts the Duration from
  the current DateTime and gives a pastime.

## UI & Design

### [Color Extensions](https://flutter-helper-utils.web.app/documentation/color-extension.html)

* [`toHex`](https://flutter-helper-utils.web.app/documentation/color-extension.html#tohex) - Converts a `Color` object
  to its hex string representation.
* [`toColor`](https://flutter-helper-utils.web.app/documentation/color-extension.html#tocolor) - Converts a hex color
  string to a `Color` object.
* [`isHexColor`](https://flutter-helper-utils.web.app/documentation/color-extension.html#ishexcolor) - Checks if the
  given string is a valid hexadecimal color string.

## Flutter Extensions

### [ThemeExtensions](https://flutter-helper-utils.web.app/documentation/theme-extension.html)

* [`themeData`](https://flutter-helper-utils.web.app/documentation/theme-extension.html#themedata) - Quickly get the
  current `ThemeData` from the nearest `Theme` widget ancestor.
* [`txtTheme`](https://flutter-helper-utils.web.app/documentation/theme-extension.html#txttheme) - Effortlessly obtain
  the `TextTheme` for your context.
* [`brightness`](https://flutter-helper-utils.web.app/documentation/theme-extension.html#brightness) - Determine the
  brightness setting of the app theme.
* [`sysBrightness`](https://flutter-helper-utils.web.app/documentation/theme-extension.html#sysbrightness) - Determine
  the brightness setting of the system.
* [`isDark & isLight`](https://flutter-helper-utils.web.app/documentation/theme-extension.html#isdark-and-islight) -
  Convenient boolean to quickly check if the current theme is light or dark.

### [MediaQueryExtensions](https://flutter-helper-utils.web.app/documentation/media-query-extension.html)

* [`mq`](https://flutter-helper-utils.web.app/documentation/media-query-extension.html#mq) - Quick Access to
  MediaQueryData
* [`nullableMQ`](https://flutter-helper-utils.web.app/documentation/media-query-extension.html#nullablemq) - Nullable
  MediaQueryData Access
* [`deviceOrientation`](https://flutter-helper-utils.web.app/documentation/media-query-extension.html#deviceorientation) -
  Device Orientation
* [`navigationMode`](https://flutter-helper-utils.web.app/documentation/media-query-extension.html#navigationmode) -
  Navigation Mode
* [`padding and viewInsets`](https://flutter-helper-utils.web.app/documentation/media-query-extension.html#padding-and-viewinsets) -
  Screen Padding and Insets
* [`screenDimensions`](https://flutter-helper-utils.web.app/documentation/media-query-extension.html#screendimensions) -
  Screen Dimensions
* [`additionalFeatures`](https://flutter-helper-utils.web.app/documentation/media-query-extension.html#additionalfeatures) -
  Additional Features
* [View All Media Query Extensions](https://flutter-helper-utils.web.app/documentation/media-query-extension.html)

### [FocusScopeExtensions](https://flutter-helper-utils.web.app/documentation/flutter-ui-extension.html)

* [`focusScope`](https://flutter-helper-utils.web.app/documentation/focus-scope-extension.html#getting-the-nearest-focusscopenode) -
  Getting the Nearest FocusScopeNode.
* [`unFocus`](https://flutter-helper-utils.web.app/documentation/focus-scope-extension.html#removing-focus) - Removing
  Focus.
* [`requestFocus`](https://flutter-helper-utils.web.app/documentation/focus-scope-extension.html#requesting-focus) -
  Requesting Focus.
* [`requestFocusCall`](https://flutter-helper-utils.web.app/documentation/focus-scope-extension.html#requesting-focus) -
  Requesting Focus (Using GestureTapCallback).
* [`hasFocus`](https://flutter-helper-utils.web.app/documentation/focus-scope-extension.html#checking-if-a-node-has-focus) -
  Checking if a Node Has Focus.
* [`hasPrimaryFocus`](https://flutter-helper-utils.web.app/documentation/focus-scope-extension.html#checking-if-a-node-has-primary-focus) -
  Checking if a Node Has Primary Focus.

### [Navigator Extensions](https://flutter-helper-utils.web.app/documentation/navigator-extension.html)

* [`popPage`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#poppage) - Pop Page
* [`popRoot`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#poproot) - Pop Root
* [`navigator`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#navigator) - Navigator State
* [`canPop`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#canpop) - Can Pop
* [`pPage`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#pushpage) - Push Page
* [`pReplacement`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#pushreplacement) - Push
  Replacement
* [`pAndRemoveUntil`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#pushandremoveuntil) -
  Push And Remove Until
* [`pNamedAndRemoveUntil`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#pushnamedandremoveuntil) -
  Push Named And Remove Until
* [`pNamed`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#pushnamed) - Push Named
* [`pReplacementNamed`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#pushreplacementnamed) -
  Push Replacement Named
* [`popUntil`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#popuntil) - Pop Until
* [`dismissActivePopup`](https://flutter-helper-utils.web.app/documentation/navigator-extension.html#dismissactivepopup) -
  Dismiss Active Popup
* [View All Navigator Extensions](https://flutter-helper-utils.web.app/documentation/navigator-extension.html)

## Exceptions

The `ConvertObject` class throws a `ParsingException` if there is an error while converting an object. This exception
provides information about the type of the object and the method used for conversion.

## Contributions

Contributions to this package are welcome. If you have any suggestions, issues, or feature requests, please create a
pull request in the [repository](https://github.com/omar-hanafy/flutter_helper_utils).

## License

`flutter_helper_utils` is available under the [BSD 3-Clause License.](https://opensource.org/license/bsd-3-clause/)

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

