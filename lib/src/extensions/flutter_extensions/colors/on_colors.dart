// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: avoid_private_typedef_functions
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

/// WCAG contrast level requirements
enum WCAGLevel {
  /// AA level: 4.5:1 for normal text, 3:1 for large text
  aa,

  /// AAA level: 7:1 for normal text, 4.5:1 for large text
  aaa
}

/// Context for WCAG contrast evaluation
enum WCAGContext {
  /// Normal text (< 18pt or < 14pt bold)
  normalText,

  /// Large text (≥ 18pt or ≥ 14pt bold)
  largeText,

  /// UI components and graphical objects
  uiComponent
}

/// Types of color blindness (color vision deficiency)
enum ColorBlindnessType {
  /// Red-green color blindness (red weakness) - most common
  protanopia,

  /// Red-green color blindness (green weakness) - second most common
  deuteranopia,

  /// Blue-yellow color blindness - rare
  tritanopia,

  /// Complete color blindness - very rare
  achromatopsia,
}

/// An extension on [Color] that provides a variety of color-manipulation helpers.
///
/// Most operations internally convert the color to the sRGB color space for
/// consistent behavior (for example, when computing luminance or performing
/// HSL transformations).
extension FHUColorExt on Color {
  WidgetStateProperty<Color> get toWidgetStateProperty =>
      WidgetStateProperty.all(this);

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

  // ===============================================
  //        Channel Setters (Primary API)
  // ===============================================

  /// Sets the opacity of this color (0.0 to 1.0).
  ///
  /// This creates a new color with the specified alpha channel while
  /// preserving the RGB values and color space.
  ///
  /// Example:
  /// ```dart
  /// final semiTransparent = Colors.red.setOpacity(0.5);
  /// ```
  Color setOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0,
        'Opacity must be between 0.0 and 1.0.');
    return withValues(alpha: opacity);
  }

  /// Sets the alpha channel from a 0-255 value.
  ///
  /// Example:
  /// ```dart
  /// final semiTransparent = Colors.blue.setAlpha(128);
  /// ```
  Color setAlpha(int alpha) {
    assert(alpha >= 0 && alpha <= 255, 'Alpha must be between 0 and 255.');
    return withValues(alpha: alpha / 255.0);
  }

  /// Sets the red channel from a 0-255 value.
  Color setRed(int red) {
    assert(red >= 0 && red <= 255, 'Red must be between 0 and 255.');
    return withValues(red: red / 255.0);
  }

  /// Sets the green channel from a 0-255 value.
  Color setGreen(int green) {
    assert(green >= 0 && green <= 255, 'Green must be between 0 and 255.');
    return withValues(green: green / 255.0);
  }

  /// Sets the blue channel from a 0-255 value.
  Color setBlue(int blue) {
    assert(blue >= 0 && blue <= 255, 'Blue must be between 0 and 255.');
    return withValues(blue: blue / 255.0);
  }

  /// Scales the current alpha by [factor], keeping the same color space.
  Color scaleOpacity(double factor) {
    assert(factor >= 0.0 && factor <= 1.0,
        'Scale factor must be between 0.0 and 1.0.');
    return withValues(alpha: a * factor);
  }

  // ===============================================
  //        Migration Helpers (Deprecated)
  // ===============================================

  /// **DEPRECATED**: Use [setOpacity] instead.
  ///
  /// This method exists only to help migrate from Flutter's deprecated
  /// `withOpacity` method. It will be removed in version 2.0.
  ///
  /// Migration guide:
  /// - Replace `color.withOpacity(0.5)` with `color.setOpacity(0.5)`
  /// - Or use Flutter's `color.withValues(alpha: 0.5)`
  @Deprecated('Use setOpacity() instead. Will be removed in the future')
  Color addOpacity(double opacity) => setOpacity(opacity);

  @Deprecated('Use setAlpha() instead. Will be removed in the future')
  Color addAlpha(int alpha) => setAlpha(alpha);

  @Deprecated('Use setRed() instead. Will be removed in the future')
  Color addRed(int red) => setRed(red);

  @Deprecated('Use setGreen() instead. Will be removed in the future')
  Color addGreen(int green) => setGreen(green);

  @Deprecated('Use setBlue() instead. Will be removed in the future')
  Color addBlue(int blue) => setBlue(blue);

  // ------------------------------------------------------
  //        Color Harmonies
  // ------------------------------------------------------

  /// Rotates the hue of this color by the specified degrees.
  /// Private helper for harmony generation.
  Color _rotateHue(double degrees) {
    final srgb = _toSRGB();
    final hsl = HSLColor.fromColor(srgb);
    final newHue = (hsl.hue + degrees) % 360.0;
    final rotated = hsl.withHue(newHue).toColor();
    // Preserve original color space and alpha
    return colorSpace == ColorSpace.sRGB
        ? rotated.withAlpha((a * 255).round())
        : rotated.withAlpha((a * 255).round()).convertToColorSpace(colorSpace);
  }

  /// Generates a triadic color harmony (3 colors evenly spaced on the color wheel).
  ///
  /// Returns the original color plus two colors at 120° and 240°.
  /// This creates a vibrant, balanced color scheme while maintaining contrast.
  ///
  /// Example:
  /// ```dart
  /// final colors = Colors.red.triadic();
  /// // Returns [red, green, blue] approximately
  /// ```
  List<Color> triadic() => [
        this,
        _rotateHue(120),
        _rotateHue(240),
      ];

  /// Generates a tetradic (square) color harmony.
  ///
  /// Returns 4 colors evenly spaced around the color wheel (90° apart).
  /// This creates a rich, varied color scheme with two complementary pairs.
  List<Color> tetradic() => [
        this,
        _rotateHue(90),
        _rotateHue(180),
        _rotateHue(270),
      ];

  /// Generates a split-complementary color harmony.
  ///
  /// Returns the original color plus two colors adjacent to its complement.
  /// This provides high contrast with less tension than complementary colors.
  ///
  /// The [angle] parameter controls the split (default 30°).
  List<Color> splitComplementary({double angle = 30.0}) {
    assert(angle > 0 && angle < 90,
        'Split angle must be between 0 and 90 degrees');
    return [
      this,
      _rotateHue(180 - angle),
      _rotateHue(180 + angle),
    ];
  }

  /// Generates an analogous color harmony.
  ///
  /// Returns colors adjacent to this color on the color wheel.
  /// Creates a harmonious, pleasing color scheme with low contrast.
  ///
  /// Parameters:
  /// - [count]: Number of colors to generate (including this color)
  /// - [angle]: Degrees between each color (default 30°)
  ///
  /// Example:
  /// ```dart
  /// final colors = Colors.blue.analogous(count: 5, angle: 15);
  /// // Returns 5 colors in the blue-green to blue-purple range
  /// ```
  List<Color> analogous({int count = 3, double angle = 30.0}) {
    assert(count >= 2, 'Count must be at least 2');
    assert(angle > 0 && angle <= 60,
        'Angle must be between 0 and 60 degrees for analogous harmony');

    final colors = <Color>[];
    final halfCount = count ~/ 2;
    final startAngle = -halfCount * angle;

    for (var i = 0; i < count; i++) {
      colors.add(_rotateHue(startAngle + (i * angle)));
    }

    return colors;
  }

  /// Generates a monochromatic color harmony.
  ///
  /// Returns variations of this color with different lightness values.
  /// Creates a cohesive, sophisticated color scheme.
  ///
  /// Parameters:
  /// - [count]: Number of colors to generate
  /// - [lightnessRange]: Range of lightness variation (0.0 to 1.0)
  List<Color> monochromatic({int count = 5, double lightnessRange = 0.5}) {
    assert(count >= 2, 'Count must be at least 2');
    assert(lightnessRange > 0 && lightnessRange <= 1.0,
        'Lightness range must be between 0 and 1');

    final srgb = _toSRGB();
    final hsl = HSLColor.fromColor(srgb);
    final colors = <Color>[];

    final currentLightness = hsl.lightness;
    final minLightness =
        (currentLightness - lightnessRange / 2).clamp(0.0, 1.0);
    final maxLightness =
        (currentLightness + lightnessRange / 2).clamp(0.0, 1.0);
    final step = (maxLightness - minLightness) / (count - 1);

    for (var i = 0; i < count; i++) {
      final lightness = minLightness + (i * step);
      final color = hsl.withLightness(lightness).toColor();
      colors.add(colorSpace == ColorSpace.sRGB
          ? color.withAlpha((a * 255).round())
          : color.withAlpha((a * 255).round()).convertToColorSpace(colorSpace));
    }

    return colors;
  }

  // ------------------------------------------------------
  //        WCAG Accessibility
  // ------------------------------------------------------

  /// Checks if this color (as background) meets WCAG contrast guidelines
  /// with the given [foreground] color.
  ///
  /// According to WCAG 2.1:
  /// - Normal text: < 18pt (24px) or < 14pt (18.66px) bold
  /// - Large text: ≥ 18pt (24px) or ≥ 14pt (18.66px) bold
  /// - UI components: 3:1 minimum contrast
  ///
  /// Example:
  /// ```dart
  /// final background = Colors.white;
  /// final text = Colors.grey;
  /// if (!background.meetsWCAG(text)) {
  ///   print('Text color does not meet accessibility standards');
  /// }
  /// ```
  bool meetsWCAG(
    Color foreground, {
    WCAGLevel level = WCAGLevel.aa,
    WCAGContext context = WCAGContext.normalText,
  }) {
    final ratio = contrast(foreground);

    switch (context) {
      case WCAGContext.normalText:
        return level == WCAGLevel.aa ? ratio >= 4.5 : ratio >= 7.0;
      case WCAGContext.largeText:
        return level == WCAGLevel.aa ? ratio >= 3.0 : ratio >= 4.5;
      case WCAGContext.uiComponent:
        return ratio >= 3.0; // UI components only need 3:1
    }
  }

  /// Suggests accessible text colors for this background color.
  ///
  /// Returns a record with suggested colors for different contexts.
  /// If the default black/white suggestions don't meet requirements,
  /// it attempts to find the best alternatives.
  ({
    Color normalText,
    Color largeText,
    Color uiComponent,
  }) suggestAccessibleColors({
    WCAGLevel level = WCAGLevel.aa,
  }) {
    // Start with simple black or white
    final black = Colors.black._toSRGB();
    final white = Colors.white._toSRGB();

    final blackContrast = contrast(black);
    final whiteContrast = contrast(white);

    // Determine base color preference
    final preferBlack = blackContrast > whiteContrast;
    final baseColor = preferBlack ? black : white;
    final baseContrast = preferBlack ? blackContrast : whiteContrast;

    // Check if base color meets all requirements
    final normalTextRatio = level == WCAGLevel.aa ? 4.5 : 7.0;
    final largeTextRatio = level == WCAGLevel.aa ? 3.0 : 4.5;

    var normalTextColor = baseColor;
    var largeTextColor = baseColor;
    var uiComponentColor = baseColor;

    // If base doesn't meet normal text requirement, adjust
    if (baseContrast < normalTextRatio) {
      normalTextColor = _findAccessibleColor(
        targetRatio: normalTextRatio,
        preferDark: preferBlack,
      );
    }

    // Large text usually can use base color, but check
    if (baseContrast < largeTextRatio) {
      largeTextColor = _findAccessibleColor(
        targetRatio: largeTextRatio,
        preferDark: preferBlack,
      );
    }

    // UI components need 3:1 minimum
    if (baseContrast < 3.0) {
      uiComponentColor = _findAccessibleColor(
        targetRatio: 3,
        preferDark: preferBlack,
      );
    }

    return (
      normalText: normalTextColor,
      largeText: largeTextColor,
      uiComponent: uiComponentColor,
    );
  }

  /// Finds a color that meets the target contrast ratio.
  /// Private helper method.
  Color _findAccessibleColor({
    required double targetRatio,
    required bool preferDark,
  }) {
    final srgb = _toSRGB();
    final currentLuminance = srgb.computeLuminance();

    // Calculate required luminance for target ratio
    // Contrast = (L1 + 0.05) / (L2 + 0.05) where L1 > L2
    double targetLuminance;

    if (preferDark) {
      // We want a darker color (lower luminance)
      targetLuminance = ((currentLuminance + 0.05) / targetRatio) - 0.05;
      targetLuminance = targetLuminance.clamp(0.0, currentLuminance);
    } else {
      // We want a lighter color (higher luminance)
      targetLuminance = (targetRatio * (currentLuminance + 0.05)) - 0.05;
      targetLuminance = targetLuminance.clamp(currentLuminance, 1.0);
    }

    // Simple approach: create grayscale with target luminance
    // For more sophisticated approach, could maintain hue
    final gray = (targetLuminance * 255).round().clamp(0, 255);
    return Color.fromARGB(255, gray, gray, gray);
  }

  // ------------------------------------------------------
  //        Color Blindness Simulation
  // ------------------------------------------------------

  /// Simulates how this color appears to someone with color blindness.
  ///
  /// This uses standard color blindness simulation matrices to transform
  /// the color. Useful for checking if your color scheme is accessible
  /// to users with color vision deficiencies.
  ///
  /// Example:
  /// ```dart
  /// final red = Colors.red;
  /// final howRedLooksToProtanope = red.simulateColorBlindness(
  ///   ColorBlindnessType.protanopia
  /// );
  /// ```
  Color simulateColorBlindness(ColorBlindnessType type) {
    final srgb = _toSRGB();

    // Convert to linear RGB for accurate simulation
    double toLinear(double channel) {
      if (channel <= 0.04045) {
        return channel / 12.92;
      } else {
        return math.pow((channel + 0.055) / 1.055, 2.4).toDouble();
      }
    }

    double toSRGB(double channel) {
      if (channel <= 0.0031308) {
        return channel * 12.92;
      } else {
        return 1.055 * math.pow(channel, 1.0 / 2.4) - 0.055;
      }
    }

    final lr = toLinear(srgb.r);
    final lg = toLinear(srgb.g);
    final lb = toLinear(srgb.b);

    late final double nr;
    late final double ng;
    late final double nb;

    switch (type) {
      case ColorBlindnessType.protanopia:
        // Protanopia simulation matrix
        nr = 0.56667 * lr + 0.43333 * lg + 0.0 * lb;
        ng = 0.55833 * lr + 0.44167 * lg + 0.0 * lb;
        nb = 0.0 * lr + 0.24167 * lg + 0.75833 * lb;

      case ColorBlindnessType.deuteranopia:
        // Deuteranopia simulation matrix
        nr = 0.625 * lr + 0.375 * lg + 0.0 * lb;
        ng = 0.7 * lr + 0.3 * lg + 0.0 * lb;
        nb = 0.0 * lr + 0.3 * lg + 0.7 * lb;

      case ColorBlindnessType.tritanopia:
        // Tritanopia simulation matrix
        nr = 0.95 * lr + 0.05 * lg + 0.0 * lb;
        ng = 0.0 * lr + 0.43333 * lg + 0.56667 * lb;
        nb = 0.0 * lr + 0.475 * lg + 0.525 * lb;

      case ColorBlindnessType.achromatopsia:
        // Complete color blindness - convert to grayscale
        final gray = 0.299 * lr + 0.587 * lg + 0.114 * lb;
        nr = ng = nb = gray;
    }

    // Convert back to sRGB
    final r = toSRGB(nr).clamp(0.0, 1.0);
    final g = toSRGB(ng).clamp(0.0, 1.0);
    final b = toSRGB(nb).clamp(0.0, 1.0);

    final simulated = Color.from(
      alpha: srgb.a,
      red: r,
      green: g,
      blue: b,
    );

    // Preserve original color space
    return colorSpace == ColorSpace.sRGB
        ? simulated
        : simulated.convertToColorSpace(colorSpace);
  }

  /// Checks if this color is distinguishable from another color
  /// for people with color blindness.
  ///
  /// Returns true if the colors have sufficient contrast when
  /// simulated for the specified type of color blindness.
  ///
  /// The [minContrast] parameter sets the minimum contrast ratio
  /// (default 3.0 for UI components).
  bool isDistinguishableFor(
    Color other,
    ColorBlindnessType type, {
    double minContrast = 3.0,
  }) {
    final simulated1 = simulateColorBlindness(type);
    final simulated2 = other.simulateColorBlindness(type);
    return simulated1.contrast(simulated2) >= minContrast;
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
