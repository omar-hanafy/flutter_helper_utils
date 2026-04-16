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
