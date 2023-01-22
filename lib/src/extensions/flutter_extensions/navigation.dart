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
