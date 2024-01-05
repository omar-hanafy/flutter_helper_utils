import 'dart:async';
import 'dart:math';

import 'package:flutter_helper_utils/src/exceptions/exceptions.dart';
import 'package:flutter_helper_utils/src/src.dart';

/* SUGGESTIONS
1. **Status Code Ranges:**
   - Methods to check for various HTTP status code ranges, such as informational responses, redirection messages, client errors, and server errors. For example, methods like `isInformational`, `isSuccess`, `isRedirection`, `isClientError`, and `isServerError`.

2. **Specific Status Checks:**
   - Methods for commonly checked status codes, such as `isBadRequest`, `isUnauthorized`, `isForbidden`, `isNotFound`, `isMethodNotAllowed`, `isNotAcceptable`, `isRequestTimeout`, `isConflict`, `isGone`, `isInternalServerError`, `isNotImplemented`, `isBadGateway`, `isServiceUnavailable`, and `isGatewayTimeout`.

3. **Category-Based Extensions:**
   - You could also categorize the status codes by their first digit and create properties like `is1xx`, `is2xx`, `is3xx`, `is4xx`, and `is5xx` for a quick range check.

4. **Custom Status Code Creators:**
   - Functions that allow users to create custom status codes that might not be part of the standard HTTP statuses, which can be useful for APIs that use custom codes.

5. **Retriable Status Check:**
   - A method like `isRetriable` that returns true for status codes where a retry might be appropriate, such as network-related errors or server errors (503 Service Unavailable, 504 Gateway Timeout).

6. **Redirection Helpers:**
   - Additional helpers for common redirection status codes, like `isPermanentRedirect` and `isTemporaryRedirect`.

7. **More Informative Enums:**
   - Expanding the `HttpResStatus` enum to include more descriptive fields for each status, such as a human-readable message or description. For example, `success` could have a description like "The request has succeeded."

8. **Conversion to Exception:**
   - A method that converts a non-successful status code to an appropriate exception, which can be thrown in the application to handle HTTP errors more effectively.

9. **Deprecation Notice:**
   - If your API or application plans to deprecate certain endpoints, a method to mark status codes as deprecated could also be helpful, prompting developers to take notice and potentially update their code.

10. **Retry-After Duration:**
    - If the number represents a `Retry-After` status, you could include a method to parse this and provide a `Duration` object, suggesting after how much time one should retry the request.
*/
// TODO(ANY): add more http helpers from response code.
extension HttpEx on num? {
  bool get isSuccessHttpResCode => this == 200 || this == 201;

  bool get isValidPhoneNumber => toString().isValidPhoneNumber;

  HttpResStatus? get toHttpResStatus =>
      HttpResStatus.values.firstWhereOrNull((s) => this == s.code);
}

extension NullSafeNumExtensions on num? {
  int? get tryToInt => this?.toInt();

  double? get tryToDouble => this?.toDouble();

  num percentage(num total, {bool allowDecimals = true}) {
    if (this != null) {
      final result = this! >= total ? 100 : max((this! / total) * 100, 0);
      if (allowDecimals) {
        return double.parse(result.toStringAsFixed(2));
      } else {
        return result.toInt();
      }
    }
    return 0;
  }

  bool get isNegative => isNotNull && this! > 0;

  bool get isPositive => isNotNull && this! > 0;

  bool get isZeroOrNull => isNull || this! == 0;

  /// Returns `true` if this integer is greater than *0*.
  bool get asBool => (this ?? 0) > 0;
}

extension NumExtensions on num {
  /// Returns if the number is positive
  bool get isPositive => this > 0;

  /// Returns if the number is negative
  bool get isNegative => this < 0;

  /// Returns if the number is zer0
  bool get isZero => this == 0;

  bool get isValidPhoneNumber => toString().isValidPhoneNumber;

  /// Returns number of digits in this number
  int get numberOfDigits => toString().length;

  String get removeTrailingZero =>
      toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');

  double get roundToFiftyOrHundred =>
      this + (50 - ((this % 50) > 0 ? this % 50 : 50));

  double get roundToTenth => (this / 10).ceil() * 10;

  /// Returns tenth of the number
  double get tenth => this / 10;

  /// Returns fourth of the number
  double get fourth => this / 4;

  /// Returns third of the number
  double get third => this / 3;

  /// Returns half of the number
  double get half => this / 2;

  /// Converts a number to a format that includes Greek symbols for thousands, millions, and beyond.
  ///
  /// Example usage:
  ///   print(1000.asGreeks); // Output: 1.0K
  ///   print(1500000.asGreeks); // Output: 1.5M
  ///   print(2500000000.asGreeks); // Output: 2.5B
  ///
  /// Here is a list of all symbols along with their corresponding names and values.
  /// k: Kilo, 10^3
  /// M: Mega, 10^6
  /// G: Giga, 10^9
  /// T: Tera, 10^12
  /// P: Peta, 10^15
  /// E: Exa, 10^18
  /// Z: Zetta, 10^21
  /// Y: Yotta, 10^24
  String get asGreeks {
    const greekSymbols = <String>['K', 'M', 'B', 'T', 'Q', 'P', 'E', 'Z', 'Y'];
    if (this < 1000) return toString();

    var magnitude = 0;
    var reducedNum = this;
    while (reducedNum >= 1000 && magnitude < greekSymbols.length) {
      reducedNum /= 1000;
      magnitude++;
    }

    final symbol = magnitude > 0 ? greekSymbols[magnitude - 1] : '';
    return '${reducedNum.toStringAsFixed(1)}$symbol';
  }

  /// Utility to delay some callback (or code execution).
  // TODO(Omar): Add a separated implementation of delay() with the ability to stop it.
  ///
  /// Sample:
  /// ```
  /// void main() async {
  ///   print('+ wait for 2 seconds');
  ///   await 2.delay();
  ///   print('- 2 seconds completed');
  ///   print('+ callback in 1.2sec');
  ///   1.delay(() => print('- 1.2sec callback called'));
  ///   print('currently running callback 1.2sec');
  /// }
  ///```
  Future<void> delay([FutureOr<dynamic> Function()? callback]) async =>
      Future.delayed(
        Duration(milliseconds: (this * 1000).round()),
        callback,
      );

  Future<void> get daysDelay => Future.delayed(asDays);

  Future<void> get hoursDelay => Future.delayed(asHours);

  Future<void> get minDelay => Future.delayed(asMinutes);

  Future<void> get secDelay => Future.delayed(asSeconds);

  Future<void> get millisecondsDelay => Future.delayed(asMilliseconds);

  /// Easy way to make Durations from numbers.
  ///
  /// Sample:
  /// ```
  /// print(1.seconds + 200.asMilliseconds);
  /// print(1.hours + 30.asMinutes);
  /// print(1.5.asHours);
  ///```
  Duration get asMilliseconds => Duration(microseconds: (this * 1000).round());

  Duration get asSeconds => Duration(milliseconds: (this * 1000).round());

  Duration get asMinutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  Duration get asHours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  Duration get asDays => Duration(hours: (this * Duration.hoursPerDay).round());

  /// Returns a sequence of integer, starting from [this],
  /// increments by [step] and ends at [end]
  Iterable<num> until(int end, {int step = 1}) sync* {
    if (step == 0) {
      // ignore: only_throw_errors
      throw RException.steps();
    }

    var currentNumber = this;

    if (step > 0) {
      while (currentNumber < end) {
        yield currentNumber;
        currentNumber += step;
      }
    } else {
      while (currentNumber > end) {
        yield currentNumber;
        currentNumber += step;
      }
    }
  }
}

extension IntExtensions on int {
  /// Return the min if this number is smaller then minimum
  /// Return the max if this number is bigger the the maximum
  /// Return this number if it's between the range
  int inRangeOf(int min, int max) {
    if (min.isNull || max.isNull) throw Exception('min or max cannot be null');
    if (min > max) throw ArgumentError('min must be smaller the max');

    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Returns the absolute value
  int get absolute => abs();

  /// Return this number time two
  int get doubled => this * 2;

  /// Return this number time three
  int get tripled => this * 3;

  /// Return this number time four
  int get quadrupled => this * 4;

  /// Return squared number
  int get squared => this * this;
}

extension DoubleExtensions on double {
  /// Return the min if this number is smaller then minimum
  /// Return the max if this number is bigger the the maximum
  /// Return this number if it's between the range
  double inRangeOf(double min, double max) {
    if (min.isNull || max.isNull) throw Exception('min or max cannot be null');
    if (min > max) throw ArgumentError('min must be smaller the max');

    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Returns the absolute value
  double get absolute => abs();

  /// Return this number time two
  double get doubled => this * 2;

  /// Return this number time three
  double get tripled => this * 3;

  /// Return this number time four
  double get quadrupled => this * 4;

  /// Return squared number
  double get squared => this * this;
}
