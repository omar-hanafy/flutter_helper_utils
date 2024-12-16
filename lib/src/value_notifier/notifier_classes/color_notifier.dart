import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

/// allows to quickly create a ValueNotifier of type Color.
class ColorNotifier extends ValueNotifier<Color> {
  ColorNotifier(super.initial);

  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (_) {}
  }

  void refresh() => notifyListeners();

  /// similar to value setter but this one force trigger the notifyListeners()
  /// event if newValue == value.
  void update(Color newValue) {
    value = newValue;
    refresh();
  }
}

/// Extension: ColorValueNotifierExtension
///
/// Description:
/// Adds convenience methods to `ValueNotifier<Color>` for managing color state changes
///
/// Example:
/// ```dart
/// final colorValueNotifier = Colors.blue.notifier;
/// colorValueNotifier.withOpacity(0.5);
/// ```
extension FHUColorValueNotifierExtension on ValueListenable<Color> {
  /// The alpha channel of this color in an 8 bit value.
  ///
  /// A value of 0 means this color is fully transparent. A value of 255 means
  /// this color is fully opaque.
  double get alpha => value.a;

  /// **Deprecated:** Use [alpha] instead.
  ///
  /// The alpha channel of this color as a double.
  ///
  /// A value of 0.0 means this color is fully transparent. A value of 1.0 means
  /// this color is fully opaque.
  @Deprecated('Use alpha instead. This will be removed in future versions.')
  double get opacity => value.a;

  /// The red channel of this color in an 8 bit value.
  double get red => value.r;

  /// The green channel of this color in an 8 bit value.
  double get green => value.g;

  /// The blue channel of this color in an 8 bit value.
  double get blue => value.b;

  /// Returns a new color that matches this color with the alpha channel
  /// replaced with `a` (which ranges from 0 to 255).
  ///
  /// Out of range values will have unexpected effects.
  Color withAlpha(int a) => value.withAlpha(a);

  /// Returns a new color that matches this color with the alpha channel
  /// replaced with the given `opacity` (which ranges from 0.0 to 1.0).
  ///
  /// Out of range values will have unexpected effects.
  Color withOpacity(double opacity) => value.addOpacity(opacity);

  /// Returns a new color that matches this color with the red channel replaced
  /// with `r` (which ranges from 0 to 255).
  ///
  /// Out of range values will have unexpected effects.
  Color withRed(int r) => value.withRed(r);

  /// Returns a new color that matches this color with the green channel
  /// replaced with `g` (which ranges from 0 to 255).
  ///
  /// Out of range values will have unexpected effects.
  Color withGreen(int g) => value.withGreen(g);

  /// Returns a new color that matches this color with the blue channel replaced
  /// with `b` (which ranges from 0 to 255).
  ///
  /// Out of range values will have unexpected effects.
  Color withBlue(int b) => value.withBlue(b);

  /// Returns a brightness value between 0 for darkest and 1 for lightest.
  ///
  /// Represents the relative luminance of the color. This value is computationally
  /// expensive to calculate.
  ///
  /// See <https://en.wikipedia.org/wiki/Relative_luminance>.
  double computeLuminance() => value.computeLuminance();
}
