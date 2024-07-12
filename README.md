<table style="border:none;">
  <tr style="border:none;">
    <td style="vertical-align:top; border:none;">
      <h1 style="border:none;" "min-width:400px;">Flutter Helper Utils</h1>
      <p style="min-width:400px;">Make Flutter development easier with Flutter Helper Utils! This toolkit is packed with helper methods and extensions that boost your productivity and help you write less code and build apps faster.</p>
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
- All the Dart-specific utilities documentations moved to the [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils) readme.
- This package already exporting [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils), so there is no breaking changes on this version.


## Table of Contents

- [Featured](#featured)
  - [ValueNotifier Supercharged](#valuenotifier-supercharged)
- [Extensions](#extensions)
  - [Listenable & ValueNotifier](#listenable--valuenotifier)
  - [UI & Design](#ui--design)
    - [Colors](#colors)
    - [ThemeData](#themedata)
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

**ValueNotifier** is a simple class in **Flutter** that allows you to store a value and notify any listeners when the
value changes.

This package enhances `ValueNotifier` with additional functionalities:

Starting from version 4.0.0, you can use a new set of extensions, helper methods, and specialized notifiers for better
data handling:

- Instantly create notifiers from any value with the intuitive `.notifier` extension (e.g.,`10.notifier`)
- Specific data types using our type-safe notifiers like `ListNotifer`,  `BoolNotifier`, `IntNotifier`, etc.
- Use the `.builder` extension on any `ValueListenable`, `Listenable`, or `List<Listenable>` instance to create a
  `ValueListenableBuilder`, `ListenableBuilder`, or `ListenablesBuilder` respectively under the hood with a shorter and simpler
  syntax.
- complex data handling with collections. For example `ListNotifier`, which acts like normal list and `ValueNotifier` at the
  same time, which means you can use it in `for` loops, in `ValueListenableBuilder` widget, and get notified automatically
  when inner data changed (Same goes for all notifier classes!).

**Example:**

```dart
final counter = 0.notifier;
counter.listenableBuilder((count) => Text('$count'));

counter.increment(); // Increment the counter easily
```

For more info about ValueNotifier check the [official flutter documentation](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html)

# Extensions
All the extensions included in the [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils#extensions) package Plus:

## Listenable & ValueNotifier
### on ValueListenable 
- `builder`: Simplifies the creation of a `ValueListenableBuilder` widget that reacts to changes in a single `ValueListenable`.
  - ```dart
    final intNotifer = 0.notifer;
    scrollController.builder((value) => /* widget reacts to intNotifer changes */ );
    ```
### on Listenable
- `.builder`: Simplifies the creation of a `ListenableBuilder` widget that reacts to changes in any `Listenable`.
  - ```dart
    final scrollController = ScrollController();
    scrollController.builder((context) => /* widget reacts to scrollController changes */ );
    ```
### on List<Listenable>
- `.builder`:  Creates a `ListenablesBuilder` widget to efficiently manage and respond to changes in multiple `Listenable` objects simultaneously, including `ValueNotifier`, `ChangeNotifier`, and others. Customize rebuild behavior using the optional `buildWhen` and `threshold` parameters.
  - ```dart
    final myListeners = <Listenable>[textController, scrollController, anyNotifier];
    myListeners.builder((context) => /* widget reacts to myListeners changes */ );
    ```
### ValueNotifier Creation
- `.notifier`:  Converts a value of any type into the corresponding `ValueNotifier` type/subtype, enabling easy integration into reactive UI components.
  - e.g. `final intNotifer = 1.notifier` creates an IntNotifier aka ValueNotifier<int>.

### UI & Design
### Colors

- `toHex`: Transforms a `Color` object into its corresponding hexadecimal string representation.
- `toColor`: Creates a `Color` object from a valid hexadecimal color string.
- `isHexColor`: Determines if a given string is a valid hexadecimal color representation.

### ThemeData
- `isDark`, `isLight`: Checks whether the current theme is in dark or light mode.
- `textTheme`: Provides direct access to the `TextTheme` of the current theme.
- `displayLarge`, `displayMedium`, `displaySmall`, etc.: Retrieve specific text styles from the theme, optimized for different display sizes.
- `displayLargeCopy`, `displayMediumCopy`, `displaySmallCopy`, etc.: Retrieve copies of the specific text styles from the theme, allowing modifications without affecting the original theme.

## BuildContext
**Important Note:** Avoid frequent use of context on actions that might call `of(context)` like theme. The widget registers itself as a dependency on the theme, meaning that if the theme changes (e.g., when switching between light/dark mode), all widgets using `Theme.of(context)` aka `context.themeData` will rebuild, even if they don’t directly depend on the changed theme properties. It’s recommended to use `final theme = context.themeData` at the top of the widget tree only once.

### For Themes
- `themeData`: Get the current `ThemeData`.
- `txtTheme`: Obtain the `TextTheme`.
- `brightness`: Determine the theme's brightness.
- `sysBrightness`: Determine the system's brightness.
- `isDark`, `isLight`: Check if the theme is dark or light.

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
- `paddingLTRB`: Add padding with individual values for left, top, right, and bottom.
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

Contributions to this package are welcome. If you have any suggestions, issues, or feature requests, please create a
pull request in the [repository](https://github.com/omar-hanafy/flutter_helper_utils).

## License

`flutter_helper_utils` is available under the [BSD 3-Clause License.](https://opensource.org/license/bsd-3-clause/)

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

