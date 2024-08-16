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

extension PaddingExtensions on num {
  /// Returns a `Padding` widget with this value applied to all sides.
  Widget paddingAll({required Widget child}) => Padding(
        padding: EdgeInsets.all(toDouble()),
        child: child,
      );

  /// Returns a `Padding` widget with this value applied horizontally (left & right).
  Widget paddingHorizontal({required Widget child}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: toDouble()),
        child: child,
      );

  /// Returns a `Padding` widget with this value applied vertically (top & bottom).
  Widget paddingVertical({required Widget child}) => Padding(
        padding: EdgeInsets.symmetric(vertical: toDouble()),
        child: child,
      );

  /// Returns a `Padding` widget with only the top padding set to this value.
  Widget paddingTop({required Widget child}) => Padding(
        padding: EdgeInsets.only(top: toDouble()),
        child: child,
      );

  /// Returns a `Padding` widget with only the bottom padding set to this value.
  Widget paddingBottom({required Widget child}) => Padding(
        padding: EdgeInsets.only(bottom: toDouble()),
        child: child,
      );

  /// Returns a `Padding` widget with only the left padding set to this value.
  Widget paddingLeft({required Widget child}) => Padding(
        padding: EdgeInsets.only(left: toDouble()),
        child: child,
      );

  /// Returns a `Padding` widget with only the right padding set to this value.
  Widget paddingRight({required Widget child}) => Padding(
        padding: EdgeInsets.only(right: toDouble()),
        child: child,
      );

  /// Returns `EdgeInsets` with this value applied to all sides.
  EdgeInsets get edgeInsetsAll => EdgeInsets.all(toDouble());

  /// Returns `EdgeInsets` with this value applied horizontally (left & right).
  EdgeInsets get edgeInsetsHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  /// Returns `EdgeInsets` with this value applied vertically (top & bottom).
  EdgeInsets get edgeInsetsVertical =>
      EdgeInsets.symmetric(vertical: toDouble());

  /// Returns `EdgeInsets` with only the top padding set to this value.
  EdgeInsets get edgeInsetsTop => EdgeInsets.only(top: toDouble());

  /// Returns `EdgeInsets` with only the bottom padding set to this value.
  EdgeInsets get edgeInsetsBottom => EdgeInsets.only(bottom: toDouble());

  /// Returns `EdgeInsets` with only the left padding set to this value.
  EdgeInsets get edgeInsetsLeft => EdgeInsets.only(left: toDouble());

  /// Returns `EdgeInsets` with only the right padding set to this value.
  EdgeInsets get edgeInsetsRight => EdgeInsets.only(right: toDouble());

  /// Returns a `SizedBox` with the given width and optional child.
  SizedBox widthBox({Widget? child}) =>
      SizedBox(width: toDouble(), child: child);

  /// Returns a `SizedBox` with the given height and optional child.
  SizedBox heightBox({Widget? child}) =>
      SizedBox(height: toDouble(), child: child);

  /// Returns a square `SizedBox` with the given dimensions and optional child.
  SizedBox squareBox({Widget? child}) =>
      SizedBox.square(dimension: toDouble(), child: child);

  /// Returns a `Size` object from the given value.
  Size get size => Size.square(toDouble());
}

extension SizeExtensions on Size {
  /// Creates a `SizedBox` with this `Size` as width and height.
  SizedBox toSizedBox({Widget? child}) => SizedBox.fromSize(
        size: this,
        child: child,
      );

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

  /// Creates a `Padding` widget with this `Size` as the padding amount.
  Padding toPadding() => Padding(
        padding: EdgeInsets.fromLTRB(width, height, width, height),
      );

  /// Creates an `AspectRatio` widget with the same aspect ratio as this `Size`.
  AspectRatio toAspectRatio() => AspectRatio(
        aspectRatio: aspectRatio(),
      );

  /// Checks if both width and height are zero.
  bool get isEmpty => width == 0 && height == 0;

  /// Compares this `Size` with another to check if it is larger based on the area.
  bool isLargerThan(Size other) => width * height > other.width * other.height;

  /// Compares this `Size` with another to check if it is smaller based on the area.
  bool isSmallerThan(Size other) => width * height < other.width * other.height;

  /// Scales the width and height independently.
  Size scaleIndependently(double widthFactor, double heightFactor) =>
      Size(width * widthFactor, height * heightFactor);

  /// Clamps the size to ensure it does not exceed specified min and max dimensions.
  Size clamp(Size minSize, Size maxSize) => Size(
        width.clamp(minSize.width, maxSize.width),
        height.clamp(minSize.height, maxSize.height),
      );

  /// Expands the size by adding specific values to the width and height.
  Size expand(double addWidth, double addHeight) => Size(
        width + addWidth,
        height + addHeight,
      );

  /// Reduces the size by subtracting specific values from the width and height.
  Size reduce(double subtractWidth, double subtractHeight) => Size(
        width - subtractWidth,
        height - subtractHeight,
      );

  /// Returns the maximum of the width and height.
  double get maxDimension => width > height ? width : height;

  /// Returns the minimum of the width and height.
  double get minDimension => width < height ? width : height;

  /// Checks if the size is equal to another size.
  bool isEqualTo(Size other) => width == other.width && height == other.height;

  /// Returns a new `Size` with width and height increased by a specific factor.
  Size increaseBy(double factor) => Size(width + factor, height + factor);

  /// Returns a new `Size` with width and height decreased by a specific factor.
  Size decreaseBy(double factor) => Size(width - factor, height - factor);

  /// Returns a new `Size` that fits within the specified constraints while preserving aspect ratio.
  Size fitWithin(Size constraints) {
    final aspectRatio = width / height;
    var newWidth = constraints.width;
    var newHeight = constraints.height;
    if (newWidth / aspectRatio <= newHeight) {
      newHeight = newWidth / aspectRatio;
    } else {
      newWidth = newHeight * aspectRatio;
    }
    return Size(newWidth, newHeight);
  }
}
