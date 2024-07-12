import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

class ThemeModeNotifier extends ValueNotifier<ThemeMode> {
  ThemeModeNotifier(super.value);

  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (_) {}
  }

  void refresh() => notifyListeners();

  /// similar to value setter but this one force trigger the notifyListeners()
  /// event if newValue == value.
  void update(ThemeMode newValue) {
    value = newValue;
    refresh();
  }
}

extension ThemeModeNotifierEx on ValueNotifier<ThemeMode> {
  bool get isDark => value.isDark;

  bool get isLight => value.isLight;

  bool get isSystem => value.isSystem;

  void setDart() => value = ThemeMode.dark;

  void setLight() => value = ThemeMode.light;

  void setSystem() => value = ThemeMode.system;
}

class BrightnessNotifier extends ValueNotifier<Brightness> {
  BrightnessNotifier(super.value);

  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (_) {}
  }

  void refresh() => notifyListeners();

  /// similar to value setter but this one force trigger the notifyListeners()
  /// event if newValue == value.
  void update(Brightness newValue) {
    value = newValue;
    refresh();
  }
}

extension BrightnessNotifierEx on ValueNotifier<Brightness> {
  bool get isDark => value.isDark;

  bool get isLight => value.isLight;

  void setDart() => value = Brightness.dark;

  void setLight() => value = Brightness.light;
}
