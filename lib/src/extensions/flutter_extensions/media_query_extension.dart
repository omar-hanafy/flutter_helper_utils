import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);

  /// Returns if Orientation is landscape
  bool get isLandscape => mq.orientation == Orientation.landscape;

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => mq.size;

  /// Returns same as MediaQuery.of(context).size.width
  double get widthPx => sizePx.width;

  /// Returns same as MediaQuery.of(context).height
  double get heightPx => sizePx.height;

  double get shortestSide => sizePx.shortestSide;

  double get longestSide => sizePx.longestSide;

  /// similar to [MediaQuery.of(context).orientation]
  Orientation get screenOrientation => mq.orientation;

  /// similar to [MediaQuery.of(this).devicePixelRatio]
  double get pixelRatio => mq.devicePixelRatio;

  /// similar to [MediaQuery.of(this).textScaleFactor]
  double get txtScaleFactor => mq.textScaleFactor;

  /// The parts of the display that are partially obscured by system UI,
  /// typically by the hardware display "notches" or the system status bar.
  /// If you consumed this padding (e.g. by building a widget that envelops or
  /// accounts for this padding in its layout in such a way that children are
  /// no longer exposed to this padding), you should remove this padding
  /// for subsequent descendants in the widget tree by inserting a new
  /// [MediaQuery] widget using the [mq.removePadding] factory.
  ///
  /// Padding is derived from the values of [viewInsets] and [viewPadding].
  EdgeInsets get padding => mq.padding;

  /// The parts of the display that are completely obscured by system UI,
  /// typically by the device's keyboard.
  /// This value is independent of the [padding] and [viewPadding]. viewPadding
  /// is measured from the edges of the [MediaQuery] widget's bounds. Padding is
  /// calculated based on the viewPadding and viewInsets. The bounds of the top
  /// level MediaQuery created by [WidgetsApp] are the same as the window
  /// (often the mobile device screen) that contains the app.
  EdgeInsets get viewInsets => mq.viewInsets;

  /// This value is independent of the [padding] and [viewInsets]. their values
  /// are measured from the edges of the [MediaQuery] widget's bounds. The
  /// bounds of the top level MediaQuery created by [WidgetsApp] are the
  /// same as the window that contains the app. On mobile devices, this will
  /// typically be the full screen.
  EdgeInsets get viewPadding => mq.viewPadding;
}

extension OrientationEx on Orientation {
  /// check if device is on landscape mode
  bool get isLandscape => this == Orientation.landscape;

  /// check if device is on portrait mode
  bool get isPortrait => this == Orientation.portrait;
}
