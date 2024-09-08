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
