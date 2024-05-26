import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

class ThemeModeNotifier extends ValueNotifier<ThemeMode> {
  ThemeModeNotifier(super.value);
}

extension ThemeModeNotifierEx on ValueNotifier<ThemeMode> {
  bool get isDark => value.isDark;

  bool get isLight => value.isLight;

  bool get isSystem => value.isSystem;
}

class BrightnessNotifier extends ValueNotifier<Brightness> {
  BrightnessNotifier(super.value);
}

extension BrightnessNotifierEx on ValueNotifier<Brightness> {
  bool get isDark => value.isDark;

  bool get isLight => value.isLight;
}
