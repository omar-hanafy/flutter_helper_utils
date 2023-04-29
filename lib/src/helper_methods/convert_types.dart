import 'dart:developer';

import 'package:flutter_helper_utils/src/exceptions/exceptions.dart';

import '../src.dart';

abstract class ConvertObject {
  static num toNum(dynamic object) {
    if (object == null) {
      throw ParsingExceptions.nullObject(
        parsingInfo: 'to Num',
        stackTrace: StackTrace.current,
      );
    }
    try {
      return '$object'.toNum;
    } catch (e, s) {
      log(
        'toNum() Unsupported object type, exception message -> $e',
        stackTrace: s,
        error: e,
      );
      throw ParsingExceptions(
        cause: '$e',
        parsingInfo: 'to Num',
        stackTrace: s,
      );
    }
  }

  static num? tryToNum(dynamic object) => num.tryParse('$object');

  static int toInt(dynamic object) => toNum(object).toInt();

  static int? tryToInt(dynamic object) => tryToNum(object).tryToInt;

  static double? toDouble(dynamic object) => toNum(object).toDouble();

  static double? tryToDouble(dynamic object) => tryToNum(object).tryToDouble;

  static Set<T> toSet<T>(dynamic object) {
    try {
      if (object == null) {
        throw ParsingExceptions.nullObject(
          parsingInfo: 'toSet',
          stackTrace: StackTrace.current,
        );
      }
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
      throw ParsingExceptions(
        cause: e.toString(),
        parsingInfo: 'toSet',
        stackTrace: s,
      );
    }
  }

  static Set<T> tryToSet<T>(dynamic object) {
    try {
      if (object == null) return <T>{};
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
      return {};
    }
  }

  static List<T> toList<T>(dynamic object) {
    final list = <T>[];
    try {
      if (object == null) {
        throw ParsingExceptions.nullObject(
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
      throw ParsingExceptions(
        cause: e.toString(),
        parsingInfo: 'toList',
        stackTrace: s,
      );
    }
    return list;
  }

  static List<T>? tryToList<T>(dynamic object) {
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
