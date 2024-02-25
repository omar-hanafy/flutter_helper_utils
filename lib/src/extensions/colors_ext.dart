import 'package:flutter/material.dart';

extension HexColor on Color {
  /// converts current color to hex in string format.
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      // '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension ColorExt on String {
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
