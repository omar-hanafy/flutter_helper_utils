import 'dart:math' as math;

import 'package:flutter/material.dart';

extension FHUHexColor on Color {
  /// Converts the current color to a hex string.
  ///
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  /// Optionally includes the alpha channel if [includeAlpha] is `true` (default is `false`).
  String toHex({bool leadingHashSign = true, bool includeAlpha = false}) {
    final alphaHex =
        includeAlpha ? alpha.toRadixString(16).padLeft(2, '0') : '';
    return leadingHashSign
        ? '#$alphaHex${red.toRadixString(16).padLeft(2, '0')}${green.toRadixString(16).padLeft(2, '0')}${blue.toRadixString(16).padLeft(2, '0')}'
        : '$alphaHex${red.toRadixString(16).padLeft(2, '0')}${green.toRadixString(16).padLeft(2, '0')}${blue.toRadixString(16).padLeft(2, '0')}';
  }

  /// Darkens the color by the given [amount].
  ///
  /// The [amount] should be between 0 and 1, where 0 means no change,
  /// and 1 means the color will be black.
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Lightens the color by the given [amount].
  ///
  /// The [amount] should be between 0 and 1, where 0 means no change,
  /// and 1 means the color will be white.
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Creates a shade of the color by mixing it with black.
  ///
  /// The [amount] should be between 0 and 1, where 0 means no change,
  /// and 1 means the color will be black.
  Color shade([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');
    return Color.lerp(this, Colors.black, amount)!; // Use non-null assertion
  }

  /// Creates a tint of the color by mixing it with white.
  ///
  /// The [amount] should be between 0 and 1, where 0 means no change,
  /// and 1 means the color will be white.
  Color tint([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');
    return Color.lerp(this, Colors.white, amount)!; // Use non-null assertion
  }

  /// Calculates the contrast ratio between this color and another [otherColor].
  /// The contrast ratio is a measure of how distinguishable two colors are from each other.
  /// A higher contrast ratio indicates better readability.
  ///
  /// Returns a double value between 1 and 21, where higher values mean better contrast.
  double contrast(Color otherColor) {
    final luminance1 = computeLuminance();
    final luminance2 = otherColor.computeLuminance();

    return (math.max(luminance1, luminance2) + 0.05) /
        (math.min(luminance1, luminance2) + 0.05);
  }

  /// Returns the complementary color of this color.
  /// The complementary color is the color on the opposite side of the color wheel.
  Color complementary() {
    final hsl = HSLColor.fromColor(this);
    return hsl.withHue((hsl.hue + 180) % 360).toColor();
  }

  /// Blends this color with another [otherColor] by the specified [amount].
  /// The [amount] should be between 0 and 1, where 0 means no blending (this color),
  /// and 1 means fully blended with the [otherColor].
  Color blend(Color otherColor, [double amount = 0.5]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');
    return Color.lerp(this, otherColor, amount)!;
  }

  /// Converts this color to grayscale.
  Color grayscale() {
    final grayValue = (0.299 * red) + (0.587 * green) + (0.114 * blue);
    return Color.fromRGBO(
        grayValue.toInt(), grayValue.toInt(), grayValue.toInt(), opacity);
  }

  /// Inverts this color.
  Color invert() {
    return Color.fromRGBO(255 - red, 255 - green, 255 - blue, opacity);
  }
}

extension FHUColorExt on String {
  /// checks if current string is in hex format or not.
  bool get isHexColor =>
      RegExp(r'^#?(?:[0-9a-fA-F]{3,4}){1,2}$').hasMatch(this);

  /// it tries to convert the current string to Color returns null if failed.
  Color? get toColor {
    if (isHexColor) {
      final buffer = StringBuffer();
      if (length == 6 || length == 7) buffer.write('FF');
      buffer.write(replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }
    return null;
  }
}
