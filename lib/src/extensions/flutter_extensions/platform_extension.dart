import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Extension on [BuildContext] to provide easy access to the target platform.
extension FHUPlatformExtension on BuildContext {
  /// Gets the [TargetPlatform] of the current [BuildContext].
  TargetPlatform get targetPlatform => Theme.of(this).platform;
}

/// Extension on nullable [BuildContext] to provide various platform checks.
extension FHUPlatformExtensionNullable on BuildContext? {
  /// Gets the [TargetPlatform] of the nullable [BuildContext].
  TargetPlatform? get targetPlatform =>
      this == null ? null : Theme.of(this!).platform;

  /// Checks if the platform is a mobile device (iOS or Android) natively.
  bool get isMobile => targetPlatform.isMobile;

  /// Checks if the platform is iOS natively.
  bool get isIOS => targetPlatform.isIOS;

  /// Checks if the platform is Android natively.
  bool get isAndroid => targetPlatform.isAndroid;

  /// Checks if the platform is a desktop OS (Linux, macOS, Windows) natively.
  bool get isDesktop => targetPlatform.isDesktop;

  /// Checks if the platform is macOS natively.
  bool get isMacOS => targetPlatform.isMacOS;

  /// Checks if the platform is Windows natively.
  bool get isWindows => targetPlatform.isWindows;

  /// Checks if the platform is Linux natively.
  bool get isLinux => targetPlatform.isLinux;

  /// Checks if the platform is Fuchsia natively.
  bool get isFuchsia => targetPlatform.isFuchsia;

  /// Checks if the platform is an Apple platform (macOS or iOS) natively.
  bool get isApple => targetPlatform.isApple;

  /// Checks if the platform is a mobile browser (iOS or Android).
  bool get isMobileWeb => targetPlatform.isMobileWeb;

  /// Checks if the platform is iOS in a web browser.
  bool get isIOSWeb => targetPlatform.isIOSWeb;

  /// Checks if the platform is Android in a web browser.
  bool get isAndroidWeb => targetPlatform.isAndroidWeb;

  /// Checks if the platform is a desktop browser (Linux, macOS, Windows).
  bool get isDesktopWeb => targetPlatform.isDesktopWeb;

  /// Checks if the platform is macOS in a web browser.
  bool get isMacOsWeb => targetPlatform.isMacOsWeb;

  /// Checks if the platform is Windows in a web browser.
  bool get isWindowsWeb => targetPlatform.isWindowsWeb;

  /// Checks if the platform is Linux in a web browser.
  bool get isLinuxWeb => targetPlatform.isLinuxWeb;

  /// Checks if the platform is Fuchsia in a web browser.
  bool get isFuchsiaWeb => targetPlatform.isFuchsiaWeb;

  /// Checks if the platform is an Apple platform (macOS or iOS) in a web browser.
  bool get isAppleWeb => targetPlatform.isAppleWeb;
}

/// Extension on nullable [ThemeData] to provide various platform checks.
extension FHUThemeDataPlatformExtensionNullable on ThemeData? {
  /// Gets the [TargetPlatform] of the nullable [ThemeData].
  TargetPlatform? get platform => this?.platform;

  /// Checks if the platform is a mobile device (iOS or Android) natively.
  bool get isMobile => platform.isMobile;

  /// Checks if the platform is iOS natively.
  bool get isIOS => platform.isIOS;

  /// Checks if the platform is Android natively.
  bool get isAndroid => platform.isAndroid;

  /// Checks if the platform is a desktop OS (Linux, macOS, Windows) natively.
  bool get isDesktop => platform.isDesktop;

  /// Checks if the platform is macOS natively.
  bool get isMacOS => platform.isMacOS;

  /// Checks if the platform is Windows natively.
  bool get isWindows => platform.isWindows;

  /// Checks if the platform is Linux natively.
  bool get isLinux => platform.isLinux;

  /// Checks if the platform is Fuchsia natively.
  bool get isFuchsia => platform.isFuchsia;

  /// Checks if the platform is an Apple platform (macOS or iOS) natively.
  bool get isApple => platform.isApple;

  /// Checks if the platform is a mobile browser (iOS or Android).
  bool get isMobileWeb => platform.isMobileWeb;

  /// Checks if the platform is iOS in a web browser.
  bool get isIOSWeb => platform.isIOSWeb;

  /// Checks if the platform is Android in a web browser.
  bool get isAndroidWeb => platform.isAndroidWeb;

  /// Checks if the platform is a desktop browser (Linux, macOS, Windows).
  bool get isDesktopWeb => platform.isDesktopWeb;

  /// Checks if the platform is macOS in a web browser.
  bool get isMacOsWeb => platform.isMacOsWeb;

  /// Checks if the platform is Windows in a web browser.
  bool get isWindowsWeb => platform.isWindowsWeb;

  /// Checks if the platform is Linux in a web browser.
  bool get isLinuxWeb => platform.isLinuxWeb;

  /// Checks if the platform is Fuchsia in a web browser.
  bool get isFuchsiaWeb => platform.isFuchsiaWeb;

  /// Checks if the platform is an Apple platform (macOS or iOS) in a web browser.
  bool get isAppleWeb => platform.isAppleWeb;
}

/// Extension on [TargetPlatform] to provide various platform checks.
extension FHUTargetPlatformExtension on TargetPlatform? {
  /// Checks if the platform is a mobile device (iOS or Android) natively.
  bool get isMobile =>
      !kIsWeb && (this == TargetPlatform.iOS || this == TargetPlatform.android);

  /// Checks if the platform is iOS natively.
  bool get isIOS => !kIsWeb && this == TargetPlatform.iOS;

  /// Checks if the platform is Android natively.
  bool get isAndroid => !kIsWeb && this == TargetPlatform.android;

  /// Checks if the platform is a desktop OS (Linux, macOS, Windows) natively.
  bool get isDesktop =>
      !kIsWeb &&
      (this == TargetPlatform.linux ||
          this == TargetPlatform.macOS ||
          this == TargetPlatform.windows);

  /// Checks if the platform is macOS natively.
  bool get isMacOS => !kIsWeb && this == TargetPlatform.macOS;

  /// Checks if the platform is Windows natively.
  bool get isWindows => !kIsWeb && this == TargetPlatform.windows;

  /// Checks if the platform is Fuchsia natively.
  bool get isFuchsia => !kIsWeb && this == TargetPlatform.fuchsia;

  /// Checks if the platform is Linux natively.
  bool get isLinux => !kIsWeb && this == TargetPlatform.linux;

  /// Checks if the platform is an Apple platform (macOS or iOS) natively.
  bool get isApple =>
      !kIsWeb && (this == TargetPlatform.macOS || this == TargetPlatform.iOS);

  /// Checks if the platform is a mobile browser (iOS or Android).
  bool get isMobileWeb =>
      kIsWeb && (this == TargetPlatform.iOS || this == TargetPlatform.android);

  /// Checks if the platform is iOS in a web browser.
  bool get isIOSWeb => kIsWeb && this == TargetPlatform.iOS;

  /// Checks if the platform is Android in a web browser.
  bool get isAndroidWeb => kIsWeb && this == TargetPlatform.android;

  /// Checks if the platform is a desktop browser (Linux, macOS, Windows).
  bool get isDesktopWeb =>
      kIsWeb &&
      (this == TargetPlatform.linux ||
          this == TargetPlatform.macOS ||
          this == TargetPlatform.windows);

  /// Checks if the platform is macOS in a web browser.
  bool get isMacOsWeb => kIsWeb && this == TargetPlatform.macOS;

  /// Checks if the platform is Windows in a web browser.
  bool get isWindowsWeb => kIsWeb && this == TargetPlatform.windows;

  /// Checks if the platform is Linux in a web browser.
  bool get isLinuxWeb => kIsWeb && this == TargetPlatform.linux;

  /// Checks if the platform is Fuchsia in a web browser.
  bool get isFuchsiaWeb => kIsWeb && this == TargetPlatform.fuchsia;

  /// Checks if the platform is an Apple platform (macOS or iOS) in a web browser.
  bool get isAppleWeb =>
      kIsWeb && (this == TargetPlatform.macOS || this == TargetPlatform.iOS);
}

/// A platform-independent class providing information about the operating system,
/// with web compatibility considerations.
///
/// Similar to the `Platform` class from the `dart:io` library, but this one
/// respects the web environment.
/// A platform-independent class providing information about the operating system,
/// with special considerations for web compatibility.
///
/// This class serves as a unified interface for interacting with platform-specific
/// details, abstracting away the differences between native and web environments.
/// It mirrors the functionality of the `Platform` class from the `dart:io` library,
/// but ensures consistent behavior even when running Dart code in a web browser.
abstract class PlatformEnv {
  /// Returns the `TargetPlatform` corresponding to the current operating system.
  ///
  /// This method maps the `operatingSystem` string to the appropriate
  /// `TargetPlatform` enum value. In the case of web platforms or unrecognized
  /// operating systems, it returns the `defaultTargetPlatform`.
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

  static bool get isLinux => !kIsWeb && Platform.isLinux;

  /// Returns `true` if the current platform is macOS, except on web platforms.
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  /// Returns `true` if the current platform is Windows, except on web platforms.
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  /// Returns `true` if the current platform is Android, except on web platforms.
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// Returns `true` if the current platform is iOS, except on web platforms.
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// Returns `true` if the current platform is web.
  static bool get isWeb => kIsWeb;

  /// Returns `true` if the current platform is Fuchsia, except on web platforms.
  static bool get isFuchsia => !kIsWeb && Platform.isFuchsia;

  /// Returns the name of the operating system as a `String`.
  /// Returns 'web' if the platform is a web platform.
  static String get operatingSystem =>
      kIsWeb ? 'web' : Platform.operatingSystem;

  /// Returns the version of the operating system as a `String`, or 'N/A' on web platforms.
  static String get operatingSystemVersion =>
      !kIsWeb ? Platform.operatingSystemVersion : 'N/A';

  /// Returns the number of processors available to the Dart VM. Returns `0` on web platforms.
  static int get numberOfProcessors =>
      !kIsWeb ? Platform.numberOfProcessors : 0;

  /// Returns the path separator used by the operating system to separate components in file paths.
  /// Returns `/` on web platforms.
  static String get pathSeparator => !kIsWeb ? Platform.pathSeparator : '/';

  /// Returns the local hostname for the system. Returns 'localhost' on web platforms.
  static String get localHostname =>
      !kIsWeb ? Platform.localHostname : 'localhost';

  /// Returns the version of the current Dart runtime as a `String`.
  static String get version => Platform.version;

  /// Returns the name of the current locale. The result may consist of a language code,
  /// optionally followed by a country code and a character set.
  static String get localeName => Platform.localeName;

  /// Returns the environment for this process as a map from string key to string value.
  /// Returns an empty map on web platforms where environment variables are not available.
  static Map<String, String> get environment =>
      !kIsWeb ? Platform.environment : {};

  /// Returns the path of the executable used to run the script in this isolate.
  /// Returns 'N/A' on web platforms where the concept of an executable is not applicable.
  static String get executable => !kIsWeb ? Platform.executable : 'N/A';

  /// Returns the path of the executable used to run the script in this isolate
  /// after it has been resolved by the OS. Returns 'N/A' on web platforms.
  static String get resolvedExecutable =>
      !kIsWeb ? Platform.resolvedExecutable : 'N/A';

  /// Returns the absolute URI of the script being run in this isolate.
  /// Returns an empty URI on web platforms.
  static Uri get script => !kIsWeb ? Platform.script : Uri();

  /// Returns the flags passed to the executable used to run the script in this isolate.
  /// Returns an empty list on web platforms.
  static List<String> get executableArguments =>
      !kIsWeb ? Platform.executableArguments : [];

  /// Returns the `--packages` flag passed to the executable used to run the script
  /// in this isolate, or `null` if no such flag was provided. Returns `null` on web platforms.
  static String? get packageConfig => !kIsWeb ? Platform.packageConfig : null;

  /// Returns the system's default line terminator. On web platforms, it defaults to `'\n'`.
  /// On Windows, it's `'\r\n'`, and on other platforms, it's `'\n'`.
  static String get lineTerminator =>
      !kIsWeb ? (Platform.isWindows ? '\r\n' : '\n') : '\n';
}
