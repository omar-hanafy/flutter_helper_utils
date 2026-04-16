// import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Exposes the active [TargetPlatform] from the nearest [Theme].
///
/// Use this when a widget should follow the app's configured platform behavior
/// instead of reading global platform information directly.
extension FHUPlatformExtension on BuildContext {
  /// Returns the [TargetPlatform] from [ThemeData.platform].
  ///
  /// This reflects the current theme configuration, so it can differ from the
  /// physical device platform when the app intentionally overrides it.
  TargetPlatform get targetPlatform => Theme.of(this).platform;
}

/// Adds null-safe platform predicates to an optional [BuildContext].
///
/// These getters resolve through [FHUPlatformExtension.targetPlatform]. When
/// the context is `null`, [targetPlatform] returns `null` and the boolean
/// helpers resolve to `false`.
extension FHUPlatformExtensionNullable on BuildContext? {
  /// Returns the themed [TargetPlatform], or `null` when no context exists.
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

/// Adds null-safe platform predicates to an optional [ThemeData].
///
/// Use these helpers when styling decisions are driven by a theme object rather
/// than a widget [BuildContext]. When the theme is `null`, the boolean getters
/// resolve to `false`.
extension FHUThemeDataPlatformExtensionNullable on ThemeData? {
  /// Returns [ThemeData.platform], or `null` when no theme exists.
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

/// Groups native and web-aware predicates for [TargetPlatform].
///
/// These helpers intentionally account for `kIsWeb`, so a value such as
/// [TargetPlatform.iOS] can be interpreted differently on the web versus a
/// native iOS app.
extension FHUTargetPlatformExtension on TargetPlatform? {
  /// Returns `true` for native iOS and Android apps only.
  bool get isMobile =>
      !kIsWeb && (this == TargetPlatform.iOS || this == TargetPlatform.android);

  /// Returns `true` for a native iOS app.
  bool get isIOS => !kIsWeb && this == TargetPlatform.iOS;

  /// Returns `true` for a native Android app.
  bool get isAndroid => !kIsWeb && this == TargetPlatform.android;

  /// Returns `true` for native desktop targets.
  bool get isDesktop =>
      !kIsWeb &&
      (this == TargetPlatform.linux ||
          this == TargetPlatform.macOS ||
          this == TargetPlatform.windows);

  /// Returns `true` for a native macOS app.
  bool get isMacOS => !kIsWeb && this == TargetPlatform.macOS;

  /// Returns `true` for a native Windows app.
  bool get isWindows => !kIsWeb && this == TargetPlatform.windows;

  /// Returns `true` for a native Fuchsia app.
  bool get isFuchsia => !kIsWeb && this == TargetPlatform.fuchsia;

  /// Returns `true` for a native Linux app.
  bool get isLinux => !kIsWeb && this == TargetPlatform.linux;

  /// Returns `true` for native Apple platforms.
  bool get isApple =>
      !kIsWeb && (this == TargetPlatform.macOS || this == TargetPlatform.iOS);

  /// Returns `true` for iOS and Android browsers.
  bool get isMobileWeb =>
      kIsWeb && (this == TargetPlatform.iOS || this == TargetPlatform.android);

  /// Returns `true` for iOS web environments.
  bool get isIOSWeb => kIsWeb && this == TargetPlatform.iOS;

  /// Returns `true` for Android web environments.
  bool get isAndroidWeb => kIsWeb && this == TargetPlatform.android;

  /// Returns `true` for desktop browsers.
  bool get isDesktopWeb =>
      kIsWeb &&
      (this == TargetPlatform.linux ||
          this == TargetPlatform.macOS ||
          this == TargetPlatform.windows);

  /// Returns `true` for macOS browsers.
  bool get isMacOsWeb => kIsWeb && this == TargetPlatform.macOS;

  /// Returns `true` for Windows browsers.
  bool get isWindowsWeb => kIsWeb && this == TargetPlatform.windows;

  /// Returns `true` for Linux browsers.
  bool get isLinuxWeb => kIsWeb && this == TargetPlatform.linux;

  /// Returns `true` for Fuchsia browsers.
  bool get isFuchsiaWeb => kIsWeb && this == TargetPlatform.fuchsia;

  /// Returns `true` for Apple browsers.
  bool get isAppleWeb =>
      kIsWeb && (this == TargetPlatform.macOS || this == TargetPlatform.iOS);
}
