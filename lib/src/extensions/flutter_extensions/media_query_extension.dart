import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Extension for accessing various `MediaQueryData` properties easily.
extension FHUMediaQueryExtension on BuildContext {
  /// The data from the closest instance of `MediaQuery` that encloses the given context.
  MediaQueryData get mq => MediaQuery.of(this);

  /// The data from the closest instance of `MediaQuery` that encloses the given context, if any.
  MediaQueryData? get nullableMQ => MediaQuery.maybeOf(this);

  // Orientation and Navigation Mode
  /// Returns the orientation for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  Orientation get deviceOrientation => MediaQuery.orientationOf(this);

  /// Returns the navigation mode for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  NavigationMode get navigationMode => MediaQuery.navigationModeOf(this);

  // Padding and Insets
  /// The parts of the display that are partially obscured by system UI, typically by the hardware display "notches" or the system status bar.
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// The parts of the display that are completely obscured by system UI, typically by the device's keyboard.
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// The area of the display that is obscured by system UI or device features.
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  /// The system gesture insets for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  EdgeInsets get systemGestureInsets => MediaQuery.systemGestureInsetsOf(this);

  // Sizes and Dimensions
  /// Returns the size of the nearest `MediaQuery` ancestor or null if no such ancestor exists.
  Size? get nullableSize => MediaQuery.maybeSizeOf(this);

  /// Returns the size of the nearest `MediaQuery` ancestor.
  Size get sizePx => MediaQuery.sizeOf(this);

  /// The horizontal extent of this size.
  double get widthPx => sizePx.width;

  /// The vertical extent of this size.
  double get heightPx => sizePx.height;

  /// The lesser of the magnitudes of the width and height.
  double get shortestSide => sizePx.shortestSide;

  /// The greater of the magnitudes of the width and height.
  double get longestSide => sizePx.longestSide;

  // Display Features and Pixel Ratio
  /// The display features for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  List<DisplayFeature>? get nullableDisplayFeatures =>
      MediaQuery.maybeDisplayFeaturesOf(this);

  /// Similar to `MediaQuery.of(this).devicePixelRatio`.
  double get pixelRatio => MediaQuery.devicePixelRatioOf(this);

  // Accessibility and Text Settings
  /// Similar to `MediaQuery.of(this).textScaler`.
  TextScaler get textScaler => MediaQuery.textScalerOf(this);

  /// Returns whether accessible navigation is enabled for the nearest `MediaQuery` ancestor or null if none exists.
  bool? get nullableAccessibleNavigation =>
      MediaQuery.maybeAccessibleNavigationOf(this);

  /// Returns whether bold text is enabled for the nearest `MediaQuery` ancestor or null if none exists.
  bool? get nullableBoldText => MediaQuery.maybeBoldTextOf(this);

  /// Returns whether to disable animations for the nearest `MediaQuery` ancestor or null if none exists.
  bool? get nullableDisableAnimations =>
      MediaQuery.maybeDisableAnimationsOf(this);

  /// Returns whether to invert colors for the nearest `MediaQuery` ancestor or null if none exists.
  bool? get nullableInvertColors => MediaQuery.maybeInvertColorsOf(this);

  /// Returns whether high contrast mode is enabled for the nearest `MediaQuery` ancestor or null if none exists.
  bool? get nullableHighContrast => MediaQuery.maybeHighContrastOf(this);

  /// Returns whether to show on/off labels inside switches for the nearest `MediaQuery` ancestor or null if none exists.
  bool? get nullableOnOffSwitchLabels =>
      MediaQuery.maybeOnOffSwitchLabelsOf(this);

  /// Returns whether to always use the 24-hour format for the nearest `MediaQuery` ancestor or null if none exists.
  bool? get nullableAlwaysUse24HourFormat =>
      MediaQuery.maybeAlwaysUse24HourFormatOf(this);

  // Gesture Settings and Navigation
  /// Returns the gesture settings for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  DeviceGestureSettings? get nullableGestureSettings =>
      MediaQuery.maybeGestureSettingsOf(this);

  /// Returns the navigation mode for the nearest `MediaQuery` ancestor or null if none exists.
  NavigationMode? get nullableNavigationMode =>
      MediaQuery.maybeNavigationModeOf(this);

  // Miscellaneous
  /// Returns the platform brightness for the nearest `MediaQuery` ancestor or null if none exists.
  Brightness? get nullablePlatformBrightness =>
      MediaQuery.maybePlatformBrightnessOf(this);

  /// Returns the padding for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  EdgeInsets? get nullablePadding => MediaQuery.maybePaddingOf(this);

  /// Returns the view insets for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  EdgeInsets? get nullableViewInsets => MediaQuery.maybeViewInsetsOf(this);
}

/// Extension for orientation utilities.
extension FHUOrientationEx on Orientation {
  /// Checks if the device is in landscape mode.
  bool get isLandscape => this == Orientation.landscape;

  /// Checks if the device is in portrait mode.
  bool get isPortrait => this == Orientation.portrait;
}
