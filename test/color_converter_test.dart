import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color Converter Tests', () {
    group('Direct conversion', () {
      test('converts hex strings', () {
        expect(
            FConvertObject.toColor('#FF0000'), equals(const Color(0xFFFF0000)));
        expect(FConvertObject.toColor('0xFF0000'),
            equals(const Color(0xFFFF0000)));
        expect(FConvertObject.toColor('#F00'), equals(const Color(0xFFFF0000)));
      });

      test('converts integers', () {
        expect(FConvertObject.toColor(0xFFFF0000),
            equals(const Color(0xFFFF0000)));
        expect(FConvertObject.toColor(4294901760),
            equals(const Color(0xFFFF0000)));
      });

      test('converts Color objects', () {
        const color = Color(0xFF00FF00);
        expect(FConvertObject.toColor(color), equals(color));
      });

      test('converts HSL/HSV colors', () {
        final hsl = HSLColor.fromColor(Colors.red);
        final hsv = HSVColor.fromColor(Colors.blue);

        expect(FConvertObject.toColor(hsl), equals(hsl.toColor()));
        expect(FConvertObject.toColor(hsv), equals(hsv.toColor()));
      });

      test('converts named colors', () {
        expect(FConvertObject.toColor('red'), equals(const Color(0xFFFF0000)));
        expect(FConvertObject.toColor('blue'), equals(const Color(0xFF0000FF)));
        expect(FConvertObject.toColor('transparent'),
            equals(const Color(0x00000000)));
      });

      test('converts rgb/hsl functions', () {
        expect(FConvertObject.toColor('rgb(255, 0, 0)'),
            equals(const Color(0xFFFF0000)));
        expect(FConvertObject.toColor('rgba(255, 0, 0, 0.5)'),
            equals(const Color(0x80FF0000)));
        expect(FConvertObject.toColor('hsl(120, 100%, 50%)'),
            equals(const Color(0xFF00FF00)));
      });
    });

    group('Map extensions', () {
      test('retrieves and converts from maps with integers', () {
        final map = {
          'primary': 0xFFFF0000,
          'secondary': 0xFF00FF00,
          'accent': 0xFF0000FF,
        };

        expect(map.getColor('primary'), equals(const Color(0xFFFF0000)));
        expect(map.getColor('secondary'), equals(const Color(0xFF00FF00)));
        expect(map.tryGetColor('accent'), equals(const Color(0xFF0000FF)));
      });

      test('retrieves and converts from maps with hex strings', () {
        final map = {
          'primary': '#FF0000',
          'secondary': '#00FF00',
          'accent': 'rgb(0, 0, 255)',
        };

        expect(map.getColor('primary'), equals(const Color(0xFFFF0000)));
        expect(map.getColor('secondary'), equals(const Color(0xFF00FF00)));
        expect(map.tryGetColor('accent'), equals(const Color(0xFF0000FF)));
      });

      test('retrieves and converts from maps with Color objects', () {
        final map = {
          'primary': Colors.red,
          'secondary': Colors.green.shade500,
          'accent': const Color(0xFF0000FF),
        };

        expect(map.getColor('primary'), equals(Colors.red));
        expect(map.getColor('secondary'), equals(Colors.green.shade500));
        expect(map.tryGetColor('accent'), equals(const Color(0xFF0000FF)));
      });

      test('handles missing keys with defaults', () {
        final map = {'primary': '#FF0000'};

        expect(
          map.tryGetColor('missing', defaultValue: Colors.blue),
          equals(Colors.blue),
        );
      });

      test('handles null maps', () {
        Map<String, dynamic>? nullMap;

        expect(nullMap.tryGetColor('any'), isNull);
        expect(
          nullMap.tryGetColor('any', defaultValue: Colors.red),
          equals(Colors.red),
        );
      });
    });

    group('List extensions', () {
      test('retrieves and converts from lists with integers', () {
        final list = [0xFFFF0000, 0xFF00FF00, 0xFF0000FF];

        expect(list.getColor(0), equals(const Color(0xFFFF0000)));
        expect(list.getColor(1), equals(const Color(0xFF00FF00)));
        expect(list.tryGetColor(2), equals(const Color(0xFF0000FF)));
      });

      test('retrieves and converts from lists with mixed types', () {
        final list = [
          '#FF0000',
          0xFF00FF00,
          Colors.blue,
          'rgb(255, 255, 0)',
        ];

        expect(list.getColor(0), equals(const Color(0xFFFF0000)));
        expect(list.getColor(1), equals(const Color(0xFF00FF00)));
        expect(list.tryGetColor(2), equals(Colors.blue));
        expect(list.tryGetColor(3), equals(const Color(0xFFFFFF00)));
      });

      test('handles out of bounds with defaults', () {
        final list = ['#FF0000'];

        expect(
          list.tryGetColor(10, defaultValue: Colors.blue),
          equals(Colors.blue),
        );
      });

      test('handles null lists', () {
        List<dynamic>? nullList;

        expect(nullList.tryGetColor(0), isNull);
        expect(
          nullList.tryGetColor(0, defaultValue: Colors.red),
          equals(Colors.red),
        );
      });
    });

    group('Custom converter', () {
      test('uses custom converter when provided', () {
        Color? customConverter(Object? obj) {
          if (obj is String && obj == 'custom') {
            return Colors.purple;
          }
          return null;
        }

        expect(
          FConvertObject.toColor('custom', converter: customConverter),
          equals(Colors.purple),
        );

        final map = {'color': 'custom'};
        expect(
          map.getColor('color', converter: customConverter),
          equals(Colors.purple),
        );
      });

      test('falls back to default converter if custom returns null', () {
        Color? customConverter(Object? obj) => null;

        expect(
          FConvertObject.toColor('#FF0000', converter: customConverter),
          equals(const Color(0xFFFF0000)),
        );
      });
    });

    group('Edge cases', () {
      test('handles numeric strings correctly', () {
        // This was the bug - numeric strings like "4294901760" should now work
        expect(FConvertObject.toColor('4294901760'),
            equals(const Color(0xFFFF0000)));
      });

      test('handles invalid inputs', () {
        expect(() => FConvertObject.toColor(null),
            throwsA(isA<ParsingException>()));
        expect(FConvertObject.tryToColor('invalid'), isNull);
        expect(FConvertObject.tryToColor(''), isNull);
      });
    });

    group('Top-level functions', () {
      test('toColor function works', () {
        expect(toColor('#FF0000'), equals(const Color(0xFFFF0000)));
        expect(toColor(0xFFFF0000), equals(const Color(0xFFFF0000)));
      });

      test('tryToColor function works', () {
        expect(tryToColor('#00FF00'), equals(const Color(0xFF00FF00)));
        expect(tryToColor('invalid'), isNull);
      });
    });
  });
}
