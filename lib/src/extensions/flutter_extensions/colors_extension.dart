import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

extension ColorUtils on Color {
  /// Returns a contrasting color (e.g., for text or icons) based on whether
  /// this color is relatively "dark" or "light" using a [threshold].
  ///
  /// - [light]: The color used against a dark background.
  /// - [dark]: The color used against a light background.
  /// - [threshold]: The WCAG luminance cutoff. Above this => "light" color; below => "dark."
  ///   Defaults to 0.179.
  ///
  /// Example:
  /// ```dart
  /// final background = Color(0xFF000000); // Black
  /// final textColor = background.contrastColor();
  /// // textColor would be white because black is below the threshold.
  /// ```
  Color contrastColor({
    Color light = Colors.white,
    Color dark = Colors.black,
    double threshold = 0.179,
  }) {
    return computeLuminance() > threshold ? dark : light;
  }

  /// Determines if this color is considered "dark" using a [threshold].
  ///
  /// If `relativeLuminance` is **less than or equal** to [threshold],
  /// this color is treated as "dark."
  bool isDark({double threshold = 0.179}) => computeLuminance() <= threshold;

  /// Determines if this color is considered "light" using a [threshold].
  ///
  /// Inversely, returns `true` if `relativeLuminance` is
  /// **greater than** [threshold].
  bool isLight({double threshold = 0.179}) => !isDark(threshold: threshold);

  /// Converts the current color to the sRGB color space if it isn't already.
  /// Certain color operations (like luminance, HSL transformations, etc.)
  /// must be done in sRGB space for consistency.
  ///
  /// Returns a [Color] in the [ColorSpace.sRGB].
  ///
  /// Example:
  /// ```dart
  /// final color = Colors.blue; // Some color in non-sRGB space
  /// final alignedColor = color._toSRGB(); // Now guaranteed to be sRGB
  /// ```
  Color _toSRGB() {
    return colorSpace == ColorSpace.sRGB
        ? this
        : withValues(colorSpace: ColorSpace.sRGB);
  }

  /// Creates a hex string (RGB or ARGB) from this color in the sRGB color space.
  ///
  /// - [leadingHashSign] prepends a `#` to the string if `true`.
  /// - [includeAlpha] includes the alpha channel if `true` (ARGB). By default, only RGB is used.
  /// - [omitAlphaIfFullOpacity] overrides [includeAlpha] if the alpha component is `1.0` (fully opaque).
  ///   If `true`, we skip alpha entirely for fully opaque colors.
  /// - [uppercase] returns uppercase hex digits if `true`.
  ///
  /// ### Examples
  /// ```dart
  /// final color = Colors.blue.withOpacity(0.6);
  ///
  /// // Hex string in ARGB format with # sign and uppercase
  /// final hexWithAlpha = color.toHex(
  ///   leadingHashSign: true,
  ///   includeAlpha: true,
  ///   uppercase: true,
  /// );
  ///
  /// // Hex string in RGB format without # sign and ignoring alpha
  /// final hexWithoutAlpha = color.toHex(
  ///   leadingHashSign: false,
  ///   includeAlpha: false,
  /// );
  /// ```
  String toHex({
    bool leadingHashSign = true,
    bool includeAlpha = false,
    bool omitAlphaIfFullOpacity = false,
    bool uppercase = false,
  }) {
    // Align to sRGB first for predictable 0..255 component values.
    final aligned = _toSRGB();

    // Convert a normalized color component (0..1) to a 2-digit hex value.
    String componentToHex(double c) {
      final intVal = (c * 255.0).round().clamp(0, 255);
      return intVal.toRadixString(16).padLeft(2, '0');
    }

    final alphaIsFull = aligned.a == 1.0;
    final shouldIncludeAlpha =
        includeAlpha && !(omitAlphaIfFullOpacity && alphaIsFull);

    // Build hex segments
    final alphaHex = shouldIncludeAlpha ? componentToHex(aligned.a) : '';
    final rHex = componentToHex(aligned.r);
    final gHex = componentToHex(aligned.g);
    final bHex = componentToHex(aligned.b);

    // Combine to form the final string
    final rawHex = '$alphaHex$rHex$gHex$bHex';
    final prefixedHex = leadingHashSign ? '#$rawHex' : rawHex;
    return uppercase ? prefixedHex.toUpperCase() : prefixedHex;
  }

  /// Darkens the color by the given amount (0.0 to 1.0).
  ///
  /// Internally converts the color to sRGB and uses [HSLColor] for manipulation.
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');
    final aligned = _toSRGB();
    final hsl = HSLColor.fromColor(aligned);
    final newLightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor()._toSRGB();
  }

  /// Lightens the color by the given amount (0.0 to 1.0).
  ///
  /// Internally converts the color to sRGB and uses [HSLColor] for manipulation.
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');
    final aligned = _toSRGB();
    final hsl = HSLColor.fromColor(aligned);
    final newLightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor()._toSRGB();
  }

  /// Creates a shade of the color by mixing it with black.
  ///
  /// [amount] defines how much black is mixed in (0.0 to 1.0).
  Color shade([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');
    final aligned = _toSRGB();
    final black = Colors.black._toSRGB();
    return Color.lerp(aligned, black, amount)!._toSRGB();
  }

  /// Creates a tint of the color by mixing it with white.
  ///
  /// [amount] defines how much white is mixed in (0.0 to 1.0).
  Color tint([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');
    final aligned = _toSRGB();
    final white = Colors.white._toSRGB();
    return Color.lerp(aligned, white, amount)!._toSRGB();
  }

  /// Calculates the contrast ratio between this color and another color.
  ///
  /// Both colors are converted to sRGB, then relative luminance is computed.
  /// The returned value is a ratio >= 1.0, where higher is more contrast.
  double contrast(Color otherColor) {
    final c1 = _toSRGB();
    final c2 = otherColor._toSRGB();
    final lum1 = c1.computeLuminance();
    final lum2 = c2.computeLuminance();
    return (math.max(lum1, lum2) + 0.05) / (math.min(lum1, lum2) + 0.05);
  }

  /// Returns the complementary color (hue + 180°) of this color.
  ///
  /// Converts to sRGB, uses [HSLColor], then returns the complementary color.
  Color complementary() {
    final aligned = _toSRGB();
    final hsl = HSLColor.fromColor(aligned);
    final newHue = (hsl.hue + 180.0) % 360.0;
    return hsl.withHue(newHue).toColor()._toSRGB();
  }

  /// Blends this color with another color by the specified amount.
  ///
  /// [amount] = 0.0 returns this color, [amount] = 1.0 returns the other color.
  /// Converts both to sRGB before blending.
  Color blend(Color otherColor, [double amount = 0.5]) {
    assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');
    final c1 = _toSRGB();
    final c2 = otherColor._toSRGB();
    return Color.lerp(c1, c2, amount)!._toSRGB();
  }

  /// Converts this color to grayscale in sRGB space.
  ///
  /// Uses the standard sRGB luminance coefficients to compute a single-channel
  /// gray, then creates a new sRGB color with that gray value.
  Color grayscale() {
    final aligned = _toSRGB();
    // Compute a gray value from sRGB components (not converting to linear here, just a basic approximation).
    final gray = 0.299 * aligned.r + 0.587 * aligned.g + 0.114 * aligned.b;
    return Color.from(alpha: aligned.a, red: gray, green: gray, blue: gray);
  }

  /// Inverts this color in sRGB space.
  ///
  /// (R,G,B) -> (1-R, 1-G, 1-B)
  Color invert() {
    final aligned = _toSRGB();
    return Color.from(
      alpha: aligned.a,
      red: 1.0 - aligned.r,
      green: 1.0 - aligned.g,
      blue: 1.0 - aligned.b,
    );
  }

  /// Adds or overrides the opacity (alpha channel) of this color using `withValues`.
  Color addOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0,
        'Opacity must be between 0.0 and 1.0.');
    return withValues(alpha: opacity);
  }

  /// Replaces the alpha channel (0-255) of this color, similar to `withAlpha` but updated.
  Color addAlpha(int alpha) {
    assert(alpha >= 0 && alpha <= 255, 'Alpha must be between 0 and 255.');
    return withValues(alpha: alpha / 255.0);
  }

  /// Replaces the red channel (0-255) of this color, similar to `withRed` but updated.
  Color addRed(int red) {
    assert(red >= 0 && red <= 255, 'Red must be between 0 and 255.');
    return withValues(red: red / 255.0);
  }

  /// Replaces the green channel (0-255) of this color, similar to `withGreen` but updated.
  Color addGreen(int green) {
    assert(green >= 0 && green <= 255, 'Green must be between 0 and 255.');
    return withValues(green: green / 255.0);
  }

  /// Replaces the blue channel (0-255) of this color, similar to `withBlue` but updated.
  Color addBlue(int blue) {
    assert(blue >= 0 && blue <= 255, 'Blue must be between 0 and 255.');
    return withValues(blue: blue / 255.0);
  }

  /// Converts this color to a format compatible with old 32-bit ARGB integer representation.
  ///
  /// This helps users transitioning from integer-based constructors to normalized floating-point.
  int toARGBInt() {
    final srgb = _toSRGB();
    return (srgb.a * 255.0).toInt() << 24 |
        (srgb.r * 255.0).toInt() << 16 |
        (srgb.g * 255.0).toInt() << 8 |
        (srgb.b * 255.0).toInt();
  }

  /// Mimics `Color.lerp` but ensures sRGB alignment for users migrating from integer-based APIs.
  static Color? lerpColor(Color? color1, Color? color2, double t) {
    assert(t >= 0.0 && t <= 1.0,
        'Interpolation factor must be between 0.0 and 1.0.');
    final aligned1 = color1?._toSRGB();
    final aligned2 = color2?._toSRGB();
    return Color.lerp(aligned1, aligned2, t);
  }

  /// Scales the alpha channel proportionally, useful for semi-transparent effects.
  ///
  /// For example, to reduce opacity by half:
  /// `color.scaleOpacity(0.5);`
  Color scaleOpacity(double scale) {
    assert(scale >= 0.0 && scale <= 1.0,
        'Scale factor must be between 0.0 and 1.0.');
    return withValues(alpha: a * scale);
  }

  /// Aligns the current color to the specified [ColorSpace], ensuring compatibility with new APIs.
  ///
  /// For example, to convert to DisplayP3:
  /// `color.convertToColorSpace(ColorSpace.displayP3);`
  Color convertToColorSpace(ColorSpace targetSpace) {
    return withValues(colorSpace: targetSpace);
  }

  /// Quickly checks if the color's color space matches the given [ColorSpace].
  ///
  /// For example:
  /// `if (color.isInColorSpace(ColorSpace.sRGB)) { ... }`
  bool isInColorSpace(ColorSpace targetSpace) {
    return colorSpace == targetSpace;
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
