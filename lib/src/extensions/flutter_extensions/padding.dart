import 'package:flutter/material.dart';

extension PaddingExtensions on Widget {
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

  Padding paddingSymmetric({Key? key, double v = 0.0, double h = 0.0}) =>
      Padding(
        key: key,
        padding: EdgeInsets.symmetric(
          vertical: v,
          horizontal: h,
        ),
        child: this,
      );

  Padding paddingOnly(
          {Key? key,
          double left = 0.0,
          double right = 0.0,
          double top = 0.0,
          double bottom = 0.0}) =>
      Padding(
        key: key,
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: this,
      );
}
