import 'dart:developer';

import 'package:helper_repository/src/extensions/nums.dart';

class ConvertTypes {
  static num? toNum(dynamic object, {String? info}) {
    if (object == null) {
      return null;
    }
    try {
      return object as num?;
    } catch (e) {
      log('toNum() Unsupported object type: ${info != null ? 'info: $info, ' : ''}exception message -> $e');
      return null;
    }
  }

  static int? toInt(var object) {
    try {
      return toNum(object, info: 'from toInt()').tryToInt;
    } catch (e) {
      log('toInt() Unsupported object type: exception message -> $e');
      return null;
    }
  }

  static double? toDouble(var object) {
    try {
      return toNum(object, info: 'from toInt()').tryToDouble;
    } catch (e) {
      log('toInt() Unsupported object type: exception message -> $e');
      return null;
    }
  }

  static List<String> toStringList(dynamic object) {
    if (object == null) {
      return [];
    }
    if (object is String) {
      return <String>[object];
    } else {
      try {
        return object.cast<String>();
      } catch (e) {
        log('toStringList() Unsupported object type: exception message -> $e');
        return [];
      }
    }
  }

  static List<int> toIntList(var object) {
    if (object == null) {
      return [];
    }
    if (object is int) {
      return [object];
    } else {
      try {
        return object.cast<int>();
      } catch (e) {
        log('toIntList() Unsupported object type: exception message -> $e');
        return [];
      }
    }
  }
}
