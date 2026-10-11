# Version 10.0.0

Version 10 moves Material-specific APIs from Flutter's SDK Material library to
[`material_ui`](https://pub.dev/packages/material_ui). Upgrade from the published
9.2.1 release with Flutter **3.47.7 or newer** and Dart **3.13.5 or newer**.

## Dependencies and imports

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_helper_utils: ^10.0.0
  material_ui: ^1.6.0
```

Declare `material_ui` directly when your app imports it. Keep the existing FHU
main or `sugar.dart` import, and replace SDK Material imports in migrated code:

```dart
import 'package:material_ui/material_ui.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
```

FHU exports its helpers and `dart_helper_utils`; it does **not** re-export the
Material library. Avoid importing both Material libraries without prefixes in
the same file. The shared Flutter `BuildContext`, `Widget`, `Color`,
`TextStyle`, `Navigator`, and `Route` primitives retain their identity.

## Material types and widget ancestors

The similarly named Material types in the two libraries are different types.
Switch explicit type annotations, theme construction, controllers, and widget
ancestors together:

| Affected surface | Version 10 contract |
| --- | --- |
| `context.themeData`, `textTheme`, `primaryTextTheme`, `colorScheme`, component theme getters | `material_ui` theme types and inherited widgets |
| ThemeData, TextTheme, ColorScheme extensions and `toThemeData()` | Extend or produce `material_ui` types |
| `ThemeMode` extensions, `context.targetPlatform`, nullable-context platform predicates | Read or extend `material_ui` themes and types |
| `context.materialLocalizations` | Read `material_ui` localizations |
| `context.defaultTabController`, `defaultTabControllerOrNull` | Return `material_ui.TabController` from a modern `DefaultTabController` |
| `context.scaffold`, `scaffoldOrNull` | `material_ui.ScaffoldState` from a `material_ui.Scaffold` |
| Scaffold messenger helpers, `showSnackBar`, `showMaterialBanner` | `material_ui` state, widgets, controllers, and close-reason enums |
| `context.pushPage` and other widget-to-page helpers | Construct `material_ui.MaterialPageRoute` |
| Carousel helpers | Extend `material_ui.CarouselController` |
| `ThemeWithoutEffects`, typed-list scrollbars, and `TypedListView(onRefresh:)` | Use `material_ui` themes, Scrollbar, and RefreshIndicator |

For example, `ThemeData theme = context.themeData` compiles when `ThemeData`
comes from `material_ui`. It cannot be assigned to an SDK Material `ThemeData`.
An SDK Material `CarouselController` no longer receives FHU carousel extensions.
Use a `material_ui.MaterialApp` and migrate the `Scaffold`, theme, and feedback
widgets that participate in these helpers. An SDK Material app cannot provide
these Material-specific ancestors merely by changing an import in a leaf file.

`context.popPage()` still requests `Navigator.maybePop`, so `PopScope` may veto
it. The deprecated `context.maybePopPage()` alias remains available.
`context.forcePopPage()` still calls `Navigator.pop`. Route-taking and
named-route helpers continue to use Flutter's shared navigation primitives.

## Temporary support for legacy widgets

`material_ui` 1.6.0 includes `MaterialUiCompatibilityBridge` for third-party
widgets that still use SDK Material. It wraps a subtree under a modern Material
app with a mapped **legacy theme and legacy localizations**. The bridge is
already deprecated and is intended only while dependencies migrate.

It does not convert Material objects or controllers, supply a legacy Scaffold
or ScaffoldMessenger state, make the two Material type systems interchangeable,
or provide modern ancestors under a legacy app. Its theme mapping copies a
subset of theme data; do not rely on it to preserve arbitrary theme extensions
or every component theme. Migrate the app's own Material code, and verify any
remaining legacy subtree on the platforms you support.

## Dart helper dependency floor

Version 10 requires `dart_helper_utils >=6.1.0 <7.0.0` and `intl >=0.20.3 <0.21.0`.
The main FHU import continues to export the whole Dart helper surface, including
`stringo` through `dart_helper_utils`. Version 9.2.1 already allowed resolving
Dart Helper Utils 6.1.0, so this change raises the minimum rather than adding a
new FHU string API.

If your old lockfile used Dart Helper Utils 6.0.x, review its 6.1.0 migration:
ordinary calls such as `'value'.toSnakeCase` stay available, but explicit
extension names for moved string helpers now use `StringCaseExtensions`,
`NullableStringCaseExtensions`, `StringTransformExtensions`,
`NullableStringTransformExtensions`, and `StringChecksExtensions`.
`toTitleCase`/`toTitle` now capitalize a leading stop word, and `mask` rejects
negative visible counts with `ArgumentError`.

## Corrected helper behavior

`textSize` now works without an ambient context, using left-to-right,
single-line text measurement and treating null as empty text. It no longer
throws because TextPainter lacks a direction.

`MultiTapDetector.duration` now controls the rolling gap between taps, including
custom gaps shorter or longer than the SDK's default tap timeout. Progress
resets after completion, timeout, or gesture cancellation, and reports `0` on
reset. A competing scroll gesture can cancel the tap sequence.

`TypedListView.onEndReached` ignores nested scrollables and serializes requests:
another request cannot start until the returned future completes. The existing
`isLoadingMore` flag also suppresses requests. Return the complete loading
operation from the callback so the list can track it across rebuilds.

## Verify the upgrade

Run `flutter pub get`, `flutter analyze`, and your test suite after migrating.
Exercise theme lookup, snackbars/banners, page transitions and back handling,
carousels, tab controllers, refresh indicators, and typed-list pagination in a
running app. Compilation alone cannot
prove that migrated inherited widgets or legacy subtrees behave correctly.

# Version 9.0.0

## Summary

Version 9 tightens the package surface and removes legacy compatibility APIs.

The biggest changes are:

- notifier utilities moved to `better_value_notifier`
- root exports simplified to `flutter_helper_utils.dart` and `sugar.dart`
- deprecated color `add*` aliases removed
- `GradientWidget.gradientAlignment` removed
- v9 naming finalized for navigation, focus, and snapshot helpers

## Imports

### Main import

```dart
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
```

### Opt-in sugar import

```dart
import 'package:flutter_helper_utils/sugar.dart';
```

### Removed root files

These old root files were removed:

- `core.dart`
- `colors.dart`
- `widgets.dart`

Use `flutter_helper_utils.dart` instead.

## Notifier Extraction

All notifier-related APIs moved to
`package:better_value_notifier/better_value_notifier.dart`.

### Add the package

```yaml
dependencies:
  flutter_helper_utils: ^9.0.0
  better_value_notifier: <latest_version>
```

### Update imports

```dart
// Before
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

// After
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:better_value_notifier/better_value_notifier.dart';
```

## Color API Cleanup

The deprecated color aliases were removed:

```dart
// Removed in v9
color.addOpacity(0.5);
color.addAlpha(128);
color.addRed(255);
color.addGreen(128);
color.addBlue(64);
```

Use the setter-style APIs:

```dart
color.setOpacity(0.5);
color.setAlpha(128);
color.setRed(255);
color.setGreen(128);
color.setBlue(64);
```

### `int.color`

`int.color` is no longer part of the main color surface.

If you still want it, import:

```dart
import 'package:flutter_helper_utils/sugar.dart';
```

## GradientWidget

The deprecated `gradientAlignment` parameter was removed.

```dart
// Before
GradientWidget(
  gradient: myGradient,
  gradientAlignment: Alignment.topLeft,
  child: child,
);

// After
GradientWidget(
  gradient: myGradient,
  child: child,
);
```

Position the gradient through the `Gradient` itself using `begin`, `end`, and
similar properties.

## Navigation

Version 9 keeps the explicit navigation naming on `BuildContext`.

### Removed wrappers

Navigation extensions on `State` and `StatelessWidget` were removed:

```dart
// Removed in v9
state.navigateTo(route: route);
state.navigatePushReplacement(route: route);
state.navigateByRouteName('/settings', args: {...});
```

Use `BuildContext` instead:

```dart
context.pushRoute(route);
context.pushReplacementRoute(route);
context.pushNamedRoute('/settings', arguments: {...});
```

### Renamed methods

| v8 | v9 |
|---|---|
| `context.pReplacement(screen)` | `context.pushReplacementPage(screen)` |
| `context.pAndRemoveUntil(screen, ...)` | `context.pushPageAndRemoveUntil(screen, ...)` |
| `context.pNamed(name, arguments: a)` | `context.pushNamedRoute(name, arguments: a)` |
| `context.pReplacementNamed(name, ...)` | `context.pushReplacementNamedRoute(name, ...)` |
| `context.pNamedAndRemoveUntil(name, predicate, ...)` | `context.pushNamedRouteAndRemoveUntil(name, predicate, ...)` |
| `context.dismissActivePopup(...)` | `context.dismissAllPopups(...)` |

## Focus and Snapshot Helpers

### Focus

```dart
// Before
context.unFocus();

// After
context.unfocus();
```

### AsyncSnapshot

```dart
// Before
snapshot.dataWhen(
  loading: () => const CircularProgressIndicator(),
  error: (error) => Text('$error'),
  success: (data) => Text('$data'),
);

// After
snapshot.when(
  none: (_) => const SizedBox.shrink(),
  waiting: (_) => const CircularProgressIndicator(),
  active: (_) => const CircularProgressIndicator(),
  done: (data) => Text('$data'),
  error: (error, stackTrace, state) => Text('$error'),
);
```

# Version 8.0.0
## SingleAxisWrap Migration Guide

This guide will help you migrate from the old `SingleAxisWrap` implementation to the [new improved version](https://pub.dev/packages/single_axis_wrap) with better RTL support, more consistent alignment, and enhanced features.

### Import the new [package](https://pub.dev/packages/single_axis_wrap)
Add the following to your `pubspec.yaml`:

<a href="https://pub.dev/packages/single_axis_wrap"><img src="https://img.shields.io/pub/v/single_axis_wrap.svg" alt="Pub"></a>
```yaml
dependencies:
  single_axis_wrap: ^<latest version>
```

Import the package:
```dart
import 'package:single_axis_wrap/single_axis_wrap.dart';
```
### Parameter Mapping

Here's how to update your code to use the new parameters:

| Old Parameter                           | New Parameter                  | Notes                                                                 |
|-----------------------------------------|--------------------------------|-----------------------------------------------------------------------|
| `preferredDirection`                    | `primaryDirection`             | Same functionality, renamed for clarity                               |
| `onLayoutModeChanged`                   | `onLayoutDirectionChanged`     | Callback signature changed from `Function(Axis?)` to `Function(Axis)` |
| `rowMainAxisAlignment`                  | `horizontalAlignment`          | Now uses `WrapAlignment` instead of `MainAxisAlignment`               |
| `columnMainAxisAlignment`               | `verticalAlignment`            | Now uses `WrapAlignment` instead of `MainAxisAlignment`               |
| `rowCrossAxisAlignment`                 | `horizontalCrossAxisAlignment` | Now uses `WrapCrossAlignment` instead of `CrossAxisAlignment`         |
| `columnCrossAxisAlignment`              | `verticalCrossAxisAlignment`   | Now uses `WrapCrossAlignment` instead of `CrossAxisAlignment`         |
| `rowSpacing`                            | `horizontalSpacing`            | Same functionality, renamed for consistency                           |
| `columnSpacing`                         | `verticalSpacing`              | Same functionality, renamed for consistency                           |
| `rowTextDirection`                      | `textDirection`                | Simplified: single parameter for both layouts                         |
| `columnTextDirection`                   | *(removed)*                    | Use `textDirection` instead                                           |
| `rowVerticalDirection`                  | `verticalDirection`            | Simplified: single parameter for both layouts                         |
| `columnVerticalDirection`               | *(removed)*                    | Use `verticalDirection` instead                                       |
| `rowTextBaseline`, `columnTextBaseline` | *(removed)*                    | No longer needed with the new alignment system                        |
| `rowMainAxisSize`, `columnMainAxisSize` | *(removed)*                    | No longer needed; sizing is handled automatically                     |
| *N/A*                                   | `spacing`                      | New! Default spacing for both directions                              |
| *N/A*                                   | `maintainLayout`               | New! Controls whether layout persists when constraints change         |

### Code Example: Before and After

#### Old Implementation

```dart
SingleAxisWrap(
  preferredDirection: Axis.horizontal,
  onLayoutModeChanged: (axis) => print("Layout changed to: $axis"),
  clipBehavior: Clip.none,
  // Row configuration:
  rowMainAxisAlignment: MainAxisAlignment.center,
  rowCrossAxisAlignment: CrossAxisAlignment.center,
  rowSpacing: 8.0,
  rowTextDirection: TextDirection.ltr,
  // Column configuration:
  columnMainAxisAlignment: MainAxisAlignment.start,
  columnCrossAxisAlignment: CrossAxisAlignment.stretch,
  columnSpacing: 12.0,
  children: myWidgets,
)
```

#### New Implementation

```dart
SingleAxisWrap(
  primaryDirection: Axis.horizontal,
  onLayoutDirectionChanged: (axis) => print("Layout changed to: $axis"),
  clipBehavior: Clip.none,
  // Universal spacing with direction-specific overrides
  spacing: 8.0,
  verticalSpacing: 12.0,
  // Alignment
  horizontalAlignment: WrapAlignment.center,
  horizontalCrossAxisAlignment: WrapCrossAlignment.center,
  verticalAlignment: WrapAlignment.start,
  verticalCrossAlignment: WrapCrossAlignment.start,
  // Single textDirection for both layouts
  textDirection: TextDirection.ltr,
  // New feature!
  maintainLayout: false,
  children: myWidgets,
)
```

### Alignment Value Mapping

#### Converting MainAxisAlignment to WrapAlignment

| MainAxisAlignment                | WrapAlignment                |
|----------------------------------|------------------------------|
| `MainAxisAlignment.start`        | `WrapAlignment.start`        |
| `MainAxisAlignment.end`          | `WrapAlignment.end`          |
| `MainAxisAlignment.center`       | `WrapAlignment.center`       |
| `MainAxisAlignment.spaceBetween` | `WrapAlignment.spaceBetween` |
| `MainAxisAlignment.spaceAround`  | `WrapAlignment.spaceAround`  |
| `MainAxisAlignment.spaceEvenly`  | `WrapAlignment.spaceEvenly`  |

#### Converting CrossAxisAlignment to WrapCrossAlignment

| CrossAxisAlignment            | WrapCrossAlignment                              |
|-------------------------------|-------------------------------------------------|
| `CrossAxisAlignment.start`    | `WrapCrossAlignment.start`                      |
| `CrossAxisAlignment.end`      | `WrapCrossAlignment.end`                        |
| `CrossAxisAlignment.center`   | `WrapCrossAlignment.center`                     |
| `CrossAxisAlignment.stretch`  | `WrapCrossAlignment.start` (closest equivalent) |
| `CrossAxisAlignment.baseline` | `WrapCrossAlignment.start` (closest equivalent) |

### Using the New Features

#### Layout Persistence

The new `maintainLayout` parameter helps prevent layout flipping between horizontal and vertical when available space changes slightly:

```dart
SingleAxisWrap(
  // ... other parameters
  maintainLayout: true, // Once a layout is chosen, it will stick with it
  children: myWidgets,
)
```

#### Simplified Spacing

The new version provides a cleaner way to specify spacing:

```dart
// Same spacing in both directions
SingleAxisWrap(
  spacing: 8.0,
  children: myWidgets,
)

// Different spacing for each direction
SingleAxisWrap(
  spacing: 8.0, // Default
  horizontalSpacing: 12.0, // Overrides default for horizontal layout
  verticalSpacing: 16.0, // Overrides default for vertical layout
  children: myWidgets,
)
```

### Key Improvements in the New Implementation

- **Better RTL support**: Now correctly handles a right-to-left text direction
- **Layout Persistence**: New `maintainLayout` parameter to prevent unwanted layout changes during animations
- **Simplified API**: More intuitive parameter naming and organization
- **Enhanced Performance**: Improved layout algorithm
- **Consistent Alignment**: Uses the same alignment system as Flutter's built-in `Wrap` widget
