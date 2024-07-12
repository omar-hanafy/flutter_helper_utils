import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

/// Extension on [Listenable] to integrate with [ListenableBuilder].
///
/// Provides a convenient method to create a [ListenableBuilder] that listens to the [Listenable].
/// This extension simplifies reacting to changes in the [Listenable] within the UI.
extension FHUListenableExtension on Listenable {
  /// Creates a [ListenableBuilder] widget that listens to this [Listenable].
  ///
  /// The [builder] function is called whenever this [Listenable] changes, allowing the UI to react to these changes.
  ///
  /// Example:
  /// ```dart
  /// final myNotifier = ValueNotifier<int>(0);
  /// myNotifier.builder(
  ///   (context) => Text('Value is ${myNotifier.value}'),
  /// );
  /// // The Text widget will update whenever [myNotifier] changes.
  /// ```
  Widget builder(Widget Function(BuildContext context) builder) {
    return ListenableBuilder(
      listenable: this,
      builder: (context, child) => builder(context),
    );
  }
}

/// Extension on a list of [Listenable] objects to integrate with [ListenablesBuilder].
///
/// Facilitates the creation of a [ListenablesBuilder] widget that listens to multiple [Listenable] instances.
/// Ideal for scenarios where the UI needs to respond to changes in multiple listenable sources.
extension FHUListenablesExtension on List<Listenable?> {
  /// Creates a [ListenablesBuilder] widget that listens to this list of [Listenable] objects.
  ///
  /// The [builder] function is called whenever any of the [Listenable] objects in this list change,
  /// allowing the UI to react to these changes. Optional parameters [buildWhen] and [threshold]
  /// can be used to control when the builder is called.
  ///
  /// Example:
  /// ```dart
  /// final textController = TextEditingController();
  /// final scrollController = ScrollController();
  /// final myNotifier = ValueNotifier<int>(0);
  /// final myListeners = <Listenable>[textController, scrollController, myNotifier];
  /// myListeners.builder(
  ///   (context) => Text('Value is ${myNotifier.value}'),
  /// );
  /// // The Text widget will update whenever any of myListeners change.
  /// ```
  Widget builder(
    Widget Function(BuildContext context) builder, {
    bool Function()? buildWhen,
    Duration? threshold,
  }) {
    return ListenablesBuilder(
      listenables: this,
      buildWhen: buildWhen,
      threshold: threshold,
      builder: builder,
    );
  }
}

/// Extension on [ValueListenable] to seamlessly create a [ValueListenableBuilder] widget.
///
/// Simplifies the instantiation of [ValueListenableBuilder], allowing for direct UI updates in response to [ValueListenable] changes.
/// Enhances code readability and efficiency by reducing boilerplate.
extension FHUValueListenableExtension<T> on ValueListenable<T> {
  /// Creates a [ValueListenableBuilder] widget that listens to this [ValueListenable].
  ///
  /// The [builder] function is called with the current value of the [ValueListenable] whenever it changes,
  /// allowing the UI to react to these changes.
  ///
  /// Example:
  /// ```dart
  /// final myNotifier = ValueNotifier<int>(0);
  /// myNotifier.builder(
  ///   (value) => Text('Value is $value'),
  /// );
  /// // The Text widget will update whenever [myNotifier] changes.
  /// ```
  Widget builder(
    Widget Function(T value) builder, {
    Key? key,
  }) {
    return ValueListenableBuilder(
      valueListenable: this,
      key: key,
      builder: (_, value, __) => builder(value),
    );
  }
}
