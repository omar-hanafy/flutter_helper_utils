import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/src/extensions/flutter_extensions/flutter_extensions.dart';

extension FHUThemeExtension on BuildContext {
  ThemeData get themeData => Theme.of(this);

  TextTheme get txtTheme => themeData.textTheme;

  Brightness get brightness => themeData.brightness;

  Brightness get sysBrightness => mq.platformBrightness;

  bool get isDark => brightness == Brightness.dark;

  bool get isLight => brightness == Brightness.light;
}

extension FHUThemeDataExtension on ThemeData {
  bool get isDark => brightness == Brightness.dark;

  bool get isLight => brightness == Brightness.light;

  TextStyle? get displayLarge => textTheme.displayLarge;

  TextStyle? get displayMedium => textTheme.displayMedium;

  TextStyle? get displaySmall => textTheme.displaySmall;

  TextStyle? get headlineLarge => textTheme.headlineLarge;

  TextStyle? get headlineMedium => textTheme.headlineMedium;

  TextStyle? get headlineSmall => textTheme.headlineSmall;

  TextStyle? get titleLarge => textTheme.titleLarge;

  TextStyle? get titleMedium => textTheme.titleMedium;

  TextStyle? get titleSmall => textTheme.titleSmall;

  TextStyle? get bodyLarge => textTheme.bodyLarge;

  TextStyle? get bodyMedium => textTheme.bodyMedium;

  TextStyle? get bodySmall => textTheme.bodySmall;

  TextStyle? get labelLarge => textTheme.labelLarge;

  TextStyle? get labelMedium => textTheme.labelMedium;

  TextStyle? get labelSmall => textTheme.labelSmall;
}

extension FHUThemeModeEx on ThemeMode? {
  Brightness getBrightness(BuildContext context) {
    switch (this) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        return context.sysBrightness;
      case null:
        return context.sysBrightness;
    }
  }

  bool get isDark => this == ThemeMode.dark;

  bool get isLight => this == ThemeMode.light;

  bool get isSystem => this == ThemeMode.system;
}

extension FHUBrightnessExtension on Brightness? {
  bool get isDark => this == Brightness.dark;

  bool get isLight => this == Brightness.light;
}
