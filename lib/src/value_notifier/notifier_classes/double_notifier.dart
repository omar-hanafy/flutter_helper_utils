import 'package:flutter/foundation.dart';

/// allows to quickly create a ValueNotifier of type double.
class DoubleNotifier extends ValueNotifier<double> {
  DoubleNotifier(super.initial);

  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (_) {}
  }

  void refresh() => notifyListeners();

  /// similar to value setter but this one force trigger the notifyListeners()
  /// event if newValue == value.
  void update(double newValue) {
    value = newValue;
    refresh();
  }
}

/// DoubleValueNotifierExtension
///
/// Extension on `ValueNotifier<double>` to enable direct manipulation of double values.
/// This extension provides convenient methods for handling double precision floating-point
/// numbers within a ValueNotifier. It simplifies arithmetic and other operations on double
/// values, such as rounding, scaling, or clamping, without the need to explicitly access the
/// `.value` property.
///
/// Ideal for scenarios where reactive double values need to be manipulated frequently and
/// with precision, this extension ensures more readable and concise code.
///
/// Example:
/// ```dart
/// final doubleValueNotifier = 10.5.notifier;
/// doubleValueNotifier.increment(2.5); // Directly adds 2.5 to the value (now 13.0)
/// doubleValueNotifier.round(); // Directly rounds the value (now 13.0)
/// // These operations modify the double value within the ValueNotifier without accessing `.value`
/// ```
extension FHUDoubleValueNotifierExtension on ValueListenable<double> {
  /// The remainder of the truncating division of `this` by [other].
  double remainder(num other) => value.remainder(other);

  /// Adds [other] to this number.
  double operator +(num other) => value + other;

  /// Subtracts [other] from this number.
  double operator -(num other) => value - other;

  /// Multiplies this number by [other].
  double operator *(num other) => value * other;

  /// Euclidean modulo of this number by [other].
  double operator %(num other) => value % other;

  /// Divides this number by [other].
  double operator /(num other) => value / other;

  /// Truncating division operator.
  int operator ~/(num other) => value ~/ other;

  /// The negation of this value.
  double operator -() => -value;

  /// The absolute value of this number.
  double abs() => value.abs();

  /// The sign of the double's numerical value.
  ///
  /// Returns -1.0 if the value is less than zero,
  /// +1.0 if the value is greater than zero,
  /// and the value itself if it is -0.0, 0.0 or NaN.
  double get sign => value.sign;

  /// Returns the integer closest to this number.
  ///
  /// Rounds away from zero when there is no closest integer:
  ///  `(3.5).round() == 4` and `(-3.5).round() == -4`.
  ///
  /// Throws an [UnsupportedError] if this number is not finite
  /// (NaN or an infinity).
  /// ```dart
  /// print(3.0.round()); // 3
  /// print(3.25.round()); // 3
  /// print(3.5.round()); // 4
  /// print(3.75.round()); // 4
  /// print((-3.5).round()); // -4
  /// ```
  int round() => value.round();

  /// Returns the greatest integer no greater than this number.
  ///
  /// Rounds the number towards negative infinity.
  ///
  /// Throws an [UnsupportedError] if this number is not finite
  /// (NaN or infinity).
  /// ```dart
  /// print(1.99999.floor()); // 1
  /// print(2.0.floor()); // 2
  /// print(2.99999.floor()); // 2
  /// print((-1.99999).floor()); // -2
  /// print((-2.0).floor()); // -2
  /// print((-2.00001).floor()); // -3
  /// ```
  int floor() => value.floor();

  /// Returns the least integer that is not smaller than this number.
  ///
  /// Rounds the number towards infinity.
  ///
  /// Throws an [UnsupportedError] if this number is not finite
  /// (NaN or an infinity).
  /// ```dart
  /// print(1.99999.ceil()); // 2
  /// print(2.0.ceil()); // 2
  /// print(2.00001.ceil()); // 3
  /// print((-1.99999).ceil()); // -1
  /// print((-2.0).ceil()); // -2
  /// print((-2.00001).ceil()); // -2
  /// ```
  int ceil() => value.ceil();

  /// Returns the integer obtained by discarding any fractional
  /// part of this number.
  ///
  /// Rounds the number towards zero.
  ///
  /// Throws an [UnsupportedError] if this number is not finite
  /// (NaN or an infinity).
  /// ```dart
  /// print(2.00001.truncate()); // 2
  /// print(1.99999.truncate()); // 1
  /// print(0.5.truncate()); // 0
  /// print((-0.5).truncate()); // 0
  /// print((-1.5).truncate()); // -1
  /// print((-2.5).truncate()); // -2
  /// ```
  int truncate() => value.truncate();

  /// Returns the integer double value closest to `this`.
  ///
  /// Rounds away from zero when there is no closest integer:
  ///  `(3.5).roundToDouble() == 4` and `(-3.5).roundToDouble() == -4`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is not
  /// a finite value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`,
  /// and `-0.0` is therefore considered closer to negative numbers than `0.0`.
  /// This means that for a value `d` in the range `-0.5 < d < 0.0`,
  /// the result is `-0.0`.
  /// ```dart
  /// print(3.0.roundToDouble()); // 3.0
  /// print(3.25.roundToDouble()); // 3.0
  /// print(3.5.roundToDouble()); // 4.0
  /// print(3.75.roundToDouble()); // 4.0
  /// print((-3.5).roundToDouble()); // -4.0
  /// ```
  double roundToDouble() => value.roundToDouble();

  /// Returns the greatest integer double value no greater than `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is not
  /// a finite value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `0.0 < d < 1.0` will return `0.0`.
  /// ```dart
  /// print(1.99999.floorToDouble()); // 1.0
  /// print(2.0.floorToDouble()); // 2.0
  /// print(2.99999.floorToDouble()); // 2.0
  /// print((-1.99999).floorToDouble()); // -2.0
  /// print((-2.0).floorToDouble()); // -2.0
  /// print((-2.00001).floorToDouble()); // -3.0
  /// ```
  double floorToDouble() => value.floorToDouble();

  /// Returns the least integer double value no smaller than `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is not
  /// a finite value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `-1.0 < d < 0.0` will return `-0.0`.
  /// ```dart
  /// print(1.99999.ceilToDouble()); // 2.0
  /// print(2.0.ceilToDouble()); // 2.0
  /// print(2.00001.ceilToDouble()); // 3.0
  /// print((-1.99999).ceilToDouble()); // -1.0
  /// print((-2.0).ceilToDouble()); // -2.0
  /// print((-2.00001).ceilToDouble()); // -2.0
  /// ```
  double ceilToDouble() => value.ceilToDouble();

  /// Returns the integer double value obtained by discarding any fractional
  /// digits from `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is not
  /// a finite value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `-1.0 < d < 0.0` will return `-0.0`, and
  /// in the range `0.0 < d < 1.0` it will return 0.0.
  /// ```dart
  /// print(2.5.truncateToDouble()); // 2.0
  /// print(2.00001.truncateToDouble()); // 2.0
  /// print(1.99999.truncateToDouble()); // 1.0
  /// print(0.5.truncateToDouble()); // 0.0
  /// print((-0.5).truncateToDouble()); // -0.0
  /// print((-1.5).truncateToDouble()); // -1.0
  /// print((-2.5).truncateToDouble()); // -2.0
  /// ```
  double truncateToDouble() => value.truncateToDouble();
}
