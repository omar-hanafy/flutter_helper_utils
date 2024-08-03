import 'package:flutter/material.dart';

extension FHUPaddingExtensions on Widget {
  Padding paddingAll(double value, {Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Padding paddingLTRB(
    double left,
    double top,
    double right,
    double bottom, {
    Key? key,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: this,
      );

  Padding paddingSymmetric({
    Key? key,
    double v = 0.0,
    double h = 0.0,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.symmetric(
          vertical: v,
          horizontal: h,
        ),
        child: this,
      );

  Padding paddingOnly({
    Key? key,
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        key: key,
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: this,
      );
}

EdgeInsets edgeInsetsFlexible({
  double? all,
  double? horizontal,
  double? vertical,
  double? top,
  double? bottom,
  double? left,
  double? right,
}) {
  // Priority:
  // 1. 'all'
  // 2. Symmetrical values (if applicable)
  // 3. Individual values (with fallbacks to 0 if not provided)

  if (all != null) {
    return EdgeInsets.all(all);
  }

  if (horizontal != null || vertical != null) {
    return EdgeInsets.symmetric(
      horizontal: horizontal ?? 0.0,
      vertical: vertical ?? 0.0,
    );
  }

  // If no symmetrical values, use individual ones
  return EdgeInsets.fromLTRB(
    left ?? 0.0,
    top ?? 0.0,
    right ?? 0.0,
    bottom ?? 0.0,
  );
}

extension PaddingGetters on num {
  /// Creates `EdgeInsets` with this value applied to all sides.
  EdgeInsets get paddingAll => EdgeInsets.all(toDouble());

  /// Creates `EdgeInsets` with this value applied horizontally (left & right).
  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  /// Creates `EdgeInsets` with this value applied vertically (top & bottom).
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: toDouble());

  /// Creates `EdgeInsets` with only the top padding set to this value.
  EdgeInsets get paddingTop => EdgeInsets.only(top: toDouble());

  /// Creates `EdgeInsets` with only the bottom padding set to this value.
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: toDouble());

  /// Creates `EdgeInsets` with only the left padding set to this value.
  EdgeInsets get paddingLeft => EdgeInsets.only(left: toDouble());

  /// Creates `EdgeInsets` with only the right padding set to this value.
  EdgeInsets get paddingRight => EdgeInsets.only(right: toDouble());
}
