import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_helper_utils/src/extensions/flutter_extensions/colors/colors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FHUStringToColorExtension', () {
    group('isValidColor', () {
      // Map each valid input to a short description.
      <String, String>{
        // Hex formats.
        '#abc': '3-digit hex with #',
        '0x123': '3-digit hex with 0x',
        '#AABBCC': '6-digit hex with #',
        '0xFF123456': '8-digit hex with 0x',
        '#abcd': '4-digit hex with #',
        '0x1234': '4-digit hex with 0x',
        // RGB/RGBA legacy.
        'rgb(255, 0, 0)': 'rgb with integers',
        'rgba(255, 0, 0, 1.0)': 'rgba with 1.0 alpha',
        'rgba(0, 100, 200, 0.5)': 'rgba with float alpha',
        'rgb(10%, 50%, 90%)': 'rgb with percentages',
        'rgba(10%, 50%, 90%,40%)': 'rgba with percentage alpha',
        // HSL/HSLA legacy.
        'hsla(180, 100%, 50%, 0.5)': 'hsla valid',
        'hsl(180, 100%, 50%)': 'hsl valid',
        'hsl(120deg, 50%, 50%)': 'hsl with deg unit',
        'hsl(3.1416rad, 50%, 50%)': 'hsl with rad unit',
        'hsl(0.5turn, 50%, 50%)': 'hsl with turn unit',
        'hsl(200grad, 50%, 50%)': 'hsl with grad unit',
        // Modern syntax (comma-free).
        'rgb(255 0 0)': 'modern rgb without commas',
        'rgba(0 100 200 / 0.5)': 'modern rgba with slash alpha',
        'hsl(180 100% 50%)': 'modern hsl',
        'hsla(180 100% 50% / 0.5)': 'modern hsla with slash',
        'hwb(180 50% 50%)': 'modern hwb',
        'hwb(180 50% 50% / 0.5)': 'modern hwb with alpha',
        // Named colors and special keywords.
        'red': 'named color (red)',
        'RED': 'named color, uppercase',
        'aliceblue': 'named color (aliceblue)',
        'transparent': 'special keyword transparent',
      }.forEach((input, description) {
        test('Valid: $description → "$input"', () {
          expect(input.isValidColor, isTrue);
        });
      });

      final invalidInputs = [
        // Hexes.
        '#ab', // too short
        '#abcg', // invalid character
        '0x1234567', // invalid length
        '#', '0x',
        // RGB/RGBA.
        'rgb(256, 0, 0)', // out-of-range value
        'rgb(-1, 0, 0)', // negative number
        'rgb(0, 0, 0, 0)', // too many values for rgb()
        'rgb(0, 0)', // too few values
        'rgb(10,10,100%)', // mixed integer and percentage
        'rgba(10,10,10,101%)', // alpha > 100%
        'rgba(10,10,10, -10%)', // negative alpha
        // HSL/HSLA.
        'hsl(180, 101%, 50%)', // saturation too high
        'hsl(180, 100%, -1%)', // lightness negative
        'hsla(180, 100%, 50%, -0.1)', // negative alpha
        'hsla(180, 100%, 50%, 1.1)', // alpha > 1
        'hsl(180, 100, 50)', // missing '%' on saturation/lightness
        // Modern syntax errors.
        'rgb(255 0 0 0)', // too many values

        'hwb(180, 50%, 50%)', // commas not allowed
        'hwb(180 50% 50% / -0.5)', // negative alpha in modern syntax
        'hwb(180 101% 50%)', // saturation out-of-range for hwb
        'hwb(180 50% 101%)', // brightness out-of-range for hwb
        // Named color mistakes.
        'notacolor',
        // Completely invalid strings.
        'some invalid string',
        '',
      ];

      for (final input in invalidInputs) {
        test('Invalid: "$input"', () {
          debugPrint('Invalid: "$input", ${input.isValidColor}');
          expect(input.isValidColor, isFalse);
        });
      }
    });

    group('isHexColor', () {
      final validHexes = [
        '#abc',
        '0x123',
        '#AABBCC',
        '0xFF123456',
        '#abcd',
        '0x1234',
      ];
      for (final input in validHexes) {
        test('Valid hex: "$input"', () {
          expect(input.isHexColor, isTrue);
        });
      }

      final invalidHexes = [
        '#ab',
        '#abcg',
        '0x1234567',
        'red',
        'rgb(255, 0, 0)',
      ];
      for (final input in invalidHexes) {
        test('Invalid hex: "$input"', () {
          expect(input.isHexColor, isFalse);
        });
      }
    });

    group('isRgbColor', () {
      final validRgb = [
        'rgb(255, 0, 0)',
        'rgba(0, 100, 200, 0.5)',
        'rgb(10%, 50%, 90%)',
        'rgba(10%, 50%, 90%, 40%)',
      ];
      for (final input in validRgb) {
        test('Valid rgb: "$input"', () {
          expect(input.isRgbColor, isTrue);
        });
      }

      final invalidRgb = [
        'rgb(256, 0, 0)',
        'rgb(0, 0, 0, 0)',
        '#AABBCC',
        'hsl(180, 100%, 50%)',
        'rgba(10,10,10,101%)',
      ];
      for (final input in invalidRgb) {
        test('Invalid rgb: "$input"', () {
          expect(input.isRgbColor, isFalse);
        });
      }
    });

    group('isHslColor', () {
      final validHsl = [
        'hsl(180, 100%, 50%)',
        'hsla(180, 100%, 50%, 0.5)',
        'hsl(120deg, 50%, 50%)',
        'hsl(3.1416rad, 50%, 50%)',
        'hsl(0.5turn, 50%, 50%)',
        'hsl(200grad, 50%, 50%)',
      ];
      for (final input in validHsl) {
        test('Valid hsl: "$input"', () {
          expect(input.isHslColor, isTrue);
        });
      }

      final invalidHsl = [
        'hsl(180, 101%, 50%)',
        'hsl(180, 100%, -1%)',
        'hsla(180, 100%, 50%, -0.1)',
        'hsla(180, 100%, 50%, 1.1)',
        'hsl(180, 100, 50)', // missing '%'
      ];
      for (final input in invalidHsl) {
        test('Invalid hsl: "$input"', () {
          expect(input.isHslColor, isFalse);
        });
      }
    });

    group('isModernColor', () {
      final validModern = [
        'rgb(255 0 0)',
        'rgba(0 100 200 / 0.5)',
        'hsl(180 100% 50%)',
        'hsla(180 100% 50% / 0.5)',
        'hwb(180 50% 50%)',
        'hwb(180 50% 50% / 0.5)',
        'hwb(190 0% 0% / 0.15)',
      ];
      for (final input in validModern) {
        test('Valid modern: "$input"', () {
          expect(input.isModernColor, isTrue);
        });
      }

      final invalidModern = [
        'rgb(255, 0, 0)', // commas not allowed
        'rgb(255 0 0 0)', // too many values
        'hsl(180, 100%, 50%)',
        'hwb(180, 50%, 50%)',
        'hwb(180 50% 50% / -0.5)',
        '#AABBCC',
        'red',
        'hwb(180 101% 50%)',
        'hwb(180 50% 101%)',
      ];
      for (final input in invalidModern) {
        test('Invalid modern: "$input"', () {
          expect(input.isModernColor, isFalse);
        });
      }
    });

    group('toColor', () {
      // A helper function to test conversion.
      void checkColorConversion(String input, int expectedArgb,
          {String? description}) {
        test('toColor "$input" ${description ?? ""}', () {
          final color = input.toColor;
          expect(color, isNotNull, reason: 'Could not parse "$input"');
          expect(color!.toARGBInt(), equals(expectedArgb),
              reason:
                  'Expected ARGB 0x${expectedArgb.toRadixString(16)} for "$input"');
        });
      }

      group('Hex conversions', () {
        checkColorConversion('#abc', 0xFFAABBCC, description: '3-digit hex');
        checkColorConversion('0x123', 0xFF112233,
            description: '3-digit hex with 0x');
        checkColorConversion('#AABBCC', 0xFFAABBCC, description: '6-digit hex');
        checkColorConversion('0xFF123456', 0x56FF1234,
            description: '8-digit hex with 0x (swapped ARGB)');
        checkColorConversion('#abcd', 0xDDAABBCC, description: '4-digit hex');
        checkColorConversion('0x1234', 0x44112233,
            description: '4-digit hex with 0x');
      });

      group('RGB(A) conversions', () {
        checkColorConversion('rgb(255, 0, 0)', 0xFFFF0000);
        checkColorConversion('rgb(0,255,0)', 0xFF00FF00);
        checkColorConversion('rgb(0,0,255)', 0xFF0000FF);
        checkColorConversion('rgba(0, 255, 0, 0.5)', 0x8000FF00,
            description: 'rgba with float alpha');
        checkColorConversion('rgba(10%, 50%, 90%, 40%)', 0x661A80E6,
            description: 'rgba with percentages');
        checkColorConversion('rgb(10%, 50%, 90%)', 0xFF1A80E6,
            description: 'rgb with percentages');
      });

      group('HSL(A) conversions', () {
        // These expected values assume proper conversion from HSL to RGB.
        checkColorConversion('hsl(0, 100%, 50%)', 0xFFFF0000,
            description: 'Red');
        checkColorConversion('hsl(120, 100%, 50%)', 0xFF00FF00,
            description: 'Green');
        checkColorConversion('hsl(240, 100%, 50%)', 0xFF0000FF,
            description: 'Blue');
        checkColorConversion('hsl(0, 0%, 0%)', 0xFF000000,
            description: 'Black');
        checkColorConversion('hsl(0, 0%, 100%)', 0xFFFFFFFF,
            description: 'White');
        checkColorConversion('hsla(0, 100%, 50%, 0.5)', 0x80FF0000,
            description: 'hsla with float alpha');
      });

      group('Modern syntax conversions', () {
        checkColorConversion('rgb(255 0 0)', 0xFFFF0000,
            description: 'modern rgb');
        checkColorConversion('rgba(0 100 200 / 0.5)', 0x800064C8,
            description: 'modern rgba');
        checkColorConversion('hsl(180 100% 50%)', 0xFF00FFFF,
            description: 'modern hsl (cyan)');
        checkColorConversion('hsla(180 100% 50% / 0.5)', 0x8000FFFF,
            description: 'modern hsla (cyan with alpha)');
        // For hwb we only verify that a non-null Color is returned.
        test('hwb conversion returns a Color', () {
          expect('hwb(180 50% 50%)'.toColor, isNotNull);
          expect('hwb(180 50% 50% / 0.5)'.toColor, isNotNull);
        });
      });

      group('Named colors and keywords', () {
        checkColorConversion('red', 0xFFFF0000,
            description: 'named color red (case-insensitive)');
        test('aliceblue', () {
          final expected = cssColorNamesToArgb['aliceblue'];
          expect('aliceblue'.toColor, isNotNull);
          expect('aliceblue'.toColor!.toARGBInt(), equals(expected));
        });
        checkColorConversion('transparent', 0x00000000,
            description: 'transparent keyword');
      });

      group('Invalid inputs return null', () {
        final invalids = [
          'notacolor',
          'rgb(256, 0, 0)',
          'hsl(100, 101%, 50%)',
          'some invalid string',
          '',
        ];
        for (final input in invalids) {
          test('toColor returns null for "$input"', () {
            expect(input.toColor, isNull);
          });
        }
      });
    });
    group('Color Parsing Performance Tests', () {
      // Helper function to measure performance
      Future<double> measureParsingTime(void Function() operation) async {
        final stopwatch = Stopwatch()..start();
        operation();
        stopwatch.stop();
        return stopwatch.elapsedMicroseconds / 1000; // Convert to milliseconds
      }

      test('Bulk hex color parsing performance', () async {
        const iterations = 10000;
        final hexColors = List.generate(
          iterations,
          (i) => '#${(i % 256).toRadixString(16).padLeft(2, '0')}'
              '${((i + 85) % 256).toRadixString(16).padLeft(2, '0')}'
              '${((i + 170) % 256).toRadixString(16).padLeft(2, '0')}',
        );

        final time = await measureParsingTime(() {
          for (final color in hexColors) {
            color.toColor;
          }
        });

        debugPrint(
            'Parsed $iterations hex colors in ${time.toStringAsFixed(2)}ms');
        expect(time, lessThan(1000)); // Should complete within 1 second
      });

      test('Bulk RGB color parsing performance', () async {
        const iterations = 10000;
        final rgbColors = List.generate(
          iterations,
          (i) => 'rgb(${i % 256}, ${(i + 85) % 256}, ${(i + 170) % 256})',
        );

        final time = await measureParsingTime(() {
          for (final color in rgbColors) {
            color.toColor;
          }
        });

        debugPrint(
            'Parsed $iterations RGB colors in ${time.toStringAsFixed(2)}ms');
        expect(time, lessThan(1000)); // Should complete within 1 second
      });

      test('Bulk HSL color parsing performance', () async {
        const iterations = 10000;
        final hslColors = List.generate(
          iterations,
          (i) => 'hsl(${i % 360}, ${50 + i % 50}%, ${30 + i % 70}%)',
        );

        final time = await measureParsingTime(() {
          for (final color in hslColors) {
            color.toColor;
          }
        });

        debugPrint(
            'Parsed $iterations HSL colors in ${time.toStringAsFixed(2)}ms');
        expect(time, lessThan(1000)); // Should complete within 1 second
      });

      test('Mixed format parsing performance', () async {
        const iterations = 10000;
        final mixedColors = List.generate(iterations, (i) {
          switch (i % 3) {
            case 0:
              return '#${(i % 256).toRadixString(16).padLeft(2, '0')}${((i + 85) % 256).toRadixString(16).padLeft(2, '0')}${((i + 170) % 256).toRadixString(16).padLeft(2, '0')}';
            case 1:
              return 'rgb(${i % 256}, ${(i + 85) % 256}, ${(i + 170) % 256})';
            default:
              return 'hsl(${i % 360}, ${50 + i % 50}%, ${30 + i % 70}%)';
          }
        });

        final time = await measureParsingTime(() {
          for (final color in mixedColors) {
            color.toColor;
          }
        });

        debugPrint(
            'Parsed $iterations mixed format colors in ${time.toStringAsFixed(2)}ms');
        expect(time, lessThan(1000)); // Should complete within 1 second
      });
    });

    group('Color Interpolation Edge Cases', () {
      test('Edge case - Interpolation between extreme values', () {
        const colors = {
          'rgb(0, 0, 0)': 'rgb(255, 255, 255)',
          // Black to White
          'rgb(255, 0, 0)': 'rgb(0, 255, 0)',
          // Red to Green
          'hsl(0, 100%, 50%)': 'hsl(180, 100%, 50%)',
          // Red to Cyan
          'hsla(0, 100%, 50%, 1)': 'hsla(0, 100%, 50%, 0)',
          // Full to transparent
        };

        for (final entry in colors.entries) {
          final color1 = entry.key.toColor;
          final color2 = entry.value.toColor;

          debugPrint('Testing interpolation: ${entry.key} to ${entry.value}');
          if (color1 == null) {
            fail('Failed to parse first color: ${entry.key}');
          }
          if (color2 == null) {
            fail('Failed to parse second color: ${entry.value}');
          }

          // Test multiple interpolation points
          for (var t = 0.0; t <= 1.0; t += 0.1) {
            final interpolated = Color.lerp(color1, color2, t);
            expect(interpolated, isNotNull);

            // Verify components are within valid ranges
            expect(interpolated!.r, inInclusiveRange(0, 255));
            expect(interpolated.g, inInclusiveRange(0, 255));
            expect(interpolated.b, inInclusiveRange(0, 255));
            expect(interpolated.a, inInclusiveRange(0, 255));
          }
        }
      });

      test('Edge case - HSL wraparound handling', () {
        final testCases = [
          ('hsl(350, 100%, 50%)', 'hsl(10, 100%, 50%)'), // Red wraparound
          ('hsl(0, 100%, 50%)', 'hsl(359, 100%, 50%)'), // Almost full circle
          ('hsl(330, 100%, 50%)', 'hsl(30, 100%, 50%)'), // 60-degree difference
        ];

        for (final (color1Str, color2Str) in testCases) {
          final color1 = color1Str.toColor;
          final color2 = color2Str.toColor;

          debugPrint('Testing HSL wraparound: $color1Str to $color2Str');
          if (color1 == null) {
            fail('Failed to parse first color: $color1Str');
          }
          if (color2 == null) {
            fail('Failed to parse second color: $color2Str');
          }

          // Verify hue interpolation
          final interpolated = Color.lerp(color1, color2, 0.5);
          expect(interpolated, isNotNull);
        }
      });

      test('Edge case - Alpha channel precision', () {
        const alphaSteps = [
          'rgba(255, 0, 0, 0.0)',
          'rgba(255, 0, 0, 0.1)',
          'rgba(255, 0, 0, 0.5)',
          'rgba(255, 0, 0, 0.9)',
          'rgba(255, 0, 0, 1.0)',
        ];

        for (var i = 0; i < alphaSteps.length - 1; i++) {
          final color1 = alphaSteps[i].toColor!;

          final color2 = alphaSteps[i + 1].toColor;
          if (color2 == null) {
            fail('Failed to parse second color: ${alphaSteps[i + 1]}');
          }

          // Test with very small interpolation steps
          for (var t = 0.0; t <= 1.0; t += 0.01) {
            final interpolated = Color.lerp(color1, color2, t);
            expect(interpolated, isNotNull);
            expect(interpolated!.a, inInclusiveRange(0, 255));
          }
        }
      });

      test('Edge case - Modern syntax interpolation', () {
        const modernColors = [
          'rgb(255 0 0)',
          'rgb(0 255 0)',
          'hsl(0 100% 50%)',
          'hsl(120 100% 50%)',
          'hwb(0 0% 0%)',
          'hwb(120 0% 0%)',
        ];

        for (var i = 0; i < modernColors.length - 1; i++) {
          final color1 = modernColors[i].toColor!;
          final color2 = modernColors[i + 1].toColor!;

          for (var t = 0.0; t <= 1.0; t += 0.1) {
            final interpolated = Color.lerp(color1, color2, t);
            expect(interpolated, isNotNull);
          }
        }
      });
    });
  });
}
