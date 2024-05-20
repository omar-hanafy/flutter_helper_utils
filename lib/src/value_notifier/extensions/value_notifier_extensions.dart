import 'dart:async';

import 'package:flutter/foundation.dart';

extension FHUValueNotifierExtensions<T> on ValueNotifier<T> {
  /// Equivalent to the getter [value] but in shorter syntax.
  T get v => value;

  set v(T newValue) => value = newValue;
}

extension FHUValueListenableExtensions<T> on ValueListenable<T> {
  /// Registers a callback to be invoked whenever the `ValueNotifier`'s value changes.
  VoidCallback onChange(void Function(T value) action) {
    void listener() => action(value);
    addListener(listener);
    return () => removeListener(listener);
  }

  /// Registers a debounced callback which is invoked only after the notifier's value
  /// is stable for the specified [duration].
  VoidCallback debounce(Duration duration, void Function(T value) action) {
    Timer? debounceTimer;

    void listener() {
      debounceTimer?.cancel();
      debounceTimer = Timer(duration, () => action(value));
    }

    addListener(listener);

    return () => {
          debounceTimer?.cancel(),
          removeListener(listener),
        };
  }

  /// Converts the [ValueNotifier] into a [Stream]. This stream emits values whenever the
  /// [value] changes. The use of [distinct] ensures that consecutive duplicate values are
  /// filtered out, thus the stream only emits when the value actually changes.
  Stream<T> get stream =>
      Stream.periodic(Duration.zero, (_) => value).distinct();
}
