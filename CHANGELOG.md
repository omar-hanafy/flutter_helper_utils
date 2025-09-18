# CHANGELOG

## 8.5.0

### Breaking
- `TypedListViewBuilder` now uses the `itemBuilder(context, index, item)` signature for idiomatic Flutter access to `BuildContext`.

### Added
- New list quality-of-life options: `spacing`, `emptyBuilder`, `showScrollbar`, and pull-to-refresh support.
- Infinite scroll helpers via `onEndReached`, `onEndReachedThreshold`, and `isLoadingMore`.
- `itemKeyBuilder` for stable keyed items when combining headers, separators, or pagination widgets.
- Introduced `TypedSliverList` with matching builder ergonomics for `CustomScrollView` usage.

### Changed
- Simplified header/footer/pagination configuration on `TypedListView`, replacing `headerBuilder`/`footerBuilder` with direct widget slots.

## 8.4.0
- Add color lookup by name to ColorScheme extensions

## 8.3.0

- Enhanced ParsingException to provide comprehensive debugging information with structured argument maps and filtered output.
- CHORE: updated the [dart_helper_utils](https://pub.dev/packages/dart_helper_utils) to be ">=5.4.0 <6.0.0".

## 8.2.0

### Added

- Added missing `ColorScheme` properties to `ThemeData` extension including `primaryFixed`, `primaryFixedDim`,
  `onPrimaryFixed`, `onPrimaryFixedVariant`, `secondaryFixed`, `secondaryFixedDim`, `onSecondaryFixed`, `onSecondaryFixedVariant`,
  `tertiaryFixed`, `tertiaryFixedDim`, `onTertiaryFixed`, `onTertiaryFixedVariant`, `surfaceDim`, `surfaceBright`,
  `surfaceContainerLowest`, `surfaceContainerLow`, `surfaceContainer`, and `surfaceContainerHigh`.

- CHORE: updated the [dart_helper_utils](https://pub.dev/packages/dart_helper_utils) to be ">=5.3.0 <6.0.0".

## 8.1.0

### Added
- **Color Conversion Utilities**: Added `toColor()` and `tryToColor()` for robustly parsing colors from strings (Hex, CSS functions), integers, and other color types.
- **Color Harmony Generation**: Added methods to generate theory-based color palettes: `monochromatic()`, `analogous()`, `triadic()`, `tetradic()`, and `splitComplementary()`.
- **WCAG Accessibility Suite**:
  - `meetsWCAG()`: Checks color contrast against AA/AAA standards.
  - `suggestAccessibleColors()`: Provides accessible color alternatives for a given background.
- **Color Blindness Simulation**:
  - `simulateColorBlindness()`: Simulates how colors appear with various vision deficiencies.
  - `isDistinguishableFor()`: Checks if two colors have enough contrast for colorblind users.

### Changed
- **API Clarity**: Renamed all `add*` color methods to `set*` (e.g., `addOpacity` to `setOpacity`) for clearer intent. Old methods are now deprecated and will be removed in v9.0.
- **CSS Compliance**: HSL color parser now correctly handles hue angle wrapping as per the CSS Color Module Level 4 specification.

## 8.0.2

- Updated docs
- Enhanced `MultiTapDetector` widget.
- Deprecated gradientAlignment parameter from the `GradientWidget`.
  Use the gradient's own positioning properties instead (like begin/end for LinearGradient).

## Version 8.0.1

- CHORE: updated the [dart_helper_utils](https://pub.dev/packages/dart_helper_utils) to be ">=4.1.2 <6.0.0" for more flexibility.

## Version 8.0.0

### New Features

- **Added `toEnum` to `TextDirection` in the `intl` module:**
  - This utility converts the `TextDirection` type from the `intl` library to the corresponding `TextDirection` enum from the Material library.
  - Solves type compatibility issues, such as "The argument type 'TextDirection' can't be assigned to the parameter type 'TextDirection?'". For example, use `TextDirection.RTL.toEnum` directly in any `Text` widget to ensure seamless integration.

### Breaking Changes

- **Relocation of `SingleAxisWrap` widget:**
  - The `SingleAxisWrap` widget has been extracted into a standalone package: [single_axis_wrap](https://pub.dev/packages/single_axis_wrap).
  - This move includes several enhancements to the widget’s functionality.
  - Refer to the [migration guide](https://github.com/omar-hanafy/flutter_helper_utils/tree/main/migration_guides.md) for instructions on updating your code.

- **Dependency Update: `dart_helper_utils` upgraded to v5.0.0:**
  - This update introduces breaking changes from the `dart_helper_utils` package.
  - Key changes include:
    - Removal of conversion helpers on `Object` to reduce IDE suggestion clutter.
    - Renaming of `DateTime` extension methods (e.g., `addOrRemoveYears` → `addOrSubtractYears`).
    - New date manipulation methods and improved precision (e.g., millisecond/microsecond support).
  - For a full list of changes, see the [dart_helper_utils v5.0.0 changelog](https://pub.dev/packages/dart_helper_utils/changelog#500).

## Version 7.0.1
 
- **Chore**: `dart_helper_util` upgraded to [v4.0.1](https://pub.dev/packages/dart_helper_utils/changelog#401) to fix Builder conflict.

## Version 7.0.0

### Features & Enhances

#### New Locale & Directionality Utilities

- Added convenient RTL/LTR direction checking utilities
- Added rich context helpers for:
    - Directionality management (`directionality`, `isLTR`, `isRTL`)
    - Locale access and formatting (`locale`, `localeString`, `languageCode`)
    - Language, script, and country code validation.
- Added direction-aware layout utilities:
    - Logical padding and margin helpers.
    - RTL-aware alignment and positioning.
    - Direction-sensitive offsets and sizing.
- Added common language detection (Arabic, English, Persian, etc.)
- Added utilities for RTL-aware list ordering and manipulation.

#### CarouselController Extension

- Added an extension on `CarouselController` with utilities for controlling carousel behavior.
    - Supports both fixed and weighted item extents.
    - Includes methods to animate or jump to items, move next/previous, and navigate by a relative number of items.
    - Wraps indices for seamless looping.
    - Supports rounding modes (`round`, `floor`, `ceil`) and snapping behavior.
    - Moves based on scroll velocity for smoother interactions.
    - Allows overriding default calculations for more flexibility.

#### Widget

- Added `SingleAxisWrap`: Adaptive single-axis layout that automatically switches between row and column based on
  available space
    - Unlike `Wrap`, maintains all children in the same axis (no wrapping to new lines/columns)
    - Configurable preferred direction with automatic fallback
    - Independent row/column configurations for spacing and alignment

#### Theme

- Added new `themeExtension` which returns a custom theme extension of type `T` from the nearest `Theme` ancestor.
- Added new `themeWithExtension` which Returns a tuple containing the `ThemeData` and a custom theme extension of type
  `T`.

#### Colors

- **Color Utilities**
    - Added `contrastColor` for generating readable contrasting colors
    - Added `isDark` and `isLight` for WCAG-based color analysis
    - Enhanced grayscale conversion using linear luminance for better perceptual accuracy
    - Added `isApproximately` for fuzzy color comparison with tolerance

- **String to Color Parsing**
  this version improves handling of hex colors, alpha channels, RGB percentages, and multiple angle units in HSL, using
  robust methods for accuracy.
    - Added support for modern color formats:
        - RGB/RGBA: `rgb(255, 0, 0)`, `rgba(255, 0, 0, 0.5)`
        - HSL/HSLA: `hsl(120, 100%, 50%)`, `hsla(120, 100%, 50%, 0.5)`
        - HWB: `hwb(0 0% 0%)`, `hwb(0 0% 0% / 0.5)`
        - Modern space-separated syntax
        - CSS named colors

    - Enhanced validation methods:
        - `isValidColor`: Universal color format validation
        - `isHexColor`: Improved hex color validation
        - `isRgbColor`: RGB/RGBA syntax validation
        - `isHslColor`: HSL/HSLA syntax validation
        - `isModernColor`: Modern color function syntax validation

#### New Scroll Extensions Helpers

- Added: `flingWithVelocity` - Performs velocity-based scroll animation
- Added: `snapToClosest` - Snaps scroll position to the closest item based on a given item extent
- Added: `scrollByPercentage` - Scrolls by relative percentage from current position
- Added: `isItemVisible` - Checks if a specific item is visible in viewport
- Added: `hasScrollMomentum` - Checks if scroll view is in ballistic scroll motion
- Added: `debugPrintScrollInfo` - Prints detailed scroll state information for debugging

#### Platform Environment

- Added `report()` method to `PlatformEnv`
    - Returns: Detailed platform information in `Map<String, String>` format

### Breaking Changes Guide

#### Focus Scope Extension Updates

All getter methods have been converted to regular method calls for clarity:

| Old (Getter)   | New (Method)     |
|----------------|------------------|
| `unFocus`      | `unFocus()`      |
| `requestFocus` | `requestFocus()` |

#### Scaffold Messenger Extension Updates

All getter methods have been converted to regular method calls:

| Old (Getter)                  | New (Method)                    |
|-------------------------------|---------------------------------|
| `hideCurrentMaterialBanner`   | `hideCurrentMaterialBanner()`   |
| `hideCurrentSnackBar`         | `hideCurrentSnackBar()`         |
| `removeCurrentMaterialBanner` | `removeCurrentMaterialBanner()` |
| `removeCurrentSnackBar`       | `removeCurrentSnackBar()`       |
| `clearMaterialBanners`        | `clearMaterialBanners()`        |
| `clearSnackBars`              | `clearSnackBars()`              |

#### Scroll Extensions Changes

- Renamed: `isInTop` → `isAtTop` for better naming consistency
- **Important**: The extension no longer supports nullable scroll controllers
    - All helper getters now require null-aware access (e.g., `controller?.isAtTop`)

### Dependencies

- Updated to `dart_helper_utils` v4.0.0 (contains breaking changes)
    - For details: [dart_helper_utils changelog](https://pub.dev/packages/dart_helper_utils/changelog#400)
- **Flutter SDK:** Enforced minimum version to `>=3.29.0`.

## v6.10.0

### New Scroll Extensions:

- **Extended ScrollController Functionality:**
    - **Basic Scroll Animations:**
        - `animateToPosition`: Animate to a specific offset with customizable duration and curve
        - `animateToBottom`/`animateToTop`: Quick navigation to extremes
        - `smoothScrollTo`: Smooth scroll with boundary clamping
    - **Advanced Controls:**
        - `pageScroll`: Paginated scrolling with a customizable viewport fraction
        - `scrollToPercentage`: Scroll to specific percentage of content
    - **Position Checking:**
        - `isAtEdge`, `isAtBottom`: Edge detection
        - `scrollProgress`: Current scroll position as percentage
        - `isNearTop`/`isNearBottom`: Proximity detection with a threshold
- **Nullable ScrollController Extensions:**
    - `isInTop`: Check if scrolled to top
    - `canScroll`: Verify if scrolling is possible
    - `didScrollToTop`: Animate to top and return success status
    - **Direction Checking:**
        - `isScrollReverse`/`isScrollForward`/`isScrollIdle`: Direction state checks
- **ScrollDirection Extensions:**
    - Simple direction state checks: `isIdle`, `isForward`, `isReverse`

## v6.9.0

### **Colors Enhancements:**

- **Wide Gamut Support:** Updated all color operations to be compatible with Flutter's new wide gamut color support.
  This includes using the `Color.withValues` constructor and ensuring sRGB alignment for consistent results.
- **Migration Helpers:** Added methods to assist with migrating from the old `Color` API to the new one:
    - `addOpacity(double opacity)`: Replaces `withOpacity`.
    - `addAlpha(int alpha)`: Replaces `withAlpha`.
    - `addRed(int red)`: Replaces `withRed`, and similar for `addGreen`/`addBlue`.
    - `toARGBInt()`: Converts to the old 32-bit integer format.
    - `lerpColor(Color? a, Color? b, double t)`:  sRGB-aware version of `Color.lerp`.
- **Additional Functionality:**
    - `scaleOpacity(double scale)`:  Scales the alpha channel.
    - `convertToColorSpace(ColorSpace targetSpace)`: Converts to a specific color space.
    - `isInColorSpace(ColorSpace targetSpace)`: Checks the color's color space.

### **Internal Improvements:**

- **sRGB Alignment:** Improved handling of color spaces, ensuring that operations like HSL transformations and luminance
  calculations are performed in the sRGB color space for consistency.
- **Code Clarity:** Refactored some methods for better readability and maintainability.

### **Chore**:

- **Flutter SDK:** Enforced minimum version to `>=3.27.0`.
- **dart_helper_utils:** Upgraded to [v3.3.0](https://pub.dev/packages/dart_helper_utils/changelog#330).

## v6.8.0

- **Easier theme color access:** Access ColorScheme properties directly from the theme data object.
  For example, use `theme.onSurface` instead of `theme.colorScheme.onSurface`.

## v6.7.2

- **Chore**: `dart_helper_util` upgraded to [v3.2.0](https://pub.dev/packages/dart_helper_utils/changelog#320).

## v6.7.1

- **Enhancement**: `TypedListView`'s internal logic for rendering items and separators has been optimized.
- **Chore**: `dart_helper_util` upgraded to [v3.1.1](https://pub.dev/packages/dart_helper_utils/changelog#311).

## v6.7.0

### New: `TypedListView` Widget

- A type-safe list view for building highly customizable list.
- Supports optional headers, footers, separators, and pagination.
- Optimized for performance with efficient item building logic.
- ```dart
  TypedListView(
    items: products,
  	itemBuilder: (index, product) => ProductCard(product: item)
  	paginationWidget: const CircularProgressIndicator(), 
    padding: 8.edgeInsetsAll,
  ),
  ```

### `Future<T>` Extensions

- **`builder`**: Simplifies creating `FutureBuilder` widgets with less boilerplate.
    - Handles `Future` states (loading, data, error) and supports `initialData` for pre-load UI.

- **`map`**: Transforms `Future` results with a specified function.
    - Returns a new `Future` with the transformed result, enabling easier async chaining.

- **`buildWidget`**: Simplifies building widgets based on `Future` states.
    - Accepts `onSuccess`, `onError`, and optional `onLoading` callbacks for rendering different states.

### `AsyncSnapshot<T>` Extensions

- **Connection State Getters**:
    - `isNone`, `isWaiting`, `isActive`, `isDone`, `isSuccess`, `hasErrorAndDone`, `isWaitingOrActive`.

- **Data Utility Methods**:
    - `dataOr`: Provides safe access to data with a default fallback.
    - `dataWhen`: Pattern-matching utility for handling different snapshot states.
    - `buildWidget`: Simplifies widget building with `onSuccess`, `onError`, and `onLoading` callbacks.
    - `mapData`: Transforms data if available, returning `null` otherwise.
  ```dart
    // Using the `buildWidget` extension on Future to build UI for different states
    fetchData().buildWidget(
      onSuccess: (context, data) => ContentWidget(data),
      onError: (context, error) => ErrorWidget(error),
      onLoading: (context) => LoadingWidget(),
    );
    ```

- Added Countries search example which uses the lightweight countries and timezone data from the `dart_helper_util`
  package [v3.0.0+](https://pub.dev/packages/dart_helper_utils/changelog).
- `dart_helper_util` upgraded to [v3.0.0](https://pub.dev/packages/dart_helper_utils/versions/3.0.0/changelog#300).

## v6.6.0

- `dart_helper_util` upgraded to [v2.6.0](https://pub.dev/packages/dart_helper_utils/changelog#260).
  This includes updates to `DoublyLinkedList` methods, which are now re-implemented in the `DoublyLinkedListNotifier`.
- **Added the following to the BuildContext extension for MediaQuery:**
    - `nullableDeviceOrientation`
    - `nullablePixelRatio`
    - `nullableTextScaler`
    - `platformBrightness`
    - `nullableSystemGestureInsets`
    - `nullableViewPadding`
    - `alwaysUse24HourFormat`
    - `accessibleNavigation`
    - `invertColors`
    - `highContrast`
    - `onOffSwitchLabels`
    - `disableAnimations`
    - `boldText`
    - `gestureSettings`
    - `displayFeatures`
    - `supportsShowingSystemContextMenu`
    - `nullableSupportsShowingSystemContextMenu`
        - Usage example:
          ```dart
            @override
            Widget build(BuildContext context) {
            // DO
            final displayFeatures = context.displayFeatures;
            // INSTEAD OF
            final displayFeatures = MediaQuery.displayFeaturesOf(context);
            }
          ```

## v6.5.1

The `MultiTapDetector` widget has been enhanced to handle rapid tapping scenarios and prevent accidental triggers.

## v6.5.0

* **Added** `GradientWidget` which applies a gradient effect to its child widget.

- Updated `dart_helper_util` to [v2.5.3](https://pub.dev/packages/dart_helper_utils/changelog#253).

## v6.4.0

* **Added** more methods on numbers for creating `Border`, `Matrix4`, and `BoxConstraints`.
* **Added** `MultiTapDetector` widget for detecting multi-tap gestures on `child` with `tapCount` and `onTap` callback.

- Updated `dart_helper_util` to [v2.5.2](https://pub.dev/packages/dart_helper_utils/changelog#252).

## v6.3.0

* **Added** new methods on numbers for creating `BorderRadius` and `Radius` with specific corner combinations:
    * `onlyTopRounded`
    * `onlyBottomRounded`
    * `diagonalBLTR`
    * `diagonalTLBR`
    * `onlyLeftRounded`
    * `onlyRightRounded`

```dart
Container
(
decoration: BoxDecoration(
color: Colors.blue,
borderRadius: 10.allCircular, // All corners rounded with radius 10
),
...
),
```

This changelog focuses on the most impactful changes, making it easy for users to quickly understand the updates to the
extension.

## v6.2.2

- Updated `dart_helper_util` to [v2.5.1](https://pub.dev/packages/dart_helper_utils/changelog#251).

## v6.2.1

- Updated `dart_helper_util` to [v2.5.0](https://pub.dev/packages/dart_helper_utils/changelog#250).

## v6.2.0

### Introducing Adaptive UI:

This update introduces a set of tools for creating adaptive user interfaces using only native Flutter code. Widgets
update efficiently, triggered only by platform type changes not on every pixel change like other APIs.

**Key Highlights:**

* **`PlatformTypeProvider` Widget:** Detect platform type (mobile, tablet, desktop, etc.) and manage breakpoint changes
  efficiently.
* **Context Extensions:**
    * Use `context.breakpoint` and `context.platformSizeInfo` for convenient access to platform and orientation
      information.
    * You can now access the platform helper directly from the theme, e.g., `theme.isMobile`.
* **Responsive Layout Builders**:
    * `BreakpointLayoutBuilder`: Build responsive layouts based on the current breakpoint (e.g., mobile, tablet).
    * `PlatformInfoLayoutBuilder`: Build responsive layouts based on both platform type and screen orientation.
* **Detailed Documentation**:
  Added [detailed documentation](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/documentations/adaptive_ui_with_platform_type_detection.md)
  for adaptive UI usage.

### New Features:

* **Extension Methods for `num`**:
    * `paddingAll`, `paddingHorizontal`, `paddingTop`, etc.: Create `Padding` widgets directly from numeric values,
      e.g., `12.paddingAll()`.
    * `edgeInsetsAll`, `edgeInsetsHorizontal`, `edgeInsetsTop`, etc.: Generate `EdgeInsets` objects from numeric values
      for padding control, e.g., `padding: 12.edgeInsetsAll`.
    * `widthBox`, `heightBox`, `squareBox`: Easily create `SizedBox` widgets with specified dimensions.
    * `size`: Converts a numeric value into a `Size` object.
* **Extension Methods for `Size`**:
    * `toSizedBox`: Transforms a `Size` object into a `SizedBox`.
    * `scaled`: Scales a `Size` by a given factor.
    * `aspectRatio`: Calculates the aspect ratio of a `Size`.
    * `withWidth`, `withHeight`: Creates a new `Size` with a modified width or height.
    * `transpose`: Swaps the width and height of a `Size`.
    * `toPadding`: Converts a `Size` into a `Padding` widget.
    * `toAspectRatio`: Creates an `AspectRatio` widget from a `Size`'s aspect ratio.
    * `isEmpty`: Checks if a `Size` has zero width and height.
    * `isLargerThan`, `isSmallerThan`: Compares the area of two `Size` objects.
    * `scaleIndependently`: Scales the width and height of a `Size` independently.
    * `clamp`: Restricts a `Size` within specified minimum and maximum dimensions.
    * `expand`, `reduce`: Increases or decreases the dimensions of a `Size`.
    * `maxDimension`, `minDimension`: Retrieves the largest or smallest dimension of a `Size`.
    * `isEqualTo`: Compares two `Size` objects for equality.
    * `increaseBy`, `decreaseBy`: Creates a new `Size` with increased or decreased dimensions.
    * `fitWithin`: Scales a `Size` to fit within specified constraints while maintaining its aspect ratio.

### Fixes

* Fixed a typo in the `setDark` method; it was previously misspelled as `setDart`.
* Removed the custom `Box` widget as `SizedBox.square` provides similar functionality.

## 6.1.0

- Introduced `isFuchsia` and `isFuchsiaWeb` properties to `BuildContext` and `TargetPlatform` extensions, simplifying
  detection of the Fuchsia operating system in both native and web environments.
- Added `DoublyLinkedListNotifier` which creates `ValueNotifier<DoublyLinkedList>` (leveraging the `DoublyLinkedList`
  from [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils/changelog#2) package as
  of [v2.2.1+](https://pub.dev/packages/dart_helper_utils/changelog#221))
- Create custom `ValueNotifier` (e.g. `ListNotifier`) from any `Iterable<E>` using the `listNotifier`, `setNotifier`,
  and `doublyLinkedListNotifier` constructors.
- `EdgeInsets` Conversion: convert numbers to `EdgeInsets` using the new extension, e.g.,
  `Padding(padding: 8.paddingAll)`.
- `themeData.withoutEffects()`: method to customize which visual feedback effects (splash, highlight, hover, etc.) to
  remove from a theme.
- `ThemeWithoutEffects` Widget: Wrap widgets with this widget to selectively disable visual effects for specific parts
  of your app.

- **PlatformEnv:**
    - Introduced the `PlatformEnv` class to replace direct usage of `dart:io`'s `Platform` for improved web
      compatibility and error prevention.
    - The `PlatformEnv` class is a critical update for web compatibility. Consider updating your code to use
      `PlatformEnv` instead of `Platform` for a smoother transition to web support.

- **Enhanced Color Extension:**
    - **Expanded `toHex`:**  The `toHex` method now accepts an optional `includeAlpha` parameter to control whether the
      alpha channel is included in the hexadecimal representation.
    - Introduced new methods:
        - `darken`, `lighten`: Adjust color lightness.
        - `shade`, `tint`: Create variations by mixing with black/white.
        - `contrast`: Calculate contrast ratios between colors.
        - `complementary`: Find the opposite color on the color wheel.
        - `blend`: Mix colors.
        - `grayscale`, `invert`: Convert to grayscale or invert colors.

## 6.0.3

- Updated some documentation.

## 6.0.2

### Breaking Changes

- **Renamed Method:** The `listenableBuilder` method has been renamed to `builder` in the
  `extension on ValueListenable`.
- **Refactored Notifier Classes**: Methods previously available as extensions on ValueNotifier<T> have been moved
  directly into the corresponding notifier classes (e.g., toggle for BoolNotifier, increment for IntNotifier).

### New Features

- Introduced `ListenablesBuilder`: A widget for building UI in response to changes in multiple listenable objects (
  `List<Listenable>`). it also has  `buildWhen` and `threshold` properties for more granular control over rebuild
  behavior.
- **Listenable Extensions:** Added `builder` methods to easily create `ListenableBuilder` (for single listeners) and
  `ListenablesBuilder`(for multiple listeners) widgets.

### Fixes & Enhancements

- Updated `dart_helper_util` to [v2.1.0](https://pub.dev/packages/dart_helper_utils/changelog#210).
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
- Enhanced and moved all `isEqual` methods (Map, Set, List, global) to [
  `dart_helper_utils`](https://pub.dev/packages/dart_helper_utils).

### BREAKING CHANGES

- The `dart_helper_utils` v2.0.0 upgrade introduces breaking changes. Review
  the [changelog](https://pub.dev/packages/dart_helper_utils/changelog#200) for detailed information and update your
  code accordingly.

## 4.4.0

- Added `copy` methods to all TextStyle properties in ThemeData (e.g., `displayLargeCopy`, `headlineMediumCopy`, etc.).
  This allows quickly using copyWith on text style with minimal code, for example,
  Use  `theme.displayLargeCopy(color: Colors.red)` instead of `theme.displayLarge?.copyWith(color: Colors.red)`
- Added `refresh` method to all specialized notifiers to allow force `notifyListeners` without changing value
  of `ValueNotifier`.

- Updated `dart_helper_util` to [v1.2.0](https://pub.dev/packages/dart_helper_utils/changelog#120).

## 4.3.0

- Added `setDart`, `setLight`, and `setSystem` to `BrightnessNotifier`, and `ThemeModeNotifier`.
- Added `modalRoute()` to the context extension for convenient access to the current ModalRoute.
- Added the `usePopUntil` parameter to the `context.dismissActivePopup` (default: `true`):
    - If `true`, uses `popUntil` for efficient dismissal of multiple pop-ups.
    - If `false`, uses `recursion` (might be necessary for compatibility reasons).
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

- No changes are necessary from your side as `flutter_helper_utils` now
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

- Fixed mime checks aren't exported.

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
  or '3.0.5,' I encourage you to upgrade.

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

- Added a New Uri extension to help convert string (supports nullable strings) link to uri, `toUri` and `toPhoneUri`.

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
  This allows for more accurate representation of large numbers, such as converting 1,000,000,000 to 1.0B.

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

- **NEW**: Added `showMaterialBanner`, `showSnackBar`, `hideCurrentMaterialBanner`, `hideCurrentSnackBar`,
  `removeCurrentMaterialBanner`, `removeCurrentSnackBar`, `clearMaterialBanners`, `clearSnackBars`
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

- **UPDATE**: Use MediaQuery as InheritedModel to improve performance, see
  this [pull](https://github.com/flutter/flutter/pull/114459) in flutter for more info.

## 1.3.6

- **NEW**: Added `isValidHttpCode` in `num?` extension that returns true if the http response code is 200 or 201.
- **NEW**: Added `toDateWithFormat` in a String extension that converts string to `DateTime` with specific format
  e.g., `d-M-y`.

&nbsp;
*Usage*:

  ```dart

final dateTime = '14-12-2030'.toDateWithFormat('d-M-y');
  ```

## 1.3.5

- **NEW**: Added `binary` in bool extension that returns `1` if true and `0` if false as `int`.

## 1.3.4

- **NEW**: Added `tryRemoveAt`, `indexOfOrNull`, `indexWhereOrNull`, and `tryRemoveWhere` on `List<T>?` extension.
- **UPDATE**: Update the package
  to [FlutterSDK 3.10](https://docs.flutter.dev/release/release-notes/release-notes-3.10.0).
- **FIX**: Fixed a bug with `isNotNull` on `Object` extension.

## 1.3.3

- **NEW**: Added `DatesHelper` class that provide a set of static methods for DateTime such
  as `isSameHour`, `diffInDays`, and `daysInRange`.
- **NEW**: Added the getters `isPresent`, `isPast`, `passedDuration`, `remainingDays`, and more to the `DateTime`
  extension.
    - Now you can get formatted date using the format method directly in any date e.g `DateTime.now().format('EEE')`

## 1.3.2

- **NEW**: Added `scaffoldMessenger` getter in the `BuildContext` extension to easily
  call `ScaffoldMessenger.of(context)`
- **UPDATE**: Improved implementation of the `toList` and `tryToList` in the `ConvertObject` class.

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

- **HOT FIX**: A fixed bool extension is not exported.

## 1.2.9

- **FIX**: Fixed a bug with `isZero` bool in numbers extensions.
- **UPDATE**: `asBool` support null safety on numbers extensions.
- **UPDATE**: Updated `ParsingException` implementation.

## 1.2.8

- **NEW**: Added `isPositiveOrNull`, `isZeroOrNull`, and `isNegativeOrNull` to all numbers extensions.
- **UPDATE**: on a String extension, `isEmptyOrNull` now returns true if string has only empty lines.

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
- **UPDATE**: on a String extension, `isEmptyOrNull` now returns true if string has only empty lines.

## 1.1.7

- **NEW**: Added `toDateTime` and `tryToDateTime` in `ConvertObject` class.

## 1.1.6

- **NEW**: Added `toMap` and `tryToMap` in `ConvertObject` class, and add `isValidSVG` in a String extension.

## 1.1.5

- **NEW**: Added `toBool` and `tryToBool` in `ConvertObject` class.
- **UPDATE**: Improved all implementations of static methods in `ConvertObject` class.

## 1.1.4

- **NEW**: Supported converting timestamp milliseconds to `DateTime` and added `tryToString` in `ConvertObject` class.

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

- **FIX**: Fixed bug with `isHexColor` in a color extension.

## 1.0.7

- **NEW**: Added new color extension to support converting hex string to color and checking if string is a hex color.

## 1.0.6

- **UPDATE**: Supported null safety to ThemeMode and Brightness.

## 1.0.5

- **UPDATE**: Changed `pop` to `popPage` to solve conflicts with the `get` package.

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
