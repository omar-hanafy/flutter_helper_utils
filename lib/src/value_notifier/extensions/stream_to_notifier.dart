import 'dart:developer';

import 'package:flutter/foundation.dart';

/// Extension on `Stream<T>` to convert any stream into a `ValueNotifier<T>`.
///
/// This extension provides a convenient way to bridge the reactive world of streams
/// with the `ValueNotifier` pattern used for state management in Flutter applications. By converting
/// a stream into a `ValueNotifier`, you can easily integrate asynchronous stream data into your
/// Flutter widgets with the reactive and efficient update mechanism that `ValueNotifier` provides.
extension FHUStreamToValueNotifier<T> on Stream<T> {
  /// Converts the current stream into a `ValueListenable<T>` which is effectively a `ValueNotifier<T>`.
  ///
  /// The conversion process involves listening to the stream and updating the `ValueNotifier`'s value
  /// each time the stream emits a new item. This allows Flutter widgets to reactively rebuild whenever
  /// the `ValueNotifier`'s value changes, based on the latest data emitted by the stream.
  ///
  /// Parameters:
  /// - `initialValue`: The initial value to be used for the `ValueNotifier` before any data is received from the stream.
  /// - `onDone`: An optional callback that gets called when the stream is done. The last value received
  ///   from the stream is passed to this callback.
  /// - `onError`: An optional error handler for stream errors. If not provided, a default error handler
  ///   that logs the error is used.
  ///
  /// Returns a `ValueListenable<T>` which is a `ValueNotifier<T>` that updates its value based on the stream's emissions.
  ValueListenable<T> toValueNotifier(
    T initialValue, {
    void Function(T)? onDone,
    void Function(Object, StackTrace)? onError,
  }) {
    final notifier = ValueNotifier<T>(initialValue);
    listen(
      (value) => notifier.value = value,
      onError: onError ?? _defaultOnError,
      onDone: () => onDone?.call(notifier.value),
    );
    return notifier;
  }

  /// Default error handler that logs any errors coming from the stream.
  ///
  /// This function is used as the error handler for the stream listener if no custom
  /// `onError` function is provided when calling `toValueNotifier`.
  ///
  /// Parameters:
  /// - `error`: The error object emitted by the stream.
  /// - `stackTrace`: The stack trace associated with the error.
  void _defaultOnError(Object error, StackTrace stackTrace) => log(
        'Error on stream $toString()',
        // Log the error with stream identification
        error: error,
        stackTrace: stackTrace,
      );
}
