import 'package:flutter/material.dart';

import 'flutter_extensions.dart';

extension ThemeExtension on BuildContext {
  ThemeData get themeData => Theme.of(this);
  TextTheme get txtTheme => themeData.textTheme;

  Brightness get brightness => themeData.brightness;

  Brightness get sysBrightness => mq.platformBrightness;

  bool get isDark => brightness == Brightness.dark;

  bool get isLight => brightness == Brightness.light;
}

extension ThemeModeEx on ThemeMode? {
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

extension BrightnessExtension on Brightness? {
  bool get isDark => this == Brightness.dark;

  bool get isLight => this == Brightness.light;
}
