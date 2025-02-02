// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: avoid_private_typedef_functions
import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Global variables – update these if needed.
const regexValidHexColor =
    r'^(#|0x)?([0-9A-Fa-f]{3}|[0-9A-Fa-f]{4}|[0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$';

const _intPattern = r'(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)';
const _percentPattern = r'(?:100|[1-9]?\d)%';

/// Updated regex for legacy rgb()/rgba() with capturing groups.
/// (The number alternatives are now explicit so that only 0–255 (or a valid percent) is allowed.)
const regexValidRgbColor = r'^rgba?\(\s*'
    '($_intPattern|$_percentPattern)\\s*,\\s*'
    '($_intPattern|$_percentPattern)\\s*,\\s*'
    '($_intPattern|$_percentPattern)'
    '(?:\\s*,\\s*((?:0?\\.\\d+)|(?:1)|(?:0)|$_percentPattern))?\\s*\\)\$';

/// Updated regex for legacy hsl()/hsla() with capturing groups.
/// The hue part now accepts a number that may have a unit (deg, rad, turn, grad).
const regexValidHslColor = r'^hsla?\s*\(\s*'
    r'((?:[0-9]+(?:\.[0-9]+)?)(?:deg|rad|turn|grad)?)\s*,\s*'
    r'((?:100|[0-9]{1,2})%)\s*,\s*'
    r'((?:100|[0-9]{1,2})%)'
    r'(?:\s*,\s*'
    r'((?:0?\.\d+|1|0))'
    r')?\s*\)$';

/// Updated modern color regex – now requires that no commas appear.
const regexValidModernColorFunc =
    r'^(?:(?:rgb|hsl|hwb|lab|lch)a?|color)\(\s*(?:(?!,).)+\)$';

/// Expanded named colors map. (Note: if a keyword like "currentColor" is not desired, omit it.)
const cssColorNamesToArgb = <String, int>{
  'black': 0xFF000000,
  'white': 0xFFFFFFFF,
  'red': 0xFFFF0000,
  'lime': 0xFF00FF00,
  'green': 0xFF008000,
  'blue': 0xFF0000FF,
  'yellow': 0xFFFFFF00,
  'cyan': 0xFF00FFFF,
  'magenta': 0xFFFF00FF,
  'silver': 0xFFC0C0C0,
  'gray': 0xFF808080,
  'maroon': 0xFF800000,
  'olive': 0xFF808000,
  'purple': 0xFF800080,
  'teal': 0xFF008080,
  'navy': 0xFF000080,
  'orange': 0xFFFFA500,
  'pink': 0xFFFFC0CB,
  'brown': 0xFFA52A2A,
  'violet': 0xFFEE82EE,
  'gold': 0xFFFFD700,
  'indigo': 0xFF4B0082,
  'khaki': 0xFFF0E68C,
  'coral': 0xFFFF7F50,
  'aquamarine': 0xFF7FFFD4,
  'turquoise': 0xFF40E0D0,
  'lavender': 0xFFE6E6FA,
  'tan': 0xFFD2B48C,
  'salmon': 0xFFFA8072,
  'plum': 0xFFDDA0DD,
  'orchid': 0xFFDA70D6,
  'chocolate': 0xFFD2691E,
  'tomato': 0xFFFF6347,
  'crimson': 0xFFDC143C,
  'transparent': 0x00000000,
  'aliceblue': 0xFFF0F8FF,
  // (Additional named colors could be added here if desired.)
};

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

  // For splitting modern color function values.
  static final RegExp _splitRegExp = RegExp(r'[\s,/]');

  /// Whether the string represents a valid color.
  bool get isValidColor => toColor != null;

  bool get isHexColor => _hexColorRegex.hasMatch(trim());

  bool get isRgbColor => _rgbColorRegex.hasMatch(trim());

  bool get isHslColor => _hslColorRegex.hasMatch(trim());

  /// For modern syntax we additionally require that parsing returns a non-null Color.
  bool get isModernColor =>
      _modernColorRegex.hasMatch(trim()) && _parseModernColor(trim()) != null;

  /// Converts this string to a [Color] object.
  Color? get toColor {
    final input = trim();

    // Named color.
    final namedColor = cssColorNamesToArgb[input.toLowerCase()];
    if (namedColor != null) return Color(namedColor);

    if (isHexColor) return _parseHexColor(input);
    if (isRgbColor) return _parseRgbColor(input);
    if (isHslColor) return _parseHslColor(input);
    if (isModernColor) return _parseModernColor(input);
    return null;
  }

  // -------------------------
  // Parsing Methods
  // -------------------------

  Color? _parseHexColor(String input) {
    var hex =
        input.trim().replaceFirst(RegExp('^(#|0x)', caseSensitive: false), '');
    if (hex.length == 3) {
      hex = hex.split('').map((c) => c * 2).join();
      hex = 'FF$hex';
    } else if (hex.length == 4) {
      hex = hex.split('').map((c) => c * 2).join();
      hex = hex.substring(6, 8) + hex.substring(0, 6);
    } else if (hex.length == 6) {
      hex = 'FF$hex';
    } else if (hex.length == 8) {
      hex = hex.substring(6, 8) + hex.substring(0, 6);
    } else {
      return null;
    }
    final colorValue = int.tryParse(hex, radix: 16);
    return colorValue != null ? Color(colorValue) : null;
  }

  Color? _parseRgbColor(String input) {
    final match = _rgbColorRegex.firstMatch(input);
    if (match == null) return null;

    // Ensure consistency: either all components are percentages or none are.
    bool isPercent(int groupIndex) =>
        match.group(groupIndex)!.trim().endsWith('%');
    bool allPercent = isPercent(1) && isPercent(2) && isPercent(3);
    bool nonePercent = !isPercent(1) && !isPercent(2) && !isPercent(3);
    if (!allPercent && !nonePercent) return null;

    final components = <int>[];
    for (var i = 1; i <= 3; i++) {
      final group = match.group(i)!;
      if (group.endsWith('%')) {
        final percentage =
            double.tryParse(group.substring(0, group.length - 1));
        if (percentage == null || percentage < 0 || percentage > 100)
          return null;
        components.add((percentage / 100 * 255).round());
      } else {
        final value = int.tryParse(group);
        if (value == null || value < 0 || value > 255) return null;
        components.add(value);
      }
    }
    int alpha = 255;
    if (match.group(4) != null) {
      final alphaGroup = match.group(4)!;
      if (alphaGroup.endsWith('%')) {
        final percentage =
            double.tryParse(alphaGroup.substring(0, alphaGroup.length - 1));
        if (percentage == null || percentage < 0 || percentage > 100)
          return null;
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
    final match = _hslColorRegex.firstMatch(input);
    if (match == null) return null;
    final lowerInput = input.toLowerCase();
    final isHsla = lowerInput.startsWith('hsla');
    final numGroups = isHsla ? 4 : 3;
    final components = <double>[];

    for (var i = 1; i <= numGroups; i++) {
      final group = match.group(i);
      if (group == null) {
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
      } else if (group.endsWith('%')) {
        final percentage =
            double.tryParse(group.substring(0, group.length - 1));
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
    final values = _extractModernValues(input);
    if (values.isEmpty) return null;
    final functionName = input.substring(0, input.indexOf('(')).toLowerCase();
    final parser = _modernColorParsers[functionName];
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
    final match = _modernColorRegex.firstMatch(input);
    if (match == null) return const [];
    final start = input.indexOf('(') + 1;
    final end = input.lastIndexOf(')');
    if (start >= end) return const [];
    return input
        .substring(start, end)
        .split(_splitRegExp)
        .where((s) => s.isNotEmpty)
        .toList();
  }

  // -------------------------
  // Modern Color Parsing Helpers
  // -------------------------
  static final Map<String, _ColorParser> _modernColorParsers = {
    'rgb': _parseRgbValues,
    'hsl': _parseHslValues,
    'hwb': _parseHwbValues,
    // Additional parsers can be added here.
  };

  static Color? _parseRgbValues(List<String> values) {
    if (values.length < 3 || values.length > 4) return null;
    final r = _parseColorComponent(values[0]);
    final g = _parseColorComponent(values[1]);
    final b = _parseColorComponent(values[2]);
    final a = values.length == 4 ? _parseAlphaComponent(values[3]) : 255;
    if (r == null || g == null || b == null || a == null) return null;
    return Color.fromARGB(a, r, g, b);
  }

  static Color? _parseHslValues(List<String> values) {
    if (values.length < 3 || values.length > 4) return null;
    final h = _parseHueValue(values[0]);
    final s = _parsePercentage(values[1]);
    final l = _parsePercentage(values[2]);
    final a = values.length == 4 ? _parseAlphaComponent(values[3]) : 255;
    if (h == null || s == null || l == null || a == null) return null;
    return _hslToColor(h, s, l, a);
  }

  static Color? _parseHwbValues(List<String> values) {
    if (values.length < 3 || values.length > 4) return null;
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
    final value = v.trim().toLowerCase();
    try {
      double hue;
      if (value.endsWith('deg')) {
        hue = double.parse(value.substring(0, value.length - 3));
        if (hue < 0 || hue > 360) return null;
      } else if (value.endsWith('rad')) {
        hue =
            double.parse(value.substring(0, value.length - 3)) * 180 / math.pi;
        if (hue < 0 || hue > 360) return null;
      } else if (value.endsWith('turn')) {
        hue = double.parse(value.substring(0, value.length - 4)) * 360;
        if (hue < 0 || hue > 360) return null;
      } else if (value.endsWith('grad')) {
        hue = double.parse(value.substring(0, value.length - 4)) * 0.9;
        // Normalize grad values (e.g. 400grad → 360deg, 450grad → 45deg)
        hue = hue % 360;
      } else {
        hue = double.tryParse(value) ?? 0;
        if (hue < 0 || hue > 360) return null;
      }
      return hue / 360;
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
        alpha, (r * 255).round(), (g * 255).round(), (b * 255).round());
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
    final rPure = pureColor.red / 255;
    final gPure = pureColor.green / 255;
    final bPure = pureColor.blue / 255;
    final rFinal = ((1 - white - black) * rPure + white) * 255;
    final gFinal = ((1 - white - black) * gPure + white) * 255;
    final bFinal = ((1 - white - black) * bPure + white) * 255;
    return Color.fromARGB(alpha, rFinal.round().clamp(0, 255),
        gFinal.round().clamp(0, 255), bFinal.round().clamp(0, 255));
  }
}
