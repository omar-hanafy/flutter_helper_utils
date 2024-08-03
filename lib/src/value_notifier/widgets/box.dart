import 'package:flutter/material.dart';

/// A simple square-shaped [SizedBox] with a specified dimension.
///
/// This widget is useful for creating consistent-sized containers for other
/// widgets or layouts. It's a convenient shorthand for creating a square SizedBox
/// without needing to specify both `width` and `height` separately.
class Box extends StatelessWidget {
  /// Creates a [Box] widget.
  ///
  /// The [dimension] parameter determines the width and height of the box.
  ///
  /// The [child] is the widget that will be contained within the box.
  /// If not provided, the box will be empty.
  const Box({
    required this.dimension,
    super.key,
    this.child,
  });

  /// The width and height of the box.
  final double dimension;

  /// The widget to be displayed inside the box.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dimension,
      height: dimension,
      child: child,
    );
  }
}
