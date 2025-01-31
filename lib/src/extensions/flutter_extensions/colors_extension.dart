import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

/// An extension on [Color] that provides a variety of color-manipulation helpers.
///
/// Most operations internally convert the color to the sRGB color space for
/// consistent behavior (for example, when computing luminance or performing
/// HSL transformations).
extension FHUColorExt on Color {
  // ------------------------------------------------------
  //        Basic sRGB alignment
  // ------------------------------------------------------

  /// Ensures this color is in the sRGB color space.
  /// If it isn't, [withValues] is called to convert it.
  Color _toSRGB() {
    return colorSpace == ColorSpace.sRGB
        ? this
        : withValues(colorSpace: ColorSpace.sRGB);
  }

  // ------------------------------------------------------
  //        Light/Dark checks & Contrast
  // ------------------------------------------------------

  /// Returns a contrasting color (e.g., for text) based on whether
  /// this color (in sRGB) is relatively "dark" or "light."
  ///
  /// - [light]: The color to return against a dark background.
  /// - [dark]: The color to return against a light background.
  /// - [threshold]: The WCAG luminance cutoff, above which this color
  ///   is considered "light." Defaults to 0.179 (commonly used in WCAG).
  Color contrastColor({
    Color light = Colors.white,
    Color dark = Colors.black,
    double threshold = 0.179,
  }) {
    final aligned = _toSRGB();
    return aligned.computeLuminance() > threshold ? dark : light;
  }

  /// Determines if this color is considered "dark" in sRGB space,
  /// using the given [threshold].
  ///
  /// If the sRGB relative luminance is <= [threshold], returns `true`.
  bool isDark({double threshold = 0.179}) {
    final aligned = _toSRGB();
    return aligned.computeLuminance() <= threshold;
  }

  /// Determines if this color is considered "light" in sRGB space.
  bool isLight({double threshold = 0.179}) => !isDark(threshold: threshold);

  /// Calculates the contrast ratio (>= 1.0) between this color and [other]
  /// in sRGB space, according to WCAG guidelines.
  double contrast(Color other) {
    final lum1 = _toSRGB().computeLuminance();
    final lum2 = other._toSRGB().computeLuminance();
    return (math.max(lum1, lum2) + 0.05) / (math.min(lum1, lum2) + 0.05);
  }

  // ------------------------------------------------------
  //        Hex & ARGB conversions
  // ------------------------------------------------------

  /// Returns a hex string representation of this color (in sRGB).
  ///
  /// - [leadingHashSign] prepends '#' if `true`.
  /// - [includeAlpha] includes alpha channel if `true`.
  /// - [omitAlphaIfFullOpacity] skips alpha if it is fully opaque.
  /// - [uppercase] returns uppercase hex if `true`.
  ///
  /// For example, `Color(0xFF0000FF)` → `#0000FF` if [includeAlpha] = false,
  /// or `#FF0000FF` if [includeAlpha] = true.
  String toHex({
    bool leadingHashSign = true,
    bool includeAlpha = false,
    bool omitAlphaIfFullOpacity = false,
    bool uppercase = false,
  }) {
    final aligned = _toSRGB();

    // Converts a 0..1 color component to a two-digit hex value.
    String componentToHex(double c) =>
        (c * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');

    final alphaIsFull = aligned.a >= 1.0 - 1e-9; // float rounding
    final needsAlpha = includeAlpha && !(omitAlphaIfFullOpacity && alphaIsFull);

    final alphaHex = needsAlpha ? componentToHex(aligned.a) : '';
    final rHex = componentToHex(aligned.r);
    final gHex = componentToHex(aligned.g);
    final bHex = componentToHex(aligned.b);

    var rawHex = '$alphaHex$rHex$gHex$bHex';
    if (uppercase) {
      rawHex = rawHex.toUpperCase();
    }
    return leadingHashSign ? '#$rawHex' : rawHex;
  }

  /// Converts this color (in sRGB) to a 32-bit ARGB integer.
  /// Useful if you're migrating from older integer-based APIs.
  int toARGBInt() {
    final srgb = _toSRGB();
    return (srgb.a * 255).round().clamp(0, 255) << 24 |
        (srgb.r * 255).round().clamp(0, 255) << 16 |
        (srgb.g * 255).round().clamp(0, 255) << 8 |
        (srgb.b * 255).round().clamp(0, 255);
  }

  // ------------------------------------------------------
  //        Brightness adjustments
  // ------------------------------------------------------

  /// Darkens the color in sRGB HSL by the given [amount], from 0.0 to 1.0.
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1,
        'Darken amount must be between 0.0 and 1.0');
    final hsl = HSLColor.fromColor(_toSRGB());
    final newLightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor()._toSRGB();
  }

  /// Lightens the color in sRGB HSL by the given [amount], from 0.0 to 1.0.
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1,
        'Lighten amount must be between 0.0 and 1.0');
    final hsl = HSLColor.fromColor(_toSRGB());
    final newLightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor()._toSRGB();
  }

  /// Creates a "shade" by mixing the color with black in sRGB.
  /// [amount] indicates how much black is mixed in.
  Color shade([double amount = 0.1]) {
    assert(
        amount >= 0 && amount <= 1, 'Shade amount must be between 0.0 and 1.0');
    return Color.lerp(_toSRGB(), Colors.black._toSRGB(), amount)!._toSRGB();
  }

  /// Creates a "tint" by mixing the color with white in sRGB.
  /// [amount] indicates how much white is mixed in.
  Color tint([double amount = 0.1]) {
    assert(
        amount >= 0 && amount <= 1, 'Tint amount must be between 0.0 and 1.0');
    return Color.lerp(_toSRGB(), Colors.white._toSRGB(), amount)!._toSRGB();
  }

  // ------------------------------------------------------
  //        Blending & Complement
  // ------------------------------------------------------

  /// Linearly blends this color with [other], in sRGB.
  /// [t] = 0.0 returns this color, 1.0 returns [other].
  Color blend(Color other, [double t = 0.5]) {
    assert(t >= 0 && t <= 1, 'Blend factor must be between 0.0 and 1.0');
    return Color.lerp(_toSRGB(), other._toSRGB(), t)!._toSRGB();
  }

  /// Returns the complementary color (hue + 180°) in sRGB HSL.
  Color complementary() {
    final hsl = HSLColor.fromColor(_toSRGB());
    final newHue = (hsl.hue + 180.0) % 360.0;
    return hsl.withHue(newHue).toColor()._toSRGB();
  }

  // ------------------------------------------------------
  //        Grayscale & Inversion
  // ------------------------------------------------------

  /// Converts this color to grayscale in sRGB, preserving its alpha.
  /// Uses the linear luminance from [computeLuminance], then re-applies
  /// the sRGB transfer function for a more perceptually accurate gray.
  Color grayscale() {
    final aligned = _toSRGB();
    final y = aligned.computeLuminance(); // linear luminance

    // Convert that luminance back to sRGB gamma-encoded space.
    double srgbValue;
    if (y <= 0.0031308) {
      srgbValue = y * 12.92;
    } else {
      srgbValue = 1.055 * math.pow(y, 1 / 2.4) - 0.055;
    }

    return Color.from(
      alpha: aligned.a,
      red: srgbValue,
      green: srgbValue,
      blue: srgbValue,
    );
  }

  /// Inverts the sRGB components, i.e., (R,G,B) → (1-R, 1-G, 1-B).
  /// Alpha is preserved.
  Color invert() {
    final aligned = _toSRGB();
    return Color.from(
      alpha: aligned.a,
      red: 1.0 - aligned.r,
      green: 1.0 - aligned.g,
      blue: 1.0 - aligned.b,
    );
  }

  // ------------------------------------------------------
  //        Opacity & Channel Helpers
  // ------------------------------------------------------

  /// Returns a new color with the given normalized [opacity] (0.0..1.0).
  Color addOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0,
        'Opacity must be between 0.0 and 1.0.');
    return withValues(alpha: opacity);
  }

  /// Scales the current alpha by [factor], keeping the same color space.
  Color scaleOpacity(double factor) {
    assert(factor >= 0.0 && factor <= 1.0,
        'Scale factor must be between 0.0 and 1.0.');
    return withValues(alpha: a * factor);
  }

  /// Sets the alpha channel from a 0-255 [alpha] value.
  Color addAlpha(int alpha) {
    assert(alpha >= 0 && alpha <= 255, 'Alpha must be between 0 and 255.');
    return withValues(alpha: alpha / 255.0);
  }

  /// Sets the red channel from a 0-255 [red] value.
  Color addRed(int red) {
    assert(red >= 0 && red <= 255, 'Red must be between 0 and 255.');
    return withValues(red: red / 255.0);
  }

  /// Sets the green channel from a 0-255 [green] value.
  Color addGreen(int green) {
    assert(green >= 0 && green <= 255, 'Green must be between 0 and 255.');
    return withValues(green: green / 255.0);
  }

  /// Sets the blue channel from a 0-255 [blue] value.
  Color addBlue(int blue) {
    assert(blue >= 0 && blue <= 255, 'Blue must be between 0 and 255.');
    return withValues(blue: blue / 255.0);
  }

  // ------------------------------------------------------
  //        ColorSpace & Approx Comparison
  // ------------------------------------------------------

  /// Converts this color to the specified [targetSpace], if not already.
  Color convertToColorSpace(ColorSpace targetSpace) {
    if (colorSpace == targetSpace) return this;
    return withValues(colorSpace: targetSpace);
  }

  /// Checks if the color's color space matches [targetSpace].
  bool isInColorSpace(ColorSpace targetSpace) {
    return colorSpace == targetSpace;
  }

  /// Checks approximate equality in sRGB space, using an [epsilon] tolerance.
  bool isApproximately(Color other, {double epsilon = 0.001}) {
    final c1 = _toSRGB();
    final c2 = other._toSRGB();
    return (c1.a - c2.a).abs() < epsilon &&
        (c1.r - c2.r).abs() < epsilon &&
        (c1.g - c2.g).abs() < epsilon &&
        (c1.b - c2.b).abs() < epsilon;
  }
}

/// An extension on [String] that provides utility methods
/// for hex color parsing (including short-hex, #RGB or #RGBA, etc.)
extension FHUStringToColorExtensions on String {
  /// Determines whether the string is a valid hexadecimal color code.
  ///
  /// A valid hex color code:
  /// - Can optionally start with a `#`.
  /// - Must contain exactly **3, 4, 6, or 8** hexadecimal digits (`0-9`, `a-f`, `A-F`).
  ///   - **3 digits**: Short form (`RGB`), e.g., `#abc`
  ///   - **4 digits**: Short form with alpha (`RGBA`), e.g., `#abcd`
  ///   - **6 digits**: Full form (`RRGGBB`), e.g., `#aabbcc`
  ///   - **8 digits**: Full form with alpha (`RRGGBBAA`), e.g., `#aabbccdd`
  ///
  /// Returns `true` if the string matches the hex color pattern, otherwise `false`.
  ///
  /// Example usage:
  /// ```dart
  /// print('#ff5733'.isHexColor); // true
  /// print('ff5733'.isHexColor);  // true
  /// print('#abcd'.isHexColor);   // true
  /// print('12345'.isHexColor);   // false (invalid length)
  /// print('#xyz'.isHexColor);    // false (invalid characters)
  /// ```
  bool get isHexColor {
    return RegExp(
            r'^#?(?:[0-9a-fA-F]{3}|[0-9a-fA-F]{4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$')
        .hasMatch(this);
  }

  /// Attempts to convert this string to an sRGB [Color].
  /// Returns `null` if parsing fails.
  ///
  /// Supports:
  /// - #RGB or RGB
  /// - #RGBA or RGBA
  /// - #RRGGBB or RRGGBB
  /// - #RRGGBBAA or RRGGBBAA
  ///
  /// Example usage:
  /// ```dart
  /// final color = "#349".toColor;       // => Color(0xFF334499)
  /// final color2 = "FF334499".toColor;  // => Color(0xFF334499)
  /// ```
  Color? get toColor {
    if (!isHexColor) return null;

    // Remove '#'
    var hex = replaceAll('#', '');

    // If it's 3 or 4 chars, expand to 6 or 8 chars by duplicating each nibble
    // e.g. "abc" => "aabbcc", "abcd" => "aabbccdd"
    if (hex.length == 3 || hex.length == 4) {
      hex = hex.split('').map((c) => c * 2).join();
    }

    // If it's now 6 chars, prepend "FF" for the alpha channel.
    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    // Now it should be 8 chars (ARGB).
    final value = int.tryParse(hex, radix: 16);
    if (value == null) return null;

    // Construct a color in the default sRGB space.
    return Color(value);
  }
}
