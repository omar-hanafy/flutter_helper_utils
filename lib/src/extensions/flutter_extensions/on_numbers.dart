import 'package:flutter/material.dart';

/// UI convenience extensions for Flutter.
///
/// Note: v9 intentionally reduces `num` extension surface area to avoid
/// suggestion clutter. Prefer Flutter SDK constructors when in doubt.
extension FHUNumExtensions on num {
  /// Returns `EdgeInsetsGeometry` with this value applied to all sides.
  EdgeInsetsGeometry get edgeInsetsAll => EdgeInsetsGeometry.all(toDouble());

  /// Returns `EdgeInsetsGeometry` with this value applied horizontally (left & right).
  EdgeInsetsGeometry get edgeInsetsHorizontal =>
      EdgeInsetsGeometry.symmetric(horizontal: toDouble());

  /// Returns `EdgeInsetsGeometry` with this value applied vertically (top & bottom).
  EdgeInsetsGeometry get edgeInsetsVertical =>
      EdgeInsetsGeometry.symmetric(vertical: toDouble());

  /// Returns `EdgeInsetsGeometry` with only the top padding set to this value.
  EdgeInsetsGeometry get edgeInsetsTop =>
      EdgeInsetsGeometry.only(top: toDouble());

  /// Returns `EdgeInsetsGeometry` with only the bottom padding set to this value.
  EdgeInsetsGeometry get edgeInsetsBottom =>
      EdgeInsetsGeometry.only(bottom: toDouble());

  /// Returns `EdgeInsetsGeometry` with only the left padding set to this value.
  EdgeInsetsGeometry get edgeInsetsLeft =>
      EdgeInsetsGeometry.only(left: toDouble());

  /// Returns `EdgeInsetsGeometry` with only the right padding set to this value.
  EdgeInsetsGeometry get edgeInsetsRight =>
      EdgeInsetsGeometry.only(right: toDouble());

  /// Returns `EdgeInsetsGeometry` with only the logical start padding set.
  ///
  /// This uses [EdgeInsetsDirectional] so it adapts to LTR and RTL layouts.
  EdgeInsetsGeometry get edgeInsetsStart =>
      EdgeInsetsDirectional.only(start: toDouble());

  /// Returns `EdgeInsetsGeometry` with only the logical end padding set.
  ///
  /// This uses [EdgeInsetsDirectional] so it adapts to LTR and RTL layouts.
  EdgeInsetsGeometry get edgeInsetsEnd =>
      EdgeInsetsDirectional.only(end: toDouble());

  /// Returns a `SizedBox` with the given width and optional child.
  SizedBox widthBox({Widget? child}) =>
      SizedBox(width: toDouble(), child: child);

  /// Returns a `SizedBox` with the given height and optional child.
  SizedBox heightBox({Widget? child}) =>
      SizedBox(height: toDouble(), child: child);

  /// Returns a square `SizedBox` with the given dimensions and optional child.
  SizedBox squareBox({Widget? child}) =>
      SizedBox.square(dimension: toDouble(), child: child);

  /// Creates a `BorderRadius` with the same radius for all corners.
  BorderRadius get allCircular => BorderRadius.circular(toDouble());

  /// Creates a `Radius` with a circular shape.
  Radius get circular => Radius.circular(toDouble());
}

/// Convenience helpers for transforming a [Size] into common UI values.
extension FHUSizeExtensions on Size {
  /// Creates a `SizedBox` with this `Size` as width and height.
  SizedBox toSizedBox({Widget? child}) =>
      SizedBox.fromSize(size: this, child: child);

  /// Returns a scaled version of the original `Size`.
  Size scaled(double factor) => Size(width * factor, height * factor);

  /// Calculates and returns the aspect ratio (width/height) of the `Size`.
  double aspectRatio() => width / height;

  /// Returns a new `Size` with the specified width.
  Size withWidth(double newWidth) => Size(newWidth, height);

  /// Returns a new `Size` with the specified height.
  Size withHeight(double newHeight) => Size(width, newHeight);

  /// Swaps the width and height values, effectively rotating the `Size` by 90 degrees.
  Size transpose() => Size(height, width);

  /// Checks if both width and height are zero.
  bool get isEmpty => width == 0 && height == 0;

  /// Returns the maximum of the width and height.
  double get maxDimension => width > height ? width : height;

  /// Returns the minimum of the width and height.
  double get minDimension => width < height ? width : height;
}
