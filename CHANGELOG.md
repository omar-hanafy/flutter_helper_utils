### 1.4.7

- **NEW**: Added new function `toTitle` on String Extension which is similar to `toTitleCase` but ignores the '-'
  and '_' characters.
  This is useful when users name events, products, etc.
  and want these characters to be shown in the correct format.
  For example, `flutter-and-dart` becomes `Flutter-And-Dart` when using `toTitle`.

### 1.4.6

- **FIX**: Fixed a bug when using `listIndex` on ConvertObject functions that may cause the list return null.

### 1.4.5

- **UPDATE**: Enhanced the `asGreeks` getter to include all available Greek symbols for converting large numbers.
  Now, the symbols used are `['K', 'M', 'B', 'T', 'Q', 'P', 'E', 'Z', 'Y']`.
  This allows for more accurate representation of large numbers, such as converting 1000000000 to 1.0B.

### 1.4.4

- **NEW**: Added new extensions to the `String?` class: `isValidIp4`, `isValidIp6`, and `isValidUrl`. These extensions
  provide convenient methods to check the validity of IPv4 addresses, IPv6 addresses, and URLs respectively.

- **NEW**: Introduced a new method called `popRoot` to the `NavigatorExtension`. This method calls the normal `pop`
  method but with the `rootNavigator` parameter set to `true` under the hood. This feature proves to be useful
  in scenarios where dialogs need to be dismissed.

### 1.4.3

- **NEW**: The convert object methods now include an optional `listIndex` parameter, enabling the conversion of specific
  values within a `List`. This enhancement provides flexibility by allowing developers to extract and convert
  targeted values based on the specified `listIndex`.

  For example:

```dart

dynamic object1 = ['John', '30', 'yes'];
final double age = ConvertObject.toDouble(object1, listIndex: 1); // 30.0
```

- **NEW**: The `List` extension now includes the `fromIndex` method, providing null-safe retrieval of values at specific
  indices within a list. It returns null if the index is out of bounds or if the list is empty or null.

### 1.4.2

- **UPDATE**: Updated Documentation.

### 1.4.1

- **NEW**: The convert object methods now include an optional `mapKey` parameter, enabling the conversion of specific
  values within a Map object. This enhancement provides flexibility by allowing developers to extract and convert
  targeted values based on the specified `mapKey`.

  For example:

```dart

dynamic object1 = {'name': 'John', 'age': '30', 'isHuman': 'yes'};

final double age = ConvertObject.toDouble(object1, mapKey: 'age'); // 30.0
final bool isHuman = ConvertObject.toBool(object1, mapKey: 'isHuman'); // true
```

### 1.4.0

- **UPDATE**: Removing support of Iterables and Maps from `toType` and `tryToType` functions due to some restrictions in
  dart generics. Here is the list of the supported conversion types:
    - `bool`
    - `int`
    - `BigInt`
    - `double`
    - `num`
    - `String`
    - `DateTime`

- For Iterables and Maps, use the preferred methods from the `ConvertObject` class:
    - To convert to a `List`, use `ConvertObject.toList<String>(dynamicIterableData)`.
    - To convert to a `Set`, use `ConvertObject.toSet<String>(dynamicIterableData)`.
    - To convert to a `Map`, use `ConvertObject.toMap<String, int>(dynamicMapData)`.

### 1.3.8

- **BREAKING CHANGES**: The navigation extension methods have been renamed to avoid conflicts with other packages, such
  as `go_router`. Please update your codebase to use the new method names accordingly.
- Renamed navigation extension methods:
    - `context.push` changed to `context.pushPage`
    - `context.pushReplacement` changed to `context.pReplacement`
    - `context.pushAndRemoveUntil` changed to `context.pAndRemoveUntil`
    - `context.pushNamedAndRemoveUntil` changed to `context.pNamedAndRemoveUntil`
    - `context.pushNamed` changed to `context.pNamed`
    - `context.pushReplacementNamed` changed to `context.pReplacementNamed`
    - The `context.popPage` method remains unchanged since it has already been resolved in a previous [version](#105).

We apologize for any inconvenience caused by this breaking change. If you encounter any issues or need assistance,
please don't hesitate to reach out.

### 1.3.7

- **NEW**: Introducing `toType` and `tryToType` global functions. They allow converting a dynamic object to a specific
  type `T` and automatically detect the type, invoking the appropriate function from the `ConvertObject` class.

&nbsp;
*Sample*:

  ```dart

dynamic data = 12.4;
final myInt = toType<int>(data); // tryToType behaves similarly but is null-safe
  ```

- **NEW**: Added `BigInt` and `tryBigInt` in the ConvertObject class. `BigInt` represents arbitrarily large
  integers. It is used when you need to perform operations on integers that exceed the maximum value that can be
  represented by the int type. It's IMPORTANT to note that BigInt operations can be computationally expensive,
  especially for very large integers. Therefore, use BigInt only when necessary, and be mindful of performance
  implications.

&nbsp;
*Sample*:

  ```dart

String largeNum = '12434535367326235634';
final BigInt myBigInt = ConvertObject.toBigInt(largeNum);
// OR
final BigInt myBigInt = toType<BigInt>(largeNum);
  ```

- **UPDATE**:  The `toList<T>`, `tryToList<T>`, `toSet<T>` and `tryToSet<T>` functions now support converting any type
  of `Iterable`.

### 1.3.6

- **UPDATE**: The `toList<T>` and `tryToList<T>` functions now support converting map values to a list if the value's
  type matches `T`. This enhancement adds more flexibility and convenience when working with collections.

### 1.3.5

- **NEW**:
  Added `showMaterialBanner`, `showSnackBar`, `hideCurrentMaterialBanner`, `hideCurrentSnackBar`, `removeCurrentMaterialBanner`, `removeCurrentSnackBar`, `clearMaterialBanners`, `clearSnackBars`
  on `BuildContext`. Usage example could be as easy as `context.removeCurrentSnackBar`.

- **NEW**: Added `focusScope`, `hasFocus`, `unFocus`, and `requestFocus` call back on BuildContext. `requestFocus` is
  commonly used to
  hide keyboard on onTap/onPress call. Usage could be `onTap: () => context.requestFocus`
  or `onTap: context.requestFocusCall`.

- **NEW**: Added new enum called `HttpResStatus` that contains all http response codes with description to each one, and
  also some helper getters such as `isSuccessful`.
  &nbsp;
  *Usage with http package could be*:
  ```dart
  final res = await http.post(...); // assume it retrun res code 505
  print(res.statusCode.toHttpResStatus); // will print "Insufficient Storage"
  ```

- **UPDATE**: Used MediaQuery as InheritedModel to improve performance, see
  this [pull](https://github.com/flutter/flutter/pull/114459) in flutter for more info.

### 1.3.4

- **NEW**: Added `isValidHttpCode` in `num?` extension that returns true if the http response code is 200 or 201.
- **NEW**: Added `toDateWithFormat` in String extension that converts string to `DateTime` with specific format
  e.g, `d-M-y`.

&nbsp;
*Usage*:

  ```dart

final dateTime = '14-12-2030'.toDateWithFormat('d-M-y');
  ```

### 1.3.3

- **NEW**: Added `binary` in bool extension that returns `1` if true and `0` if false as `int`.

### 1.3.2

- **FIX**: Fixed a bug when detecting `isIOSWeb` and `isAndroidWeb` using `TargetPlatform`.
- **NEW**: Added `isApple` that detects if the running device is made by apple e.g. MacOS, iPadOS, or iOS.

&nbsp;
*Usage*:

  ```dart
context.isApple
// OR without context
defaultTargetPlatform.isApple // import 'package:flutter/foundation.dart';
  ```

### 1.3.1

- **NEW**: Added `toBool` to nullable `Object?`.

&nbsp;
*Rules*:

* Object is true only if
    1. Object is bool and true.
    2. Object is num and is greater than zero.
    3. Object is string and is equal to 'yes', 'true', or '1'.
* any other conditions including null will return false.

### 1.3.0

- **HOT FIX**: Fixed bool extension is not exported.

### 1.2.9

- **NEW**: Added `isTrue`, and `isFalse` on nullable boolean, now if bool? is null the check will always return false
  instead of showing compile error.

### 1.2.8

- **UPDATE**: replace `isNegativeOrNull`, `isPositiveOrNull`, `isNotNegativeOrNull`, `isNotPositiveOrNull`,
  and `isNotZeroOrNull` with just `isNegative`, `isPositive`, and `isZeroOrNull` in nullable numbers.

### 1.2.7

- **NEW**: Added an option to check the device type when running on web, e.g. `isMobileWeb` or `isDesktopWeb`.

### 1.2.6

- **NEW**: Added `local` getter in datetime that call toLocal() on any dat, but it respects null safety.

### 1.2.5

- **NEW**: Added `tryRemoveAt`, `indexOfOrNull`, `indexWhereOrNull`, and `tryRemoveWhere` on `List<T>?` extension.
- **UPDATE**: Update the package
  to [FlutterSDK 3.10](https://docs.flutter.dev/release/release-notes/release-notes-3.10.0).
- **FIX**: Fixed a bug with `isNotNull` on `Object` extension.

### 1.2.4

- **NEW**: Added `DatesHelper` class that provide a set of static methods for DateTime such
  as `isSameHour`, `diffInDays`, and `daysInRange`.
- **NEW**: Added the getters `isPresent`, `isPast`, `passedDuration`, `remainingDays`, and more to the `DateTime`
  extension.
    - Now you can get formatted date using the format method directly in any date e.g `DateTime.now().format('EEE')`

### 1.2.3

- **NEW**: Added `scaffoldMessenger` getter in the `BuildContext` extension to easily
  call `ScaffoldMessenger.of(context)`
- **UPDATE**: Improved implementation of the `toList` and `tryToList` in the `ConvertObject` class.

### 1.2.2

- **NEW**: Added `toUtcIso` (supports null safety) that convert any date `toUtc()` and `toIso8601String()` in the Date
  extensions.

### 1.2.1

- **NEW**: Added `isEmptyOrNull` and `isNotEmptyOrNull` to Map and Set extensions.

### 1.2.0

- **UPDATE**: Update documentation.

### 1.1.9

- **FIX**: Fixed a bug with `isZero` bool in numbers extensions.
- **UPDATE**: `asBool` support null safety on numbers extensions.
- **UPDATE**: Updated `ParsingException` implementation.

### 1.1.8

- **NEW**: Added `isPositiveOrNull`, `isZeroOrNull`, and `isNegativeOrNull` to all numbers extensions.
- **UPDATE**: on String extension, `isEmptyOrNull` now returns true if string has only empty lines.

### 1.1.7

- **NEW**:  Added `toDateTime` and `tryToDateTime` in `ConvertObject` class.

### 1.1.6

- **NEW**:  Added `toMap` and `tryToMap` in `ConvertObject` class, and add `isValidSVG` in String extension.

### 1.1.5

- **NEW**:  Added `toBool` and `tryToBool` in `ConvertObject` class.
- **UPDATE**:  Improved all implementations of static methods in `ConvertObject` class.

### 1.1.4

- **NEW**:  Supported converting timestamp milliseconds to `DateTime` and added `tryToString` in `ConvertObject` class.

### 1.1.3

- **FIX**: Added missing `pushNamedAndRemoveUntil` in the navigation extension.

### 1.1.2

- **UPDATE**: Improved `asBool` implementation in the string extension.

### 1.1.1

- **FIX**: Fixed a bug in `camelCase` conversion algorithm.

### 1.1.0

- **FIX**: Fixed logo does not appear in readme file.

### 1.0.9

- **UPDATE**: Re-organized changelog and updated readme file.

### 1.0.8

- **FIX**: Fixed bug with `isHexColor` in color extension.

### 1.0.7

- **NEW**: Added new color extension to support converting hex string to color and checking if string is a hex color.

### 1.0.6

- **UPDATE**: Supported null safety to ThemeMode and Brightness.

### 1.0.5

- **UPDATE**: Changed `pop` to `popPage` to solve conflicts with `go_router` package extensions.

### 1.0.4

- **UPDATE**: Updated readme file.

### 1.0.3

- **NEW**: Added `capitalizeFirstLetter`, `toPascalCase`, `toTitleCase`, and `toCamelCase` to String extension.

### 1.0.2

- **UPDATE**: Renamed some getters to fix conflicts with the `get` package.

### 1.0.1

- **UPDATE**: Updated readme file.

### 1.0.0

- **INITIAL**: Initial release.
