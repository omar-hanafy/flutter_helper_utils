// import 'dart:io';

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
