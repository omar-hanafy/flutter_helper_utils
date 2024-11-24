import 'dart:async';

import 'package:flutter/material.dart';

/// Extension on [Future<T>] that provides useful utilities and shortcuts for productivity.
extension FHUFuture<T> on Future<T> {
  /// Builds a [FutureBuilder] widget for this [Future].
  ///
  /// The [builder] function defines how the UI should update based on the [AsyncSnapshot<T>].
  /// [initialData] is the initial data used to create the snapshot before the [Future] completes.
  Widget builder(
    AsyncWidgetBuilder<T> builder, {
    T? initialData,
  }) =>
      FutureBuilder<T>(
        future: this,
        builder: builder,
        initialData: initialData,
      );

  /// Transforms the result of the [Future] using the provided [transformer] function.
  ///
  /// Returns a new [Future<R>] of the transformed result.
  Future<R> map<R>(R Function(T value) transformer) {
    return then((value) => transformer(value));
  }

  /// Builds a widget based on the snapshot state of this [Future] using provided callbacks.
  ///
  /// - [onSuccess] is called when the [Future] completes successfully with data.
  /// - [onError] is called if the [Future] completes with an error.
  /// - [onLoading] is displayed while the [Future] is in progress.
  Widget buildWidget({
    required Widget Function(BuildContext context, T data) onSuccess,
    required Widget Function(BuildContext context, Object? error) onError,
    Widget Function(BuildContext context)? onLoading,
  }) {
    return builder(
      (context, snapshot) => snapshot.buildWidget(
          onSuccess: (data) => onSuccess.call(context, data),
          onError: (error) => onError.call(context, error),
          onLoading: onLoading == null ? null : () => onLoading.call(context)),
    );
  }
}

/// Extension on [ConnectionState] providing utility properties for checking the connection state.
extension FHUConnectionState on ConnectionState {
  /// Returns true if the connection state is [ConnectionState.none].
  bool get isNone => this == ConnectionState.none;

  /// Returns true if the connection state is [ConnectionState.waiting].
  bool get isWaiting => this == ConnectionState.waiting;

  /// Returns true if the connection state is [ConnectionState.active].
  bool get isActive => this == ConnectionState.active;

  /// Returns true if the connection state is [ConnectionState.done].
  bool get isDone => this == ConnectionState.done;
}

/// Extension on [AsyncSnapshot<T>] that provides convenient utilities for checking snapshot states.
extension FHUAsyncSnapshot<T> on AsyncSnapshot<T> {
  /// Returns true if the snapshot has no connection state.
  bool get isNone => connectionState.isNone;

  /// Returns true if the snapshot is currently waiting for data.
  bool get isWaiting => connectionState.isWaiting;

  /// Returns true if the snapshot is active (data is actively streaming).
  bool get isActive => connectionState.isActive;

  /// Returns true if the snapshot is done receiving data.
  bool get isDone => connectionState.isDone;

  /// Returns true if the snapshot has completed successfully with data, either active or done.
  bool get isSuccess => hasData && (isDone || isActive);

  /// Returns true if the snapshot has an error and is done receiving data.
  bool get hasErrorAndDone => hasError && isDone;

  /// Returns true if the snapshot is either waiting or active.
  bool get isWaitingOrActive => isWaiting || isActive;

  /// Provides access to data with a default value if data is not available.
  ///
  /// - [defaultValue] is returned if the snapshot does not contain data.
  T dataOr(T defaultValue) => hasData ? data! : defaultValue;

  /// Transforms the snapshot's data if available using the provided [transform] function.
  ///
  /// Returns a transformed result of type [R] if data is available, or null otherwise.
  R? mapData<R>(R Function(T data) transform) {
    return hasData ? transform(data as T) : null;
  }

  /// Handles different snapshot states and returns a result based on the current state.
  ///
  /// - [none]: Called if the snapshot has no connection.
  /// - [waiting]: Called while the snapshot is waiting for data.
  /// - [active]: Called when the snapshot is active with data.
  /// - [done]: Called when the snapshot is done and has data.
  /// - [error]: Called if the snapshot has encountered an error.
  /// - [orElse]: Optional fallback for unhandled states.
  R dataWhen<R>({
    required R Function() none,
    required R Function() waiting,
    required R Function(T data) active,
    required R Function(T data) done,
    required R Function(Object error) error,
    R Function()? orElse,
  }) {
    if (hasError) return error(this.error!);

    if (isSuccess) {
      if (isActive) return active(data as T);
      if (isDone) return done(data as T);
    }

    if (isWaiting) return waiting();
    if (isNone) return none();
    if (orElse != null) return orElse();

    return none();
  }

  /// Builds a widget based on the snapshot state using provided callbacks.
  ///
  /// - [onSuccess]: Called when the snapshot has data, in either active or done state.
  /// - [onError]: Called if the snapshot has an error.
  /// - [onLoading]: Optional, displayed while waiting for data; defaults to a [CircularProgressIndicator] if not provided.
  Widget buildWidget({
    required Widget Function(T data) onSuccess,
    required Widget Function(Object? error) onError,
    Widget Function()? onLoading,
  }) {
    if (hasError) return onError(error);
    if (hasData && (isActive || isDone)) onSuccess.call(data as T);
    return onLoading?.call() ??
        const Center(child: CircularProgressIndicator());
  }
}
