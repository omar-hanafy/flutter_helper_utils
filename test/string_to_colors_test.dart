import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/src/extensions/flutter_extensions/colors/colors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FHUStringToColorExtension', () {
    group('isValidColor', () {
      testWidgets('valid hex colors', (WidgetTester tester) async {
        expect('#abc'.isValidColor, isTrue);
        expect('0x123'.isValidColor, isTrue);
        expect('#AABBCC'.isValidColor, isTrue);
        expect('0xFF123456'.isValidColor, isTrue);
        expect('#abcd'.isValidColor, isTrue);
        expect('0x1234'.isValidColor, isTrue);
        // Note: 0xFF12345678 has 10 hex digits so it’s not supported.
      });

      testWidgets('invalid hex colors', (WidgetTester tester) async {
        expect('#ab'.isValidColor, isFalse); // Too short
        expect('#abcg'.isValidColor, isFalse); // Contains invalid character
        expect('0x1234567'.isValidColor, isFalse); // Length not supported
        expect('#'.isValidColor, isFalse);
        expect('0x'.isValidColor, isFalse);
      });

      testWidgets('valid rgb colors', (WidgetTester tester) async {
        expect('rgb(255, 0, 0)'.isValidColor, isTrue);
        expect('rgba(0, 100, 200, 0.5)'.isValidColor, isTrue);
        expect('rgb(10%, 50%, 90%)'.isValidColor, isTrue);
        expect('rgba(10%, 50%, 90%,40%)'.isValidColor, isTrue);
        expect('rgb(0,0,0)'.isValidColor, isTrue);
        expect('rgb(255,255,255)'.isValidColor, isTrue);
      });

      testWidgets('invalid rgb colors', (WidgetTester tester) async {
        expect('rgb(256, 0, 0)'.isValidColor, isFalse); // 256 out of range
        expect('rgb(-1, 0, 0)'.isValidColor, isFalse); // Negative value
        expect('rgb(0, 0, 0, 0)'.isValidColor, isFalse); // Too many values
        expect('rgb(0, 0)'.isValidColor, isFalse); // Too few values
        expect('rgb(10,10,100%)'.isValidColor, isFalse); // Mixed types
        expect('rgba(10,10,10,101%)'.isValidColor, isFalse); // Alpha > 100%
        expect('rgba(10,10,10, -10%)'.isValidColor, isFalse); // Negative alpha
      });

      testWidgets('valid hsl colors', (WidgetTester tester) async {
        expect('hsl(180, 100%, 50%)'.isValidColor, isTrue);
        expect('hsla(180, 100%, 50%, 0.5)'.isValidColor, isTrue);
        expect('hsl(0, 0%, 0%)'.isValidColor, isTrue);
        expect('hsl(360, 100%, 100%)'.isValidColor, isTrue);
        expect('hsl(120deg, 50%, 50%)'.isValidColor, isTrue);
        expect('hsl(3.1416rad, 50%, 50%)'.isValidColor, isTrue);
        expect('hsl(200grad, 50%, 50%)'.isValidColor, isTrue);
        expect('hsl(0.5turn, 50%, 50%)'.isValidColor, isTrue);
      });

      testWidgets('invalid hsl colors', (WidgetTester tester) async {
        expect('hsl(361, 100%, 50%)'.isValidColor, isFalse); // Hue > 360
        expect(
            'hsl(180, 101%, 50%)'.isValidColor, isFalse); // Saturation > 100%
        expect(
            'hsl(180, 100%, -1%)'.isValidColor, isFalse); // Lightness negative
        expect('hsla(180, 100%, 50%, -0.1)'.isValidColor,
            isFalse); // Alpha negative
        expect('hsla(180, 100%, 50%, 1.1)'.isValidColor, isFalse); // Alpha > 1
        expect('hsl(180, 100, 50)'.isValidColor,
            isFalse); // Missing '%' in saturation/lightness
        expect('hsl(120,50%,50%)'.isValidColor,
            isFalse); // Missing spaces/commas might be rejected
      });

      testWidgets('valid modern colors', (WidgetTester tester) async {
        expect('rgb(255 0 0)'.isValidColor, isTrue);
        expect('rgba(0 100 200 / 0.5)'.isValidColor, isTrue);
        expect('hsl(180 100% 50%)'.isValidColor, isTrue);
        expect('hsla(180 100% 50% / 0.5)'.isValidColor, isTrue);
        expect('hwb(180 50% 50%)'.isValidColor, isTrue);
        expect('hwb(180 50% 50% / 0.5)'.isValidColor, isTrue);
        expect('hwb(190 0% 0% / 0.15)'.isValidColor, isTrue);
      });

      testWidgets('invalid modern colors', (WidgetTester tester) async {
        // Comma-separated values should be invalid for modern syntax.
        expect('rgb(255, 0, 0)'.isModernColor, isFalse);
        expect('rgb(255 0 0 0)'.isModernColor, isFalse); // Too many values
        expect('hsl(180, 100%, 50%)'.isModernColor, isFalse);
        expect('hwb(180, 50%, 50%)'.isModernColor, isFalse);
        expect(
            'hwb(180 50% 50% / -0.5)'.isModernColor, isFalse); // Negative alpha
        expect('#AABBCC'.isModernColor, isFalse);
        expect('red'.isModernColor, isFalse);
        expect('hwb(-180 50% 50%)'.isModernColor, isFalse);
        expect('hwb(180 101% 50%)'.isModernColor, isFalse);
        expect('hwb(180 50% 101%)'.isModernColor, isFalse);
      });

      testWidgets('valid named colors', (WidgetTester tester) async {
        expect('red'.isValidColor, isTrue);
        expect('RED'.isValidColor, isTrue);
        expect('aliceblue'.isValidColor, isTrue);
      });

      testWidgets('invalid named colors', (WidgetTester tester) async {
        expect('notacolor'.isValidColor, isFalse);
        // Leading or trailing whitespace is trimmed.
        expect('red '.isValidColor, isTrue);
        expect(' red'.isValidColor, isTrue);
      });

      testWidgets('invalid colors', (WidgetTester tester) async {
        expect('rgb(256, 0, 0)'.isValidColor, isFalse);
        expect('hsl(100, 101%, 50%)'.isValidColor, isFalse);
        expect('some invalid string'.isValidColor, isFalse);
        expect(''.isValidColor, isFalse);
      });

      testWidgets('valid special keywords', (WidgetTester tester) async {
        expect('transparent'.isValidColor, isTrue);
        expect('currentColor'.isValidColor, isTrue);
        expect('TRANSPARENT'.isValidColor, isTrue);
      });
    });

    group('isHexColor', () {
      testWidgets('valid hex colors', (WidgetTester tester) async {
        expect('#abc'.isHexColor, isTrue);
        expect('0x123'.isHexColor, isTrue);
        expect('#AABBCC'.isHexColor, isTrue);
        expect('0xFF123456'.isHexColor, isTrue);
        expect('#abcd'.isHexColor, isTrue);
        expect('0x1234'.isHexColor, isTrue);
      });

      testWidgets('invalid hex colors', (WidgetTester tester) async {
        expect('#ab'.isHexColor, isFalse);
        expect('#abcg'.isHexColor, isFalse);
        expect('0x1234567'.isHexColor, isFalse);
        expect('red'.isHexColor, isFalse);
        expect('rgb(255, 0, 0)'.isHexColor, isFalse);
      });
    });

    group('isRgbColor', () {
      testWidgets('valid rgb colors', (WidgetTester tester) async {
        expect('rgb(255, 0, 0)'.isRgbColor, isTrue);
        expect('rgba(0, 100, 200, 0.5)'.isRgbColor, isTrue);
        expect('rgb(10%, 50%, 90%)'.isRgbColor, isTrue);
        expect('rgba(10%, 50%, 90%, 40%)'.isRgbColor, isTrue);
      });

      testWidgets('invalid rgb colors', (WidgetTester tester) async {
        expect('rgb(256, 0, 0)'.isRgbColor, isFalse);
        expect('rgb(0, 0, 0, 0)'.isRgbColor, isFalse);
        expect('#AABBCC'.isRgbColor, isFalse);
        expect('hsl(180, 100%, 50%)'.isRgbColor, isFalse);
        expect('rgba(10,10,10,101%)'.isRgbColor, isFalse);
      });
    });

    group('isHslColor', () {
      testWidgets('valid hsl colors', (WidgetTester tester) async {
        expect('hsl(180, 100%, 50%)'.isHslColor, isTrue);
        expect('hsla(180, 100%, 50%, 0.5)'.isHslColor, isTrue);
        expect('hsl(120deg, 50%, 50%)'.isHslColor, isTrue);
        expect('hsl(3.1416rad, 50%, 50%)'.isHslColor, isTrue);
        expect('hsl(200grad, 50%, 50%)'.isHslColor, isTrue);
        expect('hsl(0.5turn, 50%, 50%)'.isHslColor, isTrue);
      });

      testWidgets('invalid hsl colors', (WidgetTester tester) async {
        expect('hsl(361, 100%, 50%)'.isHslColor, isFalse);
        expect('hsl(180, 101%, 50%)'.isHslColor, isFalse);
        expect('hsl(180, 100%, -1%)'.isHslColor, isFalse);
        expect('hsla(180, 100%, 50%, -0.1)'.isHslColor, isFalse);
        expect('hsla(180, 100%, 50%, 1.1)'.isHslColor, isFalse);
        expect('#AABBCC'.isHslColor, isFalse);
        expect('rgb(255, 0, 0)'.isHslColor, isFalse);
        expect('hsl(180, 100, 50)'.isHslColor, isFalse);
      });
    });

    group('isModernColor', () {
      testWidgets('valid modern colors', (WidgetTester tester) async {
        expect('rgb(255 0 0)'.isModernColor, isTrue);
        expect('rgba(0 100 200 / 0.5)'.isModernColor, isTrue);
        expect('hsl(180 100% 50%)'.isModernColor, isTrue);
        expect('hsla(180 100% 50% / 0.5)'.isModernColor, isTrue);
        expect('hwb(180 50% 50%)'.isModernColor, isTrue);
        expect('hwb(180 50% 50% / 0.5)'.isModernColor, isTrue);
        expect('hwb(190 0% 0% / 0.15)'.isModernColor, isTrue);
      });

      testWidgets('invalid modern colors', (WidgetTester tester) async {
        expect('rgb(255, 0, 0)'.isModernColor, isFalse);
        expect('rgb(255 0 0 0)'.isModernColor, isFalse);
        expect('hsl(180, 100%, 50%)'.isModernColor, isFalse);
        expect('hwb(180, 50%, 50%)'.isModernColor, isFalse);
        expect('hwb(180 50% 50% / -0.5)'.isModernColor, isFalse);
        expect('#AABBCC'.isModernColor, isFalse);
        expect('red'.isModernColor, isFalse);
        expect('hwb(-180 50% 50%)'.isModernColor, isFalse);
        expect('hwb(180 101% 50%)'.isModernColor, isFalse);
        expect('hwb(180 50% 101%)'.isModernColor, isFalse);
      });
    });

    group('toColor', () {
      testWidgets('valid hex colors', (WidgetTester tester) async {
        final color1 = '#abc'.toColor;
        expect(color1, isNotNull);
        expect(color1!.value, equals(0xFFAABBCC));

        final color2 = '0x123'.toColor;
        expect(color2, isNotNull);
        expect(color2!.value, equals(0xFF112233));

        final color3 = '#AABBCC'.toColor;
        expect(color3, isNotNull);
        expect(color3!.value, equals(0xFFAABBCC));

        final color4 = '0xFF123456'.toColor;
        expect(color4, isNotNull);
        expect(color4!.value, equals(0x56FF1234));

        final color5 = '#abcd'.toColor;
        expect(color5, isNotNull);
        expect(color5!.value, equals(0xDDAABBCC));

        final color6 = '0x1234'.toColor;
        expect(color6, isNotNull);
        expect(color6!.value, equals(0x44112233));
      });

      testWidgets('valid rgb colors', (WidgetTester tester) async {
        final color1 = 'rgb(255, 0, 0)'.toColor;
        expect(color1, isNotNull);
        expect(color1!.value, equals(0xFFFF0000));

        final color2 = 'rgb(0,255,0)'.toColor;
        expect(color2, isNotNull);
        expect(color2!.value, equals(0xFF00FF00));

        final color3 = 'rgb(0,0,255)'.toColor;
        expect(color3, isNotNull);
        expect(color3!.value, equals(0xFF0000FF));

        final color4 = 'rgba(0, 255, 0, 0.5)'.toColor;
        expect(color4, isNotNull);
        expect(color4!.value, equals(Color.fromARGB(128, 0, 255, 0).value));

        final color5 = 'rgba(10%, 50%, 90%, 40%)'.toColor;
        expect(color5, isNotNull);
        expect(
          color5!.value,
          equals(Color.fromARGB(102, 26, 128, 230).value),
        );

        final color6 = 'rgb(10%, 50%, 90%)'.toColor;
        expect(color6, isNotNull);
        expect(
          color6!.value,
          equals(Color.fromARGB(255, 26, 128, 230).value),
        );
      });

      testWidgets('valid hsl colors', (WidgetTester tester) async {
        final color1 = 'hsl(0, 100%, 50%)'.toColor;
        expect(color1, isNotNull);
        expect(color1!.value, equals(0xFFFF0000)); // Red

        final color2 = 'hsl(120, 100%, 50%)'.toColor;
        expect(color2, isNotNull);
        expect(color2!.value, equals(0xFF00FF00)); // Green

        final color3 = 'hsl(240, 100%, 50%)'.toColor;
        expect(color3, isNotNull);
        expect(color3!.value, equals(0xFF0000FF)); // Blue

        final color4 = 'hsl(0, 0%, 0%)'.toColor;
        expect(color4, isNotNull);
        expect(color4!.value, equals(0xFF000000)); // Black

        final color5 = 'hsl(0, 0%, 100%)'.toColor;
        expect(color5, isNotNull);
        expect(color5!.value, equals(0xFFFFFFFF)); // White

        final color6 = 'hsla(0, 100%, 50%, 0.5)'.toColor;
        expect(color6, isNotNull);
        expect(color6!.value, equals(Color.fromARGB(128, 255, 0, 0).value));
      });

      testWidgets('valid modern colors', (WidgetTester tester) async {
        final color1 = 'rgb(255 0 0)'.toColor;
        expect(color1, isNotNull);
        expect(color1!.value, equals(0xFFFF0000));

        final color2 = 'rgba(0 100 200 / 0.5)'.toColor;
        expect(color2, isNotNull);
        expect(color2!.value, equals(Color.fromARGB(128, 0, 100, 200).value));

        final color3 = 'hsl(180 100% 50%)'.toColor;
        expect(color3, isNotNull);
        expect(color3!.value, equals(Color.fromARGB(255, 0, 255, 255).value));

        final color4 = 'hsla(180 100% 50% / 0.5)'.toColor;
        expect(color4, isNotNull);
        expect(color4!.value, equals(Color.fromARGB(128, 0, 255, 255).value));

        // For hwb we only verify that a valid Color is returned.
        final color5 = 'hwb(180 50% 50%)'.toColor;
        expect(color5, isNotNull);

        final color6 = 'hwb(180 50% 50% / 0.5)'.toColor;
        expect(color6, isNotNull);
      });

      testWidgets('valid named colors and special keywords',
          (WidgetTester tester) async {
        final redColor = 'red'.toColor;
        expect(redColor, isNotNull);
        expect(redColor!.value, equals(const Color(0xFFFF0000).value));

        final aliceBlue = 'aliceblue'.toColor;
        expect(aliceBlue, isNotNull);
        final expectedAliceBlue = cssColorNamesToArgb['aliceblue'];
        expect(aliceBlue!.value, equals(expectedAliceBlue));

        final transparentColor = 'transparent'.toColor;
        expect(transparentColor, isNotNull);
        expect(transparentColor!.value, equals(0x00000000));
      });

      testWidgets('invalid colors return null', (WidgetTester tester) async {
        expect('notacolor'.toColor, isNull);
        expect('rgb(256, 0, 0)'.toColor, isNull);
        expect('hsl(100, 101%, 50%)'.toColor, isNull);
        expect('some invalid string'.toColor, isNull);
        expect(''.toColor, isNull);
      });
    });
  });
}
