import 'dart:developer';

import 'package:flutter_helper_utils/src/exceptions/exceptions.dart';

import '../src.dart';

abstract class ConvertObject {
  /// convert any object to string if the object is not null only.
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
        log(
          'toString() Unsupported object type: exception message -> $e',
          stackTrace: s,
          error: e,
        );
        throw ParsingException(
          cause: e.toString(),
          parsingInfo: 'toString',
          stackTrace: s,
        );
      }
    }
  }

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

  static num toNum(dynamic object) {
    if (object == null) {
      throw ParsingException.nullObject(
        parsingInfo: 'to Num',
        stackTrace: StackTrace.current,
      );
    }
    try {
      if (object is num) return object;
      return '$object'.toNum;
    } catch (e, s) {
      log(
        'toNum() Unsupported object type, exception message -> $e',
        stackTrace: s,
        error: e,
      );
      throw ParsingException(
        cause: '$e',
        parsingInfo: 'toNum',
        stackTrace: s,
      );
    }
  }

  static num? tryToNum(dynamic object) {
    if (object is num?) return object;
    return num.tryParse('$object');
  }

  static int toInt(dynamic object) {
    try {
      if (object is int) return object;
      return toNum(object).toInt();
    } catch (e, s) {
      log(
        'toInt() Unsupported object type, exception message -> $e',
        stackTrace: s,
        error: e,
      );
      throw ParsingException(
        cause: '$e',
        parsingInfo: 'toInt',
        stackTrace: s,
      );
    }
  }

  static int? tryToInt(dynamic object) {
    if (object is int?) return object;
    return tryToNum(object).tryToInt;
  }

  static double toDouble(dynamic object) {
    try {
      if (object is double) return object;
      return toNum(object).toDouble();
    } catch (e, s) {
      log(
        'toInt() Unsupported object type, exception message -> $e',
        stackTrace: s,
        error: e,
      );
      throw ParsingException(
        cause: '$e',
        parsingInfo: 'toInt',
        stackTrace: s,
      );
    }
  }

  static double? tryToDouble(dynamic object) {
    if (object is double?) return object;
    return tryToNum(object).tryToDouble;
  }

  /// return true if the object is bool and equal to true
  /// or object is string and equal to 'yes' or 'true'.
  /// false is default even if object is null
  static bool toBool(dynamic object) {
    if (object is bool) return object;
    return '$object'.asBool;
  }

  /// return null if object is null
  /// or return true if the object is bool and equal to true
  /// or return true if object is string and equal to 'yes' or 'true'.
  /// false is default.
  static bool? tryToBool(dynamic object) {
    if (object is bool?) return object;
    return '$object'.asBool;
  }

  static DateTime toDateTime(dynamic object) {
    try {
      if (object is DateTime) return object;
      return DateTime.parse(toString1(object));
    } catch (e, s) {
      log(
        'toDateTime() Unsupported object type, exception message -> $e',
        stackTrace: s,
        error: e,
      );
      throw ParsingException(
        cause: '$e',
        parsingInfo: 'toDateTime',
        stackTrace: s,
      );
    }
  }

  static DateTime? tryToDateTime(dynamic object) {
    if (object is DateTime?) return object;
    return DateTime.tryParse(tryToString(object) ?? '');
  }

  static Map<K, V> toMap<K, V>(dynamic object) {
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
        cause: e.toString(),
        parsingInfo: 'toSet',
        stackTrace: s,
      );
    }
  }

  static Map<K, V>? tryToMap<K, V>(dynamic object) {
    if (object is Map<K, V>?) return object;
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
    }
    return null;
  }

  static Set<T> toSet<T>(dynamic object) {
    try {
      if (object == null) {
        throw ParsingException.nullObject(
          parsingInfo: 'toSet',
          stackTrace: StackTrace.current,
        );
      }
      if (object is Set<T>) return object;
      final temp = object as List? ?? <dynamic>[];
      final set = <T>{};
      for (final tmp in temp) {
        set.add(tmp as T);
      }
      return set;
    } catch (e, s) {
      log(
        'toSet() Unsupported object type ($T): exception message -> $e',
        stackTrace: s,
        error: e,
      );
      throw ParsingException(
        cause: e.toString(),
        parsingInfo: 'toSet',
        stackTrace: s,
      );
    }
  }

  static Set<T>? tryToSet<T>(dynamic object) {
    if (object is Set<T>?) return object;
    final set = <T>{};
    try {
      if (object == null) return null;
      final temp = object as List? ?? <dynamic>[];
      for (final tmp in temp) {
        set.add(tmp as T);
      }
    } catch (e, s) {
      log(
        'toSet() Unsupported object type ($T): exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
    return set;
  }

  static List<T> toList<T>(dynamic object) {
    if (object is List<T>) return object;
    final list = <T>[];
    try {
      if (object == null) {
        throw ParsingException.nullObject(
          parsingInfo: 'toList',
          stackTrace: StackTrace.current,
        );
      }
      final temp = object as List? ?? <dynamic>[];
      for (final tmp in temp) {
        list.add(tmp as T);
      }
    } catch (e, s) {
      log(
        'toList() Unsupported object type ($T): exception message -> $e',
        stackTrace: s,
        error: e,
      );
      throw ParsingException(
        cause: e.toString(),
        parsingInfo: 'toList',
        stackTrace: s,
      );
    }
    return list;
  }

  static List<T>? tryToList<T>(dynamic object) {
    if (object is List<T>?) return object;
    final list = <T>[];
    try {
      if (object == null) return null;
      final temp = object as List? ?? <dynamic>[];
      for (final tmp in temp) {
        list.add(tmp as T);
      }
    } catch (e, s) {
      log(
        'toList() Unsupported object type ($T): exception message -> $e',
        stackTrace: s,
        error: e,
      );
      return null;
    }
    return list;
  }
}
