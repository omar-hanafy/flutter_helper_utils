// ignore_for_file: avoid_private_typedef_functions

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

/// A callback function that converts an element to a [Color].
typedef ColorConverter = Color? Function(Object? element);

/// A utility class for converting objects to Flutter-specific types like [Color].
///
/// This class follows the same pattern as [ConvertObject] from dart_helper_utils,
/// providing seamless integration for Flutter developers familiar with DHU.
/// since we cannot inject this directly into dart_helper_utils package, because dart_helper_utils are meant for pure dart only, we had to do it this way.
abstract class FConvertObject {
  /// Converts an object to a [Color].
  ///
  /// This method handles conversion from:
  /// - [String]: Uses the robust `toColor` extension, supporting hex, rgb, hsl, hwb, and named colors.
  /// - [int]: Interprets the integer as an ARGB value (e.g., `0xFFRRGGBB`).
  /// - [Color]: Returns the color directly (including MaterialColor, etc.).
  /// - [HSLColor] / [HSVColor]: Converts to RGB Color.
  ///
  /// For nested data structures, use [mapKey] or [listIndex] to navigate:
  /// ```dart
  /// // From map
  /// final color = FConvertObject.toColor(
  ///   {'primary': '#FF0000'},
  ///   mapKey: 'primary',
  /// );
  ///
  /// // From list
  /// final color = FConvertObject.toColor(
  ///   ['#FF0000', '#00FF00', '#0000FF'],
  ///   listIndex: 1, // Gets green
  /// );
  /// ```
  ///
  /// Throws a [ParsingException] if the object is `null` or cannot be converted.
  static Color toColor(
    Object? object, {
    Object? mapKey,
    int? listIndex,
    Color? defaultValue,
    ColorConverter? converter,
  }) {
    // Extract nested object if keys/indexes are provided
    final targetObject = _extractNestedObject(object, mapKey, listIndex);

    // Convert to color
    final data = (targetObject is Color)
        ? targetObject
        : converter?.call(targetObject) ?? _defaultColorConverter(targetObject);

    if (data == null) {
      if (defaultValue != null) return defaultValue;
      throw ParsingException.nullObject(
        parsingInfo: 'toColor',
        stackTrace: StackTrace.current,
      );
    }
    return data;
  }

  /// Attempts to convert an object to a [Color], returning `null` on failure.
  ///
  /// This method handles the same conversions as [toColor] but returns `null`
  /// instead of throwing exceptions.
  ///
  /// ```dart
  /// // Safe conversion with fallback
  /// final color = FConvertObject.tryToColor(userInput) ?? Colors.blue;
  ///
  /// // From nested structure
  /// final color = FConvertObject.tryToColor(
  ///   json['theme'],
  ///   mapKey: 'primaryColor',
  /// );
  /// ```
  ///
  /// Returns `null` if the object is `null` or the conversion fails.
  static Color? tryToColor(
    Object? object, {
    Object? mapKey,
    int? listIndex,
    Color? defaultValue,
    ColorConverter? converter,
  }) {
    // Extract nested object if keys/indexes are provided
    final targetObject = _extractNestedObject(object, mapKey, listIndex);

    return (targetObject is Color)
        ? targetObject
        : converter?.call(targetObject) ??
            _defaultColorConverter(targetObject) ??
            defaultValue;
  }

  /// Helper to extract nested objects from maps/lists
  static Object? _extractNestedObject(
    Object? object,
    Object? mapKey,
    int? listIndex,
  ) {
    if (object == null) return null;

    Object? target = object;

    // Navigate through map if key provided
    if (mapKey != null && target is Map) {
      target = target[mapKey];
    }

    // Navigate through list if index provided
    if (listIndex != null && target is List) {
      if (listIndex >= 0 && listIndex < target.length) {
        target = target[listIndex];
      } else {
        return null;
      }
    }

    return target;
  }

  /// Default color converter that handles multiple input types by prioritizing direct
  /// type conversion and delegating the rest to the robust string parser.
  static Color? _defaultColorConverter(Object? obj) {
    if (obj == null) return null;

    // 1. Handle direct Color types
    if (obj is Color) return obj;
    if (obj is HSLColor) return obj.toColor();
    if (obj is HSVColor) return obj.toColor();

    // 2. Handle integer ARGB values
    if (obj is int) return Color(obj);

    // 3. Handle numeric strings that represent ARGB values
    if (obj is String) {
      // Don't try to parse hex strings as integers - let the string parser handle them
      final trimmed = obj.trim();
      if (!trimmed.startsWith('#') && !trimmed.toLowerCase().startsWith('0x')) {
        // Try to parse as integer first (for cases like "4294901760")
        final intValue = int.tryParse(trimmed);
        if (intValue != null) {
          return Color(intValue);
        }
      }
    }

    // 4. For EVERYTHING ELSE, trust the string parser.
    // This is simpler and more robust. It correctly handles hex, named colors,
    // rgb(...), hsl(...), hwb(...), etc.
    return obj.toString().toColor;
  }
}

// --- Top-Level Convenience Functions ---

/// Converts an object to a [Color]. See [FConvertObject.toColor] for details.
Color toColor(
  Object? object, {
  Object? mapKey,
  int? listIndex,
  Color? defaultValue,
  ColorConverter? converter,
}) =>
    FConvertObject.toColor(
      object,
      mapKey: mapKey,
      listIndex: listIndex,
      defaultValue: defaultValue,
      converter: converter,
    );

/// Attempts to convert an object to a [Color]. See [FConvertObject.tryToColor] for details.
Color? tryToColor(
  Object? object, {
  Object? mapKey,
  int? listIndex,
  Color? defaultValue,
  ColorConverter? converter,
}) =>
    FConvertObject.tryToColor(
      object,
      mapKey: mapKey,
      listIndex: listIndex,
      defaultValue: defaultValue,
      converter: converter,
    );

// --- Extensions for Maps ---

/// Extension methods for Maps to provide easy access to Flutter-specific type conversions.
extension FHUConvertMapEx<K, V> on Map<K, V> {
  /// Retrieves a value by [key] (or [alternativeKeys]) and converts it to a [Color].
  /// Throws a [ParsingException] if the value is null or conversion fails.
  Color getColor(
    K key, {
    List<K>? alternativeKeys,
    Object? innerMapKey,
    int? innerListIndex,
    Color? defaultValue,
    ColorConverter? converter,
  }) =>
      FConvertObject.toColor(
        firstValueForKeys(key, alternativeKeys: alternativeKeys),
        mapKey: innerMapKey,
        listIndex: innerListIndex,
        defaultValue: defaultValue,
        converter: converter,
      );

  /// Attempts to retrieve a value by [key] (or [alternativeKeys]) and convert it to a [Color].
  /// Returns `null` if the key doesn't exist or if the conversion fails.
  Color? tryGetColor(
    K key, {
    List<K>? alternativeKeys,
    Object? innerMapKey,
    int? innerListIndex,
    Color? defaultValue,
    ColorConverter? converter,
  }) =>
      FConvertObject.tryToColor(
        firstValueForKeys(key, alternativeKeys: alternativeKeys),
        mapKey: innerMapKey,
        listIndex: innerListIndex,
        defaultValue: defaultValue,
        converter: converter,
      );
}

/// Extension methods for nullable Maps.
extension FHUConvertMapNEx<K, V> on Map<K, V>? {
  /// Attempts to retrieve a value by [key] (or [alternativeKeys]) and convert it to a [Color].
  /// Returns `null` if the map is null, key doesn't exist, or conversion fails.
  Color? tryGetColor(
    K key, {
    List<K>? alternativeKeys,
    Object? innerMapKey,
    int? innerListIndex,
    Color? defaultValue,
    ColorConverter? converter,
  }) =>
      FConvertObject.tryToColor(
        this?.firstValueForKeys(key, alternativeKeys: alternativeKeys),
        mapKey: innerMapKey,
        listIndex: innerListIndex,
        defaultValue: defaultValue,
        converter: converter,
      );
}

// --- Extensions for Iterables ---

/// Extension methods for Iterables to provide easy access to Flutter-specific type conversions.
extension FHUConvertIterableEx<E> on Iterable<E> {
  /// Retrieves an element by [index] and converts it to a [Color].
  /// Throws a [ParsingException] if the element is null or conversion fails.
  Color getColor(
    int index, {
    Object? innerMapKey,
    int? innerListIndex,
    Color? defaultValue,
    ColorConverter? converter,
  }) =>
      FConvertObject.toColor(
        elementAt(index),
        mapKey: innerMapKey,
        listIndex: innerListIndex,
        defaultValue: defaultValue,
        converter: converter,
      );

  /// Attempts to retrieve an element by [index] and convert it to a [Color].
  /// Returns `null` if the index is out of bounds or if the conversion fails.
  Color? tryGetColor(
    int index, {
    Object? innerMapKey,
    int? innerListIndex,
    Color? defaultValue,
    ColorConverter? converter,
  }) {
    try {
      return FConvertObject.tryToColor(
        elementAt(index),
        mapKey: innerMapKey,
        listIndex: innerListIndex,
        defaultValue: defaultValue,
        converter: converter,
      );
    } catch (_) {
      return defaultValue;
    }
  }
}

/// Extension methods for nullable Iterables.
extension FHUConvertIterableNEx<E> on Iterable<E>? {
  /// Attempts to retrieve an element by [index] (or [alternativeIndices]) and convert it to a [Color].
  /// Returns `null` if the iterable is null, index is out of bounds, or conversion fails.
  Color? tryGetColor(
    int index, {
    List<int>? alternativeIndices,
    Object? innerMapKey,
    int? innerListIndex,
    Color? defaultValue,
    ColorConverter? converter,
  }) =>
      FConvertObject.tryToColor(
        this?.firstElementForIndices(index,
            alternativeIndices: alternativeIndices),
        mapKey: innerMapKey,
        listIndex: innerListIndex,
        defaultValue: defaultValue,
        converter: converter,
      );
}
