import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension PlatformExtension on BuildContext {
  bool get isMobile =>
      !kIsWeb &&
      (Theme.of(this).platform == TargetPlatform.iOS ||
          Theme.of(this).platform == TargetPlatform.android);

  bool get isIOS => !kIsWeb && Theme.of(this).platform == TargetPlatform.iOS;

  bool get isAndroid =>
      !kIsWeb && Theme.of(this).platform == TargetPlatform.android;

  bool get isDesktop =>
      !kIsWeb &&
      (Theme.of(this).platform == TargetPlatform.macOS ||
          Theme.of(this).platform == TargetPlatform.windows ||
          Theme.of(this).platform == TargetPlatform.linux);
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
}
