import 'dart:developer';

import '../src.dart';

class ConvertTypes {
  static num? toNum(dynamic object, {String? info}) {
    if (object == null) {
      return null;
    }
    try {
      return num.tryParse('$object');
    } catch (e) {
      log('toNum() Unsupported object type: ${info != null ? 'info: $info, ' : ''}exception message -> $e');
      return null;
    }
  }

  static int? toInt(dynamic object) {
    try {
      return toNum(object, info: 'from toInt()').tryToInt;
    } catch (e) {
      log('toInt() Unsupported object type: exception message -> $e');
      return null;
    }
  }

  static double? toDouble(dynamic object) {
    try {
      return toNum(object, info: 'from toInt()').tryToDouble;
    } catch (e) {
      log('toInt() Unsupported object type: exception message -> $e');
      return null;
    }
  }

  static Set<T> toSet<T>(dynamic object) {
    try {
      if (object == null) {
        return <T>{};
      }
      final temp = object as List? ?? <dynamic>[];
      final set = <T>{};
      for (final tmp in temp) {
        set.add(tmp as T);
      }
      return set;
    } catch (e) {
      log('toSet() Unsupported object type ($T): exception message -> $e');
      return {};
    }
  }

  static List<T> toList<T>(dynamic object) {
    try {
      if (object == null) {
        return <T>[];
      }
      final temp = object as List? ?? <dynamic>[];
      final list = <T>[];
      for (final tmp in temp) {
        list.add(tmp as T);
      }
      return list;
    } catch (e) {
      log('toList() Unsupported object type ($T): exception message -> $e');
      return [];
    }
  }
}
