import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Extension on [ValueListenable] to seamlessly create a [ValueListenableBuilder] widget.
///
/// Simplifies the instantiation of [ValueListenableBuilder], allowing for direct UI updates in response to [ValueListenable] changes.
/// Enhances code readability and efficiency by reducing boilerplate.
extension FHUValueListenableExtension<T> on ValueListenable<T> {
  /// [listenableBuilder]
  /// This method simplifies the creation of [ValueListenableBuilder]
  Widget listenableBuilder(
    Widget Function(T v) builder, {
    Key? key,
  }) {
    return ValueListenableBuilder(
      valueListenable: this,
      key: key,
      builder: (_, v, __) => builder(v),
    );
  }
}
