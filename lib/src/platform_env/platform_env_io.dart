import 'dart:io';

import 'package:flutter/foundation.dart';

/// A platform-independent class providing information about the operating system,
/// with web compatibility considerations.
abstract class PlatformEnv {
  /// Returns the `TargetPlatform` corresponding to the current operating system.
  static TargetPlatform get targetPlatform {
    switch (operatingSystem) {
      case 'android':
        return TargetPlatform.android;
      case 'fuchsia':
        return TargetPlatform.fuchsia;
      case 'ios':
        return TargetPlatform.iOS;
      case 'linux':
        return TargetPlatform.linux;
      case 'macos':
        return TargetPlatform.macOS;
      case 'windows':
        return TargetPlatform.windows;
      default:
        return defaultTargetPlatform;
    }
  }

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

  /// Returns `true` if the current platform is not web.
  static bool get isWeb => false;

  /// Returns `true` if the current platform is Fuchsia.
  static bool get isFuchsia => Platform.isFuchsia;

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
  static String get lineTerminator => Platform.isWindows ? '\r\n' : '\n';
}
