import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

const mobileBreakPoint = Breakpoint.mobile();
const tabletBreakPoint = Breakpoint.tablet();
const desktopBreakPoint = Breakpoint.desktop();

/// Base class for defining breakpoints.
class Breakpoint {
  /// Creates an instance of [Breakpoint].
  const Breakpoint({required this.size, required this.name});

  /// Creates a mobile breakpoint.
  const Breakpoint.mobile({
    this.size = const Size(600, 800),
    this.name = 'mobile',
  });

  /// Creates a tablet breakpoint.
  const Breakpoint.tablet({
    this.size = const Size(1200, 1600),
    this.name = 'tablet',
  });

  /// Creates a desktop breakpoint.
  const Breakpoint.desktop({
    this.size = const Size(1800, 2400),
    this.name = 'desktop',
  });

  final Size size;
  final String name;

  bool get isMobile => name.toLowerCase() == 'mobile';

  bool get isTablet => name.toLowerCase() == 'tablet';

  bool get isDesktop => name.toLowerCase() == 'desktop';

  bool match(String name) => this.name.toLowerCase() == name.toLowerCase();

  Breakpoint copyWith({
    required String name,
    double? height,
    double? width,
  }) {
    return Breakpoint(
      size: Size(width ?? size.width, height ?? size.height),
      name: name,
    );
  }

  static Breakpoint of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<_PlatformTypeInherited>();
    if (result == null) {
      throw FlutterError(
        'Breakpoint.of() called with a context that does not contain a PlatformTypeProvider.',
      );
    }
    return result.breakpoint;
  }

  static const List<Breakpoint> defaults = [
    mobileBreakPoint,
    tabletBreakPoint,
    desktopBreakPoint,
  ];

  @override
  String toString() => name;
}

/// Provides information about the current platform size and orientation.
class PlatformSizeInfo {
  /// Creates an instance of [PlatformSizeInfo].
  PlatformSizeInfo({
    required this.platform,
    required this.breakpoint,
    required this.orientation,
  });

  final Breakpoint breakpoint;
  final Orientation orientation;
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
class PlatformTypeProvider extends StatefulWidget {
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

  @override
  State<PlatformTypeProvider> createState() => _PlatformTypeProviderState();
}

class _PlatformTypeProviderState extends State<PlatformTypeProvider> {
  late Breakpoint _currentBreakpoint;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updatePlatformType();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updatePlatformType();
  }

  void _updatePlatformType() {
    setState(() {
      _currentBreakpoint = getPlatformType(context.sizePx, widget.breakpoints);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _PlatformTypeInherited(
      breakpoint: _currentBreakpoint,
      child: widget.child,
    );
  }
}

Breakpoint getPlatformType(Size size, List<Breakpoint> breakpoints) {
  for (final breakpoint in breakpoints) {
    if ((size.width <= breakpoint.size.width &&
            size.height <=
                breakpoint
                    .size.height) || // Handles landscape or square screens
        (size.height <= breakpoint.size.width &&
            size.width <= breakpoint.size.height)) {
      // Handles portrait screens
      return breakpoint;
    }
  }
  return breakpoints.last; // Fallback to the last breakpoint if no match
}

/// Extension methods on [BuildContext] for easy access to [Breakpoint] and [Orientation].
extension FHUBuildContextPlatformExtension on BuildContext {
  /// Gets the current [Breakpoint] for the given [BuildContext].
  /// Throws a [FlutterError] if no [PlatformTypeProvider] is found in the widget tree.
  Breakpoint get breakpoint => Breakpoint.of(this);

  /// Gets the current [PlatformSizeInfo] for the given [BuildContext].
  PlatformSizeInfo get platformSizeInfo => PlatformSizeInfo(
        breakpoint: breakpoint,
        orientation: deviceOrientation,
        platform: targetPlatform,
      );
}

class PlatformInfoLayoutBuilder extends StatelessWidget {
  /// Creates an instance of [PlatformInfoLayoutBuilder].
  ///
  /// [builder] - A function that takes the [BuildContext] and [PlatformSizeInfo] to build the widget.
  /// [breakpoints] - Defines the breakpoints used for platform type detection.
  const PlatformInfoLayoutBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext, PlatformSizeInfo) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, context.platformSizeInfo);
  }
}

class BreakpointLayoutBuilder extends StatelessWidget {
  /// Creates an instance of [BreakpointLayoutBuilder].
  ///
  /// [builder] - A function that takes the [BuildContext] and [Breakpoint] to build the widget.
  const BreakpointLayoutBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext, Breakpoint) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, context.breakpoint);
  }
}
