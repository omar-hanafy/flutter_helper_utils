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
}

extension OrientationEx on Orientation {
  /// check if device is on landscape mode
  bool get isLandscape => this == Orientation.landscape;

  /// check if device is on portrait mode
  bool get isPortrait => this == Orientation.portrait;
}
