import 'package:flutter/material.dart';

extension FHUNavigationStateExtensions on State {
  /// Navigate to another widget
  Future<T?> navigateTo<T>({required Route<T> route}) =>
      Navigator.push(context, route);

  /// Navigate to another widget and replace remove the current one
  Future<T?> navigatePushReplacement<T>({required Route<T> route}) =>
      Navigator.pushReplacement(context, route);

  /// Navigate to widget by the route name
  Future<T?> navigateByRouteName<T>(String routeName, {Object? args}) =>
      Navigator.pushNamed(context, routeName, arguments: args);
}

extension FHUNavigationStatelessExtensions on StatelessWidget {
  /// Navigate to another widget
  Future<T?> navigateTo<T>({
    required BuildContext context,
    required Route<T> route,
  }) =>
      Navigator.push(context, route);

  /// Navigate to another widget and replace remove the current one
  Future<T?> navigatePushReplacement<T>({
    required BuildContext context,
    required Route<T> route,
  }) =>
      Navigator.pushReplacement(context, route);

  /// Navigate to widget by the route name
  Future<T?> navigateByRouteName<T>({
    required BuildContext context,
    required String routeName,
    Object? args,
  }) =>
      Navigator.pushNamed(context, routeName, arguments: args);
}

extension FHUNavigatorExtension on BuildContext {
  NavigatorState navigator({bool rootNavigator = false}) =>
      Navigator.of(this, rootNavigator: rootNavigator);

  ModalRoute<T>? modalRoute<T extends Object?>() => ModalRoute.of<T>(this);

  void popPage<T extends Object?>([T? result]) =>
      Navigator.pop<T>(this, result);

  /// This method allows for popping dialogs by calling
  /// the pop method with the rootNavigator parameter set to true.
  /// This feature proves to be useful in scenarios where dialogs need to be dismissed.
  void popRoot<T extends Object?>([T? result]) =>
      navigator(rootNavigator: true).pop<T>(result);

  /// Just call this [canPop()] method and it would return true if this route can be popped and false if it’s not possible.
  bool get canPop => Navigator.canPop(this);

  /// Performs a simple [Navigator.push] action with given [route]
  Future<T?> pushPage<T extends Object?>(
    Widget screen, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
  }) async =>
      navigator().push<T>(
        MaterialPageRoute(
          builder: (_) => screen,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          allowSnapshotting: allowSnapshotting,
        ),
      );

  /// Performs a simple [Navigator.pushReplacement] action with given [route]
  Future<T?> pReplacement<T extends Object?, TO extends Object?>(
    Widget screen, {
    bool allowSnapshotting = true,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) async =>
      navigator().pushReplacement<T, TO>(
        MaterialPageRoute(
          allowSnapshotting: allowSnapshotting,
          builder: (_) => screen,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        ),
      );

  /// Perform push and remove route
  Future<T?> pAndRemoveUntil<T extends Object?>(
    Widget screen, {
    bool allowSnapshotting = true,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool routes = false,
  }) async =>
      navigator().pushAndRemoveUntil<T>(
        MaterialPageRoute(
          allowSnapshotting: allowSnapshotting,
          builder: (_) => screen,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        ),
        (Route<dynamic> route) => routes,
      );

  /// Perform push and remove route with routeName
  Future<T?> pNamedAndRemoveUntil<T extends Object?>(
    String screenName,
    RoutePredicate predicate, {
    bool allowSnapshotting = true,
    Object? arguments,
  }) async =>
      navigator().pushNamedAndRemoveUntil<T>(
        screenName,
        predicate,
        arguments: arguments,
      );

  /// Perform push with routeName
  Future<T?> pNamed<T extends Object?>(
    String screenName, {
    Object? arguments,
  }) async =>
      navigator().pushNamed<T>(screenName, arguments: arguments);

  /// Perform replace with routeName
  Future<T?> pReplacementNamed<T extends Object?, TO extends Object?>(
    String screenName, {
    Object? arguments,
    TO? result,
  }) =>
      navigator().pushReplacementNamed<T, TO>(
        screenName,
        arguments: arguments,
        result: result,
      );

  /// Perform pop until a specific route name
  void popUntil(String screenName) =>
      navigator().popUntil(ModalRoute.withName(screenName));

  /// This method calls [Navigator.maybePop] to attempt to pop the current route if possible.
  /// It is useful when you want to handle back navigation and check if the route can be popped
  /// without causing any errors.
  Future<void> maybePop<T extends Object?>([T? result]) async =>
      navigator().maybePop<T>(result);

  /// Recursively dismisses active pop-up elements within the app.

  /// This method automatically closes pop-up elements such as dialogs, modal bottom sheets,
  /// and Cupertino modal popups. It does this by programmatically navigating back in the
  /// widget tree until no pop-up routes remain.

  /// The following types of routes are considered pop-ups:
  ///  * `PopupRoute`
  ///  * `DialogRoute`
  ///  * `RawDialogRoute`
  ///  * `ModalBottomSheetRoute`
  ///  * `CupertinoModalPopupRoute`

  /// **Parameters:**
  ///  * `usePopUntil` (Optional, default: `true`):
  ///    - If `true`, the `Navigator.popUntil` method is used, which efficiently dismisses
  ///      all pop-ups in a single operation.
  ///    - If `false`, the `Navigator.pop` method is used recursively, closing one pop-up at a time.
  ///      This might be necessary in scenarios where `popUntil` is not supported or causes unexpected behavior.

  /// **Usage:**

  /// ```dart
  ///  // Dismiss all active pop-ups using the most efficient method available.
  ///  dismissActivePopup();
  ///
  ///  // Dismiss pop-ups one by one (might be needed for compatibility reasons).
  ///  dismissActivePopup(usePopUntil: false);
  /// ```
  void dismissActivePopup({bool usePopUntil = true}) {
    try {
      final navigator = this.navigator(rootNavigator: true);
      if (usePopUntil) {
        return navigator.popUntil((route) => route is! PopupRoute);
      }
      if (modalRoute() is PopupRoute && navigator.canPop()) {
        navigator.pop();
        dismissActivePopup(usePopUntil: usePopUntil);
      }
    } catch (_) {}
  }
}
