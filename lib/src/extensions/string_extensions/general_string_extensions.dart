import 'package:flutter/material.dart';

extension FHUNullSafeStringExtensions on String? {
  // String get withoutWhiteSpaces => isEmptyOrNull ? '' : this!.replaceAll(RegExp(r'\s+\b|\b\s'), '');
  Size get textSize {
    final textPainter = TextPainter(
      text: TextSpan(text: this),
      maxLines: 1,
    )..layout();
    return textPainter.size;
  }
}
