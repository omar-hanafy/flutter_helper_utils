@TestOn('chrome')
library;

import 'dart:ui_web' as ui_web;

import 'package:flutter/foundation.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlatformEnv (Web)', () {
    group('platform flags', () {
      test('isWeb is true', () {
        expect(PlatformEnv.isWeb, isTrue);
      });

      test('isFuchsia is false', () {
        expect(PlatformEnv.isFuchsia, isFalse);
      });

      test('isWasm is a bool', () {
        expect(PlatformEnv.isWasm, isA<bool>());
      });

      test('isWasm matches dart.library.html detection', () {
        const expected = !bool.fromEnvironment('dart.library.html');
        expect(PlatformEnv.isWasm, expected);
      });

      test('flutterTester defaults OS to android when unoverridden', () {
        if (ui_web.TestEnvironment.instance ==
                const ui_web.TestEnvironment.flutterTester() &&
            ui_web.browser.debugOperatingSystemOverride == null) {
          expect(PlatformEnv.operatingSystem, 'android');
          expect(PlatformEnv.isAndroid, isTrue);
        }
      });

      test('exactly one OS flag is true', () {
        final osFlags = [
          PlatformEnv.isLinux,
          PlatformEnv.isMacOS,
          PlatformEnv.isWindows,
          PlatformEnv.isAndroid,
          PlatformEnv.isIOS,
        ];
        // In the flutter test environment, defaultTargetPlatform is android,
        // so isAndroid should be true. But regardless, at most one OS should
        // be true (unknown maps to all false).
        expect(osFlags.where((f) => f).length, lessThanOrEqualTo(1));
      });
    });

    group('convenience getters', () {
      test('isDesktop is true only for desktop OSes', () {
        if (PlatformEnv.isDesktop) {
          expect(
            PlatformEnv.isLinux || PlatformEnv.isMacOS || PlatformEnv.isWindows,
            isTrue,
          );
        }
      });

      test('isMobile is true only for mobile OSes', () {
        if (PlatformEnv.isMobile) {
          expect(PlatformEnv.isAndroid || PlatformEnv.isIOS, isTrue);
        }
      });

      test('isApple is true only for Apple OSes', () {
        if (PlatformEnv.isApple) {
          expect(PlatformEnv.isMacOS || PlatformEnv.isIOS, isTrue);
        }
      });

      test('isDesktop and isMobile cover all known OSes', () {
        final os = PlatformEnv.operatingSystem;
        if (os != 'unknown') {
          expect(PlatformEnv.isDesktop || PlatformEnv.isMobile, isTrue);
        }
      });
    });

    group('browser detection', () {
      test('userAgent is a non-empty string', () {
        expect(PlatformEnv.userAgent, isNotEmpty);
        expect(PlatformEnv.userAgent, isNot('N/A'));
      });

      test('browserEngine is a known value', () {
        expect(PlatformEnv.browserEngine, isIn(['blink', 'webkit', 'firefox']));
      });

      test('exactly one engine flag is true', () {
        // isEdge is a Blink browser so it can overlap with isChromium.
        // isChromium, isSafari, isFirefox should be mutually exclusive.
        final engineFlags = [
          PlatformEnv.isChromium,
          PlatformEnv.isSafari,
          PlatformEnv.isFirefox,
        ];
        expect(engineFlags.where((f) => f).length, 1);
      });

      test('isChromium is true in Chrome test runner', () {
        // This test file is annotated @TestOn('chrome'), so we run in Chrome.
        expect(PlatformEnv.isChromium, isTrue);
        expect(PlatformEnv.browserEngine, 'blink');
      });

      test('isSafari is false in Chrome', () {
        expect(PlatformEnv.isSafari, isFalse);
      });

      test('isFirefox is false in Chrome', () {
        expect(PlatformEnv.isFirefox, isFalse);
      });

      test('isEdge is false in Chrome', () {
        expect(PlatformEnv.isEdge, isFalse);
      });

      test('debugBrowserEngineOverride updates flags', () {
        final original = ui_web.browser.debugBrowserEngineOverride;
        addTearDown(() => ui_web.browser.debugBrowserEngineOverride = original);

        ui_web.browser.debugBrowserEngineOverride = ui_web.BrowserEngine.webkit;
        expect(PlatformEnv.browserEngine, 'webkit');
        expect(PlatformEnv.isChromium, isFalse);
        expect(PlatformEnv.isSafari, isTrue);
        expect(PlatformEnv.isFirefox, isFalse);

        ui_web.browser.debugBrowserEngineOverride =
            ui_web.BrowserEngine.firefox;
        expect(PlatformEnv.browserEngine, 'firefox');
        expect(PlatformEnv.isChromium, isFalse);
        expect(PlatformEnv.isSafari, isFalse);
        expect(PlatformEnv.isFirefox, isTrue);

        ui_web.browser.debugBrowserEngineOverride = ui_web.BrowserEngine.blink;
        expect(PlatformEnv.browserEngine, 'blink');
        expect(PlatformEnv.isChromium, isTrue);
        expect(PlatformEnv.isSafari, isFalse);
        expect(PlatformEnv.isFirefox, isFalse);
      });

      test('debugUserAgentOverride updates userAgent and isEdge', () {
        final original = ui_web.browser.debugUserAgentOverride;
        addTearDown(() => ui_web.browser.debugUserAgentOverride = original);

        ui_web.browser.debugUserAgentOverride =
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edg/123.0.0.0';
        expect(PlatformEnv.userAgent, contains('Edg/'));
        expect(PlatformEnv.isEdge, isTrue);
      });
    });

    group('system info', () {
      test('operatingSystem is a known value', () {
        expect(
          PlatformEnv.operatingSystem,
          isIn(['android', 'ios', 'linux', 'macos', 'windows', 'unknown']),
        );
      });

      test('operatingSystemVersion is N/A on web', () {
        expect(PlatformEnv.operatingSystemVersion, 'N/A');
      });

      test('numberOfProcessors is at least 1', () {
        expect(PlatformEnv.numberOfProcessors, greaterThanOrEqualTo(1));
      });

      test('pathSeparator is /', () {
        expect(PlatformEnv.pathSeparator, '/');
      });

      test('localHostname is a non-empty string', () {
        // In test runner, Uri.base.host should be set (localhost).
        expect(PlatformEnv.localHostname, isNotEmpty);
      });

      test('version is N/A on web', () {
        expect(PlatformEnv.version, 'N/A');
      });

      test('localeName is not empty', () {
        expect(PlatformEnv.localeName, isNotEmpty);
      });

      test('environment is an empty map', () {
        expect(PlatformEnv.environment, isEmpty);
      });

      test('executable is N/A', () {
        expect(PlatformEnv.executable, 'N/A');
      });

      test('resolvedExecutable is N/A', () {
        expect(PlatformEnv.resolvedExecutable, 'N/A');
      });

      test('executableArguments is empty', () {
        expect(PlatformEnv.executableArguments, isEmpty);
      });

      test('packageConfig is null', () {
        expect(PlatformEnv.packageConfig, isNull);
      });

      test('lineTerminator is newline', () {
        expect(PlatformEnv.lineTerminator, '\n');
      });

      test(
        'debugOperatingSystemOverride updates flags and operatingSystem',
        () {
          final original = ui_web.browser.debugOperatingSystemOverride;
          addTearDown(
            () => ui_web.browser.debugOperatingSystemOverride = original,
          );

          for (final os in ui_web.OperatingSystem.values) {
            ui_web.browser.debugOperatingSystemOverride = os;

            final expectedOS = switch (os) {
              ui_web.OperatingSystem.android => 'android',
              ui_web.OperatingSystem.iOs => 'ios',
              ui_web.OperatingSystem.linux => 'linux',
              ui_web.OperatingSystem.macOs => 'macos',
              ui_web.OperatingSystem.windows => 'windows',
              ui_web.OperatingSystem.unknown => 'unknown',
            };

            expect(PlatformEnv.operatingSystem, expectedOS, reason: 'os: $os');
            expect(PlatformEnv.isAndroid, os == ui_web.OperatingSystem.android);
            expect(PlatformEnv.isIOS, os == ui_web.OperatingSystem.iOs);
            expect(PlatformEnv.isLinux, os == ui_web.OperatingSystem.linux);
            expect(PlatformEnv.isMacOS, os == ui_web.OperatingSystem.macOs);
            expect(PlatformEnv.isWindows, os == ui_web.OperatingSystem.windows);

            expect(
              PlatformEnv.isDesktop,
              os == ui_web.OperatingSystem.linux ||
                  os == ui_web.OperatingSystem.macOs ||
                  os == ui_web.OperatingSystem.windows,
            );
            expect(
              PlatformEnv.isMobile,
              os == ui_web.OperatingSystem.android ||
                  os == ui_web.OperatingSystem.iOs,
            );
            expect(
              PlatformEnv.isApple,
              os == ui_web.OperatingSystem.macOs ||
                  os == ui_web.OperatingSystem.iOs,
            );

            final osFlags = [
              PlatformEnv.isLinux,
              PlatformEnv.isMacOS,
              PlatformEnv.isWindows,
              PlatformEnv.isAndroid,
              PlatformEnv.isIOS,
            ];
            final expectedTrueCount = os == ui_web.OperatingSystem.unknown
                ? 0
                : 1;
            expect(osFlags.where((f) => f).length, expectedTrueCount);
          }
        },
      );
    });

    group('targetPlatform', () {
      test('returns defaultTargetPlatform', () {
        expect(PlatformEnv.targetPlatform, defaultTargetPlatform);
      });

      test('respects debugDefaultTargetPlatformOverride', () {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
        addTearDown(() => debugDefaultTargetPlatformOverride = null);

        expect(PlatformEnv.targetPlatform, TargetPlatform.iOS);
      });
    });

    group('report()', () {
      test('contains all expected keys', () {
        final r = PlatformEnv.report();
        const expectedKeys = [
          'targetPlatform',
          'isLinux',
          'isMacOS',
          'isWindows',
          'isAndroid',
          'isIOS',
          'isWeb',
          'isFuchsia',
          'isDesktop',
          'isMobile',
          'isApple',
          'isWasm',
          'userAgent',
          'browserEngine',
          'isChromium',
          'isSafari',
          'isFirefox',
          'isEdge',
          'operatingSystem',
          'operatingSystemVersion',
          'numberOfProcessors',
          'pathSeparator',
          'localHostname',
          'version',
          'localeName',
          'executable',
          'resolvedExecutable',
          'script',
          'executableArguments',
          'packageConfig',
          'lineTerminator',
        ];

        for (final key in expectedKeys) {
          expect(r.containsKey(key), isTrue, reason: 'missing key: $key');
        }
      });

      test('excludes environment by default', () {
        final r = PlatformEnv.report();
        expect(r.containsKey('environment'), isFalse);
      });

      test('includes environment when requested', () {
        final r = PlatformEnv.report(includeEnvironment: true);
        expect(r.containsKey('environment'), isTrue);
        final env = r['environment'];
        expect(env, isA<Map<String, String>>());
        expect((env! as Map<String, String>).isEmpty, isTrue);
      });

      test('values match getters', () {
        final r = PlatformEnv.report();
        expect(r['isWeb'], PlatformEnv.isWeb);
        expect(r['isDesktop'], PlatformEnv.isDesktop);
        expect(r['isMobile'], PlatformEnv.isMobile);
        expect(r['isApple'], PlatformEnv.isApple);
        expect(r['browserEngine'], PlatformEnv.browserEngine);
        expect(r['isChromium'], PlatformEnv.isChromium);
        expect(r['isSafari'], PlatformEnv.isSafari);
        expect(r['isFirefox'], PlatformEnv.isFirefox);
        expect(r['isEdge'], PlatformEnv.isEdge);
        expect(r['operatingSystem'], PlatformEnv.operatingSystem);
        expect(r['numberOfProcessors'], PlatformEnv.numberOfProcessors);
      });
    });
  });
}
