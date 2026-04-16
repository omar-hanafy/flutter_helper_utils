import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:ui' as ui;
import 'dart:ui_web' as ui_web;

import 'package:flutter/foundation.dart';

/// A platform-independent class providing information about the operating system,
/// with web compatibility considerations.
abstract final class PlatformEnv {
  /// Returns Flutter's [defaultTargetPlatform].
  ///
  /// On web, this is derived from the browser operating system and respects
  /// Flutter test overrides.
  static TargetPlatform get targetPlatform => defaultTargetPlatform;

  static ui_web.OperatingSystem get _browserOperatingSystem {
    // Match Flutter's defaultTargetPlatform behavior where web tests default to
    // android unless an explicit override is provided.
    if (ui_web.TestEnvironment.instance ==
            const ui_web.TestEnvironment.flutterTester() &&
        ui_web.browser.debugOperatingSystemOverride == null) {
      return ui_web.OperatingSystem.android;
    }
    return ui_web.browser.operatingSystem;
  }

  /// Returns `true` if the current platform is Linux.
  static bool get isLinux =>
      _browserOperatingSystem == ui_web.OperatingSystem.linux;

  /// Returns `true` if the current platform is macOS.
  static bool get isMacOS =>
      _browserOperatingSystem == ui_web.OperatingSystem.macOs;

  /// Returns `true` if the current platform is Windows.
  static bool get isWindows =>
      _browserOperatingSystem == ui_web.OperatingSystem.windows;

  /// Returns `true` if the current platform is Android.
  static bool get isAndroid =>
      _browserOperatingSystem == ui_web.OperatingSystem.android;

  /// Returns `true` if the current platform is iOS.
  static bool get isIOS =>
      _browserOperatingSystem == ui_web.OperatingSystem.iOs;

  /// Returns `true` since this is a Web runtime.
  static bool get isWeb => true;

  /// Returns `false` since the current platform is not Fuchsia.
  static bool get isFuchsia => false;

  /// Returns `true` if the current platform is a desktop OS (Linux, macOS, or Windows).
  static bool get isDesktop {
    final os = _browserOperatingSystem;
    return os == ui_web.OperatingSystem.linux ||
        os == ui_web.OperatingSystem.macOs ||
        os == ui_web.OperatingSystem.windows;
  }

  /// Returns `true` if the current platform is a mobile OS (Android or iOS).
  static bool get isMobile {
    final os = _browserOperatingSystem;
    return os == ui_web.OperatingSystem.android ||
        os == ui_web.OperatingSystem.iOs;
  }

  /// Returns `true` if the current platform is an Apple OS (macOS or iOS).
  static bool get isApple {
    final os = _browserOperatingSystem;
    return os == ui_web.OperatingSystem.macOs ||
        os == ui_web.OperatingSystem.iOs;
  }

  /// Returns `true` if this web build is compiled to Wasm.
  static bool get isWasm => ui_web.browser.isWasm;

  /// Returns the user agent reported by the current browser.
  static String get userAgent => ui_web.browser.userAgent;

  /// Returns the browser engine name (e.g. 'blink', 'webkit', 'firefox').
  static String get browserEngine => ui_web.browser.browserEngine.name;

  /// Returns `true` if the browser engine is Blink (Chrome, Edge, Opera, etc.).
  static bool get isChromium => ui_web.browser.isChromium;

  /// Returns `true` if the browser engine is WebKit (Safari).
  static bool get isSafari => ui_web.browser.isSafari;

  /// Returns `true` if the browser engine is Gecko (Firefox).
  static bool get isFirefox => ui_web.browser.isFirefox;

  /// Returns `true` if the browser is Microsoft Edge.
  static bool get isEdge => ui_web.browser.isEdge;

  /// Returns the name of the operating system.
  ///
  /// On web, this is inferred from the browser environment.
  static String get operatingSystem {
    return switch (_browserOperatingSystem) {
      ui_web.OperatingSystem.android => 'android',
      ui_web.OperatingSystem.iOs => 'ios',
      ui_web.OperatingSystem.linux => 'linux',
      ui_web.OperatingSystem.macOs => 'macos',
      ui_web.OperatingSystem.windows => 'windows',
      ui_web.OperatingSystem.unknown => 'unknown',
    };
  }

  /// Returns 'N/A' since the operating system version is not available on web.
  static String get operatingSystemVersion => 'N/A';

  static int? _tryGetHardwareConcurrency() {
    final navigator = globalContext.getProperty<JSObject?>('navigator'.toJS);
    if (navigator == null) {
      return null;
    }

    final hardwareConcurrency = navigator.getProperty<JSNumber?>(
      'hardwareConcurrency'.toJS,
    );
    if (hardwareConcurrency == null) {
      return null;
    }

    try {
      final value = hardwareConcurrency.toDartInt;
      return value >= 0 ? value : null;
    } catch (_) {
      try {
        final value = hardwareConcurrency.toDartDouble;
        if (!value.isFinite) {
          return null;
        }
        final rounded = value.round();
        return rounded >= 0 ? rounded : null;
      } catch (_) {
        return null;
      }
    }
  }

  /// Returns the number of logical processors available to the browser.
  ///
  /// Falls back to `1` when `navigator.hardwareConcurrency` is unavailable.
  static int get numberOfProcessors => _tryGetHardwareConcurrency() ?? 1;

  /// Returns `/` as the path separator on web platforms.
  static String get pathSeparator => '/';

  /// Returns the current host from [Uri.base], or 'N/A' if not available.
  ///
  /// This is not the machine hostname (which is not available on web).
  static String get localHostname {
    final host = Uri.base.host;
    return host.isNotEmpty ? host : 'N/A';
  }

  /// Returns 'N/A' as the version of the current Dart runtime on web platforms.
  static String get version => 'N/A';

  /// Returns the current locale as reported by the Flutter engine.
  static String get localeName =>
      ui.PlatformDispatcher.instance.locale.toString();

  /// Returns an empty map since environment variables are not available on web platforms.
  static Map<String, String> get environment => const <String, String>{};

  /// Returns 'N/A' as the executable path on web platforms.
  static String get executable => 'N/A';

  /// Returns 'N/A' as the resolved executable path on web platforms.
  static String get resolvedExecutable => 'N/A';

  /// Returns an empty URI as the script URI on web platforms.
  static Uri get script => Uri();

  /// Returns an empty list since no executable arguments are available on web platforms.
  static List<String> get executableArguments => const <String>[];

  /// Returns `null` since the `--packages` flag is not applicable on web platforms.
  static String? get packageConfig => null;

  /// Returns `'\n'` as the system's default line terminator on web platforms.
  static String get lineTerminator => '\n';

  /// Returns a diagnostic map that is safe to log by default.
  static Map<String, Object?> report({bool includeEnvironment = false}) => {
    'targetPlatform': targetPlatform.name,
    'isLinux': isLinux,
    'isMacOS': isMacOS,
    'isWindows': isWindows,
    'isAndroid': isAndroid,
    'isIOS': isIOS,
    'isWeb': isWeb,
    'isFuchsia': isFuchsia,
    'isDesktop': isDesktop,
    'isMobile': isMobile,
    'isApple': isApple,
    'isWasm': isWasm,
    'userAgent': userAgent,
    'browserEngine': browserEngine,
    'isChromium': isChromium,
    'isSafari': isSafari,
    'isFirefox': isFirefox,
    'isEdge': isEdge,
    'operatingSystem': operatingSystem,
    'operatingSystemVersion': operatingSystemVersion,
    'numberOfProcessors': numberOfProcessors,
    'pathSeparator': pathSeparator,
    'localHostname': localHostname,
    'version': version,
    'localeName': localeName,
    'executable': executable,
    'resolvedExecutable': resolvedExecutable,
    'script': script.toString(),
    'executableArguments': executableArguments,
    'packageConfig': packageConfig,
    'lineTerminator': lineTerminator,
    if (includeEnvironment) 'environment': environment,
  };
}
