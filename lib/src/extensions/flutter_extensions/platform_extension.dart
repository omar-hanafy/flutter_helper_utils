import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension PlatformExtension on BuildContext {
  TargetPlatform get targetPlatform => Theme.of(this).platform;

  bool get isMobile => targetPlatform.isMobile;

  bool get isIOS => targetPlatform.isIOS;

  bool get isAndroid => targetPlatform.isAndroid;

  bool get isDesktop => targetPlatform.isDesktop;

  bool get isMacOS => targetPlatform.isMacOS;

  bool get isWindows => targetPlatform.isWindows;

  bool get isLinux => targetPlatform.isLinux;

  bool get isApple => targetPlatform.isApple;

  bool get isMobileWeb => targetPlatform.isMobileWeb;

  bool get isIOSWeb => targetPlatform.isIOSWeb;

  bool get isAndroidWeb => targetPlatform.isAndroidWeb;

  bool get isDesktopWeb => targetPlatform.isDesktopWeb;

  bool get isMacOsWeb => targetPlatform.isMacOsWeb;

  bool get isWindowsWeb => targetPlatform.isWindowsWeb;

  bool get isLinuxWeb => targetPlatform.isLinuxWeb;

  bool get isAppleWeb => targetPlatform.isAppleWeb;
}

extension TargetPlatformExtension on TargetPlatform {
  bool get isMobile =>
      !kIsWeb && (this == TargetPlatform.iOS || this == TargetPlatform.android);

  bool get isIOS => !kIsWeb && this == TargetPlatform.iOS;

  bool get isAndroid => !kIsWeb && this == TargetPlatform.android;

  bool get isDesktop =>
      !kIsWeb &&
      (this == TargetPlatform.linux ||
          this == TargetPlatform.macOS ||
          this == TargetPlatform.windows);

  bool get isMacOS => !kIsWeb && this == TargetPlatform.macOS;

  bool get isWindows => !kIsWeb && this == TargetPlatform.windows;

  bool get isLinux => !kIsWeb && this == TargetPlatform.linux;

  bool get isApple =>
      !kIsWeb && (this == TargetPlatform.macOS || this == TargetPlatform.iOS);

  bool get isMobileWeb =>
      kIsWeb && (this == TargetPlatform.iOS || this == TargetPlatform.android);

  bool get isIOSWeb => kIsWeb && this == TargetPlatform.iOS;

  bool get isAndroidWeb => kIsWeb && this == TargetPlatform.android;

  bool get isDesktopWeb =>
      kIsWeb &&
      (this == TargetPlatform.linux ||
          this == TargetPlatform.macOS ||
          this == TargetPlatform.windows);

  bool get isMacOsWeb => kIsWeb && this == TargetPlatform.macOS;

  bool get isWindowsWeb => kIsWeb && this == TargetPlatform.windows;

  bool get isLinuxWeb => kIsWeb && this == TargetPlatform.linux;

  bool get isAppleWeb =>
      kIsWeb && (this == TargetPlatform.macOS || this == TargetPlatform.iOS);
}
