@TestOn('vm')
library;

import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlatformEnv (IO)', () {
    group('platform flags', () {
      test('isLinux matches Platform.isLinux', () {
        expect(PlatformEnv.isLinux, io.Platform.isLinux);
      });

      test('isMacOS matches Platform.isMacOS', () {
        expect(PlatformEnv.isMacOS, io.Platform.isMacOS);
      });

      test('isWindows matches Platform.isWindows', () {
        expect(PlatformEnv.isWindows, io.Platform.isWindows);
      });

      test('isAndroid matches Platform.isAndroid', () {
        expect(PlatformEnv.isAndroid, io.Platform.isAndroid);
      });

      test('isIOS matches Platform.isIOS', () {
        expect(PlatformEnv.isIOS, io.Platform.isIOS);
      });

      test('isFuchsia matches Platform.isFuchsia', () {
        expect(PlatformEnv.isFuchsia, io.Platform.isFuchsia);
      });

      test('isWeb is false', () {
        expect(PlatformEnv.isWeb, isFalse);
      });

      test('isWasm is false', () {
        expect(PlatformEnv.isWasm, isFalse);
      });
    });

    group('convenience getters', () {
      test('isDesktop matches Linux or macOS or Windows', () {
        final expected =
            io.Platform.isLinux || io.Platform.isMacOS || io.Platform.isWindows;
        expect(PlatformEnv.isDesktop, expected);
      });

      test('isMobile matches Android or iOS', () {
        final expected = io.Platform.isAndroid || io.Platform.isIOS;
        expect(PlatformEnv.isMobile, expected);
      });

      test('isApple matches macOS or iOS', () {
        final expected = io.Platform.isMacOS || io.Platform.isIOS;
        expect(PlatformEnv.isApple, expected);
      });

      test(
        'isDesktop and isMobile are mutually exclusive (unless Fuchsia)',
        () {
          if (!io.Platform.isFuchsia) {
            expect(PlatformEnv.isDesktop, isNot(PlatformEnv.isMobile));
          }
        },
      );
    });

    group('browser detection stubs', () {
      test('userAgent is N/A', () {
        expect(PlatformEnv.userAgent, 'N/A');
      });

      test('browserEngine is N/A', () {
        expect(PlatformEnv.browserEngine, 'N/A');
      });

      test('isChromium is false', () {
        expect(PlatformEnv.isChromium, isFalse);
      });

      test('isSafari is false', () {
        expect(PlatformEnv.isSafari, isFalse);
      });

      test('isFirefox is false', () {
        expect(PlatformEnv.isFirefox, isFalse);
      });

      test('isEdge is false', () {
        expect(PlatformEnv.isEdge, isFalse);
      });
    });

    group('system info', () {
      test('operatingSystem matches Platform.operatingSystem', () {
        expect(PlatformEnv.operatingSystem, io.Platform.operatingSystem);
      });

      test(
        'operatingSystemVersion matches Platform.operatingSystemVersion',
        () {
          expect(
            PlatformEnv.operatingSystemVersion,
            io.Platform.operatingSystemVersion,
          );
        },
      );

      test('numberOfProcessors matches Platform.numberOfProcessors', () {
        expect(PlatformEnv.numberOfProcessors, io.Platform.numberOfProcessors);
      });

      test('pathSeparator matches Platform.pathSeparator', () {
        expect(PlatformEnv.pathSeparator, io.Platform.pathSeparator);
      });

      test('localHostname matches Platform.localHostname', () {
        expect(PlatformEnv.localHostname, io.Platform.localHostname);
      });

      test('version matches Platform.version', () {
        expect(PlatformEnv.version, io.Platform.version);
      });

      test('localeName matches Platform.localeName', () {
        expect(PlatformEnv.localeName, io.Platform.localeName);
      });

      test('executable matches Platform.executable', () {
        expect(PlatformEnv.executable, io.Platform.executable);
      });

      test('resolvedExecutable matches Platform.resolvedExecutable', () {
        expect(PlatformEnv.resolvedExecutable, io.Platform.resolvedExecutable);
      });

      test('script matches Platform.script', () {
        expect(PlatformEnv.script, io.Platform.script);
      });

      test('executableArguments matches Platform.executableArguments', () {
        expect(
          PlatformEnv.executableArguments,
          io.Platform.executableArguments,
        );
      });

      test('packageConfig matches Platform.packageConfig', () {
        expect(PlatformEnv.packageConfig, io.Platform.packageConfig);
      });

      test('lineTerminator matches Platform.lineTerminator', () {
        expect(PlatformEnv.lineTerminator, io.Platform.lineTerminator);
      });

      test('environment matches Platform.environment', () {
        expect(PlatformEnv.environment, io.Platform.environment);
      });
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
        expect(r['environment'], isA<Map<String, String>>());
      });

      test('values match getters', () {
        final r = PlatformEnv.report();
        expect(r['isWeb'], PlatformEnv.isWeb);
        expect(r['isDesktop'], PlatformEnv.isDesktop);
        expect(r['isMobile'], PlatformEnv.isMobile);
        expect(r['isApple'], PlatformEnv.isApple);
        expect(r['browserEngine'], PlatformEnv.browserEngine);
        expect(r['operatingSystem'], PlatformEnv.operatingSystem);
        expect(r['numberOfProcessors'], PlatformEnv.numberOfProcessors);
      });
    });
  });
}
