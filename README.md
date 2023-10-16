![](https://raw.githubusercontent.com/omar-hanafy/flutter_helper_utils/9bb44613da240f408d02a6e745f92e5f88050265/logo.svg)
# Flutter Helper Utils

Flutter Helper Utils is a comprehensive package aimed to augment Dart and Flutter's core functionalities. With a rich set of extensions and helper methods, this package boosts productivity and simplifies coding in Flutter projects.

# Getting Started

To get started, add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_helper_utils: 1.5.5
```

## Table of Contents

- [Extensions](#extensions)
- [Helper Methods](#helper-methods)
- [Getting Started](#getting-started)

# Extensions

Our package provides a variety of extensions on Dart and Flutter's built-in types. Below are the categories of available extensions, sorted by their functionalities:

## Core Data Types

### [String Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md)

* [`isNumeric`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md#isNumeric) - Checks if the string is numeric.
* [`isAlphabet`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md#isAlphabet) - Checks if the string consists only of alphabets.
* [`hasCapitalLetter`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md#hasCapitalLetter) - Checks if the string contains at least one capital letter.
* [`isBool`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md#isBool) - Checks if the string is a boolean value.
* [`removeWhiteSpaces`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md#removeWhiteSpaces) - Removes all white spaces from the string.
* [`textSize`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md#textSize) - Returns the size of the text using TextPainter.
* [`wrapString`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md#wrapString) - Adds a new line to the string after a specified number of words.
* [`equalsIgnoreCase`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md#equalsIgnoreCase) - Compares two strings for equality, ignoring case.
* [`removeSurrounding`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md#removeSurrounding) - Removes a specified delimiter from both ends of the string, if present.
* [`replaceAfter`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md#replaceAfter) - Replaces part of the string after the first occurrence of a given delimiter.
* [View All String Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/string_extension.md)

### [Number Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md)

* [`isSuccessHttpResCode`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md#isSuccessHttpResCode) - Checks if the numeric HTTP status code represents a successful response.
* [`toHttpResStatus`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md#toHttpResStatus) - Converts the numeric HTTP status code to its corresponding HttpResStatus enum.
* [`tryToInt`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md#tryToInt) - Safely converts a nullable number to an integer.
* [`tryToDouble`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md#tryToDouble) - Safely converts a nullable number to a double.
* [`percentage`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md#percentage) - Calculates the percentage this number represents out of a total.
* [`isNegative & isPositive`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md#isNegative--isPositive) - Checks if the number is negative or positive.
* [`isZeroOrNull`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md#isZeroOrNull) - Checks if the number is zero or null.
* [`asBool`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md#asBool) - Evaluates the truthiness of a nullable number based on whether it's greater than 0.
* [`isZero`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md#isZero) - Checks if the number is zero.
* [`numberOfDigits`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md#numberOfDigits) - Returns the number of digits in the number.
* [View All Number Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/number_extension.md)

### [Boolean Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/bool_extension.md)

* [`isTrue`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/bool_extension.md#istrue) - Checks if the Boolean value is true, considering null safety.
* [`isFalse`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/bool_extension.md#isfalse) - Checks if the Boolean value is false or null.
* [`val`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/bool_extension.md#val) - Returns the Boolean value or false if it is null.
* [`binary`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/bool_extension.md#binary) - Returns 1 if the Boolean is true and 0 if it is false or null.
* [`binaryText`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/bool_extension.md#binarytext) - Returns '1' if the Boolean is true and '0' if it is false or null.

### [DateTime Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/date_time_extension.md)

* [`format & tryFormat`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/date_time_extension.md#format-and-tryFormat) - format a DateTime object as a string using a specified format (e.g. "yyyy-MM-dd"), while tryFormat attempts to do the same but returns null if unsuccessful.
* [`tryToDateTime`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/date_time_extension.md#format) - Safely attempts to convert a string to a DateTime object. Returns null if the conversion fails.
* [`toDateTime`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/date_time_extension.md#toDateTime) - Converts a string to a DateTime object. Throw an exception if the conversion fails.
* [`dateFormat`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/date_time_extension.md#dateFormat) - Returns a DateFormat object based on the string format provided.
* [`toDateWithFormat`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/date_time_extension.md#toDateWithFormat) - Converts a string to a DateTime object using a specific format.
* [`tryToDateWithFormat`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/date_time_extension.md#tryToDateWithFormat) - Safely attempts to convert a string to a DateTime object using a specific format. Returns null if the conversion fails.
* [`timestampToDate`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/date_time_extension.md#timestampToDate) - Converts a timestamp string to a DateTime object.
* [`toSmallMonthName & toFullMonthName`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/date_time_extension.md#toSmallMonthName-and-toFullMonthName) - Convert an integer representing a month to its abbreviated name.
* [`toSmallDayName & toFullDayName`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/date_time_extension.md#toSmallDayName-and-toFullDayName) - Convert an integer representing a day of the week to its abbreviated name.
* [View All DateTime Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/date_time_extension.md)

### [Duration Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/duration_extension.md)

* [`delayed`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/duration_extension.md#delayed) - Utility to delay some code execution.
* [`fromNow`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/duration_extension.md#fromNow) - Adds the Duration to the current DateTime and gives a future time.
* [`ago`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/duration_extension.md#ago) - Subtracts the Duration from the current DateTime and gives a pastime.

## UI & Design

### [Color Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/color_extension.md)

* [`toHex`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/color_extension.md#toHex) - Converts a `Color` object to its hex string representation.
* [`toColor`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/color_extension.md#toColor) - Converts a hex color string to a `Color` object.
* [`isHexColor`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/color_extension.md#isHexColor) - Checks if the given string is a valid hexadecimal color string.

## Flutter Extensions

### [ThemeExtensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/theme_extension.md)

* [`themeData`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/theme_extension.md#themeData) - Quickly get the current `ThemeData` from the nearest `Theme` widget ancestor.
* [`txtTheme`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/theme_extension.md#txtTheme) - Effortlessly obtain the `TextTheme` for your context.
* [`brightness`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/theme_extension.md#brightness) - Determine the brightness setting of the app theme.
* [`sysBrightness`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/theme_extension.md#sysBrightness) - Determine the brightness setting of the system.
* [`isDark & isLight`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/theme_extension.md#isDark-and-isLight) - Convenient boolean to quickly check if the current theme is light or dark.

### [MediaQueryExtensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/media_query_extension.md)

* [`mq`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/media_query_extension.md#mq) - Quick Access to MediaQueryData
* [`nullableMQ`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/media_query_extension.md#nullableMQ) - Nullable MediaQueryData Access
* [`deviceOrientation`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/media_query_extension.md#deviceOrientation) - Device Orientation
* [`navigationMode`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/media_query_extension.md#navigationMode) - Navigation Mode
* [`padding and viewInsets`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/media_query_extension.md#padding-and-viewInsets) - Screen Padding and Insets
* [`screenDimensions`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/media_query_extension.md#screenDimensions) - Screen Dimensions
* [`additionalFeatures`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/media_query_extension.md#additionalFeatures) - Additional Features
* [View All Media Query Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/media_query_extension.md)

### [FocusScopeExtensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/flutter_ui_extension.md)

* [`focusScope`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/focus_scope_extension.md#getting-the-nearest-focusscopenode) - Getting the Nearest FocusScopeNode.
* [`unFocus`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/focus_scope_extension.md#removing-focus) - Removing Focus.
* [`requestFocus`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/focus_scope_extension.md#requesting-focus) - Requesting Focus.
* [`requestFocusCall`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/focus_scope_extension.md#requesting-focus) - Requesting Focus (Using GestureTapCallback).
* [`hasFocus`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/focus_scope_extension.md#checking-if-a-node-has-focus) - Checking if a Node Has Focus.
* [`hasPrimaryFocus`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/focus_scope_extension.md#checking-if-a-node-has-primary-focus) - Checking if a Node Has Primary Focus.

### [Navigator Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md)

* [`popPage`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#popPage) - Pop Page
* [`popRoot`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#popRoot) - Pop Root
* [`navigator`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#navigator) - Navigator State
* [`canPop`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#canPop) - Can Pop
* [`pushPage`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#pushPage) - Push Page
* [`pushReplacement`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#pushReplacement) - Push Replacement
* [`pushAndRemoveUntil`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#pushAndRemoveUntil) - Push And Remove Until
* [`pushNamedAndRemoveUntil`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#pushNamedAndRemoveUntil) - Push Named And Remove Until
* [`pushNamed`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#pushNamed) - Push Named
* [`pushReplacementNamed`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#pushReplacementNamed) - Push Replacement Named
* [`popUntil`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#popUntil) - Pop Until
* [`dismissActivePopup`](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md#dismissActivePopup) - Dismiss Active Popup
* [View All Navigator Extensions](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/navigator_extension.md)

# Helper Methods

### [ConvertObject](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/convert_object.md):

The `ConvertObject` class aims to simplify this process, making it more reliable and efficient. For example

let's say we have `Map<String, dynamic>` from API response, and want to get the `map['colors']` as `List<String>`

the value will actually be dynamic and casting this value into a list will result in List<dynamic> which makes it more complex, that's what the ConvertObject methods solve.

```dart
final strList = ConvertObject.toList<String>(map['colors']);
// or using the global method.
final strList = toList<String>(map['colors']);
```

[More Details here](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/docs/convert_object.md)


## Exceptions

The `ConvertObject` class throws a `ParsingException` if there is an error while converting an object. This exception provides information about the type of the object and the method used for conversion.

## Contributions

Contributions to this package are welcome. If you have any suggestions, issues, or feature requests, please create a pull request on the [repository](https://github.com/omar-hanafy/flutter_helper_utils).

## License

`flutter_helper_utils` is available under the [BSD 3-Clause License.](https://opensource.org/license/bsd-3-clause/)

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
