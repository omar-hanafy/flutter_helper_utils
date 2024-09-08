import 'package:flutter/material.dart';

/// A [GradientWidget] applies a gradient effect to its child widget
/// and offers extensive customization options for blending, alignment,
/// and opacity.
///
/// This widget uses a [ShaderMask] to overlay the provided [gradient] on top
/// of the [child] widget. Additionally, it provides options to control how the
/// gradient interacts with the child, including blend mode, gradient alignment,
/// child alignment, and opacity.
///
/// Example usage:
/// ```dart
/// GradientWidget(
///   gradient: LinearGradient(
///     colors: [Colors.blue, Colors.purple, Colors.pink],
///     begin: Alignment.topLeft,
///     end: Alignment.bottomRight,
///   ),
///   blendMode: BlendMode.srcIn,
///   opacity: 0.8,
///   child: Text(
///     'Gradient Text!',
///     style: TextStyle(fontSize: 40, color: Colors.white),
///   ),
/// )
/// ```
///
/// The gradient can be customized with any [Gradient], and the child can
/// be any widget, not limited to just text.
class GradientWidget extends StatelessWidget {
  /// Creates a [GradientWidget] with customizable gradient, blend mode, opacity,
  /// and alignments for both the gradient and the child.
  const GradientWidget({
    required this.child,
    required this.gradient,
    this.blendMode = BlendMode.srcIn,
    this.gradientAlignment = Alignment.topLeft,
    this.opacity = 1.0,
    this.childAlignment = Alignment.center,
    super.key,
  }) : assert(opacity >= 0.0 && opacity <= 1.0,
            'Opacity must be between 0.0 and 1.0');

  /// The widget that will have the gradient applied to it.
  final Widget child;

  /// The gradient to apply on the child widget.
  final Gradient gradient;

  /// The blend mode to determine how the gradient interacts with the
  /// child widget's existing colors. Defaults to [BlendMode.srcIn].
  final BlendMode blendMode;

  /// The alignment of the gradient relative to the child widget's bounds.
  /// This controls how the gradient is positioned. Defaults to [Alignment.topLeft].
  final Alignment gradientAlignment;

  /// The opacity of the gradient, ranging from 0.0 (fully transparent)
  /// to 1.0 (fully opaque). Defaults to 1.0.
  final double opacity;

  /// The alignment of the child within the widget. Useful if the child does not
  /// fill the entire available space. Defaults to [Alignment.center].
  final Alignment childAlignment;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: ShaderMask(
        blendMode: blendMode,
        shaderCallback: (bounds) => gradient.createShader(
          _calculateGradientRect(bounds, gradientAlignment),
        ),
        child: Align(
          alignment: childAlignment,
          child: child,
        ),
      ),
    );
  }

  /// Calculates the [Rect] to determine the positioning of the gradient
  /// based on the provided [Alignment].
  Rect _calculateGradientRect(Rect bounds, Alignment alignment) {
    final x = alignment.x * (bounds.width / 2) + (bounds.width / 2);
    final y = alignment.y * (bounds.height / 2) + (bounds.height / 2);
    return Rect.fromLTWH(x, y, bounds.width, bounds.height);
  }
}
