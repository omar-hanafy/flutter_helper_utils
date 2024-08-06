# Adaptive UI with Platform Type Detection

This documentation is part of the [flutter_helper_utils](https://pub.dev/packages/flutter_helper_utils) package

## Features

- **Efficient:** Rebuild widgets only when the platform type changes, not on every size change.
- **Native Dart:** Built with native Dart code, no 3rd party dependencies are used.
- **Easy Access:** Use context extensions to easily get platform and orientation details.
- **Customizable:** Define your own breakpoints and helper extensions.

## Usage

### 1. Wrap with PlatformTypeProvider

Wrap the root of your application with `PlatformTypeProvider` to make platform and orientation information accessible throughout your widget tree.

```dart
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

runApp(PlatformTypeProvider(child: MyApp()));
```

### 2. Build UI Using Context Extensions

Leverage context extensions for a streamlined approach to building adaptive UIs:

```dart
@override
Widget build(BuildContext context) {
  final breakpoint = context.breakpoint; // Automatically rebuilds when the breakpoint changes
  return breakpoint.isMobile ? const MobileLayout() : const TabletLayout();
}
```

**Other context extensions:**

* `context.platformSizeInfo`:  Provides `orientation`, `platform`, and `breakpoint` information, rebuilding the widget when any of these values change.
* `context.deviceOrientation`: Offers the current orientation (rebuilds on change).

### 3. Build UI Using Layout Builder Widgets

#### BreakpointLayoutBuilder

Use this to build widgets based solely on the current breakpoint (e.g., mobile, tablet).

```dart
BreakpointLayoutBuilder(
  builder: (context, breakpoint) {
    if (breakpoint.isMobile) {
      // Mobile layout
    } else if (breakpoint.isTablet) {
      // Tablet layout
    } else if (breakpoint.isDesktop) {
      // Desktop layout
    } // ... (add more conditions for other breakpoints)
  },
);
```

#### PlatformInfoLayoutBuilder

This widget provides both the platform type and orientation for building your UI:

```dart
PlatformInfoLayoutBuilder(
  builder: (context, platformSizeInfo) {
    // Access platform, breakpoint, and orientation
    if (platformSizeInfo.breakpoint.isMobile) {
      // Mobile layout
    } // ... (add more conditions)
  },
);
```

## Customizing Breakpoints

The `PlatformTypeProvider` widget lets you build responsive layouts by defining breakpoints for different screen sizes. It comes with default breakpoints for mobile, tablet, and desktop devices, but you can easily customize these or create your own to match your app's unique requirements.

### Default Breakpoints

The package provides default breakpoints to get you started:

- `mobileBreakPoint`:  `Size(600, 800)`
- `tabletBreakPoint`: `Size(1200, 1600)`
- `desktopBreakPoint`: `Size(1800, 2400)`

You can use these directly or as a basis for customization:

```dart
const smallerMobileBreakpoint = mobileBreakPoint.copyWith(
   name: 'mobileSmall', 
   width: 360
);
```

### Defining and Using Custom Breakpoints

Create a `Breakpoint` instance with your desired size and a unique name:

```dart
const watchBreakPoint = Breakpoint(size: Size(250, 250), name: 'watch');
```

**To use your custom breakpoint**, pass it to the `PlatformTypeProvider`:

```dart
PlatformTypeProvider(
  breakpoints: [
    watchBreakPoint, // Your custom breakpoint
    ...Breakpoint.defaults, // Include default breakpoints if needed
  ],
  child: MyApp(),
),
```

Now, within your `BreakpointLayoutBuilder`, you can easily check for your custom breakpoint:

```dart
BreakpointLayoutBuilder(
  builder: (context, breakpoint) {
    if (breakpoint.isWatch) { 
      // Render a watch-specific UI
    } else if (breakpoint.isMobile) {
      // Render a mobile UI
    }  // ... and so on
  },
);
```

**Important Note:** When defining your own breakpoints, consider screen dimensions and pixel densities for various watch models.

### Extending Breakpoint Functionality

To make your breakpoint logic more readable and reusable, create extensions:

```dart
extension CustomBreakpoint on Breakpoint {
  bool get isWatch => match('watch');  
}

if (breakpoint.isWatch) {
  // Watch-specific layout
}
```

**Complete Example with customizations** 

```dart
import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

const watchBreakPoint = Breakpoint(size: Size(250, 250), name: 'watch');

extension CustomBreakpointEx on Breakpoint {
  bool get isWatch => match('watch');
}

void main() {
  runApp(
    PlatformTypeProvider(
      breakpoints: [
        watchBreakPoint,
        ...Breakpoint.defaults,
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive UI',
      home: BreakpointLayoutBuilder(
        builder: (context, breakpoint) {
          if (breakpoint.isWatch) {
            // Render a watch-specific UI
          } else if (breakpoint.isMobile) {
            // Render a mobile UI
          } // ... and so on
        },
      ),
    );
  }
}
```
