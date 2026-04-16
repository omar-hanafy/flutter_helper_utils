import 'package:flutter/material.dart';

/// Nullable string helpers that derive layout information.
extension FHUNullSafeStringExtensions on String? {
  // all string extensions could be found in the https://
  // String get withoutWhiteSpaces => isEmptyOrNull ? '' : this!.replaceAll(RegExp(r'\s+\b|\b\s'), '');
  /// Measures the rendered size of this string using a single-line [TextPainter].
  ///
  /// A `null` value is treated as empty text.
  Size get textSize {
    final textPainter = TextPainter(text: TextSpan(text: this), maxLines: 1)
      ..layout();
    return textPainter.size;
  }
}
