import 'dart:developer';

import 'package:flutter_helper_utils/src/exceptions/exceptions.dart';
import 'package:flutter_helper_utils/src/src.dart';

/// A utility class for converting objects to different types.
abstract class ConvertObject {
  /// Converts any object to a string if the object is not `null`.
  ///
  /// - Converts various object types to their string representation.
  /// - If the object is `null`, throws a [ParsingException] with a `nullObject` error.
  /// - If the conversion to string fails, throws a [ParsingException].
  ///
  /// [object] The object to be converted to a string.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a string if conversion is successful.
  /// Throws a [ParsingException] if the conversion fails or the object is `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 'Hello';
  /// final string1 = ConvertObject.toString1(object1); // 'Hello'
  ///
  /// final object2 = 10;
  /// final string2 = ConvertObject.toString1(object2); // '10'
  ///
  /// final object3 = true;
  /// final string3 = ConvertObject.toString1(object3); // 'true'
  ///
  /// final object4 = null;
  /// final string4 = ConvertObject.toString1(object4); // throws ParsingException
  /// ```
  static String toString1(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toString',
        stackTrace: StackTrace.current,
      );
    } else {
      if (object is String) return object;
      if (mapKey != null && object is Map<dynamic, dynamic>) {
        return object[mapKey].toString();
      }
      if (listIndex != null && object is List<dynamic>) {
        return toString1(object.of(listIndex));
      }
      try {
        return object.toString();
      } catch (e, s) {
        throw ParsingException(
          error: e,
          parsingInfo: 'toString',
          stackTrace: s,
        );
      }
    }
  }

  /// Converts any object to a string, or returns `null` if the object is `null`.
  ///
  /// - Converts various object types to their string representation.
  /// - If the conversion to string fails, logs an error and returns `null`.
  ///
  /// [object] The object to be converted to a string.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a string if conversion is successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 'Hello';
  /// final string1 = ConvertObject.tryToString(object1); // 'Hello'
  ///
  /// final object2 = 10;
  /// final string2 = ConvertObject.tryToString(object2); // '10'
  ///
  /// final object3 = true;
  /// final string3 = ConvertObject.tryToString(object3); // 'true'
  ///
  /// final object4 = null;
  /// final string4 = ConvertObject.tryToString(object4); // null
  /// ```
  static String? tryToString(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object is String?) return object;
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return object[mapKey].toString();
    }
    if (listIndex != null && object is List<dynamic>) {
      return tryToString(object.of(listIndex));
    }
    try {
      return object != null ? '$object' : null;
    } catch (e, s) {
      log(
        'tryToString() Unsupported object type: exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
  }

  /// Converts an object to a [num].
  ///
  /// - Converts numeric types and strings that represent valid numbers to [num].
  /// - If the object is `null`, throws a [ParsingException] with a `nullObject` error.
  /// - If the conversion to [num] fails, throws a [ParsingException].
  ///
  /// [object] The object to be converted to a [num].
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [num] if conversion is successful.
  /// Throws a [ParsingException] if the conversion fails or the object is `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 10;
  /// final num1 = ConvertObject.toNum(object1); // 10
  ///
  /// final object2 = '5.5';
  /// final num2 = ConvertObject.toNum(object2); // 5.5
  ///
  /// final object3 = true;
  /// final num3 = ConvertObject.toNum(object3); // 1
  ///
  /// final object4 = 'abc';
  /// final num4 = ConvertObject.toNum(object4); // throws ParsingException
  ///
  /// final object5 = null;
  /// final num5 = ConvertObject.toNum(object5); // throws ParsingException
  /// ```
  static num toNum(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toNum',
        stackTrace: StackTrace.current,
      );
    }
    if (object is num) return object;
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return toNum(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return toNum(object.of(listIndex));
    }
    try {
      return '$object'.toNum;
    } catch (e, s) {
      throw ParsingException(
        error: e,
        parsingInfo: 'toNum',
        stackTrace: s,
      );
    }
  }

  /// Attempts to convert an object to a [num], or returns `null` if the object is `null` or conversion fails.
  ///
  /// - Converts numeric types and strings that represent valid numbers to [num].
  /// - If the conversion to [num] fails (e.g., non-numeric string), logs an error and returns `null`.
  ///
  /// [object] The object to be converted to a [num].
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [num] if conversion is successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 10;
  /// final num1 = ConvertObject.tryToNum(object1); // 10
  ///
  /// final object2 = '5.5';
  /// final num2 = ConvertObject.tryToNum(object2); // 5.5
  ///
  /// final object3 = true;
  /// final num3 = ConvertObject.tryToNum(object3); // 1
  ///
  /// final object4 = 'abc';
  /// final num4 = ConvertObject.tryToNum(object4); // null
  ///
  /// final object5 = null;
  /// final num5 = ConvertObject.tryToNum(object5); // null
  /// ```
  static num? tryToNum(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object is num?) return object;

    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return tryToNum(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return tryToNum(object.of(listIndex));
    }
    try {
      return num.tryParse('$object');
    } catch (e, s) {
      log(
        'tryToNum() Unsupported object type: exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
  }

  /// Converts an object to an [int].
  ///
  /// - Converts numeric types and strings that represent valid integers to [int].
  /// - If the conversion to [int] fails (e.g., non-integer string), throws a [ParsingException].
  ///
  /// [object] The object to be converted to an [int].
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns an [int] if conversion is successful.
  /// Throws a [ParsingException] if the conversion fails.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 10;
  /// final int1 = ConvertObject.toInt(object1); // 10
  ///
  /// final object2 = '5';
  /// final int2 = ConvertObject.toInt(object2); // 5
  ///
  /// final object3 = true;
  /// final int3 = ConvertObject.toInt(object3); // 1
  ///
  /// final object4 = 'abc';
  /// final int4 = ConvertObject.toInt(object4); // throws ParsingException
  /// ```
  static int toInt(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object is int) return object;
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return toInt(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return toInt(object.of(listIndex));
    }
    try {
      return toNum(object).toInt();
    } catch (e, s) {
      throw ParsingException(
        error: e,
        parsingInfo: 'toInt',
        stackTrace: s,
      );
    }
  }

  /// Attempts to convert an object to an [int], or returns `null` if the object is `null` or conversion fails.
  ///
  /// - Converts numeric types and strings that represent valid integers to [int].
  /// - If the conversion to [int] fails (e.g., non-integer string), logs an error and returns `null`.
  ///
  /// [object] The object to be converted to an [int].
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns an [int] if conversion is successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 10;
  /// final int1 = ConvertObject.tryToInt(object1); // 10
  ///
  /// final object2 = '5';
  /// final int2 = ConvertObject.tryToInt(object2); // 5
  ///
  /// final object3 = true;
  /// final int3 = ConvertObject.tryToInt(object3); // 1
  ///
  /// final object4 = 'abc';
  /// final int4 = ConvertObject.tryToInt(object4); // null
  ///
  /// final object5 = null;
  /// final int5 = ConvertObject.tryToInt(object5); // null
  /// ```
  static int? tryToInt(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object is int?) return object;

    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return tryToInt(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return tryToInt(object.of(listIndex));
    }
    try {
      return tryToNum(object).tryToInt;
    } catch (e, s) {
      log(
        'tryToInt() Unsupported object type: exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
  }

  /// Converts an object to a [BigInt].
  ///
  /// - Converts numeric types and strings that represent valid large integers to [BigInt].
  /// - IMPORTANT: BigInt operations can be computationally expensive, especially for very large integers.
  ///   Use BigInt only when necessary, and be mindful of performance implications.
  /// - If the conversion to [BigInt] fails or the object is `null`, throws a [ParsingException].
  ///
  /// [object] The object to be converted to a [BigInt].
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [BigInt] if conversion is successful.
  /// Throws a [ParsingException] if the conversion fails or the object is `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 10;
  /// final bigInt1 = ConvertObject.toBigInt(object1); // BigInt.from(10)
  ///
  /// final object2 = '1234567890';
  /// final bigInt2 = ConvertObject.toBigInt(object2); // BigInt.from(1234567890)
  ///
  /// final object3 = 'abc';
  /// final bigInt3 = ConvertObject.toBigInt(object3); // throws ParsingException
  ///
  /// final object4 = null;
  /// final bigInt4 = ConvertObject.toBigInt(object4); // throws ParsingException
  /// ```
  static BigInt toBigInt(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toBigInt',
        stackTrace: StackTrace.current,
      );
    }
    if (object is BigInt) return object;
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return toBigInt(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return toBigInt(object.of(listIndex));
    }
    try {
      if (object is num) return BigInt.from(object);
      return BigInt.parse('$object');
    } catch (e, s) {
      throw ParsingException(
        error: e,
        parsingInfo: 'toBigInt',
        stackTrace: s,
      );
    }
  }

  /// Attempts to convert an object to a [BigInt], or returns `null` if the object is `null` or conversion fails.
  ///
  /// - Converts numeric types and strings that represent valid large integers to [BigInt].
  /// - IMPORTANT: BigInt operations can be computationally expensive, especially for very large integers.
  ///   Use BigInt only when necessary, and be mindful of performance implications.
  /// - If the conversion to [BigInt] fails (e.g., non-numeric string), logs an error and returns `null`.
  ///
  /// [object] The object to be converted to a [BigInt].
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [BigInt] if conversion is successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 10;
  /// final bigInt1 = ConvertObject.tryToBigInt(object1); // BigInt.from(10)
  ///
  /// final object2 = '1234567890';
  /// final bigInt2 = ConvertObject.tryToBigInt(object2); // BigInt.from(1234567890)
  ///
  /// final object3 = 'abc';
  /// final bigInt3 = ConvertObject.tryToBigInt(object3); // null
  ///
  /// final object4 = null;
  /// final bigInt4 = ConvertObject.tryToBigInt(object4); // null
  /// ```
  static BigInt? tryToBigInt(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object is BigInt?) return object;
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return tryToBigInt(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return tryToBigInt(object.of(listIndex));
    }
    try {
      if (object is num) return BigInt.from(object);
      return BigInt.tryParse('$object');
    } catch (e, s) {
      log(
        'tryToBigInt() Unsupported object type: exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
  }

  /// Converts an object to a [double].
  ///
  /// - Converts numeric types and strings that represent valid numbers to [double].
  /// - If the conversion to [double] fails (e.g., non-numeric string), throws a [ParsingException].
  ///
  /// [object] The object to be converted to a [double].
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [double] if conversion is successful.
  /// Throws a [ParsingException] if the conversion fails.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 5.5;
  /// final double1 = ConvertObject.toDouble(object1); // 5.5
  ///
  /// final object2 = '3.14';
  /// final double2 = ConvertObject.toDouble(object2); // 3.14
  ///
  /// final object3 = true;
  /// final double3 = ConvertObject.toDouble(object3); // 1.0
  ///
  /// final object4 = 'abc';
  /// final double4 = ConvertObject.toDouble(object4); // throws ParsingException
  /// ```
  static double toDouble(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object is double) return object;
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return toDouble(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return toDouble(object.of(listIndex));
    }
    try {
      return toNum(object).toDouble();
    } catch (e, s) {
      throw ParsingException(
        error: e,
        parsingInfo: 'toDouble',
        stackTrace: s,
      );
    }
  }

  /// Attempts to convert an object to a [double], or returns `null` if the object is `null` or conversion fails.
  ///
  /// - Converts numeric types and strings that represent valid numbers to [double].
  /// - If the conversion to [double] fails (e.g., non-numeric string), logs an error and returns `null`.
  ///
  /// [object] The object to be converted to a [double].
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [double] if conversion is successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 5.5;
  /// final double1 = ConvertObject.tryToDouble(object1); // 5.5
  ///
  /// final object2 = '3.14';
  /// final double2 = ConvertObject.tryToDouble(object2); // 3.14
  ///
  /// final object3 = true;
  /// final double3 = ConvertObject.tryToDouble(object3); // 1.0
  ///
  /// final object4 = 'abc';
  /// final double4 = ConvertObject.tryToDouble(object4); // null
  ///
  /// final object5 = null;
  /// final double5 = ConvertObject.tryToDouble(object5); // null
  /// ```
  static double? tryToDouble(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object is double?) return object;
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return tryToDouble(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return tryToDouble(object.of(listIndex));
    }
    try {
      return tryToNum(object).tryToDouble;
    } catch (e, s) {
      log(
        'tryToDouble() Unsupported object type: exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
  }

  /// Converts an object to a `bool`.
  ///
  /// - Returns `true` if the object is a `bool` and equal to `true`.
  /// - Returns `true` if the object is a `String` and equal to 'yes' or 'true' (case-insensitive).
  /// - Returns `true` if the object is a `num`, `int`, or `double` and is larger than zero.
  /// - Returns `false` for other types or if the object is `null`.
  ///
  /// [object] The object to be converted to a `bool`.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a `bool`, with a default value of `false`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = true;
  /// final bool1 = ConvertObject.toBool(object1); // true
  ///
  /// final object2 = 'yes';
  /// final bool2 = ConvertObject.toBool(object2); // true
  ///
  /// final object3 = 10;
  /// final bool3 = ConvertObject.toBool(object3); // true
  ///
  /// final object4 = false;
  /// final bool4 = ConvertObject.toBool(object4); // false
  ///
  /// final object5 = 'no';
  /// final bool5 = ConvertObject.toBool(object5); // false
  ///
  /// final object6 = null;
  /// final bool6 = ConvertObject.toBool(object6); // false
  /// ```
  static bool toBool(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return (object[mapKey] as Object?).asBool;
    }
    if (listIndex != null && object is List<dynamic>) {
      return (object.of(listIndex) as Object?).asBool;
    }
    return (object as Object?).asBool;
  }

  /// Attempts to convert an object to a `bool`, or returns `null` if the object is `null` or conversion is not applicable.
  ///
  /// - Returns `true` if the object is a `bool` and equal to `true`.
  /// - Returns `true` if the object is a `String` and equal to 'yes' or 'true' (case-insensitive).
  /// - Returns `null` for other types or if the object is `null`.
  ///
  /// [object] The object to be converted to a `bool`.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a `bool` if conversion is applicable, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = true;
  /// final bool1 = ConvertObject.tryToBool(object1); // true
  ///
  /// final object2 = 'yes';
  /// final bool2 = ConvertObject.tryToBool(object2); // true
  ///
  /// final object3 = 10;
  /// final bool3 = ConvertObject.tryToBool(object3); // null
  ///
  /// final object4 = false;
  /// final bool4 = ConvertObject.tryToBool(object4); // false
  ///
  /// final object5 = 'no';
  /// final bool5 = ConvertObject.tryToBool(object5); // false
  ///
  /// final object6 = null;
  /// final bool6 = ConvertObject.tryToBool(object6); // null
  /// ```
  static bool? tryToBool(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object == null) {
      return null;
    } else {
      if (mapKey != null && object is Map<dynamic, dynamic>) {
        return (object[mapKey] as Object?).asBool;
      }
      if (listIndex != null && object is List<dynamic>) {
        return (object.of(listIndex) as Object?).asBool;
      }
      return (object as Object?).asBool;
    }
  }

  /// Converts an object to a [DateTime].
  ///
  /// - If the object is a string representing a valid DateTime, it converts it to a [DateTime] object.
  /// - If the object is already a [DateTime], it is returned as-is.
  /// - If the object is `null`, throws a [ParsingException] with a `nullObject` error.
  /// - If the conversion to [DateTime] fails (e.g., invalid format), throws a [ParsingException].
  ///
  /// [object] The object to be converted to a [DateTime].
  /// [format] (Optional) Specify the format if the object is a string representing a DateTime.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [DateTime] if conversion is successful.
  /// Throws a [ParsingException] if the conversion fails or the object is `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = '2023-06-26T12:00:00Z';
  /// final dateTime1 = ConvertObject.toDateTime(object1); // 2023-06-26 12:00:00.000Z
  ///
  /// final object2 = DateTime(2023, 6, 26, 12, 0, 0);
  /// final dateTime2 = ConvertObject.toDateTime(object2); // 2023-06-26 12:00:00.000
  ///
  /// final object3 = 'Invalid DateTime';
  /// final dateTime3 = ConvertObject.toDateTime(object3); // ParsingException (logs an error)
  ///
  /// final object4 = null;
  /// final dateTime4 = ConvertObject.toDateTime(object4); // ParsingException (null object)
  /// ```
  static DateTime toDateTime(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
    String? format,
  }) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toDateTime',
        stackTrace: StackTrace.current,
      );
    }
    if (object is DateTime) return object;
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return toDateTime(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return toDateTime(object.of(listIndex));
    }
    try {
      if (format.isEmptyOrNull) return DateTime.parse('$object');
      return '$object'.toDateWithFormat(format!);
    } catch (e, s) {
      throw ParsingException(
        error: e,
        parsingInfo: 'toDateTime',
        stackTrace: s,
      );
    }
  }

  /// Attempts to convert an object to a [DateTime], or returns `null` if the object is `null` or conversion fails.
  ///
  /// - If the object is a string representing a valid DateTime, it converts it to a [DateTime] object.
  /// - If the object is already a [DateTime], it is returned as-is.
  /// - If the conversion to [DateTime] fails (e.g., invalid format), logs an error and returns `null`.
  ///
  /// [object] The object to be converted to a [DateTime].
  /// [format] (Optional) Specify the format if the object is a string representing a DateTime.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [DateTime] if conversion is successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = '2023-06-26T12:00:00Z';
  /// final dateTime1 = ConvertObject.tryToDateTime(object1); // 2023-06-26 12:00:00.000Z
  ///
  /// final object2 = DateTime(2023, 6, 26, 12, 0, 0);
  /// final dateTime2 = ConvertObject.tryToDateTime(object2); // 2023-06-26 12:00:00.000
  ///
  /// final object3 = 'Invalid DateTime';
  /// final dateTime3 = ConvertObject.tryToDateTime(object3); // null (logs an error)
  ///
  /// final object4 = null;
  /// final dateTime4 = ConvertObject.tryToDateTime(object4); // null
  /// ```
  static DateTime? tryToDateTime(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
    String? format,
  }) {
    if (object is DateTime?) return object;
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return tryToDateTime(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return tryToDateTime(object.of(listIndex));
    }
    try {
      if (format.isEmptyOrNull) return DateTime.tryParse('$object');
      return '$object'.tryToDateWithFormat(format!);
    } catch (e, s) {
      log(
        'tryToDateTime() Unsupported object type: exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
  }

  /// Converts an object to a [Uri].
  ///
  /// - If the object is a string representing a valid URI, it converts it to a [Uri] object.
  /// - If the object is `null`, throws a [ParsingException] with a `nullObject` error.
  /// - If the conversion to [Uri] fails (e.g., if the string is not a valid URI), throws a [ParsingException].
  ///
  /// [object] The object to be converted to a [Uri]. Expected to be a string representing a URI.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [Uri] if conversion is successful.
  /// Throws a [ParsingException] if the conversion fails or the object is null.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 'https://www.example.com';
  /// final uri1 = ConvertObject.toUri(object1); // Uri.parse('https://www.example.com')
  ///
  /// final object2 = 'invalid_uri';
  /// final uri2 = ConvertObject.toUri(object2); // throws ParsingException
  ///
  /// final object3 = null;
  /// final uri3 = ConvertObject.toUri(object3); // throws ParsingException
  /// ```
  static Uri toUri(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toUri',
        stackTrace: StackTrace.current,
      );
    }
    if (object is Uri) return object;
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return toUri(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return toUri(object.of(listIndex));
    }
    try {
      final ob = object.toString();
      if (ob.isValidPhoneNumber) return ob.toPhoneUri;
      return ob.toUri;
    } catch (e, s) {
      throw ParsingException(
        error: e,
        parsingInfo: 'toUri',
        stackTrace: s,
      );
    }
  }

  /// Attempts to convert an object to a [Uri], or returns `null` if the object is `null` or conversion fails.
  ///
  /// - If the object is a string representing a valid URI, it converts it to a [Uri] object.
  /// - If the conversion to [Uri] fails (e.g., if the string is not a valid URI), it logs an error and returns `null`.
  /// - If the object is null, returns null.
  ///
  /// [object] The object to be converted to a [Uri]. Expected to be a string representing a URI.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [Uri] if conversion is successful, otherwise null.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = 'https://www.example.com';
  /// final uri1 = ConvertObject.tryToUri(object1); // Uri.parse('https://www.example.com')
  ///
  /// final object2 = 'invalid_uri';
  /// final uri2 = ConvertObject.tryToUri(object2); // null (logs an error)
  ///
  /// final object3 = null;
  /// final uri3 = ConvertObject.tryToUri(object3); // null
  /// ```
  static Uri? tryToUri(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object is Uri?) return object;

    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return tryToUri(object[mapKey]);
    }
    if (listIndex != null && object is List<dynamic>) {
      return tryToUri(object.of(listIndex));
    }
    try {
      final ob = object.toString();
      if (ob.isValidPhoneNumber) return ob.toPhoneUri;
      return ob.toUri;
    } catch (e, s) {
      log(
        'tryToUri() Unsupported object type: exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
  }

  /// Converts an object to a [Map] with keys of type `K` and values of type `V`.
  ///
  /// - If the object is already a [Map] with the correct key and value types, it is returned as-is.
  /// - If the object is an empty [Map], an empty [Map] is returned.
  /// - If the object is null, throws a [ParsingException] with a `nullObject` error.
  /// - If the object cannot be converted to a [Map] with the specified types, throws a [ParsingException].
  ///
  /// [object] The object to be converted to a [Map] with keys of type `K` and values of type `V`.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [Map<K, V>] if conversion is successful.
  /// Throws a [ParsingException] if the conversion fails.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = {'key1': 'value1', 'key2': 'value2'};
  /// final map1 = ConvertObject.toMap<String, String>(object1); // {'key1': 'value1', 'key2': 'value2'}
  ///
  /// final object2 = {'key1': 1, 'key2': 2};
  /// final map2 = ConvertObject.toMap<String, int>(object2); // {'key1': 1, 'key2': 2'}
  ///
  /// final object3 = 'Hello';
  /// final map3 = ConvertObject.toMap<String, int>(object3); // ParsingException (logs an error)
  ///
  /// final object4 = null;
  /// final map4 = ConvertObject.toMap<String, int>(object4); // ParsingException (null object)
  /// ```
  static Map<K, V> toMap<K, V>(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toMap',
        stackTrace: StackTrace.current,
      );
    }
    if (object is Map && object.isEmpty) return <K, V>{};
    if (listIndex != null && object is List<dynamic>) {
      return toMap<K, V>(object.of(listIndex));
    }
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return toMap<K, V>(object[mapKey]);
    }
    if (object is Map<K, V>) return object;
    try {
      return object as Map<K, V>;
    } catch (_) {}
    try {
      return (object as Map)
          .map((key, value) => MapEntry(key as K, value as V));
    } catch (e, s) {
      log(
        'toMap() Unsupported Map type <$K, $V>: exception message -> $e',
        stackTrace: s,
        error: e,
      );
      throw ParsingException(
        error: e.toString(),
        parsingInfo: 'toMap',
        stackTrace: s,
      );
    }
  }

  /// Attempts to convert an object to a [Map] with keys of type `K` and values of type `V`.
  ///
  /// - If the object is already a [Map] with the correct key and value types, it is returned as-is.
  /// - If the object is an empty [Map], an empty [Map] is returned.
  /// - If the object is null, returns null.
  /// - If the object cannot be converted to a [Map] with the specified types, logs an error and returns null.
  ///
  /// [object] The object to be converted to a [Map] with keys of type `K` and values of type `V`.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [Map<K, V>] if conversion is successful, otherwise null.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = {'key1': 'value1', 'key2': 'value2'};
  /// final map1 = ConvertObject.tryToMap<String, String>(object1); // {'key1': 'value1', 'key2': 'value2'}
  ///
  /// final object2 = {'key1': 1, 'key2': 2};
  /// final map2 = ConvertObject.tryToMap<String, int>(object2); // {'key1': 1, 'key2': 2}
  ///
  /// final object3 = 'Hello';
  /// final map3 = ConvertObject.tryToMap<String, int>(object3); // null (logs an error)
  ///
  /// final object4 = null;
  /// final map4 = ConvertObject.tryToMap<String, int>(object4); // null
  /// ```
  static Map<K, V>? tryToMap<K, V>(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object is Map && object.isEmpty) return <K, V>{};
    if (listIndex != null && object is List<dynamic>) {
      return tryToMap<K, V>(object.of(listIndex));
    }
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return tryToMap<K, V>(object[mapKey]);
    }
    if (object is Map<K, V>?) return object;
    try {
      return object as Map<K, V>;
    } catch (_) {}
    try {
      return (object as Map)
          .map((key, value) => MapEntry(key as K, value as V));
    } catch (e, s) {
      log(
        'tryToMap() Unsupported Map type <$K, $V>: exception message -> $e',
        stackTrace: s,
        error: e,
      );
    }
    return null;
  }

  /// Converts an object to a [Set] of type `T`.
  ///
  /// - If the object is already a [Set] of type `T`, it is returned as-is.
  /// - If the object is an [Iterable], it converts it to a [Set] of type `T`.
  /// - If the object is null, throws a [ParsingException] with a `nullObject` error.
  /// - If the object cannot be converted to a [Set] of type `T`, throws a [ParsingException].
  ///
  /// [object] The object to be converted to a [Set] of type `T`.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [Set] of type `T` if conversion is successful.
  /// Throws a [ParsingException] if the conversion fails.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = {1, 2, 3};
  /// final set1 = ConvertObject.toSet<int>(object1); // {1, 2, 3}
  ///
  /// final object2 = [1, 2, 3];
  /// final set2 = ConvertObject.toSet<int>(object2); // {1, 2, 3}
  ///
  /// final object3 = 'Hello';
  /// final set3 = ConvertObject.toSet<int>(object3); // ParsingException (logs an error)
  ///
  /// final object4 = null;
  /// final set4 = ConvertObject.toSet<int>(object4); // ParsingException (null object)
  /// ```
  static Set<T> toSet<T>(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toSet',
        stackTrace: StackTrace.current,
      );
    }
    if (object is Iterable && object.isEmpty) return <T>{};
    if (listIndex != null && object is List<dynamic>) {
      return toSet<T>(object.of(listIndex));
    }
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return toSet<T>(object[mapKey]);
    }
    if (object is Set<T>) return object;
    if (object is T) return <T>{object};
    if (object is Map<dynamic, T>) return object.values.toSet();
    try {
      return (object as Iterable).map((tmp) => toType<T>(tmp)).toSet();
    } catch (e, s) {
      log(
        'toSet() Unsupported object type ($T): exception message -> $e',
        stackTrace: s,
        error: e,
      );
      throw ParsingException(
        error: e.toString(),
        parsingInfo: 'toSet',
        stackTrace: s,
      );
    }
  }

  /// Attempts to convert an object to a [Set] of type `T`, or returns null if conversion is not possible.
  ///
  /// - If the object is already a [Set] of type `T`, it is returned as-is.
  /// - If the object is an [Iterable], it converts it to a [Set] of type `T`.
  /// - If the object is null, returns null.
  /// - If the object cannot be converted to a [Set] of type `T`, logs an error and returns null.
  ///
  /// [object] The object to be converted to a [Set] of type `T`.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [Set] of type `T` if conversion is successful, otherwise null.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = {1, 2, 3};
  /// final set1 = ConvertObject.tryToSet<int>(object1); // {1, 2, 3}
  ///
  /// final object2 = [1, 2, 3];
  /// final set2 = ConvertObject.tryToSet<int>(object2); // {1, 2, 3}
  ///
  /// final object3 = 'Hello';
  /// final set3 = ConvertObject.tryToSet<int>(object3); // null (logs an error)
  ///
  /// final object4 = null;
  /// final set4 = ConvertObject.tryToSet<int>(object4); // null
  /// ```
  static Set<T>? tryToSet<T>(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object is Iterable && object.isEmpty) return <T>{};
    if (listIndex != null && object is List<dynamic>) {
      return tryToSet<T>(object.of(listIndex));
    }
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return tryToSet<T>(object[mapKey]);
    }
    if (object is Set<T>?) return object;
    if (object is T) return <T>{object};
    if (object is Map<dynamic, T>) return object.values.toSet();
    try {
      if (mapKey != null && object is Map<dynamic, dynamic>) {
        return tryToSet(object[mapKey]);
      }
      if (object == null) return null;
      return (object as Iterable).map((tmp) => toType<T>(tmp)).toSet();
    } catch (e, s) {
      log(
        'toSet() Unsupported object type ($T): exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
  }

  /// Converts an object to a [List] of type `T`.
  ///
  /// - If the object is already a [List] of type `T`, it is returned as-is.
  /// - If the object is a single instance of type `T`, it returns a [List] containing that object.
  /// - If the object is a [Map], and `mapKey` is provided, it returns a [List] of the values for that key across all map entries.
  /// - If the object is a [Map] with values of type `T` and no `mapKey` is provided, it returns a [List] of all the map's values.
  /// - If the object is a [List], and `listIndex` is provided, it attempts to return a [List] containing the element at that index from each list in the original list.
  /// - If the object cannot be converted to a [List] of type `T`, a [ParsingException] is thrown.
  ///
  /// [object] The object to be converted to a [List] of type `T`.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [List] of type `T` if conversion is successful.
  /// Throws a [ParsingException] if the conversion fails.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = [1, 2, 3];
  /// final list1 = ConvertObject.toList<int>(object1); // [1, 2, 3]
  ///
  /// final object2 = 42;
  /// final list2 = ConvertObject.toList<int>(object2); // [42]
  ///
  /// final object3 = {'a': 1, 'b': 2};
  /// final list3 = ConvertObject.toList<int>(object3); // [1, 2]
  ///
  /// final object4 = {'a': [1, 2], 'b': [3, 4]};
  /// final list4 = ConvertObject.toList<int>(object4, mapKey: 'a'); // [1, 2]
  ///
  /// final object5 = [[1, 2], [3, 4]];
  /// final list5 = ConvertObject.toList<int>(object5, listIndex: 0); // [1, 3]
  ///
  /// final object6 = 'Hello';
  /// final list6 = ConvertObject.toList<int>(object6); // throws ParsingException
  /// ```
  static List<T> toList<T>(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toList',
        stackTrace: StackTrace.current,
      );
    }
    if (object is Iterable && object.isEmpty) return <T>[];
    if (listIndex != null && object is List<dynamic>) {
      return toList<T>(object.of(listIndex));
    }
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return toList<T>(object[mapKey]);
    }
    if (object is List<T>) return object;
    if (object is T) return <T>[object];
    if (object is Map<dynamic, T>) return object.values.toList();
    try {
      return (object as Iterable).map((tmp) => toType<T>(tmp)).toList();
    } catch (e, s) {
      log(
        'toList() Unsupported object type ($T): exception message -> $e',
        stackTrace: s,
        error: e,
      );
      throw ParsingException(
        error: e.toString(),
        parsingInfo: 'toList',
        stackTrace: s,
      );
    }
  }

  /// Attempts to convert an object to a [List] of type `T`, or returns `null` if conversion is not possible.
  ///
  /// - If the object is already a [List] of type `T`, it is returned as-is.
  /// - If the object is a single instance of type `T`, it returns a [List] containing that object.
  /// - If the object is a [Map], and `mapKey` is provided, it returns a [List] of the values for that key across all map entries.
  /// - If the object is a [Map] with values of type `T` and no `mapKey` is provided, it returns a [List] of all the map's values.
  /// - If the object is a [List], and `listIndex` is provided, it attempts to return a [List] containing the element at that index from each list in the original list.
  /// - If the object cannot be converted to a [List] of type `T`, an error is logged, and `null` is returned.
  ///
  /// [object] The object to be converted to a [List] of type `T`.
  /// [mapKey] (Optional) Specifies the key to extract values from a [Map] object.
  /// [listIndex] (Optional) Specifies the index to extract elements from a [List] object.
  ///
  /// Returns a [List] of type `T` if conversion is successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = [1, 2, 3];
  /// final list1 = ConvertObject.tryToList<int>(object1); // [1, 2, 3]
  ///
  /// final object2 = 42;
  /// final list2 = ConvertObject.tryToList<int>(object2); // [42]
  ///
  /// final object3 = {'a': 1, 'b': 2};
  /// final list3 = ConvertObject.tryToList<int>(object3); // [1, 2]
  ///
  /// final object4 = {'a': [1, 2], 'b': [3, 4]};
  /// final list4 = ConvertObject.tryToList<int>(object4, mapKey: 'a'); // [1, 2]
  ///
  /// final object5 = [[1, 2], [3, 4]];
  /// final list5 = ConvertObject.tryToList<int>(object5, listIndex: 0); // [1, 3]
  ///
  /// final object6 = 'Hello';
  /// final list6 = ConvertObject.tryToList<int>(object6); // null (logs an error)
  ///
  /// final object7 = null;
  /// final list7 = ConvertObject.tryToList<int>(object7); // null
  /// ```
  static List<T>? tryToList<T>(
    dynamic object, {
    Object? mapKey,
    int? listIndex,
  }) {
    if (object is Iterable && object.isEmpty) return <T>[];
    if (listIndex != null && object is List<dynamic>) {
      return tryToList<T>(object.of(listIndex));
    }
    if (mapKey != null && object is Map<dynamic, dynamic>) {
      return tryToList<T>(object[mapKey]);
    }
    if (object is List<T>?) return object;
    if (object is T) return <T>[object];
    if (object is Map<dynamic, T>) return object.values.toList();
    try {
      if (object == null) return null;
      return (object as Iterable).map((tmp) => toType<T>(tmp)).toList();
    } catch (e, s) {
      log(
        'tryToList() Unsupported object type ($T): exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
  }
}
