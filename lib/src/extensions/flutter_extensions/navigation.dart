import 'package:flutter/material.dart';

/// Navigation extensions on [BuildContext] for Flutter Helper Utils.
///
/// **Naming convention:** Methods that wrap [MaterialPageRoute] use "Page"
/// (e.g. [pushPage], [pushReplacementPage]). Methods that accept a [Route]
/// object use "Route" (e.g. [pushRoute]). Named-route methods use
/// "NamedRoute" (e.g. [pushNamedRoute]). This avoids collisions with
/// go_router's extension methods on [BuildContext].
///
/// Note: Navigation helpers are exposed only on [BuildContext] to avoid
/// duplicated APIs on `State` and `StatelessWidget`.
extension FHUNavigatorExtension on BuildContext {
  // Navigator access.
  /// Returns the nearest [NavigatorState].
  ///
  /// Set [rootNavigator] to `true` to get the furthest ancestor navigator,
  /// useful for pushing above nested navigators (e.g. tab navigators).
  NavigatorState navigator({bool rootNavigator = false}) =>
      Navigator.of(this, rootNavigator: rootNavigator);

  /// Returns the nearest [NavigatorState], or `null` if none exists.
  NavigatorState? maybeNavigator({bool rootNavigator = false}) =>
      Navigator.maybeOf(this, rootNavigator: rootNavigator);

  // Route introspection.
  /// The [ModalRoute] enclosing this context, or `null`.
  ModalRoute<T>? modalRoute<T extends Object?>() => ModalRoute.of<T>(this);

  /// The [RouteSettings] of the enclosing [ModalRoute], or `null`.
  RouteSettings? get routeSettings => ModalRoute.of(this)?.settings;

  /// The enclosing route name, or `null`.
  String? get routeName => routeSettings?.name;

  /// Reads `ModalRoute.of(context)?.settings.arguments` and casts to [T].
  ///
  /// Returns `null` on type mismatch instead of throwing.
  @optionalTypeArgs
  T? maybeRouteArgs<T>() {
    final args = routeSettings?.arguments;
    return args is T ? args : null;
  }

  /// Reads `ModalRoute.of(context)?.settings.arguments` and casts to [T].
  ///
  /// Throws a [FlutterError] if the value is missing or has the wrong type.
  ///
  /// Prefer this when a route argument is required for correctness.
  @optionalTypeArgs
  T routeArgs<T>({String? debugLabel}) {
    final args = routeSettings?.arguments;
    if (args is T) return args;

    final labelSuffix = debugLabel == null ? '' : ' ($debugLabel)';
    throw FlutterError(
      'Expected route arguments of type <$T> for route "${routeName ?? 'unknown'}"$labelSuffix, '
      'but got ${args.runtimeType}: $args',
    );
  }

  /// Same as [routeArgs], but the name is explicit.
  @optionalTypeArgs
  T requireRouteArgs<T>({String? debugLabel}) =>
      routeArgs<T>(debugLabel: debugLabel);

  /// Returns `true` if the enclosing route has name equal to [name].
  bool isRouteNamed(String name) => routeName == name;

  /// Whether the enclosing route is the top-most active route.
  bool get isCurrentRoute => ModalRoute.of(this)?.isCurrent ?? false;

  /// Whether the enclosing route is the bottom-most active route.
  bool get isFirstRoute => ModalRoute.of(this)?.isFirst ?? false;

  /// Whether the enclosing route is on the navigator stack.
  bool get isActiveRoute => ModalRoute.of(this)?.isActive ?? false;

  // Can pop.
  /// `true` when [Navigator.pop] can remove the current route.
  ///
  /// Does **not** account for [PopScope] widgets that might block pops.
  bool get canPopPage => Navigator.canPop(this);

  /// `true` when the root [Navigator] can pop.
  ///
  /// Does **not** account for [PopScope] widgets that might block pops.
  bool get canPopRootPage =>
      maybeNavigator(rootNavigator: true)?.canPop() ?? false;

  // Pop helpers.
  /// Pops the current route, optionally returning [result].
  void popPage<T extends Object?>([T? result]) =>
      Navigator.pop<T>(this, result);

  /// Pops only if [canPopPage] is `true`.
  void tryPopPage<T extends Object?>([T? result]) {
    if (canPopPage) Navigator.pop<T>(this, result);
  }

  /// Pops via the root navigator - useful for dismissing dialogs or
  /// bottom sheets shown above nested navigators.
  void popRoot<T extends Object?>([T? result]) =>
      navigator(rootNavigator: true).pop<T>(result);

  /// Pops via the root navigator only if [canPopRootPage] is `true`.
  void tryPopRoot<T extends Object?>([T? result]) {
    final rootNav = maybeNavigator(rootNavigator: true);
    if (rootNav == null) return;
    if (!rootNav.canPop()) return;
    rootNav.pop<T>(result);
  }

  /// Delegates to [NavigatorState.maybePop]: consults the current route's
  /// [Route.popDisposition] before deciding whether to pop.
  Future<bool> maybePopPage<T extends Object?>([T? result]) =>
      navigator().maybePop<T>(result);

  /// Like [maybePopPage], but targets the root navigator.
  Future<bool> maybePopRootPage<T extends Object?>([T? result]) =>
      maybeNavigator(rootNavigator: true)?.maybePop<T>(result) ??
      Future<bool>.value(false);

  /// Pops routes until [predicate] returns `true`.
  void popUntilRoute(RoutePredicate predicate, {bool rootNavigator = false}) =>
      navigator(rootNavigator: rootNavigator).popUntil(predicate);

  /// Pops routes until a route named [routeName] is reached.
  void popUntilNamed(String routeName, {bool rootNavigator = false}) =>
      popUntilRoute(
        ModalRoute.withName(routeName),
        rootNavigator: rootNavigator,
      );

  /// Pops until only the first (root) route remains.
  void popToRoot({bool rootNavigator = false}) =>
      popUntilRoute((route) => route.isFirst, rootNavigator: rootNavigator);

  // Push helpers (MaterialPageRoute).
  /// Pushes a [MaterialPageRoute] displaying [screen].
  Future<T?> pushPage<T extends Object?>(
    Widget screen, {
    bool rootNavigator = false,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
  }) => navigator(rootNavigator: rootNavigator).push<T>(
    MaterialPageRoute<T>(
      builder: (_) => screen,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      allowSnapshotting: allowSnapshotting,
    ),
  );

  /// Pushes [screen] and replaces the current route.
  Future<T?> pushReplacementPage<T extends Object?, TO extends Object?>(
    Widget screen, {
    bool rootNavigator = false,
    TO? result,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
  }) => navigator(rootNavigator: rootNavigator).pushReplacement<T, TO>(
    MaterialPageRoute<T>(
      builder: (_) => screen,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      allowSnapshotting: allowSnapshotting,
    ),
    result: result,
  );

  /// Pushes [screen] and removes previous routes until [predicate] is `true`.
  Future<T?> pushPageAndRemoveUntil<T extends Object?>(
    Widget screen,
    RoutePredicate predicate, {
    bool rootNavigator = false,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
  }) => navigator(rootNavigator: rootNavigator).pushAndRemoveUntil<T>(
    MaterialPageRoute<T>(
      builder: (_) => screen,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      allowSnapshotting: allowSnapshotting,
    ),
    predicate,
  );

  /// Pushes [screen] and clears the entire stack below it.
  ///
  /// Equivalent to `pushPageAndRemoveUntil(screen, (_) => false)`.
  Future<T?> pushPageAndClearStack<T extends Object?>(
    Widget screen, {
    bool rootNavigator = false,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
  }) => pushPageAndRemoveUntil<T>(
    screen,
    (_) => false,
    rootNavigator: rootNavigator,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
    allowSnapshotting: allowSnapshotting,
  );

  // Push helpers (Route objects).
  /// Pushes a pre-built [Route].
  Future<T?> pushRoute<T extends Object?>(
    Route<T> route, {
    bool rootNavigator = false,
  }) => navigator(rootNavigator: rootNavigator).push<T>(route);

  /// Pushes [route] and replaces the current route.
  Future<T?> pushReplacementRoute<T extends Object?, TO extends Object?>(
    Route<T> route, {
    bool rootNavigator = false,
    TO? result,
  }) => navigator(
    rootNavigator: rootNavigator,
  ).pushReplacement<T, TO>(route, result: result);

  /// Pushes [route] and removes previous routes until [predicate] is `true`.
  Future<T?> pushRouteAndRemoveUntil<T extends Object?>(
    Route<T> route,
    RoutePredicate predicate, {
    bool rootNavigator = false,
  }) => navigator(
    rootNavigator: rootNavigator,
  ).pushAndRemoveUntil<T>(route, predicate);

  /// Pushes [route] and clears the entire stack below it.
  ///
  /// Equivalent to `pushRouteAndRemoveUntil(route, (_) => false)`.
  Future<T?> pushRouteAndClearStack<T extends Object?>(
    Route<T> route, {
    bool rootNavigator = false,
  }) => pushRouteAndRemoveUntil<T>(
    route,
    (_) => false,
    rootNavigator: rootNavigator,
  );

  // Push helpers (Named routes).
  /// Pushes a named route.
  Future<T?> pushNamedRoute<T extends Object?>(
    String routeName, {
    bool rootNavigator = false,
    Object? arguments,
  }) => navigator(
    rootNavigator: rootNavigator,
  ).pushNamed<T>(routeName, arguments: arguments);

  /// Pushes a named route and replaces the current route.
  Future<T?> pushReplacementNamedRoute<T extends Object?, TO extends Object?>(
    String routeName, {
    bool rootNavigator = false,
    TO? result,
    Object? arguments,
  }) => navigator(rootNavigator: rootNavigator).pushReplacementNamed<T, TO>(
    routeName,
    arguments: arguments,
    result: result,
  );

  /// Pops the current route, then pushes a named route.
  Future<T?> popAndPushNamedRoute<T extends Object?, TO extends Object?>(
    String routeName, {
    bool rootNavigator = false,
    TO? result,
    Object? arguments,
  }) => navigator(
    rootNavigator: rootNavigator,
  ).popAndPushNamed<T, TO>(routeName, arguments: arguments, result: result);

  /// Pushes a named route and removes previous routes until [predicate].
  Future<T?> pushNamedRouteAndRemoveUntil<T extends Object?>(
    String routeName,
    RoutePredicate predicate, {
    bool rootNavigator = false,
    Object? arguments,
  }) => navigator(
    rootNavigator: rootNavigator,
  ).pushNamedAndRemoveUntil<T>(routeName, predicate, arguments: arguments);

  /// Pushes a named route and clears the entire stack below it.
  ///
  /// Equivalent to `pushNamedRouteAndRemoveUntil(routeName, (_) => false)`.
  Future<T?> pushNamedRouteAndClearStack<T extends Object?>(
    String routeName, {
    bool rootNavigator = false,
    Object? arguments,
  }) => pushNamedRouteAndRemoveUntil<T>(
    routeName,
    (_) => false,
    rootNavigator: rootNavigator,
    arguments: arguments,
  );

  // Replace / remove.
  /// Replaces [oldRoute] with [newRoute] without animation.
  ///
  /// The old route must **not** be the current (top-most) route.
  /// Use [pushReplacementRoute] for that instead.
  ///
  /// Note: [oldRoute] must belong to the navigator selected by [rootNavigator].
  void replaceRoute<T extends Object?>({
    required Route<dynamic> oldRoute,
    required Route<T> newRoute,
    bool rootNavigator = false,
  }) => navigator(
    rootNavigator: rootNavigator,
  ).replace<T>(oldRoute: oldRoute, newRoute: newRoute);

  /// Replaces the route immediately below [anchorRoute] with [newRoute].
  ///
  /// Note: [anchorRoute] must belong to the navigator selected by
  /// [rootNavigator].
  void replaceRouteBelow<T extends Object?>({
    required Route<dynamic> anchorRoute,
    required Route<T> newRoute,
    bool rootNavigator = false,
  }) => navigator(
    rootNavigator: rootNavigator,
  ).replaceRouteBelow<T>(anchorRoute: anchorRoute, newRoute: newRoute);

  /// Immediately removes [route] from the navigator (no animation).
  ///
  /// Note: [route] must belong to the navigator selected by [rootNavigator].
  void removeRoute<T extends Object?>(
    Route<T> route, {
    bool rootNavigator = false,
    T? result,
  }) => navigator(rootNavigator: rootNavigator).removeRoute<T>(route, result);

  /// Immediately removes the route below [anchorRoute] (no animation).
  ///
  /// Note: [anchorRoute] must belong to the navigator selected by
  /// [rootNavigator].
  void removeRouteBelow<T extends Object?>(
    Route<T> anchorRoute, {
    bool rootNavigator = false,
    T? result,
  }) => navigator(
    rootNavigator: rootNavigator,
  ).removeRouteBelow<T>(anchorRoute, result);

  // Restorable navigation (Named routes).
  //
  // These wrap NavigatorState.restorable* methods. Routes pushed this way
  // are restored during state restoration. The returned opaque ID can be
  // used with [RestorableRouteFuture].

  /// Restorable version of [pushNamedRoute].
  String restorablePushNamedRoute<T extends Object?>(
    String routeName, {
    bool rootNavigator = false,
    Object? arguments,
  }) => navigator(
    rootNavigator: rootNavigator,
  ).restorablePushNamed<T>(routeName, arguments: arguments);

  /// Restorable version of [pushReplacementNamedRoute].
  String
  restorablePushReplacementNamedRoute<T extends Object?, TO extends Object?>(
    String routeName, {
    bool rootNavigator = false,
    TO? result,
    Object? arguments,
  }) => navigator(rootNavigator: rootNavigator)
      .restorablePushReplacementNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      );

  /// Restorable version of [popAndPushNamedRoute].
  String restorablePopAndPushNamedRoute<T extends Object?, TO extends Object?>(
    String routeName, {
    bool rootNavigator = false,
    TO? result,
    Object? arguments,
  }) =>
      navigator(rootNavigator: rootNavigator).restorablePopAndPushNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      );

  /// Restorable version of [pushNamedRouteAndRemoveUntil].
  String restorablePushNamedRouteAndRemoveUntil<T extends Object?>(
    String routeName,
    RoutePredicate predicate, {
    bool rootNavigator = false,
    Object? arguments,
  }) => navigator(rootNavigator: rootNavigator)
      .restorablePushNamedAndRemoveUntil<T>(
        routeName,
        predicate,
        arguments: arguments,
      );

  /// Restorable version of [pushNamedRouteAndClearStack].
  String restorablePushNamedRouteAndClearStack<T extends Object?>(
    String routeName, {
    bool rootNavigator = false,
    Object? arguments,
  }) => restorablePushNamedRouteAndRemoveUntil<T>(
    routeName,
    (_) => false,
    rootNavigator: rootNavigator,
    arguments: arguments,
  );

  // Restorable navigation (Route builders).
  //
  // IMPORTANT: [routeBuilder] must be a **static** function annotated with
  // `@pragma('vm:entry-point')` for restoration to work.

  /// Restorable push with a [RestorableRouteBuilder].
  String restorablePushRoute<T extends Object?>(
    RestorableRouteBuilder<T> routeBuilder, {
    bool rootNavigator = false,
    Object? arguments,
  }) => navigator(
    rootNavigator: rootNavigator,
  ).restorablePush<T>(routeBuilder, arguments: arguments);

  /// Restorable push-replacement with a [RestorableRouteBuilder].
  String restorablePushReplacementRoute<T extends Object?, TO extends Object?>(
    RestorableRouteBuilder<T> routeBuilder, {
    bool rootNavigator = false,
    TO? result,
    Object? arguments,
  }) =>
      navigator(rootNavigator: rootNavigator).restorablePushReplacement<T, TO>(
        routeBuilder,
        result: result,
        arguments: arguments,
      );

  /// Restorable push-and-remove-until with a [RestorableRouteBuilder].
  String restorablePushRouteAndRemoveUntil<T extends Object?>(
    RestorableRouteBuilder<T> routeBuilder,
    RoutePredicate predicate, {
    bool rootNavigator = false,
    Object? arguments,
  }) => navigator(rootNavigator: rootNavigator).restorablePushAndRemoveUntil<T>(
    routeBuilder,
    predicate,
    arguments: arguments,
  );

  /// Restorable version of push-and-clear-stack for route builders.
  String restorablePushRouteAndClearStack<T extends Object?>(
    RestorableRouteBuilder<T> routeBuilder, {
    bool rootNavigator = false,
    Object? arguments,
  }) => restorablePushRouteAndRemoveUntil<T>(
    routeBuilder,
    (_) => false,
    rootNavigator: rootNavigator,
    arguments: arguments,
  );

  /// Restorable replace with a [RestorableRouteBuilder].
  String restorableReplaceRoute<T extends Object?>({
    required Route<dynamic> oldRoute,
    required RestorableRouteBuilder<T> newRouteBuilder,
    bool rootNavigator = false,
    Object? arguments,
  }) => navigator(rootNavigator: rootNavigator).restorableReplace<T>(
    oldRoute: oldRoute,
    newRouteBuilder: newRouteBuilder,
    arguments: arguments,
  );

  /// Restorable replace-below with a [RestorableRouteBuilder].
  String restorableReplaceRouteBelow<T extends Object?>({
    required Route<dynamic> anchorRoute,
    required RestorableRouteBuilder<T> newRouteBuilder,
    bool rootNavigator = false,
    Object? arguments,
  }) => navigator(rootNavigator: rootNavigator).restorableReplaceRouteBelow<T>(
    anchorRoute: anchorRoute,
    newRouteBuilder: newRouteBuilder,
    arguments: arguments,
  );

  // Popup helpers.
  /// Dismisses all active popup routes (dialogs, menus, bottom sheets, etc.).
  ///
  /// Uses the root navigator by default to catch overlays above nested
  /// navigators. Pass `rootNavigator: false` to target only the nearest.
  void dismissAllPopups({bool rootNavigator = true}) {
    maybeNavigator(
      rootNavigator: rootNavigator,
    )?.popUntil((route) => route is! PopupRoute);
  }

  // Gesture status.
  /// Whether a user gesture is controlling the nearest navigator
  /// (e.g. iOS interactive back swipe).
  bool get isUserGestureInProgress =>
      maybeNavigator()?.userGestureInProgress ?? false;
}
