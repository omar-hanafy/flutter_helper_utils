import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color Harmonies', () {
    test('complementary harmony returns opposite hue', () {
      const red = Color(0xFFFF0000);
      final cyan = red.complementary();

      // Red's complement should be cyan (hue ~180)
      final redHsl = HSLColor.fromColor(red);
      final cyanHsl = HSLColor.fromColor(cyan);

      expect((cyanHsl.hue - redHsl.hue).abs(), closeTo(180, 1));
    });

    test('triadic harmony returns 3 evenly spaced colors', () {
      const blue = Color(0xFF0000FF);
      final triadic = blue.triadic();

      expect(triadic.length, equals(3));
      expect(triadic[0], equals(blue));

      // Check that colors are ~120 degrees apart
      final hues = triadic.map((c) => HSLColor.fromColor(c).hue).toList();

      // Calculate hue differences accounting for wrapping
      double hueDifference(double h1, double h2) {
        final diff = (h2 - h1).abs();
        return diff > 180 ? 360 - diff : diff;
      }

      final diff1 = hueDifference(hues[0], hues[1]);
      final diff2 = hueDifference(hues[1], hues[2]);

      expect(diff1, closeTo(120, 1));
      expect(diff2, closeTo(120, 1));
    });

    test('tetradic harmony returns 4 evenly spaced colors', () {
      const green = Color(0xFF00FF00);
      final tetradic = green.tetradic();

      expect(tetradic.length, equals(4));
      expect(tetradic[0], equals(green));

      // Check that colors are ~90 degrees apart
      final hues = tetradic.map((c) => HSLColor.fromColor(c).hue).toList();

      // Calculate hue differences accounting for wrapping
      double hueDifference(double h1, double h2) {
        final diff = (h2 - h1).abs();
        return diff > 180 ? 360 - diff : diff;
      }

      for (var i = 1; i < hues.length; i++) {
        final diff = hueDifference(hues[i - 1], hues[i]);
        expect(diff, closeTo(90, 1));
      }
    });

    test('split complementary uses correct angles', () {
      const yellow = Color(0xFFFFFF00);
      final split = yellow.splitComplementary();

      expect(split.length, equals(3));
      expect(split[0], equals(yellow));

      // Check angles relative to complement (180°)
      final yellowHue = HSLColor.fromColor(yellow).hue;
      final hue1 = HSLColor.fromColor(split[1]).hue;
      final hue2 = HSLColor.fromColor(split[2]).hue;

      // Should be at 150° and 210° from original
      expect((hue1 - yellowHue).abs() % 360, closeTo(150, 1));
      expect((hue2 - yellowHue).abs() % 360, closeTo(210, 1));
    });

    test('analogous harmony creates adjacent colors', () {
      const purple = Color(0xFF800080);
      final analogous = purple.analogous(count: 5, angle: 15);

      expect(analogous.length, equals(5));

      // Middle color should be close to original
      expect(analogous[2].toARGBInt(), equals(purple.toARGBInt()));

      // Check spacing
      final hues = analogous.map((c) => HSLColor.fromColor(c).hue).toList();
      for (var i = 1; i < hues.length; i++) {
        final diff = (hues[i] - hues[i - 1]).abs();
        expect(diff, closeTo(15, 1));
      }
    });

    test('monochromatic harmony varies lightness', () {
      const orange = Color(0xFFFF8800);
      final mono = orange.monochromatic(lightnessRange: 0.6);

      expect(mono.length, equals(5));

      // All should have same hue
      final hues = mono.map((c) => HSLColor.fromColor(c).hue).toList();
      for (var i = 1; i < hues.length; i++) {
        expect(hues[i], closeTo(hues[0], 1));
      }

      // Lightness should vary
      final lightnesses =
          mono.map((c) => HSLColor.fromColor(c).lightness).toList();
      expect(lightnesses.first, lessThan(lightnesses.last));

      // Check range (with small tolerance for floating point)
      final range = lightnesses.last - lightnesses.first;
      expect(range, lessThan(0.61));
    });

    test('grayscale colors maintain harmony', () {
      const gray = Color(0xFF808080);
      final complementary = gray.complementary();

      // Grayscale should return same color since hue is undefined
      expect(complementary.toARGBInt(), equals(gray.toARGBInt()));
    });

    test('preserves color space and alpha', () {
      const semiTransparent = Color(0x80FF0000); // 50% transparent red
      final triadic = semiTransparent.triadic();

      for (final color in triadic) {
        expect(color.a, closeTo(semiTransparent.a, 0.01));
        expect(color.colorSpace, equals(semiTransparent.colorSpace));
      }
    });
  });

  group('WCAG Accessibility', () {
    test('meetsWCAG correctly evaluates contrast ratios', () {
      const white = Color(0xFFFFFFFF);
      const black = Color(0xFF000000);
      const gray = Color(0xFF767676); // Adjusted to meet AA (exactly 4.5:1)
      const lightGray = Color(0xFFCCCCCC);

      // Black on white should meet all standards
      expect(white.meetsWCAG(black), isTrue);
      expect(white.meetsWCAG(black, level: WCAGLevel.aaa), isTrue);

      // Gray on white - depends on level
      expect(white.meetsWCAG(gray), isTrue); // Should be ~4.5:1
      expect(white.meetsWCAG(gray, level: WCAGLevel.aaa), isFalse);

      // Light gray on white - fails normal text
      expect(white.meetsWCAG(lightGray), isFalse); // ~1.6:1
      expect(
        white.meetsWCAG(lightGray, context: WCAGContext.largeText),
        isFalse, // Still too low
      );

      // UI components have lower requirement (3:1)
      const uiGray = Color(0xFF767676); // Same as AA gray, definitely meets 3:1
      expect(
        white.meetsWCAG(uiGray, context: WCAGContext.uiComponent),
        isTrue, // Should meet 3:1 requirement
      );
    });

    test('suggestAccessibleColors provides appropriate suggestions', () {
      const lightBlue = Color(0xFF87CEEB); // Sky blue
      final suggestions = lightBlue.suggestAccessibleColors();

      // Should suggest dark colors for light background
      expect(suggestions.normalText.computeLuminance(), lessThan(0.5));
      expect(suggestions.largeText.computeLuminance(), lessThan(0.5));

      // Verify suggestions meet requirements
      expect(lightBlue.meetsWCAG(suggestions.normalText), isTrue);
      expect(
        lightBlue.meetsWCAG(
          suggestions.largeText,
          context: WCAGContext.largeText,
        ),
        isTrue,
      );
      expect(
        lightBlue.meetsWCAG(
          suggestions.uiComponent,
          context: WCAGContext.uiComponent,
        ),
        isTrue,
      );
    });

    test('suggestAccessibleColors handles AAA level', () {
      // Use a color that can achieve AAA contrast
      const lightBackground = Color(0xFFF0F0F0); // Very light gray
      final suggestionsAA = lightBackground.suggestAccessibleColors();
      final suggestionsAAA = lightBackground.suggestAccessibleColors(
        level: WCAGLevel.aaa,
      );

      // Verify AA suggestions meet AA requirements
      expect(
        lightBackground.meetsWCAG(suggestionsAA.normalText),
        isTrue,
      );

      // Verify AAA suggestions meet AAA requirements
      expect(
        lightBackground.meetsWCAG(
          suggestionsAAA.normalText,
          level: WCAGLevel.aaa,
        ),
        isTrue,
      );

      // AAA normal text should have contrast >= 7.0
      expect(
        lightBackground.contrast(suggestionsAAA.normalText),
        greaterThanOrEqualTo(7.0),
      );
    });

    test('contrast calculation is symmetric', () {
      const color1 = Color(0xFF336699);
      const color2 = Color(0xFFFFCC00);

      expect(color1.contrast(color2), equals(color2.contrast(color1)));
    });
  });

  group('Color Blindness Simulation', () {
    test('protanopia simulation affects red channel', () {
      const red = Color(0xFFFF0000);
      const green = Color(0xFF00FF00);

      final redSim = red.simulateColorBlindness(ColorBlindnessType.protanopia);
      final greenSim =
          green.simulateColorBlindness(ColorBlindnessType.protanopia);

      // Red and green should appear more similar
      final normalContrast = red.contrast(green);
      final simContrast = redSim.contrast(greenSim);

      expect(simContrast, lessThan(normalContrast));
    });

    test('deuteranopia simulation affects green channel', () {
      const red = Color(0xFFFF0000);
      const green = Color(0xFF00FF00);

      final redSim =
          red.simulateColorBlindness(ColorBlindnessType.deuteranopia);
      final greenSim =
          green.simulateColorBlindness(ColorBlindnessType.deuteranopia);

      // Similar to protanopia, red-green distinction reduced
      final normalContrast = red.contrast(green);
      final simContrast = redSim.contrast(greenSim);

      expect(simContrast, lessThan(normalContrast));
    });

    test('tritanopia simulation affects blue-yellow', () {
      const blue = Color(0xFF0000FF);
      const yellow = Color(0xFFFFFF00);

      final blueSim =
          blue.simulateColorBlindness(ColorBlindnessType.tritanopia);
      final yellowSim =
          yellow.simulateColorBlindness(ColorBlindnessType.tritanopia);

      // Blue-yellow distinction should be reduced
      final normalContrast = blue.contrast(yellow);
      final simContrast = blueSim.contrast(yellowSim);

      expect(simContrast, lessThan(normalContrast));
    });

    test('achromatopsia converts to grayscale', () {
      const colorful = Color(0xFFFF00FF); // Magenta
      final achromatic = colorful.simulateColorBlindness(
        ColorBlindnessType.achromatopsia,
      );

      // Should be grayscale (R = G = B)
      expect(achromatic.r, closeTo(achromatic.g, 0.01));
      expect(achromatic.g, closeTo(achromatic.b, 0.01));
    });

    test('isDistinguishableFor checks color pairs', () {
      const problematicRed = Color(0xFFCC0000);
      const problematicGreen = Color(0xFF009900);
      const safeBlue = Color(0xFF0066CC);
      const safeOrange = Color(0xFFFF9900);

      // Red-green pair problematic for protanopia
      expect(
        problematicRed.isDistinguishableFor(
          problematicGreen,
          ColorBlindnessType.protanopia,
        ),
        isFalse,
      );

      // Blue-orange pair should work better
      expect(
        safeBlue.isDistinguishableFor(
          safeOrange,
          ColorBlindnessType.protanopia,
        ),
        isTrue,
      );
    });

    test('simulation preserves alpha and color space', () {
      const semiTransparent = Color(0x80FF0000); // 50% transparent red

      for (final type in ColorBlindnessType.values) {
        final simulated = semiTransparent.simulateColorBlindness(type);
        expect(simulated.a, closeTo(semiTransparent.a, 0.01));
        expect(simulated.colorSpace, equals(semiTransparent.colorSpace));
      }
    });
  });

  group('Edge Cases and Integration', () {
    test('handles extreme color values', () {
      const colors = [
        Color(0xFF000000), // Black
        Color(0xFFFFFFFF), // White
        Color(0x00000000), // Transparent
        Color(0xFF7F7F7F), // Middle gray
      ];

      for (final color in colors) {
        // Should not throw
        expect(color.triadic, returnsNormally);
        expect(color.analogous, returnsNormally);
        expect(color.monochromatic, returnsNormally);
        expect(color.suggestAccessibleColors, returnsNormally);
        expect(
          () => color.simulateColorBlindness(ColorBlindnessType.protanopia),
          returnsNormally,
        );
      }
    });

    test('parameter validation', () {
      const color = Color(0xFF0000FF);

      // Invalid split angle
      expect(
        () => color.splitComplementary(angle: 0),
        throwsAssertionError,
      );
      expect(
        () => color.splitComplementary(angle: 90),
        throwsAssertionError,
      );

      // Invalid analogous count
      expect(
        () => color.analogous(count: 1),
        throwsAssertionError,
      );

      // Invalid analogous angle
      expect(
        () => color.analogous(angle: 0),
        throwsAssertionError,
      );
      expect(
        () => color.analogous(angle: 61),
        throwsAssertionError,
      );

      // Invalid monochromatic count
      expect(
        () => color.monochromatic(count: 1),
        throwsAssertionError,
      );

      // Invalid lightness range
      expect(
        () => color.monochromatic(lightnessRange: 0),
        throwsAssertionError,
      );
      expect(
        () => color.monochromatic(lightnessRange: 1.1),
        throwsAssertionError,
      );
    });

    test('real-world color scheme generation', () {
      // Brand color
      const brandBlue = Color(0xFF1E88E5);

      // Generate full color scheme
      const primary = brandBlue;
      final complementary = brandBlue.splitComplementary(angle: 15);
      final shades = brandBlue.monochromatic(lightnessRange: 0.7);

      // Verify all colors are accessible
      final background = shades.last; // Lightest shade
      final text = background.suggestAccessibleColors().normalText;

      expect(background.meetsWCAG(text), isTrue);

      // Check if primary and one of the split complementary colors
      // are distinguishable for color blind users
      expect(
        primary.isDistinguishableFor(
          complementary[1], // Use split complementary instead of analogous
          ColorBlindnessType.protanopia,
          minContrast: 2, // Lower threshold for color pairs
        ),
        isTrue,
      );
    });
  });
}
