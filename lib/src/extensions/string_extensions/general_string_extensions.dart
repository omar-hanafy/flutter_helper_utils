import 'package:flutter/painting.dart';

/// Nullable string helpers that derive layout information.
extension FHUNullSafeStringExtensions on String? {
  // all string extensions could be found in the https://
  // String get withoutWhiteSpaces => isEmptyOrNull ? '' : this!.replaceAll(RegExp(r'\s+\b|\b\s'), '');
  /// Measures the rendered size of this string using a single-line [TextPainter].
  ///
  /// A `null` value is treated as empty text. Measurement uses left-to-right
  /// direction because this getter has no ambient `Directionality` context.
  Size get textSize {
    final textPainter = TextPainter(
      text: TextSpan(text: this),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    final size = textPainter.size;
    textPainter.dispose();
    return size;
  }
}
