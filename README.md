<table style="border:none;">
  <tr style="border:none;">
    <td style="vertical-align:top; border:none;">
      <h1 style="border:none; min-width:400px;">Flutter Helper Utils</h1>
      <p style="min-width:400px;">Make Flutter development easier with Flutter Helper Utils! This toolkit is packed with helper methods and extensions that boost your productivity, helping you write less code and build apps faster.</p>
    </td>
    <td style="vertical-align:top; border:none;">
      <a href="https://pub.dev/packages/flutter_helper_utils" target="_blank">
        <img src="https://raw.githubusercontent.com/omar-hanafy/flutter_helper_utils/main/dash-tools.png" alt="Flutter Helper Utils Logo" style="max-width:400px;"/>
      </a>
    </td>
  </tr>
</table>

**Important Notes for Version 4.1.0+:** We've refactored the Dart-specific utilities into a new package, [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils), to allow Dart projects to use these utilities without depending on Flutter.

- Future updates for Dart-specific utilities will be available in the [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils) changelog.
- All the Dart-specific utilities documentation has been moved to the [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils) readme.
- This package already exports [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils), so there are no breaking changes in this version.

## Table of Contents

- [Featured](#featured)
  - [ValueNotifier Supercharged](#valuenotifier-supercharged)
  - [PlatformEnv](#platformenv-class)
  - [Adaptive UI](#adaptive-ui)
- [Extensions](#extensions)
  - [Listenable & ValueNotifier](#listenable--valuenotifier)
  - [UI & Design](#ui--design)
    - [Colors](#colors)
    - [ThemeData](#themedata)
  - [TargetPlatform](#targetplatform)
  - [BuildContext](#buildcontext)
    - [For Themes](#for-themes)
    - [For MediaQuery](#for-mediaquery)
    - [For FocusScope](#for-focusscope)
    - [For Navigation](#for-navigation)
  - [Widgets](#widgets)
    - [Align](#align)
    - [Padding](#padding)
  - [List/Iterable Extensions](#listiterable-extensions)

# Featured
## ValueNotifier Supercharged

**ValueNotifier** is a simple class in **Flutter** that allows you to store a value and notify any listeners when the value changes.

This package enhances `ValueNotifier` with additional functionalities:

Starting from version 4.0.0, you can use a new set of extensions,
helper methods, and specialized notifiers for better data handling:

- Instantly create notifiers from any value with the intuitive `.notifier` extension (e.g., `10.notifier`).
- Specific data types using our type-safe notifiers like `ListNotifier`, `BoolNotifier`, `IntNotifier`, etc.
- Use the `.builder` extension on any `ValueListenable`, `Listenable`, or `List<Listenable>` instance to create a `ValueListenableBuilder`, `ListenableBuilder`, or `ListenablesBuilder` respectively under the hood with a shorter and simpler syntax.
- Complex data handling with collections. For example, `ListNotifier`, which acts like a normal list and `ValueNotifier` at the same time, allowing usage in `for` loops, in `ValueListenableBuilder` widgets, and automatic notifications when inner data changes (same goes for all notifier classes!).

**Example:**

```dart
final counter = 0.notifier;
counter.listenableBuilder((count) => Text('$count'));

counter.increment(); // Increment the counter easily
```

For more info about `ValueNotifier`,
check the [official Flutter documentation](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html).

## PlatformEnv class
A replacement for the `dart:io` `Platform` class.
Key enhancements over the original `Platform`:
- Eliminates errors caused by using dart:io functionality in web browsers.
- Maintains a familiar API similar to the dart:io Platform class, making migration and usage effortless.
- Handles system-specific properties like the number of processors, path separator, and local hostname, with sensible defaults on web platforms.

**Example Usage:**
```dart
print('TargetPlatform: ${PlatformEnv.targetPlatform}');
print('Is Web: ${PlatformEnv.isWeb}');
print('Is macOS: ${PlatformEnv.isMacOS}');
// and all other Platform getters are supported.
```

## Adaptive UI
Create responsive layouts for different screen sizes and platforms (mobile, tablet, desktop).

### Features
- **Efficient:** Rebuilds only when the platform type changes.
- **Easy-to-use context extensions:** Access platform/orientation information directly.
- **Customizable:** Define your own breakpoints and helper extensions.
- **Layout builders:** Convenient widgets for building adaptive UI.

### Basic Usage
```dart
PlatformTypeProvider( // Wrap your app
  child: MyApp(),
); // optionally receive custom breakpoints.

@override
Widget build(BuildContext context) {
  final breakpoint = context.breakpoint; // rebuilds on change.
  return breakpoint.isMobile ? const MobileLayout() : const TabletLayout();
}
```
See the [detailed documentation](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/documentations/adaptive_ui_with_platform_type_detection.md) for adaptive ui
to explore more.

# Extensions
All the extensions included in the [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils#extensions) package plus:

## Listenable & ValueNotifier
### on ValueListenable 
- `builder`: Simplifies the creation of a `ValueListenableBuilder` widget that reacts to changes in a single `ValueListenable`.
  - ```dart
    final intNotifier = 0.notifier;
    intNotifier.builder((value) => /* widget reacts to intNotifier changes */ );
    ```
### on Listenable
- `.builder`: Simplifies the creation of a `ListenableBuilder` widget that reacts to changes in any `Listenable`.
  - ```dart
    final scrollController = ScrollController();
    scrollController.builder((context) => /* widget reacts to scrollController changes */ );
    ```
### on List<Listenable>
- `.builder`: Creates a `ListenablesBuilder` widget to efficiently manage and respond to changes in multiple `Listenable` objects simultaneously, including `ValueNotifier`, `ChangeNotifier`, and others. Customize rebuild behavior using the optional `buildWhen` and `threshold` parameters.
  - ```dart
    final myListeners = <Listenable>[textController, scrollController, anyNotifier];
    myListeners.builder((context) => /* widget reacts to myListeners changes */ );
    ```
### ValueNotifier Creation
- `.notifier`: Converts a value of any type into the corresponding `ValueNotifier` type/subtype, enabling easy integration into reactive UI components.
  - e.g., `final intNotifier = 1.notifier` creates an `IntNotifier`, aka `ValueNotifier<int>`.

### UI & Design
### Colors
- `toHex`: Transforms a `Color` object into its corresponding hexadecimal string representation.
- `darken`, `lighten`: Adjust color lightness.
- `shade`, `tint`: Create variations by mixing with black/white.
- `contrast`: Calculate contrast ratios between colors.
- `complementary`: Find the opposite color on the color wheel.
- `blend`: Mix colors.
- `grayscale`, `invert`: Convert to grayscale or invert colors. 
- `toColor`: Creates a `Color` object from a valid hexadecimal color string `"#FFFFFF".toColor()`.
- `isHexColor`: Determines if a given string is a valid hexadecimal color representation `"#FFFFFF".isHexColor()`.

### ThemeData
- `isDark`, `isLight`: Checks whether the current theme is in dark or light mode.
- `textTheme`: Provides direct access to the `TextTheme` of the current theme.
- `displayLarge`, `displayMedium`, `displaySmall`, etc.: Retrieve specific text styles from the theme, optimized for different display sizes.
- `displayLargeCopy`, `displayMediumCopy`, `displaySmallCopy`, etc.: Retrieve copies of the specific text styles from the theme, allowing modifications without affecting the original theme.

## TargetPlatform
All the above getters are available under both `BuildContext` instances and `TargetPlatform` instances.

**Native Only Platforms**
- `isMobile`: true if running on a mobile device (iOS or Android) natively.
- `isIOS`: true if running on iOS natively.
- `isAndroid`: true if running on Android natively.
- `isDesktop`: true if running on a desktop OS (Linux, macOS, Windows) natively.
- `isMacOS`: true if running on macOS natively.
- `isWindows`: true if running on Windows natively.
- `isLinux`: true if running on Linux natively.
- `isApple`: true if running on any Apple platform (macOS or iOS) natively.

**Web Platforms**
- `isMobileWeb`: true if running on a mobile browser (iOS or Android).
- `isIOSWeb`: true if running on iOS in a web browser.
- `isAndroidWeb`: true if running on Android in a web browser.
- `isDesktopWeb`: true if running on a desktop browser (Linux, macOS, Windows).
- `isMacOSWeb`: true if running on macOS in a web browser.
- `isWindowsWeb`: true if running on Windows in a web browser.
- `isLinuxWeb`: true if running on Linux in a web browser.
- `isAppleWeb`: true if running on an Apple platform (macOS or iOS) in a web browser.

## BuildContext
**Important Note:** Avoid frequent use of context on actions that might call `of(context)`, like theme. The widget registers itself as a dependency on the theme, meaning that if the theme changes (e.g., when switching between light/dark mode), all widgets using `Theme.of(context)`, aka `context.themeData`, will rebuild, even if they don’t directly depend on the changed theme properties. It’s recommended to use `final theme = context.themeData` at the top of the widget tree only once.

### For Themes
- `themeData`: Get the current `ThemeData`.
- `txtTheme`: Obtain the `TextTheme`.
- `brightness`: Determine the theme's brightness.
- `sysBrightness`: Determine the system's brightness.
- `isDark`, `isLight`: Check if the theme is dark or light.
- `targetPlatform`: Get the current `TargetPlatform`; all the getters mentioned in [TargetPlatform](#targetplatform) are also available here.
- `withoutEffects()`: Remove visual feedback effects (splash, highlight, hover, etc.) from a theme with customizations.

### For MediaQuery
- `mq`: Access `MediaQueryData`.
- `nullableMQ`: Access `MediaQueryData` (nullable).
- `deviceOrientation`: Get device orientation.
- `navigationMode`: Get navigation mode.
- `padding`, `viewInsets`: Get screen padding and insets.
- `screenDimensions`: Get screen width and height.
- `additionalFeatures`: Access additional features.

### For FocusScope
- `focusScope`: Get the nearest `FocusScopeNode`.
- `unFocus`: Remove focus.
- `requestFocus`: Request focus.
- `requestFocusCall`: Request focus (using `GestureTapCallback`).
- `hasFocus`: Check if a node has focus.
- `hasPrimaryFocus`: Check if a node has primary focus.

### For Navigation
- `popPage`: Pop the current page.
- `popRoot`: Pop to the root page.
- `navigator`: Get the `NavigatorState`.
- `canPop`: Check if you can pop the current page.
- `pPage`: Push a new page.
- `pReplacement`: Push and replace the current page.
- `pAndRemoveUntil`: Push and remove pages until a condition is met.
- `pNamedAndRemoveUntil`: Push a named route and remove pages until a condition is met.
- `pNamed`: Push a named route.
- `pReplacementNamed`: Push and replace the current page with a named route.
- `popUntil`: Pop pages until a condition is met.
- `dismissActivePopup`: Dismiss the active popup.

## Widgets
### Align
- `alignAtBottomCenter`, `alignAtTopLeft`, `alignAtBottomLeft`, etc.: Align a widget within its parent using various alignment options.
- `alignXY`: Align a widget using explicit x and y coordinates.
- `alignAtLERP`: Align a widget using linear interpolation between two alignments.

### Padding
- `paddingAll`: Add padding on all sides of a widget.
- `paddingLTRB`: Add padding with individual values for a left, top, right, and bottom.
- `paddingSymmetric`: Add padding symmetrically for horizontal and vertical.
- `paddingOnly`: Add padding to specific sides.

**More widget extensions to be added soon.**

## List/Iterable Extensions

- `toRow`: Convert a list of widgets into a `Row`.
- `toColumn`: Convert a list of widgets into a `Column`.
- `toStack`: Convert a list of widgets into a `Stack`.
- `toList`: Convert an `Iterable` to a `List`.
- `toListView`: Convert an `Iterable` to a `ListView`.

## Contributions

Contributions to this package are welcome.
If you have any suggestions, issues, or feature requests,
please create a pull request in the [repository](https://github.com/omar-hanafy/flutter_helper_utils).

## License

`flutter_helper_utils` is available under the [BSD 3-Clause License](https://opensource.org/license/bsd-3-clause/).

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>