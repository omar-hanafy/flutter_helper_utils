// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: avoid_private_typedef_functions
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../flutter_helper_utils.dart';

typedef _ColorParser = Color? Function(List<String> values);

extension FHUStringToColorExtension on String {
  // Precompiled regexes.
  static final RegExp _hexColorRegex =
      RegExp(regexValidHexColor, caseSensitive: false);
  static final RegExp _rgbColorRegex =
      RegExp(regexValidRgbColor, caseSensitive: false);
  static final RegExp _hslColorRegex =
      RegExp(regexValidHslColor, caseSensitive: false);
  static final RegExp _modernColorRegex =
      RegExp(regexValidModernColorFunc, caseSensitive: false);

  /// Whether the string represents a valid color.
  bool get isValidColor => isNotEmptyOrNull && (isHexColor || toColor != null);

  /// Checks if the string is a valid hex color code.
  bool get isHexColor => isNotEmptyOrNull && _hexColorRegex.hasMatch(trim());

  bool get isRgbColor => isNotEmptyOrNull && _parseRgbColor(trim()) != null;

  bool get isHslColor => isNotEmptyOrNull && _parseHslColor(trim()) != null;

  /// For modern syntax we additionally require that parsing returns a non-null Color.
  bool get isModernColor {
    final input = trim();
    return input.isNotEmpty &&
        _modernColorRegex.hasMatch(input) &&
        _parseModernColor(input) != null;
  }

  /// Converts this string to a [Color] object.
  Color? get toColor {
    final input = trim();
    if (input.isEmpty) return null;

    // Try named colors first.
    final namedColor = cssColorNamesToArgb[input.toLowerCase()];
    if (namedColor != null) return Color(namedColor);

    return _parseHexColor(input) ??
        _parseRgbColor(input) ??
        _parseHslColor(input) ??
        _parseModernColor(input);
  }

  // -------------------------
  // Parsing Methods
  // -------------------------

  Color? _parseHexColor(String input) {
    var hex = input.trim().replaceFirst(
          RegExp('^(#|0x)', caseSensitive: false),
          '',
        );

    // Normalize the hex string into ARGB format.
    if (hex.length == 3) {
      // e.g. "abc" -> "aabbcc", then add full opacity.
      hex = hex.split('').map((c) => c * 2).join();
      hex = 'FF$hex';
    } else if (hex.length == 4) {
      // e.g. "abcd" -> duplicate then swap (assuming rgba → argb).
      hex = hex.split('').map((c) => c * 2).join();
      hex = hex.substring(6, 8) + hex.substring(0, 6);
    } else if (hex.length == 6) {
      // e.g. "aabbcc" → add full opacity.
      hex = 'FF$hex';
    } else if (hex.length == 8) {
      // e.g. "aabbccdd" → swap to ARGB order.
      hex = hex.substring(6, 8) + hex.substring(0, 6);
    } else {
      return null;
    }

    final colorValue = int.tryParse(hex, radix: 16);
    return colorValue != null ? Color(colorValue) : null;
  }

  Color? _parseRgbColor(String input) {
    final trimmed = input.trim();
    final match = _rgbColorRegex.firstMatch(trimmed);
    if (match == null) return null;

    final lowerInput = trimmed.toLowerCase();
    // Legacy rule: if input starts with "rgb(" (without "a"), a fourth value is invalid.
    if (lowerInput.startsWith('rgb(') && match.group(4) != null) {
      return null;
    }

    // Ensure either all three components are percentages or none are.
    bool isPercent(int groupIndex) =>
        match.group(groupIndex)!.trim().endsWith('%');
    final allPercent = isPercent(1) && isPercent(2) && isPercent(3);
    final nonePercent = !isPercent(1) && !isPercent(2) && !isPercent(3);
    if (!allPercent && !nonePercent) return null;

    final components = <int>[];
    for (var i = 1; i <= 3; i++) {
      final group = match.group(i)!;
      if (group.endsWith('%')) {
        final percentage =
            double.tryParse(group.substring(0, group.length - 1));
        if (percentage == null || percentage < 0 || percentage > 100) {
          return null;
        }
        components.add((percentage / 100 * 255).round());
      } else {
        final value = int.tryParse(group);
        if (value == null || value < 0 || value > 255) {
          return null;
        }
        components.add(value);
      }
    }

    var alpha = 255;
    if (match.group(4) != null) {
      final alphaGroup = match.group(4)!;
      if (alphaGroup.trim().endsWith('%')) {
        final percentage =
            double.tryParse(alphaGroup.substring(0, alphaGroup.length - 1));
        if (percentage == null || percentage < 0 || percentage > 100) {
          return null;
        }
        alpha = (percentage / 100 * 255).round();
      } else {
        final d = double.tryParse(alphaGroup);
        if (d == null || d < 0 || d > 1) return null;
        alpha = (d * 255).round();
      }
    }
    return Color.fromARGB(alpha, components[0], components[1], components[2]);
  }

  Color? _parseHslColor(String input) {
    final trimmed = input.trim();
    final match = _hslColorRegex.firstMatch(trimmed);
    if (match == null) return null;

    final lowerInput = trimmed.toLowerCase();
    // Legacy rule: if input starts with "hsl(" (without "a"), reject if an alpha is present.
    final isHsla = lowerInput.startsWith('hsla');
    if (!isHsla && lowerInput.startsWith('hsl(') && match.group(4) != null) {
      return null;
    }

    // Depending on whether alpha is present, expect 3 or 4 groups.
    final numComponents = isHsla ? 4 : 3;
    final components = <double>[];

    for (var i = 1; i <= numComponents; i++) {
      final group = match.group(i);
      if (group == null) {
        // For hsla, if alpha is missing, default to 1.
        if (isHsla && i == 4) {
          components.add(1);
          continue;
        }
        return null;
      }
      if (i == 1) {
        final hue = _parseHueValue(group);
        if (hue == null) return null;
        components.add(hue);
      } else if (i == 4 && isHsla) {
        final alpha = double.tryParse(group);
        if (alpha == null || alpha < 0 || alpha > 1) return null;
        components.add(alpha);
      } else if (group.trim().endsWith('%')) {
        final percentage =
            double.tryParse(group.substring(0, group.length - 1).trim());
        if (percentage == null || percentage < 0 || percentage > 100) {
          return null;
        }
        components.add(percentage / 100);
      } else {
        return null;
      }
    }

    return isHsla
        ? _hslToColor(components[0], components[1], components[2],
            (components[3] * 255).round())
        : _hslToColor(components[0], components[1], components[2], 255);
  }

  Color? _parseModernColor(String input) {
    final trimmed = input.trim();
    final values = _extractModernValues(trimmed);
    if (values.isEmpty) return null;

    // If there are 4 tokens but no slash in the original input, the syntax is invalid.
    if (values.length == 4 && !trimmed.contains('/')) return null;

    final funcName = trimmed.substring(0, trimmed.indexOf('(')).toLowerCase();
    final parser = _modernColorParsers[funcName];
    if (parser != null) {
      try {
        return parser(values);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  List<String> _extractModernValues(String input) {
    final start = input.indexOf('(') + 1;
    final end = input.lastIndexOf(')');
    if (start >= end) return const [];
    final inner = input.substring(start, end).trim();
    if (inner.contains('/')) {
      // Expecting exactly three main parts and one alpha part.
      final parts = inner.split('/');
      if (parts.length != 2) return const [];
      final mainParts = parts[0].trim().split(RegExp(r'\s+'));
      final alphaParts = parts[1].trim().split(RegExp(r'\s+'));
      if (mainParts.length != 3 || alphaParts.length != 1) return const [];
      return [...mainParts, ...alphaParts];
    } else {
      return inner.split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
    }
  }

  // -------------------------
  // Modern Color Parsing Helpers
  // -------------------------
  static final Map<String, _ColorParser> _modernColorParsers = {
    'rgb': _parseRgbValues,
    'rgba': _parseRgbValues, // Allow rgba syntax.
    'hsl': _parseHslValues,
    'hsla': _parseHslValues, // Allow hsla syntax.
    'hwb': _parseHwbValues,
    // Additional parsers (e.g. for "lab", "lch", or "color") can be added here.
  };

  static Color? _parseRgbValues(List<String> values) {
    // Expect exactly 3 tokens if no alpha, or 4 tokens if an alpha value is provided.
    if (values.length != 3 && values.length != 4) return null;
    final r = _parseColorComponent(values[0]);
    final g = _parseColorComponent(values[1]);
    final b = _parseColorComponent(values[2]);
    final a = values.length == 4 ? _parseAlphaComponent(values[3]) : 255;
    if (r == null || g == null || b == null || a == null) return null;
    return Color.fromARGB(a, r, g, b);
  }

  static Color? _parseHslValues(List<String> values) {
    if (values.length != 3 && values.length != 4) return null;
    final h = _parseHueValue(values[0]);
    final s = _parsePercentage(values[1]);
    final l = _parsePercentage(values[2]);
    final a = values.length == 4 ? _parseAlphaComponent(values[3]) : 255;
    if (h == null || s == null || l == null || a == null) return null;
    return _hslToColor(h, s, l, a);
  }

  static Color? _parseHwbValues(List<String> values) {
    if (values.length != 3 && values.length != 4) return null;
    final h = _parseHueValue(values[0]);
    final w = _parsePercentage(values[1]);
    final b = _parsePercentage(values[2]);
    final a = values.length == 4 ? _parseAlphaComponent(values[3]) : 255;
    if (h == null || w == null || b == null || a == null) return null;
    return _hwbToColor(h, w, b, a);
  }

  static int? _parseColorComponent(String v) {
    final value = v.trim();
    if (value.endsWith('%')) {
      final percentage = double.tryParse(value.substring(0, value.length - 1));
      if (percentage == null || percentage < 0 || percentage > 100) return null;
      return (percentage / 100 * 255).round();
    }
    final intValue = int.tryParse(value);
    if (intValue == null || intValue < 0 || intValue > 255) return null;
    return intValue;
  }

  static int? _parseAlphaComponent(String v) {
    final value = v.trim();
    if (value.endsWith('%')) {
      final percentage = double.tryParse(value.substring(0, value.length - 1));
      if (percentage == null || percentage < 0 || percentage > 100) return null;
      return (percentage / 100 * 255).round();
    }
    final d = double.tryParse(value);
    if (d == null || d < 0 || d > 1) return null;
    return (d * 255).round();
  }

  static double? _parseHueValue(String v) {
    // Normalize the input: remove extra spaces, commas, etc.
    final value = v
        .trim()
        .toLowerCase()
        .replaceAll(RegExp('$regexComponentSeparator\$'), '');
    try {
      double hue;
      if (value.endsWith('grad')) {
        // Check 'grad' first!
        final gradValue = double.parse(value.substring(0, value.length - 4));
        // 400 gradians = 360 degrees.
        hue = (gradValue * 360 / 400) % 360;
      } else if (value.endsWith('rad')) {
        hue =
            double.parse(value.substring(0, value.length - 3)) * 180 / math.pi;
      } else if (value.endsWith('deg')) {
        hue = double.parse(value.substring(0, value.length - 3));
      } else if (value.endsWith('turn')) {
        hue = double.parse(value.substring(0, value.length - 4)) * 360;
      } else {
        hue = double.tryParse(value) ?? 0;
      }
      if (hue < 0 || hue > 360) return null;
      // Normalize so that 360° becomes 0°.
      return (hue / 360) % 1;
    } catch (_) {
      return null;
    }
  }

  static double? _parsePercentage(String v) {
    final value = v.trim();
    if (!value.endsWith('%')) return null;
    final percentage = double.tryParse(value.substring(0, value.length - 1));
    if (percentage == null || percentage < 0 || percentage > 100) return null;
    return percentage / 100;
  }

  static Color _hslToColor(double h, double s, double l, int alpha) {
    double r;
    double g;
    double b;
    if (s == 0) {
      r = g = b = l;
    } else {
      double hue2rgb(double p, double q, double _t) {
        // we do that to avoid "Invalid assignment to the parameter 't'." warning
        // in dart its not recommended to modify the value of the method argument
        // instead we can do this:
        var t = _t;
        if (t < 0) t += 1;
        if (t > 1) t -= 1;
        if (t < 1 / 6) return p + (q - p) * 6 * t;
        if (t < 1 / 2) return q;
        if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
        return p;
      }

      final q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      final p = 2 * l - q;
      r = hue2rgb(p, q, h + 1 / 3);
      g = hue2rgb(p, q, h);
      b = hue2rgb(p, q, h - 1 / 3);
    }
    return Color.fromARGB(
      alpha,
      (r * 255).round(),
      (g * 255).round(),
      (b * 255).round(),
    );
  }

  static Color _hwbToColor(double h, double w, double b, int alpha) {
    var white = w;
    var black = b;
    if (white + black > 1) {
      final sum = white + black;
      white /= sum;
      black /= sum;
    }
    final pureColor = _hslToColor(h, 1, 0.5, 255);
    // using new getters for red, green, blue in Color object
    // now they are .r, .g, .b, instead of .red, .green, .blue.
    final rPure = pureColor.r / 255;
    final gPure = pureColor.g / 255;
    final bPure = pureColor.b / 255;
    final rFinal = ((1 - white - black) * rPure + white) * 255;
    final gFinal = ((1 - white - black) * gPure + white) * 255;
    final bFinal = ((1 - white - black) * bPure + white) * 255;
    return Color.fromARGB(
      alpha,
      rFinal.round().clamp(0, 255),
      gFinal.round().clamp(0, 255),
      bFinal.round().clamp(0, 255),
    );
  }
}
