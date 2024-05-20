import 'dart:convert';

import 'package:flutter/foundation.dart';

dynamic _makeValueEncodable(dynamic value) {
  if (value is String ||
      value is int ||
      value is double ||
      value is bool ||
      value == null) {
    return value;
  } else if (value is Enum) {
    return value.name;
  } else if (value is List) {
    return value.map(_makeValueEncodable).toList();
  } else if (value is Set) {
    return value.map(_makeValueEncodable).toSet();
  } else if (value is Map) {
    return value.makeEncodable;
  } else {
    return value.toString();
  }
}

extension FHUMapExtension<K, V> on Map<K, V> {
  /// Converts a map with dynamic keys and values to a map with string keys and JSON-encodable values.
  ///
  /// This function is useful for serializing maps to a format compatible with JSON serialization.
  /// It ensures that all keys are strings and that all values are in a form that can be
  /// encoded into JSON. Complex objects and types are processed recursively to make them encodable.
  ///
  /// [inputMap] is the map with dynamic keys and values that needs to be converted.
  ///
  /// Returns a new map where all keys are strings and all values are JSON-encodable.
  ///
  /// Example:
  /// ```dart
  /// var originalMap = {123: 'value', 'key': {'innerKey': DateTime.now()}};
  /// var encodableMap = makeMapEncodable(originalMap);
  /// // encodableMap is now {'123': 'value', 'key': {'innerKey': '2021-08-01T12:00:00'}}
  /// ```
  Map<String, dynamic> get makeEncodable {
    final result = <String, dynamic>{};
    forEach((key, value) {
      result[key.toString()] = _makeValueEncodable(value);
    });
    return result;
  }

  /// Converts a map with potentially complex data types to a formatted JSON string.
  ///
  /// This function utilizes `makeMapEncodable` to prepare the map for JSON encoding,
  /// ensuring compatibility with JSON standards, especially for non-primitive types like enums
  /// or DateTime. It then uses `JsonEncoder.withIndent` to convert the map to a
  /// human-readable JSON string with proper indentation.
  ///
  /// Example:
  /// ```dart
  /// Map<dynamic, dynamic> yourMap = {
  ///   'id': 1,
  ///   'name': 'Flutter Helper',
  ///   'isActive': true,
  ///   'registeredDate': DateTime(2024, 01, 06),
  ///   'category': Category.mobile // Assuming Category is an enum.
  /// };
  ///
  /// String jsonOutput = yourMap.formattedJsonString;
  /// print(jsonOutput);
  /// ```
  ///
  /// Sample Output:
  /// ```json
  /// {
  ///   "id": 1,
  ///   "name": "Flutter Helper",
  ///   "isActive": true,
  ///   "registeredDate": "2024-01-06T00:00:00",
  ///   "category": "mobile"
  /// }
  /// ```
  ///
  /// Parameters:
  ///   [map] - A Map with dynamic keys and values, potentially containing complex data types.
  ///
  /// Returns:
  ///   A string representing the formatted JSON.
  String get safelyEncodedJson =>
      const JsonEncoder.withIndent('  ').convert(makeEncodable);
}

extension FHUMapNullableExtension<K, V> on Map<K, V>? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;

  bool get isNotEmptyOrNull => !isEmptyOrNull;

  bool isEqual(Map<K, V>? other) => mapEquals(this, other);
}

extension FHUMapExt<K extends String, V> on Map<K, V> {
  /// Flatten a nested Map into a single level map
  ///
  /// If you don't want to flatten arrays (with 0, 1,... indexes),
  /// use [safe] mode.
  ///
  /// To avoid circular reference issues or huge calculations,
  /// you can specify the [maxDepth] the function will traverse.
  Map<String, dynamic> flatJson({
    String delimiter = '.',
    bool safe = false,
    int? maxDepth,
  }) {
    final result = <String, dynamic>{};
    void step(
      Map<String, dynamic> obj, [
      String? previousKey,
      int currentDepth = 1,
    ]) {
      obj.forEach((key, value) {
        final newKey = previousKey != null ? '$previousKey$delimiter$key' : key;

        if (maxDepth != null && currentDepth >= maxDepth) {
          result[newKey] = value;
          return;
        }

        if (value is Map<String, dynamic>) {
          return step(value, newKey, currentDepth + 1);
        }
        if (value is List && !safe) {
          return step(
            _listToMap(value as List<Object>),
            newKey,
            currentDepth + 1,
          );
        }
        result[newKey] = value;
      });
    }

    step(this);

    return result;
  }

  Map<String, T> _listToMap<T>(List<T> list) =>
      list.asMap().map((key, value) => MapEntry(key.toString(), value));
}
