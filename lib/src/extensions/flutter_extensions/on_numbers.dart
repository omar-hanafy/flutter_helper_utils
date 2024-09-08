import 'package:flutter/material.dart';

/// various extension on numbers for flutter
extension FHUNumExtensions on num {
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

  /// Creates a `BorderRadius` with the same radius for all corners.
  BorderRadius get allCircular => BorderRadius.circular(toDouble());

  /// Creates a `Radius` with a circular shape.
  Radius get circular => Radius.circular(toDouble());

  /// Creates a `BorderRadius` with only the top-left and top-right corners rounded.
  BorderRadius get onlyTopRounded => BorderRadius.vertical(top: circular);

  /// Creates a `BorderRadius` with only the bottom-left and bottom-right corners rounded.
  BorderRadius get onlyBottomRounded => BorderRadius.vertical(bottom: circular);

  /// Creates a `BorderRadius` with only the bottom-left and top-right corners rounded.
  BorderRadius get diagonalBLTR => BorderRadius.only(
        bottomLeft: circular,
        topRight: circular,
      );

  /// Creates a `BorderRadius` with only the top-left and bottom-right corners rounded.
  BorderRadius get diagonalTLBR => BorderRadius.only(
        topLeft: circular,
        bottomRight: circular,
      );

  /// Creates a `BorderRadius` with only the top-left and bottom-left corners rounded.
  BorderRadius get onlyLeftRounded => BorderRadius.horizontal(left: circular);

  /// Creates a `BorderRadius` with only the top-right and bottom-right corners rounded.
  BorderRadius get onlyRightRounded => BorderRadius.horizontal(right: circular);

  /// Creates a `BorderRadius` with different radii for each corner.
  BorderRadius radiusLTRB(
    num topLeft,
    num topRight,
    num bottomRight,
    num bottomLeft,
  ) =>
      BorderRadius.only(
        topLeft: Radius.circular(topLeft.toDouble()),
        topRight: Radius.circular(topRight.toDouble()),
        bottomRight: Radius.circular(bottomRight.toDouble()),
        bottomLeft: Radius.circular(bottomLeft.toDouble()),
      );

  /// Creates a `BeveledRectangleBorder` with a circular shape for each corner.
  BeveledRectangleBorder get beveledRectangleBorderCircular =>
      BeveledRectangleBorder(borderRadius: allCircular);

  /// Creates a `RoundedRectangleBorder` with a circular shape for each corner.
  RoundedRectangleBorder get roundedRectangleBorderCircular =>
      RoundedRectangleBorder(borderRadius: allCircular);

  /// Creates a `ContinuousRectangleBorder` with a circular shape for each corner.
  ContinuousRectangleBorder get continuousRectangleBorderCircular =>
      ContinuousRectangleBorder(borderRadius: allCircular);

  /// Creates a `Border` with the given width and color.
  Border borderAll({required Color color}) => Border.all(
        width: toDouble(),
        color: color,
      );

  /// Creates a `Border` with the given width, color, and style.
  Border borderAllWithStyle(
          {required Color color, required BorderStyle style}) =>
      Border.all(
        width: toDouble(),
        color: color,
        style: style,
      );

  /// Creates a `Border` with only the top side having the given width and color.
  Border borderTop({required Color color}) => Border(
        top: BorderSide(width: toDouble(), color: color),
      );

  /// Creates a `Border` with only the bottom side having the given width and color.
  Border borderBottom({required Color color}) => Border(
        bottom: BorderSide(width: toDouble(), color: color),
      );

  /// Creates a `Border` with only the left side having the given width and color.
  Border borderLeft({required Color color}) => Border(
        left: BorderSide(width: toDouble(), color: color),
      );

  /// Creates a `Border` with only the right side having the given width and color.
  Border borderRight({required Color color}) => Border(
        right: BorderSide(width: toDouble(), color: color),
      );

  /// Creates a `Matrix4` for rotation around the Z-axis (in radians).
  Matrix4 get rotateZ => Matrix4.rotationZ(toDouble());

  /// Creates a `Matrix4` for rotation around the Y-axis (in radians).
  Matrix4 get rotateY => Matrix4.rotationY(toDouble());

  /// Creates a `Matrix4` for rotation around the X-axis (in radians).
  Matrix4 get rotateX => Matrix4.rotationX(toDouble());

  /// Creates a `Matrix4` for scaling uniformly in all directions.
  Matrix4 get scaleUniform =>
      Matrix4.diagonal3Values(toDouble(), toDouble(), 1);

  /// Creates a `Matrix4` for scaling in the X direction.
  Matrix4 get scaleX => Matrix4.diagonal3Values(toDouble(), 1, 1);

  /// Creates a `Matrix4` for scaling in the Y direction.
  Matrix4 get scaleY => Matrix4.diagonal3Values(1, toDouble(), 1);

  /// Creates a `Matrix4` for scaling in the Z direction.
  Matrix4 get scaleZ => Matrix4.diagonal3Values(1, 1, toDouble());

  /// Creates a `Matrix4` for translation along the X-axis.
  Matrix4 get translateX => Matrix4.translationValues(toDouble(), 0, 0);

  /// Creates a `Matrix4` for translation along the Y-axis.
  Matrix4 get translateY => Matrix4.translationValues(0, toDouble(), 0);

  /// Creates a `Matrix4` for translation along the Z-axis.
  Matrix4 get translateZ => Matrix4.translationValues(0, 0, toDouble());

  /// Creates a `Matrix4` for skewing along the X-axis by this value (in radians).
  Matrix4 get skewX => Matrix4.skewX(toDouble());

  /// Creates a `Matrix4` for skewing along the Y-axis by this value (in radians).
  Matrix4 get skewY => Matrix4.skewY(toDouble());

  /// Returns a `BoxConstraints` with this value as the minimum width and height.
  BoxConstraints get constraints => BoxConstraints(
        minWidth: toDouble(),
        minHeight: toDouble(),
      );

  /// Returns a `BoxConstraints` with this value as the maximum width and height.
  BoxConstraints get maxConstraints => BoxConstraints(
        maxWidth: toDouble(),
        maxHeight: toDouble(),
      );
}

extension FHUSizeExtensions on Size {
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
