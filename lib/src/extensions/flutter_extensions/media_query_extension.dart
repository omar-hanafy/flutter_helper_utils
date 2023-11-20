import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  /// The data from the closest instance of this class that encloses the given
  /// context.
  MediaQueryData get mq => MediaQuery.of(this);

  /// The data from the closest instance of this class that encloses the given
  /// context, if any.
  MediaQueryData? get nullableMQ => MediaQuery.maybeOf(this);

  /// Returns orientation for the nearest MediaQuery ancestor or
  /// throws an exception, if no such ancestor exists.
  Orientation get deviceOrientation => MediaQuery.orientationOf(this);

  /// Returns navigationMode for the nearest MediaQuery ancestor or
  /// throws an exception, if no such ancestor exists.
  NavigationMode get navigationMode => MediaQuery.navigationModeOf(this);

  /// The parts of the display that are partially obscured by system UI,
  /// typically by the hardware display "notches" or the system status bar.
  /// If you consumed this padding (e.g. by building a widget that envelops or
  /// accounts for this padding in its layout in such a way that children are
  /// no longer exposed to this padding), you should remove this padding
  /// for subsequent descendants in the widget tree by inserting a new
  /// [MediaQuery] widget using the [mq.removePadding] factory.
  ///
  /// Padding is derived from the values of [viewInsets] and [viewPadding].
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  Brightness get platformBrightness => MediaQuery.platformBrightnessOf(this);

  /// The parts of the display that are completely obscured by system UI,
  /// typically by the device's keyboard.
  /// This value is independent of the [padding] and [viewPadding]. viewPadding
  /// is measured from the edges of the [MediaQuery] widget's bounds. Padding is
  /// calculated based on the viewPadding and viewInsets. The bounds of the top
  /// level MediaQuery created by [WidgetsApp] are the same as the window
  /// (often the mobile device screen) that contains the app.
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// This value is independent of the [padding] and [viewInsets]. their values
  /// are measured from the edges of the [MediaQuery] widget's bounds. The
  /// bounds of the top level MediaQuery created by [WidgetsApp] are the
  /// same as the window that contains the app. On mobile devices, this will
  /// typically be the full screen.
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => MediaQuery.sizeOf(this);

  /// Returns if Orientation is landscape
  bool get isLandscape => deviceOrientation.isLandscape;

  /// Returns if Orientation is landscape
  bool get isPortrait => deviceOrientation.isPortrait;

  /// The horizontal extent of this size.
  double get widthPx => sizePx.width;

  /// The vertical extent of this size.
  double get heightPx => sizePx.height;

  /// The lesser of the magnitudes of the [width] and the [height].
  double get shortestSide => sizePx.shortestSide;

  /// The greater of the magnitudes of the [width] and the [height].
  double get longestSide => sizePx.longestSide;

  /// similar to [MediaQuery.of(this).devicePixelRatio]
  double get pixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// similar to [MediaQuery.of(this).textScaler]
  TextScaler get textScaler => MediaQuery.textScalerOf(this);

  /// Returns accessibleNavigationOf for the nearest MediaQuery ancestor or
  /// throws an exception, if no such ancestor exists.
  bool get accessibleNavigation => MediaQuery.accessibleNavigationOf(this);

  /// Returns the boldText accessibility setting for the nearest MediaQuery
  /// ancestor or false, if no such ancestor exists.
  bool get boldText => MediaQuery.boldTextOf(this);

  /// Returns disableAnimations for the nearest MediaQuery ancestor or
  /// [Brightness.light], if no such ancestor exists.
  bool get disableAnimations => MediaQuery.disableAnimationsOf(this);

  /// Area of the display that may be obstructed by a hardware feature.
  ///
  /// This is populated only on Android.
  List<DisplayFeature> get displayFeatures =>
      MediaQuery.displayFeaturesOf(this);

  /// Returns gestureSettings for the nearest MediaQuery ancestor or
  /// throws an exception, if no such ancestor exists.
  DeviceGestureSettings get gestureSettings =>
      MediaQuery.gestureSettingsOf(this);

  /// Returns highContrast for the nearest MediaQuery ancestor or false, if no
  /// such ancestor exists.
  bool get highContrast => MediaQuery.highContrastOf(this);

  /// Returns highContrast for the nearest MediaQuery ancestor or false, if no
  /// such ancestor exists.
  bool get invertColors => MediaQuery.invertColorsOf(this);

  /// Returns the size of the nearest [MediaQuery] ancestor or null if no such
  /// ancestor exists.
  Size? get nullableSize => MediaQuery.maybeSizeOf(this);

  /// Returns the orientation for the nearest [MediaQuery] ancestor or null if
  /// no such ancestor exists.
  Orientation? get nullableOrientation => MediaQuery.maybeOrientationOf(this);

  /// Returns the device pixel ratio for the nearest [MediaQuery] ancestor or
  /// null if no such ancestor exists.
  double? get nullableDevicePixelRatio =>
      MediaQuery.maybeDevicePixelRatioOf(this);

  /// Returns the [TextScaler] for the nearest [MediaQuery] ancestor or null if
  /// no such ancestor exists.
  TextScaler? get nullableTextScaler => MediaQuery.maybeTextScalerOf(this);

  /// Returns the platform brightness for the nearest [MediaQuery] ancestor or
  /// null if no such ancestor exists.
  Brightness? get nullablePlatformBrightness =>
      MediaQuery.maybePlatformBrightnessOf(this);

  /// Returns the padding for the nearest [MediaQuery] ancestor or throws an
  /// exception if no such ancestor exists.
  EdgeInsets? get nullablePadding => MediaQuery.maybePaddingOf(this);

  /// Returns the view insets for the nearest [MediaQuery] ancestor or throws
  /// an exception if no such ancestor exists.
  EdgeInsets? get nullableViewInsets => MediaQuery.maybeViewInsetsOf(this);

  /// Returns the system gesture insets for the nearest [MediaQuery] ancestor or
  /// throws an exception if no such ancestor exists.
  EdgeInsets get systemGestureInsets => MediaQuery.systemGestureInsetsOf(this);

  /// Returns the system gesture insets for the nearest [MediaQuery] ancestor or
  /// null if no such ancestor exists.
  EdgeInsets? get nullableSystemGestureInsets =>
      MediaQuery.maybeSystemGestureInsetsOf(this);

  /// Returns the view padding for the nearest [MediaQuery] ancestor or throws
  /// an exception if no such ancestor exists.
  EdgeInsets? get nullableViewPadding => MediaQuery.maybeViewPaddingOf(this);

  /// Returns whether to always use the 24-hour format for the nearest
  /// [MediaQuery] ancestor or throws an exception if no such ancestor exists.
  bool get alwaysUse24HourFormat => MediaQuery.alwaysUse24HourFormatOf(this);

  /// Returns whether to always use the 24-hour format for the nearest
  /// [MediaQuery] ancestor or null if no such ancestor exists.
  bool? get nullableAlwaysUse24HourFormat =>
      MediaQuery.maybeAlwaysUse24HourFormatOf(this);

  /// Returns whether accessible navigation is enabled for the nearest
  /// [MediaQuery] ancestor or null if no such ancestor exists.
  bool? get nullableAccessibleNavigation =>
      MediaQuery.maybeAccessibleNavigationOf(this);

  /// Returns whether to invert colors for the nearest [MediaQuery] ancestor or
  /// null if no such ancestor exists.
  bool? get nullableInvertColors => MediaQuery.maybeInvertColorsOf(this);

  /// Returns whether high contrast mode is enabled for the nearest [MediaQuery]
  /// ancestor or null if no such ancestor exists.
  bool? get nullableHighContrast => MediaQuery.maybeHighContrastOf(this);

  /// Returns whether to show on/off labels inside switches for the nearest
  /// [MediaQuery] ancestor or throws an exception if no such ancestor exists.
  bool get onOffSwitchLabels => MediaQuery.onOffSwitchLabelsOf(this);

  /// Returns whether to show on/off labels inside switches for the nearest
  /// [MediaQuery] ancestor or null if no such ancestor exists.
  bool? get nullableOnOffSwitchLabels =>
      MediaQuery.maybeOnOffSwitchLabelsOf(this);

  /// Returns whether to disable animations for the nearest [MediaQuery] ancestor
  /// or null if no such ancestor exists.
  bool? get nullableDisableAnimations =>
      MediaQuery.maybeDisableAnimationsOf(this);

  /// Returns whether bold text is enabled for the nearest [MediaQuery] ancestor
  /// or null if no such ancestor exists.
  bool? get nullableBoldText => MediaQuery.maybeBoldTextOf(this);

  /// Returns the navigation mode for the nearest [MediaQuery] ancestor or
  /// null if no such ancestor exists.
  NavigationMode? get nullableNavigationMode =>
      MediaQuery.maybeNavigationModeOf(this);

  /// Returns the device gesture settings for the nearest [MediaQuery] ancestor or
  /// null if no such ancestor exists.
  DeviceGestureSettings? get nullableGestureSettings =>
      MediaQuery.maybeGestureSettingsOf(this);

  /// Returns the display features for the nearest [MediaQuery] ancestor or
  /// throws an exception if no such ancestor exists.
  List<DisplayFeature>? get nullableDisplayFeatures =>
      MediaQuery.maybeDisplayFeaturesOf(this);
}

extension OrientationEx on Orientation {
  /// check if device is on landscape mode
  bool get isLandscape => this == Orientation.landscape;

  /// check if device is on portrait mode
  bool get isPortrait => this == Orientation.portrait;
}
