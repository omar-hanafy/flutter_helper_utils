import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Extension for accessing various `MediaQueryData` properties easily.
extension FHUMediaQueryExtension on BuildContext {
  /// The data from the closest instance of `MediaQuery` that encloses the given context.
  ///
  /// Example:
  /// ```dart
  /// MediaQueryData mediaQuery = context.mq;
  /// ```
  MediaQueryData get mq => MediaQuery.of(this);

  /// The data from the closest instance of `MediaQuery` that encloses the given context, if any.
  ///
  /// Example:
  /// ```dart
  /// MediaQueryData? nullableMQ = context.nullableMQ;
  /// ```
  MediaQueryData? get nullableMQ => MediaQuery.maybeOf(this);

  // Orientation and Navigation Mode

  /// Returns the orientation for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  ///
  /// Example:
  /// ```dart
  /// Orientation orientation = context.deviceOrientation;
  /// ```
  Orientation get deviceOrientation => MediaQuery.orientationOf(this);

  /// Returns the navigation mode for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  ///
  /// Example:
  /// ```dart
  /// NavigationMode navMode = context.navigationMode;
  /// ```
  NavigationMode get navigationMode => MediaQuery.navigationModeOf(this);

  // Padding and Insets

  /// The parts of the display that are partially obscured by system UI, typically by the hardware display "notches" or the system status bar.
  ///
  /// Example:
  /// ```dart
  /// EdgeInsets padding = context.padding;
  /// ```
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// The parts of the display that are completely obscured by system UI, typically by the device's keyboard.
  ///
  /// Example:
  /// ```dart
  /// EdgeInsets viewInsets = context.viewInsets;
  /// ```
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// The area of the display that is obscured by system UI or device features.
  ///
  /// Example:
  /// ```dart
  /// EdgeInsets viewPadding = context.viewPadding;
  /// ```
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  /// The system gesture insets for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  ///
  /// Example:
  /// ```dart
  /// EdgeInsets systemGestureInsets = context.systemGestureInsets;
  /// ```
  EdgeInsets get systemGestureInsets => MediaQuery.systemGestureInsetsOf(this);

  // Sizes and Dimensions

  /// Returns the size of the nearest `MediaQuery` ancestor or null if no such ancestor exists.
  ///
  /// Example:
  /// ```dart
  /// Size? nullableSize = context.nullableSize;
  /// ```
  Size? get nullableSize => MediaQuery.maybeSizeOf(this);

  /// Returns the size of the nearest `MediaQuery` ancestor.
  ///
  /// Example:
  /// ```dart
  /// Size size = context.sizePx;
  /// ```
  Size get sizePx => MediaQuery.sizeOf(this);

  /// The horizontal extent of this size.
  ///
  /// Example:
  /// ```dart
  /// double width = context.widthPx;
  /// ```
  double get widthPx => sizePx.width;

  /// The vertical extent of this size.
  ///
  /// Example:
  /// ```dart
  /// double height = context.heightPx;
  /// ```
  double get heightPx => sizePx.height;

  /// The lesser of the magnitudes of the width and height.
  ///
  /// Example:
  /// ```dart
  /// double shortestSide = context.shortestSide;
  /// ```
  double get shortestSide => sizePx.shortestSide;

  /// The greater of the magnitudes of the width and height.
  ///
  /// Example:
  /// ```dart
  /// double longestSide = context.longestSide;
  /// ```
  double get longestSide => sizePx.longestSide;

  // Display Features and Pixel Ratio

  /// The display features for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  ///
  /// Example:
  /// ```dart
  /// List<DisplayFeature>? displayFeatures = context.nullableDisplayFeatures;
  /// ```
  List<DisplayFeature>? get nullableDisplayFeatures =>
      MediaQuery.maybeDisplayFeaturesOf(this);

  /// Similar to `MediaQuery.of(this).devicePixelRatio`.
  ///
  /// Example:
  /// ```dart
  /// double pixelRatio = context.pixelRatio;
  /// ```
  double get pixelRatio => MediaQuery.devicePixelRatioOf(this);

  // Accessibility and Text Settings

  /// Similar to `MediaQuery.of(this).textScaler`.
  ///
  /// Example:
  /// ```dart
  /// TextScaler textScaler = context.textScaler;
  /// ```
  TextScaler get textScaler => MediaQuery.textScalerOf(this);

  /// Returns whether accessible navigation is enabled for the nearest `MediaQuery` ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// bool? accessibleNav = context.nullableAccessibleNavigation;
  /// ```
  bool? get nullableAccessibleNavigation =>
      MediaQuery.maybeAccessibleNavigationOf(this);

  /// Returns whether bold text is enabled for the nearest `MediaQuery` ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// bool? boldText = context.nullableBoldText;
  /// ```
  bool? get nullableBoldText => MediaQuery.maybeBoldTextOf(this);

  /// Returns whether to disable animations for the nearest `MediaQuery` ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// bool? disableAnimations = context.nullableDisableAnimations;
  /// ```
  bool? get nullableDisableAnimations =>
      MediaQuery.maybeDisableAnimationsOf(this);

  /// Returns whether to invert colors for the nearest `MediaQuery` ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// bool? invertColors = context.nullableInvertColors;
  /// ```
  bool? get nullableInvertColors => MediaQuery.maybeInvertColorsOf(this);

  /// Returns whether high contrast mode is enabled for the nearest `MediaQuery` ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// bool? highContrast = context.nullableHighContrast;
  /// ```
  bool? get nullableHighContrast => MediaQuery.maybeHighContrastOf(this);

  /// Returns whether to show on/off labels inside switches for the nearest `MediaQuery` ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// bool? onOffLabels = context.nullableOnOffSwitchLabels;
  /// ```
  bool? get nullableOnOffSwitchLabels =>
      MediaQuery.maybeOnOffSwitchLabelsOf(this);

  /// Returns whether to always use the 24-hour format for the nearest `MediaQuery` ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// bool? always24Hour = context.nullableAlwaysUse24HourFormat;
  /// ```
  bool? get nullableAlwaysUse24HourFormat =>
      MediaQuery.maybeAlwaysUse24HourFormatOf(this);

  // Gesture Settings and Navigation

  /// Returns the gesture settings for the nearest `MediaQuery` ancestor or throws an exception if none exists.
  ///
  /// Example:
  /// ```dart
  /// DeviceGestureSettings? gestureSettings = context.nullableGestureSettings;
  /// ```
  DeviceGestureSettings? get nullableGestureSettings =>
      MediaQuery.maybeGestureSettingsOf(this);

  /// Returns the navigation mode for the nearest `MediaQuery` ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// NavigationMode? navMode = context.nullableNavigationMode;
  /// ```
  NavigationMode? get nullableNavigationMode =>
      MediaQuery.maybeNavigationModeOf(this);

  // Miscellaneous

  /// Returns the platform brightness for the nearest `MediaQuery` ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// Brightness? brightness = context.nullablePlatformBrightness;
  /// ```
  Brightness? get nullablePlatformBrightness =>
      MediaQuery.maybePlatformBrightnessOf(this);

  /// quick way to provide access to `maybeOrientationOf`.
  ///
  /// Example:
  /// ```dart
  /// Orientation? nullableOrientation = context.nullableDeviceOrientation;
  /// ```
  Orientation? get nullableDeviceOrientation =>
      MediaQuery.maybeOrientationOf(this);

  /// quick way to provide access to `maybeDevicePixelRatioOf`.
  ///
  /// Example:
  /// ```dart
  /// double? nullablePixelRatio = context.nullablePixelRatio;
  /// ```
  double? get nullablePixelRatio => MediaQuery.maybeDevicePixelRatioOf(this);

  /// quick way to provide access to `maybeTextScalerOf`.
  ///
  /// Example:
  /// ```dart
  /// TextScaler? nullableTextScaler = context.nullableTextScaler;
  /// ```
  TextScaler? get nullableTextScaler => MediaQuery.maybeTextScalerOf(this);

  /// quick way to provide access to `platformBrightnessOf`.
  ///
  /// Example:
  /// ```dart
  /// Brightness brightness = context.platformBrightness;
  /// ```
  Brightness get platformBrightness => MediaQuery.platformBrightnessOf(this);

  /// quick way to provide access to `maybeSystemGestureInsetsOf`.
  ///
  /// Example:
  /// ```dart
  /// EdgeInsets? nullableSystemInsets = context.nullableSystemGestureInsets;
  /// ```
  EdgeInsets? get nullableSystemGestureInsets =>
      MediaQuery.maybeSystemGestureInsetsOf(this);

  /// quick way to provide access to `maybeViewPaddingOf`.
  ///
  /// Example:
  /// ```dart
  /// EdgeInsets? nullableViewPadding = context.nullableViewPadding;
  /// ```
  EdgeInsets? get nullableViewPadding => MediaQuery.maybeViewPaddingOf(this);

  /// quick way to provide access to `alwaysUse24HourFormatOf`.
  ///
  /// Example:
  /// ```dart
  /// bool alwaysUse24Hour = context.alwaysUse24HourFormat;
  /// ```
  bool get alwaysUse24HourFormat => MediaQuery.alwaysUse24HourFormatOf(this);

  /// quick way to provide access to `accessibleNavigationOf`.
  ///
  /// Example:
  /// ```dart
  /// bool accessibleNavigation = context.accessibleNavigation;
  /// ```
  bool get accessibleNavigation => MediaQuery.accessibleNavigationOf(this);

  /// quick way to provide access to `invertColorsOf`.
  ///
  /// Example:
  /// ```dart
  /// bool invertColors = context.invertColors;
  /// ```
  bool get invertColors => MediaQuery.invertColorsOf(this);

  /// quick way to provide access to `highContrastOf`.
  ///
  /// Example:
  /// ```dart
  /// bool highContrast = context.highContrast;
  /// ```
  bool get highContrast => MediaQuery.highContrastOf(this);

  /// quick way to provide access to `onOffSwitchLabelsOf`.
  ///
  /// Example:
  /// ```dart
  /// bool onOffSwitchLabels = context.onOffSwitchLabels;
  /// ```
  bool get onOffSwitchLabels => MediaQuery.onOffSwitchLabelsOf(this);

  /// quick way to provide access to `disableAnimationsOf`.
  ///
  /// Example:
  /// ```dart
  /// bool disableAnimations = context.disableAnimations;
  /// ```
  bool get disableAnimations => MediaQuery.disableAnimationsOf(this);

  /// quick way to provide access to `boldTextOf`.
  ///
  /// Example:
  /// ```dart
  /// bool boldText = context.boldText;
  /// ```
  bool get boldText => MediaQuery.boldTextOf(this);

  /// quick way to provide access to `gestureSettingsOf`.
  ///
  /// Example:
  /// ```dart
  /// DeviceGestureSettings gestureSettings = context.gestureSettings;
  /// ```
  DeviceGestureSettings get gestureSettings =>
      MediaQuery.gestureSettingsOf(this);

  /// quick way to provide access to `displayFeaturesOf`.
  ///
  /// Example:
  /// ```dart
  /// List<DisplayFeature> displayFeatures = context.displayFeatures;
  /// ```
  List<DisplayFeature> get displayFeatures =>
      MediaQuery.displayFeaturesOf(this);

  /// quick way to provide access to `supportsShowingSystemContextMenu`.
  ///
  /// Example:
  /// ```dart
  /// bool supportsContextMenu = context.supportsShowingSystemContextMenu;
  /// ```
  bool get supportsShowingSystemContextMenu =>
      MediaQuery.supportsShowingSystemContextMenu(this);

  /// quick way to provide access to `maybeSupportsShowingSystemContextMenu`.
  ///
  /// Example:
  /// ```dart
  /// bool? nullableSupportsContextMenu = context.nullableSupportsShowingSystemContextMenu;
  /// ```
  bool? get nullableSupportsShowingSystemContextMenu =>
      MediaQuery.maybeSupportsShowingSystemContextMenu(this);
}

/// Extension for orientation utilities.
extension FHUOrientationEx on Orientation {
  /// Checks if the device is in landscape mode.
  bool get isLandscape => this == Orientation.landscape;

  /// Checks if the device is in portrait mode.
  bool get isPortrait => this == Orientation.portrait;
}
