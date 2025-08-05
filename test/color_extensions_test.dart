import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FHUColorExt - Channel Setters', () {
    test('setOpacity sets the opacity correctly', () {
      const color = Color(0xFFFF0000); // Opaque red
      final result = color.setOpacity(0.5);
      expect(result.a, closeTo(0.5, 0.001));
      expect(result.r, closeTo(1.0, 0.001));
      expect(result.g, closeTo(0.0, 0.001));
      expect(result.b, closeTo(0.0, 0.001));
    });

    test('setAlpha sets the alpha channel correctly', () {
      const color = Color(0xFFFF0000); // Opaque red
      final result = color.setAlpha(128);
      expect(result.a, closeTo(0.502, 0.01)); // 128/255 ≈ 0.502
      expect(result.r, closeTo(1.0, 0.001));
    });

    test('setRed sets the red channel correctly', () {
      const color = Color(0xFF000000); // Black
      final result = color.setRed(128);
      expect(result.r, closeTo(0.502, 0.01)); // 128/255 ≈ 0.502
      expect(result.g, closeTo(0.0, 0.001));
      expect(result.b, closeTo(0.0, 0.001));
    });

    test('setGreen sets the green channel correctly', () {
      const color = Color(0xFF000000); // Black
      final result = color.setGreen(128);
      expect(result.r, closeTo(0.0, 0.001));
      expect(result.g, closeTo(0.502, 0.01)); // 128/255 ≈ 0.502
      expect(result.b, closeTo(0.0, 0.001));
    });

    test('setBlue sets the blue channel correctly', () {
      const color = Color(0xFF000000); // Black
      final result = color.setBlue(128);
      expect(result.r, closeTo(0.0, 0.001));
      expect(result.g, closeTo(0.0, 0.001));
      expect(result.b, closeTo(0.502, 0.01)); // 128/255 ≈ 0.502
    });

    test('chaining set* methods works correctly', () {
      const color = Color(0xFF000000); // Black
      final result =
          color.setRed(255).setGreen(128).setBlue(64).setOpacity(0.75);

      expect(result.r, closeTo(1.0, 0.001));
      expect(result.g, closeTo(0.502, 0.01));
      expect(result.b, closeTo(0.251, 0.01));
      expect(result.a, closeTo(0.75, 0.001));
    });

    test('scaleOpacity scales the opacity correctly', () {
      const color = Color(0xFFFF0000); // Opaque red
      final halfOpacity = color.scaleOpacity(0.5);
      expect(halfOpacity.a, closeTo(0.5, 0.001));

      final quarterOpacity = halfOpacity.scaleOpacity(0.5);
      expect(quarterOpacity.a, closeTo(0.25, 0.001));
    });
  });

  group('FHUColorExt - Deprecated Methods', () {
    test('deprecated addOpacity still works', () {
      const color = Color(0xFFFF0000);
      // ignore: deprecated_member_use_from_same_package
      final result = color.addOpacity(0.5);
      expect(result.a, closeTo(0.5, 0.001));
    });

    test('deprecated addAlpha still works', () {
      const color = Color(0xFFFF0000);
      // ignore: deprecated_member_use_from_same_package
      final result = color.addAlpha(128);
      expect(result.a, closeTo(0.502, 0.01));
    });

    test('deprecated addRed still works', () {
      const color = Color(0xFF000000);
      // ignore: deprecated_member_use_from_same_package
      final result = color.addRed(255);
      expect(result.r, closeTo(1.0, 0.001));
    });

    test('deprecated addGreen still works', () {
      const color = Color(0xFF000000);
      // ignore: deprecated_member_use_from_same_package
      final result = color.addGreen(255);
      expect(result.g, closeTo(1.0, 0.001));
    });

    test('deprecated addBlue still works', () {
      const color = Color(0xFF000000);
      // ignore: deprecated_member_use_from_same_package
      final result = color.addBlue(255);
      expect(result.b, closeTo(1.0, 0.001));
    });
  });

  group('CSS-compliant hue parsing', () {
    // Note: Legacy HSL syntax doesn't support negative values due to regex limitations
    // from the dart_helper_utils package. Testing modern syntax only for negative values.

    test('modern syntax with negative hue', () {
      final color1 = 'hsl(-10 100% 50%)'.toColor;
      final color2 = 'hsl(350 100% 50%)'.toColor;

      expect(color1, isNotNull);
      expect(color2, isNotNull);
      expect(color1!.toARGBInt(), equals(color2!.toARGBInt()));
    });

    test('modern syntax with hue > 360', () {
      final color1 = 'hsl(370 100% 50%)'.toColor;
      final color2 = 'hsl(10 100% 50%)'.toColor;

      expect(color1, isNotNull);
      expect(color2, isNotNull);
      expect(color1!.toARGBInt(), equals(color2!.toARGBInt()));
    });

    test('modern syntax with large positive hue', () {
      final color1 = 'hsl(730 100% 50%)'.toColor;
      final color2 = 'hsl(10 100% 50%)'.toColor;

      expect(color1, isNotNull);
      expect(color2, isNotNull);
      expect(color1!.toARGBInt(), equals(color2!.toARGBInt()));
    });

    test('modern syntax with large negative hue', () {
      final color1 = 'hsl(-370 100% 50%)'.toColor;
      final color2 = 'hsl(350 100% 50%)'.toColor;

      expect(color1, isNotNull);
      expect(color2, isNotNull);
      expect(color1!.toARGBInt(), equals(color2!.toARGBInt()));
    });

    test('modern syntax with negative hue and units', () {
      final color1 = 'hsl(-10deg 100% 50%)'.toColor;
      final color2 = 'hsl(350deg 100% 50%)'.toColor;

      expect(color1, isNotNull);
      expect(color2, isNotNull);
      expect(color1!.toARGBInt(), equals(color2!.toARGBInt()));
    });

    test('modern syntax with negative turns', () {
      // -0.5 turns = -180 degrees = 180 degrees
      final color1 = 'hsl(-0.5turn 100% 50%)'.toColor;
      final color2 = 'hsl(180deg 100% 50%)'.toColor;

      expect(color1, isNotNull);
      expect(color2, isNotNull);
      expect(color1!.toARGBInt(), equals(color2!.toARGBInt()));
    });

    test('modern syntax with negative radians', () {
      // -π radians = -180 degrees = 180 degrees
      final color1 = 'hsl(-3.14159rad 100% 50%)'.toColor;
      final color2 = 'hsl(180deg 100% 50%)'.toColor;

      expect(color1, isNotNull);
      expect(color2, isNotNull);
      // Allow some tolerance due to π approximation
      expect((color1!.r - color2!.r).abs(), lessThan(0.01));
      expect((color1.g - color2.g).abs(), lessThan(0.01));
      expect((color1.b - color2.b).abs(), lessThan(0.01));
    });

    test('modern syntax with negative gradians', () {
      // -400 gradians = -360 degrees = 0 degrees
      final color1 = 'hsl(-400grad 100% 50%)'.toColor;
      final color2 = 'hsl(0deg 100% 50%)'.toColor;

      expect(color1, isNotNull);
      expect(color2, isNotNull);
      expect(color1!.toARGBInt(), equals(color2!.toARGBInt()));
    });
  });

  group('FHUColorExt - Other Methods', () {
    test('toHex works correctly', () {
      const color = Color(0xFFFF0000);
      expect(color.toHex(), equals('#ff0000'));
      expect(color.toHex(includeAlpha: true), equals('#ffff0000'));
      expect(color.toHex(leadingHashSign: false), equals('ff0000'));
      expect(color.toHex(uppercase: true), equals('#FF0000'));
    });

    test('isDark and isLight work correctly', () {
      const black = Color(0xFF000000);
      const white = Color(0xFFFFFFFF);
      const gray = Color(0xFF808080);

      expect(black.isDark(), isTrue);
      expect(black.isLight(), isFalse);

      expect(white.isDark(), isFalse);
      expect(white.isLight(), isTrue);

      // Gray is on the edge, depends on threshold
      expect(gray.isDark(threshold: 0.5), isTrue);
      expect(gray.isLight(threshold: 0.5), isFalse);
    });

    test('complementary works correctly', () {
      const red = Color(0xFFFF0000);
      final cyan = red.complementary();

      // Red's complement is cyan
      expect(cyan.r, closeTo(0.0, 0.1));
      expect(cyan.g, closeTo(1.0, 0.1));
      expect(cyan.b, closeTo(1.0, 0.1));
    });

    test('grayscale works correctly', () {
      const red = Color(0xFFFF0000);
      final gray = red.grayscale();

      // All channels should be equal in grayscale
      expect(gray.r, equals(gray.g));
      expect(gray.g, equals(gray.b));
      expect(gray.a, equals(red.a)); // Alpha preserved
    });

    test('invert works correctly', () {
      const red = Color(0xFFFF0000);
      final inverted = red.invert();

      expect(inverted.r, closeTo(0.0, 0.001));
      expect(inverted.g, closeTo(1.0, 0.001));
      expect(inverted.b, closeTo(1.0, 0.001));
      expect(inverted.a, equals(red.a)); // Alpha preserved
    });
  });
}
