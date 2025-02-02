// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: avoid_private_typedef_functions
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

  /// Converts this color (assumed to be in sRGB) to a 32-bit ARGB integer.
  /// This is useful if you're migrating from older APIs that expected an integer.
  int toARGBInt() {
    final srgb = _toSRGB();
    return (_floatToInt8(srgb.a) << 24) |
        (_floatToInt8(srgb.r) << 16) |
        (_floatToInt8(srgb.g) << 8) |
        _floatToInt8(srgb.b);
  }

  int _floatToInt8(double component) => (component * 255).round().clamp(0, 255);

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
