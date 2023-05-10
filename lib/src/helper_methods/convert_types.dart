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
        throw ParsingException(
          error: e,
          parsingInfo: 'toString',
          stackTrace: s,
        );
      }
    }
  }

  /// convert any object to string or return null.
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
      throw ParsingException(
        error: e,
        parsingInfo: 'toNum',
        stackTrace: s,
      );
    }
  }

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

  /// return true if the object is bool and equal to true
  /// or object is string and equal to 'yes' or 'true'.
  /// or object is num, int, or double and is larger than zero
  /// false is default even if object is null
  static bool toBool(dynamic object) {
    if (object is bool) return object;
    if (object is num?) return object.asBool;
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
      throw ParsingException(
        error: e,
        parsingInfo: 'toDateTime',
        stackTrace: s,
      );
    }
  }

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

  static Set<T> toSet<T>(dynamic object) {
    try {
      if (object == null) {
        throw ParsingException.nullObject(
          parsingInfo: 'toSet',
          stackTrace: StackTrace.current,
        );
      }
      if (object is Set<T>) return object;
      final set = <T>{};
      if (object is Set && object.isEmpty) return set;
      final temp = object as List? ?? <dynamic>[];
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
        error: e.toString(),
        parsingInfo: 'toSet',
        stackTrace: s,
      );
    }
  }

  static Set<T>? tryToSet<T>(dynamic object) {
    if (object is Set<T>?) return object;
    final set = <T>{};
    if (object is Set && object.isEmpty) return set;
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
    if (object is List && object.isEmpty) return list;
    try {
      if (object == null) {
        throw ParsingException.nullObject(
          parsingInfo: 'toList',
          stackTrace: StackTrace.current,
        );
      }
      final temp = object as List? ?? <dynamic>[];
      try {
        temp.cast<T>();
      } catch (_) {}
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
        error: e.toString(),
        parsingInfo: 'toList',
        stackTrace: s,
      );
    }
    return list;
  }

  static List<T>? tryToList<T>(dynamic object) {
    if (object is List<T>?) return object;
    final list = <T>[];
    if (object is List && object.isEmpty) return list;
    try {
      if (object == null) return null;
      final temp = object as List? ?? <dynamic>[];
      try {
        temp.cast<T>();
      } catch (_) {}
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
