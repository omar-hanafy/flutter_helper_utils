import 'package:flutter/material.dart';

extension PlatformExtension on BuildContext {
  bool get isMobile =>
      Theme.of(this).platform == TargetPlatform.iOS ||
      Theme.of(this).platform == TargetPlatform.android;

  bool get isDesktop =>
      Theme.of(this).platform == TargetPlatform.macOS ||
      Theme.of(this).platform == TargetPlatform.windows ||
      Theme.of(this).platform == TargetPlatform.linux;
}

extension TargetPlatformExtension on TargetPlatform {
  bool get isMobile =>
      this == TargetPlatform.iOS || this == TargetPlatform.android;

  bool get isDesktop =>
      this == TargetPlatform.linux ||
      this == TargetPlatform.macOS ||
      this == TargetPlatform.windows;
}
