import 'dart:io';

import 'package:flutter/foundation.dart';

/// A platform-independent class providing information about the operating system,
/// with web compatibility considerations.
abstract final class PlatformEnv {
  /// Returns Flutter's [defaultTargetPlatform].
  ///
  /// This respects Flutter test behavior and any debug platform override.
  static TargetPlatform get targetPlatform => defaultTargetPlatform;

  /// Returns `true` if the current platform is Linux.
  static bool get isLinux => Platform.isLinux;

  /// Returns `true` if the current platform is macOS.
  static bool get isMacOS => Platform.isMacOS;

  /// Returns `true` if the current platform is Windows.
  static bool get isWindows => Platform.isWindows;

  /// Returns `true` if the current platform is Android.
  static bool get isAndroid => Platform.isAndroid;

  /// Returns `true` if the current platform is iOS.
  static bool get isIOS => Platform.isIOS;

  /// Returns `false` since this is not a Web runtime.
  static bool get isWeb => false;

  /// Returns `true` if the current platform is Fuchsia.
  static bool get isFuchsia => Platform.isFuchsia;

  /// Returns `true` if the current platform is a desktop OS (Linux, macOS, or Windows).
  static bool get isDesktop =>
      Platform.isLinux || Platform.isMacOS || Platform.isWindows;

  /// Returns `true` if the current platform is a mobile OS (Android or iOS).
  static bool get isMobile => Platform.isAndroid || Platform.isIOS;

  /// Returns `true` if the current platform is an Apple OS (macOS or iOS).
  static bool get isApple => Platform.isMacOS || Platform.isIOS;

  /// Returns `false` since this is not a Web runtime.
  static bool get isWasm => false;

  /// Returns 'N/A' since user agent is not available on non-web platforms.
  static String get userAgent => 'N/A';

  /// Returns 'N/A' since browser engine detection is not applicable on native platforms.
  static String get browserEngine => 'N/A';

  /// Returns `false` since browser engine detection is not applicable on native platforms.
  static bool get isChromium => false;

  /// Returns `false` since browser engine detection is not applicable on native platforms.
  static bool get isSafari => false;

  /// Returns `false` since browser engine detection is not applicable on native platforms.
  static bool get isFirefox => false;

  /// Returns `false` since browser engine detection is not applicable on native platforms.
  static bool get isEdge => false;

  /// Returns the name of the operating system.
  static String get operatingSystem => Platform.operatingSystem;

  /// Returns the version of the operating system.
  static String get operatingSystemVersion => Platform.operatingSystemVersion;

  /// Returns the number of processors available to the Dart VM.
  static int get numberOfProcessors => Platform.numberOfProcessors;

  /// Returns the path separator used by the operating system.
  static String get pathSeparator => Platform.pathSeparator;

  /// Returns the local hostname for the system.
  static String get localHostname => Platform.localHostname;

  /// Returns the version of the current Dart runtime.
  static String get version => Platform.version;

  /// Returns the name of the current locale.
  static String get localeName => Platform.localeName;

  /// Returns the environment for this process as a map.
  static Map<String, String> get environment => Platform.environment;

  /// Returns the path of the executable used to run the script in this isolate.
  static String get executable => Platform.executable;

  /// Returns the path of the executable used to run the script in this isolate after it has been resolved by the OS.
  static String get resolvedExecutable => Platform.resolvedExecutable;

  /// Returns the absolute URI of the script being run in this isolate.
  static Uri get script => Platform.script;

  /// Returns the flags passed to the executable used to run the script in this isolate.
  static List<String> get executableArguments => Platform.executableArguments;

  /// Returns the `--packages` flag passed to the executable used to run the script in this isolate, or `null` if no such flag was provided.
  static String? get packageConfig => Platform.packageConfig;

  /// Returns the system's default line terminator.
  static String get lineTerminator => Platform.lineTerminator;

  /// Returns a diagnostic map that is safe to log by default.
  ///
  /// Set [includeEnvironment] to `true` only if you are sure it will not leak
  /// secrets in logs.
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
