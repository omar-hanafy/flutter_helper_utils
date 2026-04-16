import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Exposes frequently used [MediaQuery] values on [BuildContext].
///
/// These getters fall into two groups:
/// - strict accessors, which throw when no [MediaQuery] is in scope
/// - nullable accessors, which return `null` instead
///
/// Prefer the nullable variants when calling from code that may execute above
/// `MaterialApp`, during tests, or inside utilities that should degrade
/// gracefully when layout data is unavailable.
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

  /// Returns [MediaQueryData.padding] for the nearest [MediaQuery] ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// EdgeInsets? padding = context.nullablePadding;
  /// ```
  EdgeInsets? get nullablePadding => MediaQuery.maybePaddingOf(this);

  /// The parts of the display that are completely obscured by system UI, typically by the device's keyboard.
  ///
  /// Example:
  /// ```dart
  /// EdgeInsets viewInsets = context.viewInsets;
  /// ```
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// Returns [MediaQueryData.viewInsets] for the nearest [MediaQuery] ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// EdgeInsets? viewInsets = context.nullableViewInsets;
  /// ```
  EdgeInsets? get nullableViewInsets => MediaQuery.maybeViewInsetsOf(this);

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
  /// Uses [MediaQuery.widthOf] so the widget only rebuilds when the width
  /// changes, not when height changes.
  ///
  /// Example:
  /// ```dart
  /// double width = context.widthPx;
  /// ```
  double get widthPx => MediaQuery.widthOf(this);

  /// Returns the width from the nearest [MediaQuery] ancestor or null if none exists.
  ///
  /// Uses [MediaQuery.maybeWidthOf] so the widget only rebuilds when the width
  /// changes, not when height changes.
  ///
  /// Example:
  /// ```dart
  /// double? width = context.nullableWidthPx;
  /// ```
  double? get nullableWidthPx => MediaQuery.maybeWidthOf(this);

  /// The vertical extent of this size.
  ///
  /// Uses [MediaQuery.heightOf] so the widget only rebuilds when the height
  /// changes, not when width changes.
  ///
  /// Example:
  /// ```dart
  /// double height = context.heightPx;
  /// ```
  double get heightPx => MediaQuery.heightOf(this);

  /// Returns the height from the nearest [MediaQuery] ancestor or null if none exists.
  ///
  /// Uses [MediaQuery.maybeHeightOf] so the widget only rebuilds when the height
  /// changes, not when width changes.
  ///
  /// Example:
  /// ```dart
  /// double? height = context.nullableHeightPx;
  /// ```
  double? get nullableHeightPx => MediaQuery.maybeHeightOf(this);

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

  /// Whether accessibility announcements (like `SemanticsService.announce`)
  /// are supported on the current platform.
  ///
  /// Example:
  /// ```dart
  /// bool supportsAnnounce = context.supportsAnnounce;
  /// ```
  bool get supportsAnnounce => MediaQuery.supportsAnnounceOf(this);

  /// Returns whether accessibility announcements are supported for the nearest
  /// `MediaQuery` ancestor or null if none exists.
  ///
  /// Example:
  /// ```dart
  /// bool? supportsAnnounce = context.nullableSupportsAnnounce;
  /// ```
  bool? get nullableSupportsAnnounce =>
      MediaQuery.maybeSupportsAnnounceOf(this);

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

  /// Returns the current [Orientation], or `null` when no [MediaQuery] exists.
  ///
  /// Example:
  /// ```dart
  /// Orientation? nullableOrientation = context.nullableDeviceOrientation;
  /// ```
  Orientation? get nullableDeviceOrientation =>
      MediaQuery.maybeOrientationOf(this);

  /// Returns the device pixel ratio, or `null` when no [MediaQuery] exists.
  ///
  /// Example:
  /// ```dart
  /// double? nullablePixelRatio = context.nullablePixelRatio;
  /// ```
  double? get nullablePixelRatio => MediaQuery.maybeDevicePixelRatioOf(this);

  /// Returns the current [TextScaler], or `null` when no [MediaQuery] exists.
  ///
  /// Example:
  /// ```dart
  /// TextScaler? nullableTextScaler = context.nullableTextScaler;
  /// ```
  TextScaler? get nullableTextScaler => MediaQuery.maybeTextScalerOf(this);

  /// Returns the platform brightness from the nearest [MediaQuery].
  ///
  /// This reflects the current system light or dark preference rather than the
  /// app's themed brightness.
  ///
  /// Example:
  /// ```dart
  /// Brightness brightness = context.platformBrightness;
  /// ```
  Brightness get platformBrightness => MediaQuery.platformBrightnessOf(this);

  /// Returns system gesture insets, or `null` when no [MediaQuery] exists.
  ///
  /// Example:
  /// ```dart
  /// EdgeInsets? nullableSystemInsets = context.nullableSystemGestureInsets;
  /// ```
  EdgeInsets? get nullableSystemGestureInsets =>
      MediaQuery.maybeSystemGestureInsetsOf(this);

  /// Returns view padding, or `null` when no [MediaQuery] exists.
  ///
  /// Example:
  /// ```dart
  /// EdgeInsets? nullableViewPadding = context.nullableViewPadding;
  /// ```
  EdgeInsets? get nullableViewPadding => MediaQuery.maybeViewPaddingOf(this);

  /// Returns whether the platform prefers 24-hour time formatting.
  ///
  /// Example:
  /// ```dart
  /// bool alwaysUse24Hour = context.alwaysUse24HourFormat;
  /// ```
  bool get alwaysUse24HourFormat => MediaQuery.alwaysUse24HourFormatOf(this);

  /// Returns whether accessible navigation is enabled.
  ///
  /// Use this to reduce motion or simplify interactions when assistive
  /// navigation features are active.
  ///
  /// Example:
  /// ```dart
  /// bool accessibleNavigation = context.accessibleNavigation;
  /// ```
  bool get accessibleNavigation => MediaQuery.accessibleNavigationOf(this);

  /// Returns whether platform color inversion is enabled.
  ///
  /// Example:
  /// ```dart
  /// bool invertColors = context.invertColors;
  /// ```
  bool get invertColors => MediaQuery.invertColorsOf(this);

  /// Returns whether the platform requests higher contrast rendering.
  ///
  /// Example:
  /// ```dart
  /// bool highContrast = context.highContrast;
  /// ```
  bool get highContrast => MediaQuery.highContrastOf(this);

  /// Returns whether switches should show explicit on and off labels.
  ///
  /// Example:
  /// ```dart
  /// bool onOffSwitchLabels = context.onOffSwitchLabels;
  /// ```
  bool get onOffSwitchLabels => MediaQuery.onOffSwitchLabelsOf(this);

  /// Returns whether non-essential animations should be reduced or disabled.
  ///
  /// Example:
  /// ```dart
  /// bool disableAnimations = context.disableAnimations;
  /// ```
  bool get disableAnimations => MediaQuery.disableAnimationsOf(this);

  /// Returns whether the platform requests bolder text rendering.
  ///
  /// Example:
  /// ```dart
  /// bool boldText = context.boldText;
  /// ```
  bool get boldText => MediaQuery.boldTextOf(this);

  /// Returns gesture settings from the nearest [MediaQuery].
  ///
  /// Example:
  /// ```dart
  /// DeviceGestureSettings gestureSettings = context.gestureSettings;
  /// ```
  DeviceGestureSettings get gestureSettings =>
      MediaQuery.gestureSettingsOf(this);

  /// Returns display features such as folds, hinges, or cutout regions.
  ///
  /// Example:
  /// ```dart
  /// List<DisplayFeature> displayFeatures = context.displayFeatures;
  /// ```
  List<DisplayFeature> get displayFeatures =>
      MediaQuery.displayFeaturesOf(this);

  /// Returns whether the platform can show the native system context menu.
  ///
  /// Example:
  /// ```dart
  /// bool supportsContextMenu = context.supportsShowingSystemContextMenu;
  /// ```
  bool get supportsShowingSystemContextMenu =>
      MediaQuery.supportsShowingSystemContextMenu(this);

  /// Returns whether the platform can show the native context menu, or `null`
  /// when no [MediaQuery] exists.
  ///
  /// Example:
  /// ```dart
  /// bool? nullableSupportsContextMenu = context.nullableSupportsShowingSystemContextMenu;
  /// ```
  bool? get nullableSupportsShowingSystemContextMenu =>
      MediaQuery.maybeSupportsShowingSystemContextMenu(this);
}

/// Adds orientation predicates for layout branching.
extension FHUOrientationEx on Orientation {
  /// Returns `true` when width is the dominant axis.
  bool get isLandscape => this == Orientation.landscape;

  /// Returns `true` when height is the dominant axis.
  bool get isPortrait => this == Orientation.portrait;
}
