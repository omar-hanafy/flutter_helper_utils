import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NavigationStateExtensions on State {
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

extension NavigationStatelessExtensions on StatelessWidget {
  /// Navigate to another widget
  Future<T?> navigateTo<T>(
          {required BuildContext context, required Route<T> route}) =>
      Navigator.push(context, route);

  /// Navigate to another widget and replace remove the current one
  Future<T?> navigatePushReplacement<T>(
          {required BuildContext context, required Route<T> route}) =>
      Navigator.pushReplacement(context, route);

  /// Navigate to widget by the route name
  Future<T?> navigateByRouteName<T>(
          {required BuildContext context,
          required String routeName,
          Object? args}) =>
      Navigator.pushNamed(context, routeName, arguments: args);
}

extension NavigatorExtension on BuildContext {
  void popPage<T extends Object?>([T? result]) =>
      Navigator.pop<T>(this, result);

  /// This method allows for popping dialogs by calling
  /// the pop method with the rootNavigator parameter set to true.
  /// This feature proves to be useful in scenarios where dialogs need to be dismissed.
  void popRoot<T extends Object?>([T? result]) =>
      navigator(rootNavigator: true).pop<T>(result);

  NavigatorState navigator({bool rootNavigator = false}) =>
      Navigator.of(this, rootNavigator: rootNavigator);

  ///  just call this [canPop()] method and it would return true if this route can be popped and false if it’s not possible.
  bool get canPop => Navigator.canPop(this);

  /// performs a simple [Navigator.push] action with given [route]
  Future<T?> pushPage<T extends Object?>(
    Widget screen, {
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
  }) async =>
      Navigator.of(this).push<T>(
        MaterialPageRoute(
          builder: (_) => screen,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          allowSnapshotting: allowSnapshotting,
        ),
      );

  /// performs a simple [Navigator.pushReplacement] action with given [route]
  Future<T?> pReplacement<T extends Object?, TO extends Object?>(
    Widget screen, {
    bool allowSnapshotting = true,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) async =>
      Navigator.of(this).pushReplacement<T, TO>(
        MaterialPageRoute(
          allowSnapshotting: allowSnapshotting,
          builder: (_) => screen,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        ),
      );

  /// perform push and remove route
  Future<T?> pAndRemoveUntil<T extends Object?>(
    Widget screen, {
    bool allowSnapshotting = true,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool routes = false,
  }) async =>
      Navigator.of(this).pushAndRemoveUntil<T>(
          MaterialPageRoute(
            allowSnapshotting: allowSnapshotting,
            builder: (_) => screen,
            settings: settings,
            maintainState: maintainState,
            fullscreenDialog: fullscreenDialog,
          ),
          (Route<dynamic> route) => routes);

  /// perform push and remove route with routeName
  Future<T?> pNamedAndRemoveUntil<T extends Object?>(
    String screenName,
    RoutePredicate predicate, {
    bool allowSnapshotting = true,
    Object? arguments,
  }) async =>
      Navigator.of(this).pushNamedAndRemoveUntil<T>(
        screenName,
        (route) => false,
        arguments: arguments,
      );

  /// perform push with routeName
  Future<T?> pNamed<T extends Object?>(
    String screenName, {
    Object? arguments,
  }) async =>
      Navigator.of(this).pushNamed<T>(screenName, arguments: arguments);

  /// perform replace with routeName
  Future<T?> pReplacementNamed<T extends Object?, TO extends Object?>(
    String screenName, {
    Object? arguments,
    TO? result,
  }) =>
      Navigator.of(this).pushReplacementNamed<T, TO>(
        screenName,
        arguments: arguments,
        result: result,
      );

  /// perform replace with routeName
  void popUntil(String screenName) =>
      Navigator.of(this).popUntil(ModalRoute.withName(screenName));

  /// This method programmatically and recursively dismisses any active pop-up elements like dialogs, modal bottom sheets,
  ///   and Cupertino modal popups.
  ///   It checks for the types [PopupRoute], [DialogRoute], [RawDialogRoute], [ModalBottomSheetRoute],
  ///   and [CupertinoModalPopupRoute] to determine if a pop-up is currently displayed and closes it.
  ///   If multiple pop-ups are stacked, the method will recursively close all of them.
  void dismissActivePopup() {
    try {
      // Get the current route
      final currentRoute = ModalRoute.of(this);
      // Check if the current route is a dialog, modal, etc...
      if ((currentRoute is PopupRoute ||
              currentRoute is DialogRoute ||
              currentRoute is RawDialogRoute ||
              currentRoute is ModalBottomSheetRoute ||
              currentRoute is CupertinoModalPopupRoute) &&
          Navigator.of(this).canPop()) {
        // Pop the current dialog, modal, etc...
        Navigator.pop(this);
        // Recursively call this function to pop any other dialogs or modal sheets
        dismissActivePopup();
      }
    } catch (_) {}
  }
}
