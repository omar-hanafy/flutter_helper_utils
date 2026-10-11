import 'package:flutter/painting.dart';
import 'package:flutter_helper_utils/sugar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FHUNullSafeStringExtensions.textSize', () {
    test('measures nonempty text without an ambient text direction', () {
      const text = 'Measure me';
      final painter = TextPainter(
        text: const TextSpan(text: text),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout();
      addTearDown(painter.dispose);

      expect(text.textSize, painter.size);
      expect(text.textSize.width, greaterThan(0));
    });

    test('treats a nullable string as empty text', () {
      const String? text = null;

      expect(text.textSize, ''.textSize);
      expect(text.textSize.width, 0);
    });
  });
}
