# MediaQueryExtension in `flutter_helper_utils`

## Overview

`MediaQueryExtension` in the `flutter_helper_utils` package offers a set of extensions on `BuildContext` to ease and speed up the access to these properties.

### Quick Access to MediaQueryData

```dart
final mediaQueryData = context.mq;
```

### Nullable MediaQueryData Access

You can access `MediaQueryData` safely, returning `null` if not available.

```dart
final mediaQueryData = context.nullableMQ;
```

### Device Orientation

Get the device orientation, either landscape or portrait.

```dart
final orientation = context.deviceOrientation;
```

### Navigation Mode

Retrieve the device's navigation mode.

```dart
final navMode = context.navigationMode;
```

### Screen Padding and Insets

Get the screen's padding and view insets. This is useful when you want to account for elements like notches, the system status bar, or software keyboards.

```dart
final padding = context.padding;
final viewInsets = context.viewInsets;
```

### Screen Dimensions

Easy access to screen width, height, shortest and longest side.

```dart
final width = context.widthPx;
final height = context.heightPx;
final shortest = context.shortestSide;
final longest = context.longestSide;
```

### Additional Features

You can get the device's pixel ratio, text scale factor, and accessibility settings like `boldText`, `disableAnimations`, etc., directly from the context.

```dart
final pixelRatio = context.pixelRatio;
final textFactor = context.txtScaleFactor;
final isBoldText = context.boldText;
```

## Example Usage

Here's an example that shows how to use some of these extensions in a Flutter app.

```dart
class MyResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MediaQueryExtension to fetch screen width
    double screenWidth = context.widthPx;
    
    // Determine device orientation
    bool isLandscape = context.isLandscape;
    
    return Container(
      width: isLandscape ? screenWidth / 2 : screenWidth,
      child: Text('Hello, Responsive World!'),
    );
  }
}
```

By incorporating `MediaQueryExtension`, you can significantly reduce boilerplate code and make your applications more readable and maintainable.