import 'package:flutter/widgets.dart';

/// Helpers for working with [AsyncSnapshot] (typically from [FutureBuilder] and
/// [StreamBuilder]).
///
/// This extension focuses on:
/// - Correctness (including `Future<void>` and other `null` results).
/// - Explicit, predictable state handling.
extension FHUAsyncSnapshot<T> on AsyncSnapshot<T> {
  /// Returns [data] if it is non-null, otherwise [defaultValue].
  ///
  /// Note that [AsyncSnapshot.hasData] is only true when [data] is non-null.
  /// For example, `Future<void>` completes successfully with `null`, so it
  /// will have `connectionState == ConnectionState.done` but `hasData == false`.
  T dataOr(T defaultValue) => hasData ? data as T : defaultValue;

  /// Maps [data] using [transform] when [hasData] is true.
  ///
  /// Returns `null` when [hasData] is false.
  R? mapData<R>(R Function(T data) transform) =>
      hasData ? transform(data as T) : null;

  /// Returns true when the snapshot is waiting for completion and already has
  /// a non-null [data] value (from `initialData` or a previous computation).
  bool get isWaitingWithData =>
      connectionState == ConnectionState.waiting && hasData;

  /// Returns true when the snapshot has completed (active or done) without an
  /// error.
  ///
  /// This does not require [hasData]. See [dataOr] docs for why.
  bool get isSuccess =>
      !hasError &&
      (connectionState == ConnectionState.active ||
          connectionState == ConnectionState.done);

  /// Pattern matching helper over [connectionState] and [hasError].
  ///
  /// Error handling takes precedence over [connectionState]. This matches the
  /// SDK behavior where [AsyncSnapshot] can retain an error even when the
  /// connection state changes (for example, when a [StreamBuilder] disconnects).
  R when<R>({
    required R Function(T? data) none,
    required R Function(T? data) waiting,
    required R Function(T? data) active,
    required R Function(T? data) done,
    required R Function(
      Object error,
      StackTrace stackTrace,
      ConnectionState state,
    )
    error,
  }) {
    if (hasError) {
      return error(
        this.error!,
        stackTrace ?? StackTrace.empty,
        connectionState,
      );
    }

    final currentData = data;

    switch (connectionState) {
      case ConnectionState.none:
        return none(currentData);
      case ConnectionState.waiting:
        return waiting(currentData);
      case ConnectionState.active:
        return active(currentData);
      case ConnectionState.done:
        return done(currentData);
    }
  }

  /// Like [when], but each handler is optional and [orElse] is required.
  R maybeWhen<R>({
    required R Function() orElse,
    R Function(T? data)? none,
    R Function(T? data)? waiting,
    R Function(T? data)? active,
    R Function(T? data)? done,
    R Function(Object error, StackTrace stackTrace, ConnectionState state)?
    error,
  }) {
    if (hasError) {
      final onError = error;
      if (onError == null) return orElse();
      return onError(
        this.error!,
        stackTrace ?? StackTrace.empty,
        connectionState,
      );
    }

    final currentData = data;

    switch (connectionState) {
      case ConnectionState.none:
        return none?.call(currentData) ?? orElse();
      case ConnectionState.waiting:
        return waiting?.call(currentData) ?? orElse();
      case ConnectionState.active:
        return active?.call(currentData) ?? orElse();
      case ConnectionState.done:
        return done?.call(currentData) ?? orElse();
    }
  }
}
