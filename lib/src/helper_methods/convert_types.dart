import 'dart:developer';

import 'package:flutter_helper_utils/src/exceptions/exceptions.dart';

import '../src.dart';

/// A utility class for converting objects to different types.
abstract class ConvertObject {
  /// Convert any object to a string if the object is not `null`.
  ///
  /// If the object is `null`, a [ParsingException] with a `nullObject` error will be thrown.
  /// If the conversion to string fails, a [ParsingException] will be thrown.
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
  static String toString1(dynamic object) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toString',
        stackTrace: StackTrace.current,
      );
    } else {
      try {
        if (object is String) return object;
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

  /// Convert any object to a string, or return `null` if the object is `null`.
  ///
  /// If the conversion to string fails, it will log an error and return `null`.
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
  static String? tryToString(dynamic object) {
    try {
      if (object is String?) return object;
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

  /// Convert an object to a [num].
  ///
  /// If the object is `null`, a [ParsingException] with a `nullObject` error will be thrown.
  /// If the conversion to [num] fails, a [ParsingException] will be thrown.
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
  static num toNum(dynamic object) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toNum',
        stackTrace: StackTrace.current,
      );
    }
    try {
      if (object is num) return object;
      return '$object'.toNum;
    } catch (e, s) {
      throw ParsingException(
        error: e,
        parsingInfo: 'toNum',
        stackTrace: s,
      );
    }
  }

  /// Convert an object to a [num], or return `null` if the object is `null`.
  ///
  /// If the conversion to [num] fails, it will log an error and return `null`.
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
  static num? tryToNum(dynamic object) {
    try {
      if (object is num?) return object;
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

  /// Convert an object to an [int].
  ///
  /// If the conversion to [int] fails, a [ParsingException] will be thrown.
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
  static int toInt(dynamic object) {
    try {
      if (object is int) return object;
      return toNum(object).toInt();
    } catch (e, s) {
      throw ParsingException(
        error: e,
        parsingInfo: 'toInt',
        stackTrace: s,
      );
    }
  }

  /// Convert an object to an [int], or return `null` if the object is `null`.
  ///
  /// If the conversion to [int] fails, it will log an error and return `null`.
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
  static int? tryToInt(dynamic object) {
    try {
      if (object is int?) return object;
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

  /// Convert an object to a [BigInt].
  ///
  /// It's IMPORTANT to note that BigInt operations can be computationally expensive,
  /// especially for very large integers. Therefore, use BigInt only when necessary,
  /// and be mindful of performance implications.
  ///
  /// If the object is `null`, a [ParsingException] with a `nullObject` error will be thrown.
  /// If the conversion to [BigInt] fails, a [ParsingException] will be thrown.
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
  static BigInt toBigInt(dynamic object) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toBigInt',
        stackTrace: StackTrace.current,
      );
    }
    try {
      if (object is BigInt) return object;
      if (object is num) return BigInt.from(object);
      return BigInt.parse(toString1(object));
    } catch (e, s) {
      throw ParsingException(
        error: e,
        parsingInfo: 'toBigInt',
        stackTrace: s,
      );
    }
  }

  /// Convert an object to a [BigInt], or return `null` if the object is `null`.
  ///
  /// It's IMPORTANT to note that BigInt operations can be computationally expensive,
  /// especially for very large integers. Therefore, use BigInt only when necessary,
  /// and be mindful of performance implications.
  ///
  /// If the conversion to [BigInt] fails, it will log an error and return `null`.
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
  static BigInt? tryToBigInt(dynamic object) {
    try {
      if (object is BigInt?) return object;
      if (object is num) return BigInt.from(object);
      return BigInt.tryParse(toString1(object));
    } catch (e, s) {
      log(
        'tryToBigInt() Unsupported object type: exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
  }

  /// Convert an object to a [double].
  ///
  /// If the conversion to [double] fails, a [ParsingException] will be thrown.
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
  static double toDouble(dynamic object) {
    try {
      if (object is double) return object;
      return toNum(object).toDouble();
    } catch (e, s) {
      throw ParsingException(
        error: e,
        parsingInfo: 'toDouble',
        stackTrace: s,
      );
    }
  }

  /// Convert an object to a [double], or return `null` if the object is `null`.
  ///
  /// If the conversion to [double] fails, it will log an error and return `null`.
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
  static double? tryToDouble(dynamic object) {
    try {
      if (object is double?) return object;
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

  /// Return `true` if the object is a `bool` and equal to `true`,
  /// or the object is a `String` and equal to 'yes' or 'true',
  /// or the object is a `num`, `int`, or `double` and is larger than zero.
  /// The default value is `false`, even if the object is `null`.
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
  static bool toBool(dynamic object) => (object as Object?).asBool;

  /// Return `null` if the object is `null`,
  /// or return `true` if the object is a `bool` and equal to `true`,
  /// or return `true` if the object is a `String` and equal to 'yes' or 'true'.
  /// The default value is `false`.
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
  static bool? tryToBool(dynamic object) =>
      object == null ? null : (object as Object?).asBool;

  /// Convert an object to a [DateTime].
  ///
  /// If the object is null, a [ParsingException] with a `nullObject` error will be thrown.
  /// If the conversion to [DateTime] fails, a [ParsingException] will be thrown.
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
  static DateTime toDateTime(dynamic object) {
    try {
      if (object is DateTime) return object;
      return DateTime.parse(toString1(object));
    } catch (e, s) {
      throw ParsingException(
        error: e,
        parsingInfo: 'toDateTime',
        stackTrace: s,
      );
    }
  }

  /// Convert an object to a [DateTime], or return null if the object is null.
  ///
  /// If the conversion to [DateTime] fails, it will log an error and return null.
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
  static DateTime? tryToDateTime(dynamic object) {
    if (object is DateTime?) return object;
    try {
      return DateTime.tryParse(tryToString(object) ?? '');
    } catch (e, s) {
      log(
        'tryToDateTime() Unsupported object type: exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
  }

  /// Convert an object to a [Map].
  ///
  /// If the object is an empty [Map], an empty [Map] will be returned.
  /// If the object is already a [Map], it will be returned.
  /// If the object is null, a [ParsingException] with a `nullObject` error will be thrown.
  /// If the object cannot be converted to a [Map], a [ParsingException] will be thrown.
  ///
  /// Example usage:
  /// ```dart
  /// final object1 = {'key1': 'value1', 'key2': 'value2'};
  /// final map1 = ConvertObject.toMap<String, String>(object1); // {'key1': 'value1', 'key2': 'value2'}
  ///
  /// final object2 = {'key1': 1, 'key2': 2};
  /// final map2 = ConvertObject.toMap<String, int>(object2); // {'key1': 1, 'key2': 2}
  ///
  /// final object3 = 'Hello';
  /// final map3 = ConvertObject.toMap<String, int>(object3); // ParsingException (logs an error)
  ///
  /// final object4 = null;
  /// final map4 = ConvertObject.toMap<String, int>(object4); // ParsingException (null object)
  /// ```
  static Map<K, V> toMap<K, V>(dynamic object) {
    if (object is Map && object.isEmpty) return <K, V>{};
    if (object is Map<K, V>) return object;
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'toMap',
        stackTrace: StackTrace.current,
      );
    }
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

  /// Convert an object to a [Map], or return null if the object is null.
  ///
  /// If the object is an empty [Map], an empty [Map] will be returned.
  /// If the object is already a [Map], it will be returned.
  /// If the object cannot be converted to a [Map], it will log an error and return null.
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
  static Map<K, V>? tryToMap<K, V>(dynamic object) {
    if (object is Map && object.isEmpty) return <K, V>{};
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

  /// Convert an object to a [Set].
  ///
  /// If the object is an empty [Set], an empty [Set] will be returned.
  /// If the object is already a [Set], it will be returned.
  /// If the object is null, a [ParsingException] with a `nullObject` error will be thrown.
  /// If the object cannot be converted to a [Set], a [ParsingException] will be thrown.
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
  static Set<T> toSet<T>(dynamic object) {
    try {
      if (object == null) {
        throw ParsingException.nullObject(
          parsingInfo: 'toSet',
          stackTrace: StackTrace.current,
        );
      }
      if (object is Set<T>) return object;
      if (object is Set && object.isEmpty) return <T>{};
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

  /// Convert an object to a [Set], or return null if the object is null.
  ///
  /// If the object is an empty [Set], an empty [Set] will be returned.
  /// If the object is already a [Set], it will be returned.
  /// If the object cannot be converted to a [Set], it will log an error and return null.
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
  static Set<T>? tryToSet<T>(dynamic object) {
    if (object is Set<T>?) return object;
    if (object is Set && object.isEmpty) return <T>{};
    try {
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

  /// Convert an object to a [List] of type `T`.
  ///
  /// If the object is already a [List] of type `T`, it will be returned.
  /// If the object is of type `T`, a [List] containing the object as a single element will be returned.
  /// If the object is a [Map] with values of type `T`, a [List] containing the values of the [Map] will be returned.
  /// If the object cannot be converted to a [List] of type `T`, it will throw a [ParsingException].
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
  /// final object4 = 'Hello';
  /// final list4 = ConvertObject.toList<int>(object4); // throws ParsingException
  /// ```
  static List<T> toList<T>(dynamic object) {
    if (object is List<T>) return object;
    if (object is T) return <T>[object];
    if (object is Map<dynamic, T>) return object.values.toList();
    if (object is List && object.isEmpty) return <T>[];
    try {
      if (object == null) {
        throw ParsingException.nullObject(
          parsingInfo: 'toList',
          stackTrace: StackTrace.current,
        );
      }
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

  /// Convert an object to a [List] of type `T`, or return `null` if the object is `null`.
  ///
  /// If the object is already a [List] of type `T`, it will be returned.
  /// If the object is of type `T`, a [List] containing the object as a single element will be returned.
  /// If the object is a [Map] with values of type `T`, a [List] containing the values of the [Map] will be returned.
  /// If the object cannot be converted to a [List] of type `T`, it will log an error and return `null`.
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
  /// final object4 = 'Hello';
  /// final list4 = ConvertObject.tryToList<int>(object4); // null (logs an error)
  ///
  /// final object5 = null;
  /// final list5 = ConvertObject.tryToList<int>(object5); // null
  /// ```
  static List<T?>? tryToList<T>(dynamic object) {
    if (object is List<T>?) return object;
    if (object is T) return <T>[object];
    if (object is Map<dynamic, T>) return object.values.toList();
    if (object is List && object.isEmpty) return <T?>[];
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

/// Global function that allow Convert an object to a specified type.
///
/// - If the object is already of type [T], it will be returned.
/// - If the object is null, a [ParsingException] with a `nullObject` error will
///     be thrown. If you want to ensure null safe values, consider using [tryToType] instead.
/// - If the object cannot be converted to the specified type, a [ParsingException] will be thrown.
///
/// - Supported conversion types:
///   - [bool]
///   - [int]
///   - [BigInt]
///   - [double]
///   - [num]
///   - [String]
///   - [DateTime]
///
/// Throws a [ParsingException] if it cannot be converted to the specified type.
///
/// Example usage:
/// ```dart
/// final dynamicValue = '42';
/// final intValue = ConvertObject.toType<int>(dynamicValue); // 42
///
/// final dynamicValue2 = 'Hello';
/// final intValue2 = ConvertObject.toType<int>(dynamicValue2); // Throws ParsingException
///
/// final dynamicValue3 = null;
/// final intValue3 = ConvertObject.toType<int>(dynamicValue3); // Throws ParsingException with nullObject error
/// ```
T toType<T>(dynamic object) {
  if (object is T) return object;
  if (object == null) {
    throw ParsingException.nullObject(
      parsingInfo: 'toType',
      stackTrace: StackTrace.current,
    );
  }
  try {
    if (T == bool) return ConvertObject.toBool(object) as T;
    if (T == int) return ConvertObject.toInt(object) as T;
    if (T == double) return ConvertObject.toDouble(object) as T;
    if (T == num) return ConvertObject.toNum(object) as T;
    if (T == BigInt) return ConvertObject.toBigInt(object) as T;
    if (T == String) return ConvertObject.toString1(object) as T;
    if (T == DateTime) return ConvertObject.toDateTime(object) as T;
  } catch (e, s) {
    throw ParsingException(
      error: e,
      parsingInfo: 'toType',
      stackTrace: s,
    );
  }
  throw ParsingException(
    parsingInfo: 'toType',
    error: 'Unsupported type: $T',
  );
}

/// Global function that allow Convert an object to a specified type or return null.
///
/// If the object is already of type [T], it will be returned.
/// If the object is null, a null value will be returned. If you want to ensure non-nullable values, consider using [toType] instead.
/// If the object cannot be converted to the specified type, a [ParsingException] will be thrown.
///
/// Supported conversion types:
///   - [bool]
///   - [int]
///   - [BigInt]
///   - [double]
///   - [num]
///   - [String]
///   - [DateTime]
/// Throws a [ParsingException] if the object cannot be converted to the specified type.
///
/// Example usage:
/// ```dart
/// final dynamicValue = '42';
/// final intValue = ConvertObject.tryToType<int>(dynamicValue); // 42
///
/// final dynamicValue2 = 'Hello';
/// final intValue2 = ConvertObject.tryToType<int>(dynamicValue2); // Throws ParsingException
/// ```
T? tryToType<T>(dynamic object) {
  if (object is T) return object;
  if (object == null) return null;
  try {
    if (T == bool) return ConvertObject.tryToBool(object) as T?;
    if (T == int) return ConvertObject.tryToInt(object) as T?;
    if (T == BigInt) return ConvertObject.tryToBigInt(object) as T?;
    if (T == double) return ConvertObject.tryToDouble(object) as T?;
    if (T == num) return ConvertObject.tryToNum(object) as T?;
    if (T == String) return ConvertObject.tryToString(object) as T?;
    if (T == DateTime) return ConvertObject.tryToDateTime(object) as T?;
  } catch (e, s) {
    throw ParsingException(
      error: e,
      parsingInfo: 'toType',
      stackTrace: s,
    );
  }
  throw ParsingException(
    parsingInfo: 'toType',
    error: 'Unsupported type: $T',
  );
}
