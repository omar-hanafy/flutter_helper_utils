import 'package:flutter/material.dart';

/// create a [ValueNotifier] of type [Duration], which reacts just like normal [Duration],
/// but with notifier capabilities.
class DurationNotifier extends ValueNotifier<Duration> implements Duration {
  DurationNotifier(super.initial);

  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (_) {}
  }

  void refresh() => notifyListeners();

  /// similar to value setter but this one force trigger the notifyListeners()
  /// event if newValue == value.
  void update(Duration newValue) {
    value = newValue;
    refresh();
  }

  /// documentation available in the original overridden method.
  @override
  Duration operator *(num factor) => value * factor;

  /// documentation available in the original overridden method.
  @override
  Duration operator +(Duration other) => value + other;

  /// documentation available in the original overridden method.
  @override
  Duration operator -() => -value;

  /// documentation available in the original overridden method.
  @override
  Duration operator -(Duration other) => value - other;

  /// documentation available in the original overridden method.
  @override
  bool operator <(Duration other) => value < other;

  /// documentation available in the original overridden method.
  @override
  bool operator <=(Duration other) => value <= other;

  /// documentation available in the original overridden method.
  @override
  bool operator >(Duration other) => value > other;

  /// documentation available in the original overridden method.
  @override
  bool operator >=(Duration other) => value >= other;

  /// documentation available in the original overridden method.
  @override
  Duration operator ~/(int quotient) => value ~/ quotient;

  /// documentation available in the original overridden method.
  @override
  Duration abs() => value.abs();

  /// documentation available in the original overridden method.
  @override
  int compareTo(Duration other) => value.compareTo(other);

  /// documentation available in the original overridden method.
  @override
  int get inDays => value.inDays;

  /// documentation available in the original overridden method.
  @override
  int get inHours => value.inHours;

  /// documentation available in the original overridden method.
  @override
  int get inMicroseconds => value.inMicroseconds;

  /// documentation available in the original overridden method.
  @override
  int get inMilliseconds => value.inMilliseconds;

  /// documentation available in the original overridden method.
  @override
  int get inMinutes => value.inMinutes;

  /// documentation available in the original overridden method.
  @override
  int get inSeconds => value.inSeconds;

  /// documentation available in the original overridden method.
  @override
  bool get isNegative => value.isNegative;
}
