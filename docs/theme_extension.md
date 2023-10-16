# ThemeExtension in `flutter_helper_utils`

## Overview

The `ThemeExtension` in the `flutter_helper_utils` package provides a set of extensions on `BuildContext` that simplify access to various theme properties. This makes working with themes more intuitive and reduces boilerplate code.

### themeData

Quickly get the current `ThemeData` from the nearest `Theme` widget ancestor in the widget tree.

```dart
final theme = context.themeData;
```

### txtTheme

Effortlessly obtain the `TextTheme` for your context.

```dart
final textTheme = context.txtTheme;
```

### brightness

Determine the brightness setting of the system and the app theme. This is useful for toggling between light and dark modes.

```dart
final themeBrightness = context.brightness;
final systemBrightness = context.sysBrightness;
```

### sysBrightness

Determine the brightness setting of the system and the app theme. This is useful for toggling between light and dark modes.

```dart
final themeBrightness = context.brightness;
final systemBrightness = context.sysBrightness;
```

### isDark and isLight

Convenient booleans to quickly check if the current theme is dark or light.

```dart
final isDarkMode = context.isDark;
final isLightMode = context.isLight;
```


## Example Usage

Here is an example that shows how to use these extensions to dynamically change the text color based on the current theme's brightness.

```dart
class ThemedText extends StatelessWidget {
  final String text;

  ThemedText(this.text);

  @override
  Widget build(BuildContext context) {
    // Access text theme and brightness
    final textTheme = context.txtTheme;
    final isDarkMode = context.isDark;

    return Text(
      text,
      style: textTheme.bodyText1?.copyWith(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
```

Utilizing `ThemeExtension` from `flutter_helper_utils` will make your code cleaner and more maintainable while working with themes.