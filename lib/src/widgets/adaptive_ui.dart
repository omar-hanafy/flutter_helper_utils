import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

/// Default mobile breakpoint constant used throughout the package.
const mobileBreakPoint = Breakpoint.mobile();

/// Default tablet breakpoint constant used throughout the package.
const tabletBreakPoint = Breakpoint.tablet();

/// Default desktop breakpoint constant used throughout the package.
const desktopBreakPoint = Breakpoint.desktop();

/// Base class for defining breakpoints.
///
/// A breakpoint represents a specific screen size that can be used to
/// implement responsive design in a Flutter application. This class
/// provides various helpers for comparing breakpoints, checking orientation,
/// and working with responsive layouts.
@immutable
class Breakpoint {
  /// Creates an instance of [Breakpoint] with a specific width and name.
  const Breakpoint({required this.width, required this.name});

  /// Creates a mobile breakpoint with a default width of 600.
  const Breakpoint.mobile({this.width = 600, this.name = 'mobile'});

  /// Creates a tablet breakpoint with a default width of 1200.
  const Breakpoint.tablet({this.width = 1200, this.name = 'tablet'});

  /// Creates a desktop breakpoint with a default width of 1800.
  const Breakpoint.desktop({this.width = 1800, this.name = 'desktop'});

  /// The minimum width of the breakpoint.
  final double width;

  /// The name of the breakpoint.
  final String name;

  /// Returns true if the breakpoint is defined as mobile.
  bool get isMobile => name.toLowerCase() == 'mobile';

  /// Returns true if the breakpoint is defined as tablet.
  bool get isTablet => name.toLowerCase() == 'tablet';

  /// Returns true if the breakpoint is defined as desktop.
  bool get isDesktop => name.toLowerCase() == 'desktop';

  /// Returns true if the breakpoint matches the provided [name].
  bool match(String name) => this.name.toLowerCase() == name.toLowerCase();

  // Comparison and Range Helpers

  /// Returns true if this breakpoint is larger than the [other] breakpoint.
  bool isLargerThan(Breakpoint other) {
    return width > other.width;
  }

  /// Returns true if this breakpoint is larger than or equal to the [other] breakpoint.
  bool isLargerThanOrEqual(Breakpoint other) {
    return width >= other.width;
  }

  /// Returns true if this breakpoint is smaller than the [other] breakpoint.
  bool isSmallerThan(Breakpoint other) {
    return width < other.width;
  }

  /// Returns true if this breakpoint is smaller than or equal to the [other] breakpoint.
  bool isSmallerThanOrEqual(Breakpoint other) {
    return width <= other.width;
  }

  /// Returns true if this breakpoint is equal to the [other] breakpoint.
  bool isEqualTo(Breakpoint other) {
    return width == other.width;
  }

  /// Returns true if this breakpoint is not equal to the [other] breakpoint.
  bool isNotEqualTo(Breakpoint other) {
    return !isEqualTo(other);
  }

  /// Returns true if this breakpoint is between the [lower] and [upper] breakpoints.
  bool isBetween(Breakpoint lower, Breakpoint upper) {
    return isLargerThanOrEqual(lower) && isSmallerThanOrEqual(upper);
  }

  // Logical Operators
  /// Compares this breakpoint with [other] to check if it is larger.
  bool operator >(Breakpoint other) => isLargerThan(other);

  /// Compares this breakpoint with [other] to check if it is larger or equal.
  bool operator >=(Breakpoint other) => isLargerThanOrEqual(other);

  /// Compares this breakpoint with [other] to check if it is smaller.
  bool operator <(Breakpoint other) => isSmallerThan(other);

  /// Compares this breakpoint with [other] to check if it is smaller or equal.
  bool operator <=(Breakpoint other) => isSmallerThanOrEqual(other);

  // Orientation Helpers

  /// Returns true if this breakpoint is the active one in the given [context].
  bool isActive(BuildContext context) => this == of(context);

  /// Creates a copy of this breakpoint with modified properties.
  ///
  /// You can provide a new [name] and/or [width] to create a new instance
  /// of [Breakpoint] with the updated values.
  Breakpoint copyWith({required String name, double? width}) {
    return Breakpoint(width: width ?? this.width, name: name);
  }

  /// Retrieves the active breakpoint from the context.
  ///
  /// If [listen] is `true` (the default), the widget calling this method will
  /// rebuild whenever the breakpoint changes.
  ///
  /// If [listen] is `false`, the breakpoint is retrieved without establishing a
  /// dependency, preventing unnecessary rebuilds.
  ///
  /// Throws a [FlutterError] if the context does not contain a `PlatformTypeProvider`.
  static Breakpoint of(BuildContext context, {bool listen = true}) {
    if (listen) {
      final result = context
          .dependOnInheritedWidgetOfExactType<_PlatformTypeInherited>();
      if (result == null) {
        throw FlutterError(
          'Breakpoint.of() called with a context that does not contain a PlatformTypeProvider.',
        );
      }
      return result.breakpoint;
    } else {
      final inheritedElement = context
          .getElementForInheritedWidgetOfExactType<_PlatformTypeInherited>();
      final result = inheritedElement?.widget as _PlatformTypeInherited?;
      if (result == null) {
        throw FlutterError(
          'Breakpoint.of() called with a context that does not contain a PlatformTypeProvider.',
        );
      }
      return result.breakpoint;
    }
  }

  // String Representation
  /// Returns a human-readable string representation of this breakpoint.
  /// e.g. "mobile: 600".
  String toPrettyString() => '$name: $width';

  /// Default breakpoint set used by [PlatformTypeProvider].
  static const List<Breakpoint> defaults = [
    mobileBreakPoint,
    tabletBreakPoint,
    desktopBreakPoint,
  ];

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Breakpoint) return false;
    return width == other.width && name == other.name;
  }

  @override
  int get hashCode => width.hashCode ^ name.hashCode;
}

/// Provides information about the current platform size and orientation.
class PlatformSizeInfo {
  /// Creates an instance of [PlatformSizeInfo].
  PlatformSizeInfo({
    required this.platform,
    required this.breakpoint,
    required this.orientation,
  });

  /// Active breakpoint selected for the current width.
  final Breakpoint breakpoint;

  /// Current device orientation from the surrounding layout context.
  final Orientation orientation;

  /// Target platform reported by Flutter for the current app.
  final TargetPlatform platform;
}

/// An inherited widget that holds the current [Breakpoint] for its descendants.
class _PlatformTypeInherited extends InheritedWidget {
  /// Creates an instance of [_PlatformTypeInherited].
  const _PlatformTypeInherited({
    required this.breakpoint,
    required super.child,
  });

  /// The current breakpoint.
  final Breakpoint breakpoint;

  @override
  bool updateShouldNotify(_PlatformTypeInherited oldWidget) =>
      breakpoint != oldWidget.breakpoint;
}

/// A widget that provides the current [Breakpoint] and [Orientation] to its descendants.
/// Wrap this around the root of your application to make platform and orientation information
/// available throughout the widget tree.
///
/// Example usage:
/// ```dart
/// runApp(PlatformTypeProvider(
///     breakpoints: Breakpoint.defaults,
///     child: MyApp(),
/// ));
/// ```
class PlatformTypeProvider extends StatelessWidget {
  /// Creates an instance of [PlatformTypeProvider].
  ///
  /// [child] - The widget below this widget in the tree.
  /// [breakpoints] - Defines the breakpoints used for platform type detection.
  const PlatformTypeProvider({
    required this.child,
    this.breakpoints = Breakpoint.defaults,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Defines the breakpoints used for platform type detection.
  final List<Breakpoint> breakpoints;

  List<Breakpoint> get _sortedBreakpoints =>
      [...breakpoints]..sort((a, b) => a.width.compareTo(b.width));

  @override
  Widget build(BuildContext context) {
    final sortedBreakpoints = _sortedBreakpoints;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = _resolveAvailableSize(context, constraints);
        return _PlatformTypeInherited(
          breakpoint: getBreakpoint(size, sortedBreakpoints),
          child: child,
        );
      },
    );
  }
}

Size _resolveAvailableSize(BuildContext context, BoxConstraints constraints) {
  final maxWidth = constraints.maxWidth;
  final maxHeight = constraints.maxHeight;
  if (maxWidth.isFinite &&
      maxHeight.isFinite &&
      maxWidth > 0 &&
      maxHeight > 0) {
    return Size(maxWidth, maxHeight);
  }

  final mediaQuerySize = MediaQuery.maybeSizeOf(context);
  if (mediaQuerySize != null &&
      mediaQuerySize.width > 0 &&
      mediaQuerySize.height > 0) {
    return mediaQuerySize;
  }

  final FlutterView? view = View.maybeOf(context);
  if (view != null &&
      view.physicalSize.width > 0 &&
      view.physicalSize.height > 0) {
    return view.physicalSize / view.devicePixelRatio;
  }

  return Size.zero;
}

/// Returns the first breakpoint whose width is greater than or equal to [size].
///
/// If [size] exceeds every configured width, the last breakpoint is returned.
Breakpoint getBreakpoint(Size size, List<Breakpoint> breakpoints) {
  for (final breakpoint in breakpoints) {
    if (size.width <= breakpoint.width) {
      return breakpoint;
    }
  }
  return breakpoints.last;
}

/// Extension methods on [BuildContext] for easy access to [Breakpoint] and [Orientation].
extension FHUBuildContextPlatformExtension on BuildContext {
  /// Gets the current [Breakpoint] for the given [BuildContext] and establishes
  /// a dependency, causing the widget to rebuild whenever the breakpoint changes.
  ///
  /// Throws a [FlutterError] if no [PlatformTypeProvider] is found in the widget tree.
  Breakpoint get watchBreakpoint => Breakpoint.of(this);

  /// Gets the current [Breakpoint] for the given [BuildContext] without
  /// establishing a dependency, preventing unnecessary rebuilds.
  ///
  /// Throws a [FlutterError] if no [PlatformTypeProvider] is found in the widget tree.
  Breakpoint get readBreakpoint => Breakpoint.of(this, listen: false);

  /// Gets the current [PlatformSizeInfo] for the given [BuildContext].
  PlatformSizeInfo get platformSizeInfo => PlatformSizeInfo(
    breakpoint: watchBreakpoint,
    orientation: deviceOrientation,
    platform: PlatformEnv.targetPlatform,
  );
}

/// Builds with the current [PlatformSizeInfo] from the nearest provider.
class PlatformInfoLayoutBuilder extends StatelessWidget {
  /// Creates an instance of [PlatformInfoLayoutBuilder].
  ///
  /// [builder] - A function that takes the [BuildContext] and [PlatformSizeInfo] to build the widget.
  /// [breakpoints] - Defines the breakpoints used for platform type detection.
  const PlatformInfoLayoutBuilder({required this.builder, super.key});

  /// Builds a widget from the current [PlatformSizeInfo].
  final Widget Function(BuildContext, PlatformSizeInfo) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, context.platformSizeInfo);
  }
}

/// Builds with the active [Breakpoint] from the nearest provider.
class BreakpointLayoutBuilder extends StatelessWidget {
  /// Creates an instance of [BreakpointLayoutBuilder].
  ///
  /// [builder] - A function that takes the [BuildContext] and [Breakpoint] to build the widget.
  const BreakpointLayoutBuilder({required this.builder, super.key});

  /// Builds a widget from the current [Breakpoint].
  final Widget Function(BuildContext, Breakpoint) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, context.watchBreakpoint);
  }
}
