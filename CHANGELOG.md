## 6.1.0
- Introduced `isFuchsia` and `isFuchsiaWeb` properties to `BuildContext` and `TargetPlatform` extensions, simplifying detection of the Fuchsia operating system in both native and web environments.
- Added `DoublyLinkedListNotifier` which creates `ValueNotifier<DoublyLinkedList>` (leveraging the `DoublyLinkedList` from [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils/changelog#2) package as of [v2.2.1+](https://pub.dev/packages/dart_helper_utils/changelog#221))
- Easily create custom `ValueNotifier` (e.g. `ListNotifier`) from any `Iterable<E>` using the `listNotifier`, `setNotifier`, and `doublyLinkedListNotifier` constructors.
- `Box` Widget: Introduced the `Box` widget for creating square `SizedBox` elements with a single `dimension` parameter, reducing boilerplate.
- `EdgeInsets` Conversion: convert numbers to `EdgeInsets` using the new extension, e.g., `Padding(padding: 8.paddingAll)`.
- `themeData.withoutEffects()`: method to customize which visual feedback effects (splash, highlight, hover, etc.) to remove from a theme.
- `ThemeWithoutEffects` Widget: Wrap widgets with this widget to selectively disable visual effects for specific parts of your app.

- **PlatformEnv:**
    - Introduced the `PlatformEnv` class to replace direct usage of `dart:io`'s `Platform` for improved web compatibility and error prevention.
    - The `PlatformEnv` class is a critical update for web compatibility. Consider updating your code to use `PlatformEnv` instead of `Platform` for a smoother transition to web support.

- **Enhanced Color Extension:**
    - **Expanded `toHex`:**  The `toHex` method now accepts an optional `includeAlpha` parameter to control whether the alpha channel is included in the hexadecimal representation.
    - Introduced new methods:
        - `darken`, `lighten`: Adjust color lightness.
        - `shade`, `tint`: Create variations by mixing with black/white.
        - `contrast`: Calculate contrast ratios between colors.
        - `complementary`: Find the opposite color on the color wheel.
        - `blend`: Mix colors together.
        - `grayscale`, `invert`: Convert to grayscale or invert colors.

## 6.0.3
- Updated some documentations.

## 6.0.2
### Breaking Changes
- **Renamed Method:** The `listenableBuilder` method has been renamed to `builder` in the `extension on ValueListenable`.
- **Refactored Notifier Classes**: Methods previously available as extensions on ValueNotifier<T> have been moved directly into the corresponding notifier classes (e.g., toggle for BoolNotifier, increment for IntNotifier).

### New Features
- Introduced `ListenablesBuilder`: A widget for building UI in response to changes in multiple listenable objects (`List<Listenable>`). it also has  `buildWhen` and `threshold` properties for more granular control over rebuild behavior.
- **Listenable Extensions:** Added `builder` methods to easily create `ListenableBuilder` (for single listeners) and `ListenablesBuilder`(for multiple listeners) widgets.

### Fixes & Enhancements
- Updated `dart_helper_util` to [v2.1.0](https://pub.dev/packages/dart_helper_utils/changelog#120).
- Fixed custom notifier classes sometimes produce Stackoverflow bug when notify listeners.

### Migration Guide
1. **Updating ValueNotifier Extensions**:
    - Replace all instances of `listenableBuilder` with the new `builder` method to ensure compatibility.
        - **Before**:
          ```dart
          final myNotifier = ValueNotifier<int>(0);
          myNotifier.listenableBuilder(
            (value) => Text('Value is $value'),
          );
          ```
        - **After**:
          ```dart
          final myNotifier = ValueNotifier<int>(0);
          myNotifier.builder(
            (value) => Text('Value is $value'),
          );
          ``` 

## 5.0.0
### Changed

- Upgraded `dart_helper_utils` to [v2.0.0](https://pub.dev/packages/dart_helper_utils/changelog#200), **introducing
  breaking changes**.
- Enhanced and moved all `isEqual` methods (Map, Set, List, global) to [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils).

### BREAKING CHANGES

- The `dart_helper_utils` v2.0.0 upgrade introduces breaking changes. Review
  the [changelog](https://pub.dev/packages/dart_helper_utils/changelog#200) for detailed information and update your
  code accordingly.

## 4.4.0

- Added `copy` methods to all TextStyle properties in ThemeData (e.g., `displayLargeCopy`, `headlineMediumCopy`, etc.).
  This allows to quickly use copyWith on text style with minimal code for example:
  Use  `theme.displayLargeCopy(color: Colors.red)` instead of `theme.displayLarge?.copyWith(color: Colors.red)`
- Added `refresh` method to all specialized notifiers to allow force `notifyListeners` without changing value
  of `ValueNotifier`.

- Updated `dart_helper_util` to [v1.2.0](https://pub.dev/packages/dart_helper_utils/changelog#120).

## 4.3.0

- Added `setDart`, `setLight`, and `setSystem` to `BrightnessNotifier`, and `ThemeModeNotifier`.
- Added `modalRoute()` to the context extension for convenient access to the current ModalRoute.
- Added the `usePopUntil` parameter to the `context.dismissActivePopup` (default: `true`):
    - If `true`, uses `popUntil` for efficient dismissal of multiple pop-ups.
    - If `false`, uses `recursion` (might be needed for compatibility reasons).
    - This provides flexibility for different navigation scenarios and compatibility needs.

- Updated `dart_helper_util` to [v1.1.0](https://pub.dev/packages/dart_helper_utils/changelog#110).

## 4.2.0

- Enhancement to the `context.dismissActivePopup()`.

## 4.1.1

- Updated the README

## 4.1.0

### Introducing [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils)

We've refactored the Dart-specific utilities into a new
package, [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils), to allow Dart projects to use these
utilities without depending on Flutter.

- No changes are needed from your side as `flutter_helper_utils` now
  exports [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils) internally.

### New Features:

- **BrightnessNotifier** and **ThemeModeNotifier** for easy creation of `ValueNotifier` instances.
- New extensions on `ThemeData` for quick access to common text styles (`theme.bodySmall`) and brightness
  checks (`isDark`, `isLight`).

**NOTES:**

- All the Dart-specific utilities documentations moved to
  the [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils) readme.
- Future updates for Dart-specific utilities will be available in
  the [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils) changelog.
- Do NOT use the older versions (under 4.1.0) of this package
  with [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils) as it may conflict with it.

## 4.0.1

- Fixed mime checks not exported.

## 4.0.0

### New Features

- **JSON Handling**
    - **Encoding:** Easily encode any object to JSON using the new `.encode()`  method on any object.
    - **Decoding:** Decode JSON effortlessly with the `.decode()` method on String, e.g. `"[1,3,4]".decode();`.
- **ValueNotifier Helpers**
    - A comprehensive suite of tools for working with `ValueNotifier`
        - **Specialized Notifiers:** Type-safe notifiers like `BoolNotifier`, `IntNotifier`, and more.
        - **`.notifier` Extension:** Quickly create notifiers from various types.
        - **Enhanced Functionality:** Added extension methods like `toggle`, `round`, and `increment` to `ValueNotifier`
          subclasses.
        - **Reactive Integration:** Easily convert `ValueNotifier` into a `Stream` with the `stream` extension.
        - **Concise UI Building:** The `.listenableBuilder` extension offers a **shorter and more readable syntax**
          compared to the traditional `ValueListenableBuilder`.

### Enhancements

- **Map Extension Improvements:**

    - **BREAKING CHANGE:** Removed global functions `formattedJsonString` and `makeMapEncodable`. Introduced more
      intuitively named methods within a Map extension: `makeEncodable`, `safelyEncodedJson`, and `encodedJson`
      for `Map<K, V>` types.

      **Migration Guide:**

      ```dart
      final myMap = { ... };
      // BEFORE:
      makeMapEncodable(myMap);
      formattedJsonString(myMap);
      
      // NOW:
      myMap.makeEncodable;
      myMap.safelyEncodedJson;
      ```

- **MIME Type Checks on String:**

    - **BREAKING CHANGE:** Replaced `isValidVideo`, `isValidHTML`, `isValidAudio`, `isValidImage`, and `isValidSVG` with
      more streamlined methods: `isVideo`, `isHTML`, `isAudio`, `isImage`, and `isSVG`.
    - Added a new `mimeType()` function that returns the MIME type for any given file path or URL,
      e.g., `'path.mp4'.mimeType()` returns `'video/mp4'`.
    - Introduced new getters for various file types, enhancing the way file types are detected based on file paths or
      URLs.
        - These include checks for:
            - **Videos:** `isVideo`, `isMP4`, `isMOV`, etc.
            - **Images:** `isImage`, `isPNG`, `isJPEG`, etc.
            - **Documents:** `isPDF`, `isDOCX`, `isTXT`, etc.
            - **Audio:** `isAudio`, `isMP3`, `isWAV`, etc.
            - **Archives:** `isArchive`, `isZIP`, `isRAR`, etc.
            - And more, allowing for straightforward usage like `'file.mp4'.isMP4` returning `true`.

### Breaking Changes Summary

- Removed `formattedJsonString` and `makeMapEncodable` in favor of new methods within the Map extension.
- Replaced various `isValid` MIME type checks with simpler and more intuitive `is` methods,
  e.g. `isValidVideo -> isVideo`

## 3.1.0

- **UPDATE**: Updated `asBool` in the objects.

## 3.0.7

- **NEW**: Added `getRandom` that can be used with any number to get random number from
  it. `final random = 1000.getRandom;`

## 3.0.6

- IMPORTANT fix to for the convert objects helper and static methods which makes the app freeze, if you are at '3.0.4'
  or '3.0.5', I encourage you to upgrade.

## 3.0.5

- Added isEqual to the `Set`, `List`, `Map`, and as global method.

## 3.0.4

- The `asGreeks` is no longer a getter, it's a function now that takes optional `fractionDigits` which lets you specify
  number of digits after the decimal point in the generated greek number. (`asGreeks` used to Convert a number to a
  format that includes Greek symbols for thousands, millions, and beyond. e.g. '1000' asGreek is '1k')

## 3.0.3

**NEW**:

- Introduced `formattedJsonString` global function for converting maps to a formatted/indented JSON strings,
  ensuring compatibility with complex types and ready to be used in logs output files.

- Added new `local` optional argument to the `toDateTime` and `tryToDateTime` in both the static and global functions.

## 3.0.2

- **UPDATE**: Update docs for README, all ConvertObject's static methods, and add docs to all global functions.

## 3.0.0

- **BREAKING CHANGE**:
    - The [`Watcher`](https://pub.dev/packages/flutter_watcher) state management functionality has been moved into a
      separate [package](https://pub.dev/packages/flutter_watcher).
      This change aligns with our goal of maintaining the simplicity and original intent of this package.
      Please update your imports and dependencies accordingly if you rely
      on [`Watcher`](https://pub.dev/packages/flutter_watcher) for state management.

- **NEW FEATURE**:
    - Added new `toUri` and `tryToUri` in both the `ConvertObject` class and the global functions.
    - Introducing a new getter `domainName` in the `Uri` extension.
- **ENHANCEMENTS**: The `indexOfOrNull` method under Iterable Extensions now supports taking null values.

## 2.0.1

- **NEW**: Introducing Watcher state management, It's designed to be efficient, lightweight, and leverages native
  Flutter state management mechanisms.
  [more here](https://flutter-helper-utils.web.app/documentation/watcher-state-management.html)

## 1.6.0

- **BREAKING CHANGE**: Upgraded to Flutter 3.16 and resolved a deprecation on the BuildContext extension for MediaQuery
  by changing `context.textScaleFactor` to `context.textScaler`.

- **NEW**: added New getters to the BuildContext extension for MediaQuery to support all properties on MediaQuery even
  the nullable.

## 1.5.8

- **NEW**: Added `makeMapEncodable` to our global helper methods. This function provides a convenient way to ensure all
  elements within a map are encodable to JSON format.

- **UPDATE**: Updated the `isValidUrl` function's regular expression to handle URLs with special characters like `[]`
  and `()`. This update addresses the issue of catastrophic backtracking, Which might cause freezing or performance
  issues.

## 1.5.7

- added `maybePop` to the Navigation extension to respect `onWillPop` widget action.
- Hosted new documentation [website](https://flutter-helper-utils.web.app/)

## 1.5.6

- Added New Uri extension to help convert string (supports nullable strings) link to uri, `toUri` and `toPhoneUri`.

## 1.5.4

- Added a new `format` argument to the `toDateTime` and `tryDateTime` methods, allowing you to specify the converted
  date format.
- Updated and enhanced the entire documentation.

## 1.5.3

- Added global conversion functions mirroring the static methods in `ConvertObject`, providing alternative easy less
  code usage options.

For example:

```dart
// Use this shorter way to convert values.
final stringList = toList<String>(dynamicValue);
// If 'toList' name is already defined in your code, use this way to avoid conflicts.
final stringList = ConvertObject.toList<String>(dynamicValue);
```

## 1.5.1

- **NEW**: Added `dismissActivePopup` method to the `NavigatorExtension` extension on `BuildContext`.
  This method programmatically and recursively dismisses any active pop-up elements like dialogs, modal bottom sheets,
  and Cupertino modal popups.
  It checks for the types `PopupRoute`, `DialogRoute`, `RawDialogRoute`, `ModalBottomSheetRoute`,
  and `CupertinoModalPopupRoute` to determine if a pop-up is currently displayed and closes it.
  If multiple pop-ups are stacked, the method will recursively close all of them.

## 1.5.0

- **UPDATE**: update flutter version boundaries to be `  sdk: '>=3.0.6 <4.0.0'`

## 1.4.9

- **FIX**: Fixed `isTomorrow`, `isToday`, `isYesterday` getters in DateTime extensions.

## 1.4.8

- **BREAKING CHANGE**: Renamed the `delay` function in the Duration extension to be `delayed` to avoid conflicts with
  other packages

- **UPDATE**: Updated the `remainingDays`, `passedDays` getter in the DateTime extension to correctly consider the day
  ending at midnight.

- **NEW**: Added the `remainingDuration`, `passedDuration` getter to the DateTime extension for calculating the
  remaining duration between two dates.

For example:

```dart

final date = DateTime(2030);
final remainingDuration = date.remainingDuration(DateTime.now());
```

## 1.4.7

- **NEW**: Added new function `toTitle` on String Extension which is similar to `toTitleCase` but ignores the '-'
  and '_' characters.
  This is useful when users name events, products, etc.
  and want these characters to be shown in the correct format.
  For example, `flutter-and-dart` becomes `Flutter-And-Dart` when using `toTitle`.

## 1.4.6

- **FIX**: Fixed a bug when using `listIndex` on ConvertObject functions that may cause the list return null.

## 1.4.5

- **UPDATE**: Enhanced the `asGreeks` getter to include all available Greek symbols for converting large numbers.
  Now, the symbols used are `['K', 'M', 'B', 'T', 'Q', 'P', 'E', 'Z', 'Y']`.
  This allows for more accurate representation of large numbers, such as converting 1000000000 to 1.0B.

## 1.4.4

- **NEW**: Added new extensions to the `String?` class: `isValidIp4`, `isValidIp6`, and `isValidUrl`. These extensions
  provide convenient methods to check the validity of IPv4 addresses, IPv6 addresses, and URLs respectively.

- **NEW**: Introduced a new method called `popRoot` to the `NavigatorExtension`. This method calls the normal `pop`
  method but with the `rootNavigator` parameter set to `true` under the hood. This feature proves to be useful
  in scenarios where dialogs need to be dismissed.

## 1.4.3

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

## 1.4.2

- **UPDATE**: Updated Documentation.

## 1.4.1

- **NEW**: The convert object methods now include an optional `mapKey` parameter, enabling the conversion of specific
  values within a Map object. This enhancement provides flexibility by allowing developers to extract and convert
  targeted values based on the specified `mapKey`.

  For example:

```dart

dynamic object1 = {'name': 'John', 'age': '30', 'isHuman': 'yes'};

final double age = ConvertObject.toDouble(object1, mapKey: 'age'); // 30.0
final bool isHuman = ConvertObject.toBool(object1, mapKey: 'isHuman'); // true
```

## 1.4.0

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

## 1.3.8

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

## 1.3.7

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

## 1.3.6

- **UPDATE**: The `toList<T>` and `tryToList<T>` functions now support converting map values to a list if the value's
  type matches `T`. This enhancement adds more flexibility and convenience when working with collections.

## 1.3.5

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

## 1.3.4

- **NEW**: Added `isValidHttpCode` in `num?` extension that returns true if the http response code is 200 or 201.
- **NEW**: Added `toDateWithFormat` in String extension that converts string to `DateTime` with specific format
  e.g., `d-M-y`.

&nbsp;
*Usage*:

  ```dart

final dateTime = '14-12-2030'.toDateWithFormat('d-M-y');
  ```

## 1.3.3

- **NEW**: Added `binary` in bool extension that returns `1` if true and `0` if false as `int`.

## 1.3.2

- **FIX**: Fixed a bug when detecting `isIOSWeb` and `isAndroidWeb` using `TargetPlatform`.
- **NEW**: Added `isApple` that detects if the running device is made by apple e.g. MacOS, iPadOS, or iOS.

&nbsp;
*Usage*:

  ```dart
context.isApple
// OR without context
defaultTargetPlatform.isApple // import 'package:flutter/foundation.dart';
  ```

## 1.3.1

- **NEW**: Added `toBool` to nullable `Object?`.

&nbsp;
*Rules*:

* Object is true only if
    1. Object is bool and true.
    2. Object is num and is greater than zero.
    3. Object is string and is equal to 'yes', 'true', or '1'.
* any other conditions including null will return false.

## 1.3.0

- **HOT FIX**: Fixed bool extension is not exported.

## 1.2.9

- **NEW**: Added `isTrue`, and `isFalse` on nullable boolean, now if bool? is null the check will always return false
  instead of showing compile error.

## 1.2.8

- **UPDATE**: replace `isNegativeOrNull`, `isPositiveOrNull`, `isNotNegativeOrNull`, `isNotPositiveOrNull`,
  and `isNotZeroOrNull` with just `isNegative`, `isPositive`, and `isZeroOrNull` in nullable numbers.

## 1.2.7

- **NEW**: Added an option to check the device type when running on web, e.g. `isMobileWeb` or `isDesktopWeb`.

## 1.2.6

- **NEW**: Added `local` getter in datetime that call toLocal() on any dat, but it respects null safety.

## 1.2.5

- **NEW**: Added `tryRemoveAt`, `indexOfOrNull`, `indexWhereOrNull`, and `tryRemoveWhere` on `List<T>?` extension.
- **UPDATE**: Update the package
  to [FlutterSDK 3.10](https://docs.flutter.dev/release/release-notes/release-notes-3.10.0).
- **FIX**: Fixed a bug with `isNotNull` on `Object` extension.

## 1.2.4

- **NEW**: Added `DatesHelper` class that provide a set of static methods for DateTime such
  as `isSameHour`, `diffInDays`, and `daysInRange`.
- **NEW**: Added the getters `isPresent`, `isPast`, `passedDuration`, `remainingDays`, and more to the `DateTime`
  extension.
    - Now you can get formatted date using the format method directly in any date e.g `DateTime.now().format('EEE')`

## 1.2.3

- **NEW**: Added `scaffoldMessenger` getter in the `BuildContext` extension to easily
  call `ScaffoldMessenger.of(context)`
- **UPDATE**: Improved implementation of the `toList` and `tryToList` in the `ConvertObject` class.

## 1.2.2

- **NEW**: Added `toUtcIso` (supports null safety) that convert any date `toUtc()` and `toIso8601String()` in the Date
  extensions.

## 1.2.1

- **NEW**: Added `isEmptyOrNull` and `isNotEmptyOrNull` to Map and Set extensions.

## 1.2.0

- **UPDATE**: Update documentation.

## 1.1.9

- **FIX**: Fixed a bug with `isZero` bool in numbers extensions.
- **UPDATE**: `asBool` support null safety on numbers extensions.
- **UPDATE**: Updated `ParsingException` implementation.

## 1.1.8

- **NEW**: Added `isPositiveOrNull`, `isZeroOrNull`, and `isNegativeOrNull` to all numbers extensions.
- **UPDATE**: on String extension, `isEmptyOrNull` now returns true if string has only empty lines.

## 1.1.7

- **NEW**:  Added `toDateTime` and `tryToDateTime` in `ConvertObject` class.

## 1.1.6

- **NEW**:  Added `toMap` and `tryToMap` in `ConvertObject` class, and add `isValidSVG` in String extension.

## 1.1.5

- **NEW**:  Added `toBool` and `tryToBool` in `ConvertObject` class.
- **UPDATE**:  Improved all implementations of static methods in `ConvertObject` class.

## 1.1.4

- **NEW**:  Supported converting timestamp milliseconds to `DateTime` and added `tryToString` in `ConvertObject` class.

## 1.1.3

- **FIX**: Added missing `pushNamedAndRemoveUntil` in the navigation extension.

## 1.1.2

- **UPDATE**: Improved `asBool` implementation in the string extension.

## 1.1.1

- **FIX**: Fixed a bug in `camelCase` conversion algorithm.

## 1.1.0

- **FIX**: Fixed logo does not appear in readme file.

## 1.0.9

- **UPDATE**: Re-organized changelog and updated readme file.

## 1.0.8

- **FIX**: Fixed bug with `isHexColor` in color extension.

## 1.0.7

- **NEW**: Added new color extension to support converting hex string to color and checking if string is a hex color.

## 1.0.6

- **UPDATE**: Supported null safety to ThemeMode and Brightness.

## 1.0.5

- **UPDATE**: Changed `pop` to `popPage` to solve conflicts with `go_router` package extensions.

## 1.0.4

- **UPDATE**: Updated readme file.

## 1.0.3

- **NEW**: Added `capitalizeFirstLetter`, `toPascalCase`, `toTitleCase`, and `toCamelCase` to String extension.

## 1.0.2

- **UPDATE**: Renamed some getters to fix conflicts with the `get` package.

## 1.0.1

- **UPDATE**: Updated readme file.

## 1.0.0

- **INITIAL**: Initial release.
