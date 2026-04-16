import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

/// A [GradientWidget] applies a gradient effect to its child widget
/// and offers customization options for blending, child alignment, and opacity.
///
/// This widget uses a [ShaderMask] to overlay the provided [gradient] on top
/// of the [child].
///
/// Use this when the child should keep its own layout while the visible pixels
/// are tinted or filled by a gradient. The shader is created from the final
/// paint bounds, so the gradient scales with the rendered size of the child.
///
/// The current [TextDirection] is forwarded to [Gradient.createShader], which
/// matters for directional gradients such as [LinearGradient] using
/// [AlignmentDirectional].
///
/// Example usage:
/// ```dart
/// GradientWidget(
///   gradient: LinearGradient(
///     colors: [Colors.blue, Colors.purple, Colors.pink],
///     begin: AlignmentDirectional.topStart,
///     end: AlignmentDirectional.bottomEnd,
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
  /// Creates a [GradientWidget] with customizable gradient, blend mode,
  /// opacity, and child alignment.
  const GradientWidget({
    required this.child,
    required this.gradient,
    this.blendMode = BlendMode.srcIn,
    this.opacity = 1.0,
    this.childAlignment = AlignmentDirectional.center,
    super.key,
  }) : assert(
         opacity >= 0.0 && opacity <= 1.0,
         'Opacity must be between 0.0 and 1.0',
       );

  /// The widget whose painted output is masked by [gradient].
  final Widget child;

  /// The gradient used to shade the child.
  ///
  /// Configure direction and distribution on the gradient itself, for example
  /// with `begin` and `end` on a [LinearGradient].
  final Gradient gradient;

  /// The blend mode to determine how the gradient interacts with the
  /// child widget's existing colors. Defaults to [BlendMode.srcIn].
  final BlendMode blendMode;

  /// The opacity of the gradient, ranging from 0.0 (fully transparent)
  /// to 1.0 (fully opaque). Defaults to 1.0.
  final double opacity;

  /// Positions [child] inside the widget before the shader is applied.
  ///
  /// This is most useful when the child does not naturally expand to the
  /// available space.
  final AlignmentGeometry childAlignment;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: ShaderMask(
        blendMode: blendMode,
        shaderCallback: (Rect bounds) => gradient.createShader(
          bounds,
          textDirection: context.directionality,
        ),
        child: Align(alignment: childAlignment, child: child),
      ),
    );
  }
}
