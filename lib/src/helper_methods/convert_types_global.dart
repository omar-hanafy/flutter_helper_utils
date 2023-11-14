import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_helper_utils/src/exceptions/exceptions.dart';

String toString1(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toString1(object, mapKey: mapKey, listIndex: listIndex);

String? tryToString(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToString(object, mapKey: mapKey, listIndex: listIndex);

num toNum(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toNum(object, mapKey: mapKey, listIndex: listIndex);

num? tryToNum(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToNum(object, mapKey: mapKey, listIndex: listIndex);

int toInt(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toInt(object, mapKey: mapKey, listIndex: listIndex);

int? tryToInt(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToInt(object, mapKey: mapKey, listIndex: listIndex);

BigInt toBigInt(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toBigInt(object, mapKey: mapKey, listIndex: listIndex);

BigInt? tryToBigInt(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToBigInt(object, mapKey: mapKey, listIndex: listIndex);

double toDouble(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toDouble(object, mapKey: mapKey, listIndex: listIndex);

double? tryToDouble(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToDouble(object, mapKey: mapKey, listIndex: listIndex);

bool toBool(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toBool(object, mapKey: mapKey, listIndex: listIndex);

bool? tryToBool(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToBool(object, mapKey: mapKey, listIndex: listIndex);

DateTime toDateTime(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
  String? format,
}) =>
    ConvertObject.toDateTime(
      object,
      mapKey: mapKey,
      listIndex: listIndex,
      format: format,
    );

DateTime? tryToDateTime(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
  String? format,
}) =>
    ConvertObject.tryToDateTime(
      object,
      mapKey: mapKey,
      listIndex: listIndex,
      format: format,
    );

Map<K, V> toMap<K, V>(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toMap(object, mapKey: mapKey, listIndex: listIndex);

Map<K, V>? tryToMap<K, V>(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToMap(object, mapKey: mapKey, listIndex: listIndex);

Set<T> toSet<T>(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toSet(object, mapKey: mapKey, listIndex: listIndex);

Set<T>? tryToSet<T>(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToSet(object, mapKey: mapKey, listIndex: listIndex);

List<T> toList<T>(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toList(object, mapKey: mapKey, listIndex: listIndex);

List<T>? tryToList<T>(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToList(object, mapKey: mapKey, listIndex: listIndex);

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

Map<String, dynamic> makeMapEncodable(Map<dynamic, dynamic> inputMap) {
  final result = <String, dynamic>{};
  inputMap.forEach((key, value) {
    result[key.toString()] = _makeValueEncodable(value);
  });
  return result;
}

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
    return makeMapEncodable(value);
  } else {
    return value.toString();
  }
}
