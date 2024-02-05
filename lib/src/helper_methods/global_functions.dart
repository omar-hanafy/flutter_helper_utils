import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_helper_utils/src/exceptions/exceptions.dart';

/// Converts any object to a string if the object is not `null`.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final string1 = toString1(object1); // 'Hello'
///
/// final object2 = 10;
/// final string2 = toString1(object2); // '10'
///
/// final object3 = true;
/// final string3 = toString1(object3); // 'true'
///
/// final object4 = null;
/// final string4 = toString1(object4); // throws ParsingException
/// ```
String toString1(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toString1(object, mapKey: mapKey, listIndex: listIndex);

/// Converts any object to a string, or returns `null` if the object is `null`.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final string1 = tryToString(object1); // 'Hello'
///
/// final object2 = 10;
/// final string2 = tryToString(object2); // '10'
///
/// final object3 = true;
/// final string3 = tryToString(object3); // 'true'
///
/// final object4 = null;
/// final string4 = tryToString(object4); // null
/// ```
String? tryToString(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToString(object, mapKey: mapKey, listIndex: listIndex);

/// Converts an object to a [num].
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final num1 = toNum(object1); // 10
///
/// final object2 = '5.5';
/// final num2 = toNum(object2); // 5.5
///
/// final object3 = true;
/// final num3 = toNum(object3); // 1
///
/// final object4 = 'abc';
/// final num4 = toNum(object4); // throws ParsingException
///
/// final object5 = null;
/// final num5 = toNum(object5); // throws ParsingException
/// ```
num toNum(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toNum(object, mapKey: mapKey, listIndex: listIndex);

/// Attempts to convert an object to a [num], or returns `null` if the object is `null` or conversion fails.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final num1 = tryToNum(object1); // 10
///
/// final object2 = '5.5';
/// final num2 = tryToNum(object2); // 5.5
///
/// final object3 = true;
/// final num3 = tryToNum(object3); // 1
///
/// final object4 = 'abc';
/// final num4 = tryToNum(object4); // null
///
/// final object5 = null;
/// final num5 = tryToNum(object5); // null
/// ```
num? tryToNum(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToNum(object, mapKey: mapKey, listIndex: listIndex);

/// Converts an object to an [int].
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final int1 = toInt(object1); // 10
///
/// final object2 = '5';
/// final int2 = toInt(object2); // 5
///
/// final object3 = true;
/// final int3 = toInt(object3); // 1
///
/// final object4 = 'abc';
/// final int4 = toInt(object4); // throws ParsingException
/// ```
int toInt(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toInt(object, mapKey: mapKey, listIndex: listIndex);

/// Attempts to convert an object to an [int], or returns `null` if the object is `null` or conversion fails.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final int1 = tryToInt(object1); // 10
///
/// final object2 = '5';
/// final int2 = tryToInt(object2); // 5
///
/// final object3 = true;
/// final int3 = tryToInt(object3); // 1
///
/// final object4 = 'abc';
/// final int4 = tryToInt(object4); // null
///
/// final object5 = null;
/// final int5 = tryToInt(object5); // null
/// ```
int? tryToInt(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToInt(object, mapKey: mapKey, listIndex: listIndex);

/// Converts an object to a [BigInt].
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final bigInt1 = toBigInt(object1); // BigInt.from(10)
///
/// final object2 = '1234567890';
/// final bigInt2 = toBigInt(object2); // BigInt.from(1234567890)
///
/// final object3 = 'abc';
/// final bigInt3 = toBigInt(object3); // throws ParsingException
///
/// final object4 = null;
/// final bigInt4 = toBigInt(object4); // throws ParsingException
/// ```
BigInt toBigInt(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toBigInt(object, mapKey: mapKey, listIndex: listIndex);

/// Attempts to convert an object to a [BigInt], or returns `null` if the object is `null` or conversion fails.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final bigInt1 = tryToBigInt(object1); // BigInt.from(10)
///
/// final object2 = '1234567890';
/// final bigInt2 = tryToBigInt(object2); // BigInt.from(1234567890)
///
/// final object3 = 'abc';
/// final bigInt3 = tryToBigInt(object3); // null
///
/// final object4 = null;
/// final bigInt4 = tryToBigInt(object4); // null
/// ```
BigInt? tryToBigInt(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToBigInt(object, mapKey: mapKey, listIndex: listIndex);

/// Converts an object to a [double].
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final double1 = toDouble(object1); // 5.5
///
/// final object2 = '3.14';
/// final double2 = toDouble(object2); // 3.14
///
/// final object3 = true;
/// final double3 = toDouble(object3); // 1.0
///
/// final object4 = 'abc';
/// final double4 = toDouble(object4); // throws ParsingException
/// ```
double toDouble(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toDouble(object, mapKey: mapKey, listIndex: listIndex);

/// Attempts to convert an object to a [double], or returns `null` if the object is `null` or conversion fails.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final double1 = tryToDouble(object1); // 5.5
///
/// final object2 = '3.14';
/// final double2 = tryToDouble(object2); // 3.14
///
/// final object3 = true;
/// final double3 = tryToDouble(object3); // 1.0
///
/// final object4 = 'abc';
/// final double4 = tryToDouble(object4); // null
///
/// final object5 = null;
/// final double5 = tryToDouble(object5); // null
/// ```
double? tryToDouble(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToDouble(object, mapKey: mapKey, listIndex: listIndex);

/// Converts an object to a `bool`.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final bool1 = toBool(object1); // true
///
/// final object2 = 'yes';
/// final bool2 = toBool(object2); // true
///
/// final object3 = 10;
/// final bool3 = toBool(object3); // true
///
/// final object4 = false;
/// final bool4 = toBool(object4); // false
///
/// final object5 = 'no';
/// final bool5 = toBool(object5); // false
///
/// final object6 = null;
/// final bool6 = toBool(object6); // false
/// ```
bool toBool(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toBool(object, mapKey: mapKey, listIndex: listIndex);

/// Attempts to convert an object to a `bool`, or returns `null` if the object is `null` or conversion is not applicable.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final bool1 = tryToBool(object1); // true
///
/// final object2 = 'yes';
/// final bool2 = tryToBool(object2); // true
///
/// final object3 = 10;
/// final bool3 = tryToBool(object3); // null
///
/// final object4 = false;
/// final bool4 = tryToBool(object4); // false
///
/// final object5 = 'no';
/// final bool5 = tryToBool(object5); // false
///
/// final object6 = null;
/// final bool6 = tryToBool(object6); // null
/// ```
bool? tryToBool(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToBool(object, mapKey: mapKey, listIndex: listIndex);

/// Attempts to convert an object to a `bool`, or returns `null` if the object is `null` or conversion is not applicable.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final bool1 = tryToBool(object1); // true
///
/// final object2 = 'yes';
/// final bool2 = tryToBool(object2); // true
///
/// final object3 = 10;
/// final bool3 = tryToBool(object3); // null
///
/// final object4 = false;
/// final bool4 = tryToBool(object4); // false
///
/// final object5 = 'no';
/// final bool5 = tryToBool(object5); // false
///
/// final object6 = null;
/// final bool6 = tryToBool(object6); // null
/// ```
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

/// Attempts to convert an object to a [DateTime], or returns `null` if the object is `null` or conversion fails.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final dateTime1 = tryToDateTime(object1); // 2023-06-26 12:00:00.000Z
///
/// final object2 = DateTime(2023, 6, 26, 12, 0, 0);
/// final dateTime2 = tryToDateTime(object2); // 2023-06-26 12:00:00.000
///
/// final object3 = 'Invalid DateTime';
/// final dateTime3 = tryToDateTime(object3); // null (logs an error)
///
/// final object4 = null;
/// final dateTime4 = tryToDateTime(object4); // null
/// ```
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

/// Converts an object to a [Uri].
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final uri1 = toUri(object1); // Uri.parse('https://www.example.com')
///
/// final object2 = 'invalid_uri';
/// final uri2 = toUri(object2); // throws ParsingException
///
/// final object3 = null;
/// final uri3 = toUri(object3); // throws ParsingException
/// ```
Uri toUri(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toUri(
      object,
      mapKey: mapKey,
      listIndex: listIndex,
    );

/// Attempts to convert an object to a [Uri], or returns `null` if the object is `null` or conversion fails.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final uri1 = tryToUri(object1); // Uri.parse('https://www.example.com')
///
/// final object2 = 'invalid_uri';
/// final uri2 = tryToUri(object2); // null (logs an error)
///
/// final object3 = null;
/// final uri3 = tryToUri(object3); // null
/// ```
Uri? tryToUri(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToUri(
      object,
      mapKey: mapKey,
      listIndex: listIndex,
    );

/// Converts an object to a [Map] with keys of type `K` and values of type `V`.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final map1 = toMap<String, String>(object1); // {'key1': 'value1', 'key2': 'value2'}
///
/// final object2 = {'key1': 1, 'key2': 2};
/// final map2 = toMap<String, int>(object2); // {'key1': 1, 'key2': 2'}
///
/// final object3 = 'Hello';
/// final map3 = toMap<String, int>(object3); // ParsingException (logs an error)
///
/// final object4 = null;
/// final map4 = toMap<String, int>(object4); // ParsingException (null object)
/// ```
Map<K, V> toMap<K, V>(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toMap(object, mapKey: mapKey, listIndex: listIndex);

/// Attempts to convert an object to a [Map] with keys of type `K` and values of type `V`.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final map1 = tryToMap<String, String>(object1); // {'key1': 'value1', 'key2': 'value2'}
///
/// final object2 = {'key1': 1, 'key2': 2};
/// final map2 = tryToMap<String, int>(object2); // {'key1': 1, 'key2': 2}
///
/// final object3 = 'Hello';
/// final map3 = tryToMap<String, int>(object3); // null (logs an error)
///
/// final object4 = null;
/// final map4 = tryToMap<String, int>(object4); // null
/// ```
Map<K, V>? tryToMap<K, V>(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToMap(object, mapKey: mapKey, listIndex: listIndex);

/// Converts an object to a [Set] of type `T`.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final set1 = toSet<int>(object1); // {1, 2, 3}
///
/// final object2 = [1, 2, 3];
/// final set2 = toSet<int>(object2); // {1, 2, 3}
///
/// final object3 = 'Hello';
/// final set3 = toSet<int>(object3); // ParsingException (logs an error)
///
/// final object4 = null;
/// final set4 = toSet<int>(object4); // ParsingException (null object)
/// ```
Set<T> toSet<T>(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toSet(object, mapKey: mapKey, listIndex: listIndex);

/// Attempts to convert an object to a [Set] of type `T`, or returns null if conversion is not possible.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final set1 = tryToSet<int>(object1); // {1, 2, 3}
///
/// final object2 = [1, 2, 3];
/// final set2 = tryToSet<int>(object2); // {1, 2, 3}
///
/// final object3 = 'Hello';
/// final set3 = tryToSet<int>(object3); // null (logs an error)
///
/// final object4 = null;
/// final set4 = tryToSet<int>(object4); // null
/// ```
Set<T>? tryToSet<T>(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.tryToSet(object, mapKey: mapKey, listIndex: listIndex);

/// Converts an object to a [List] of type `T`.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final list1 = toList<int>(object1); // [1, 2, 3]
///
/// final object2 = 42;
/// final list2 = toList<int>(object2); // [42]
///
/// final object3 = {'a': 1, 'b': 2};
/// final list3 = toList<int>(object3); // [1, 2]
///
/// final object4 = {'a': [1, 2], 'b': [3, 4]};
/// final list4 = toList<int>(object4, mapKey: 'a'); // [1, 2]
///
/// final object5 = [[1, 2], [3, 4]];
/// final list5 = toList<int>(object5, listIndex: 0); // [1, 3]
///
/// final object6 = 'Hello';
/// final list6 = toList<int>(object6); // throws ParsingException
/// ```
List<T> toList<T>(
  dynamic object, {
  Object? mapKey,
  int? listIndex,
}) =>
    ConvertObject.toList(object, mapKey: mapKey, listIndex: listIndex);

/// Attempts to convert an object to a [List] of type `T`, or returns `null` if conversion is not possible.
/// mirroring the same static method in the [ConvertObject], providing alternative easy less code usage options.
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
/// final list1 = tryToList<int>(object1); // [1, 2, 3]
///
/// final object2 = 42;
/// final list2 = tryToList<int>(object2); // [42]
///
/// final object3 = {'a': 1, 'b': 2};
/// final list3 = tryToList<int>(object3); // [1, 2]
///
/// final object4 = {'a': [1, 2], 'b': [3, 4]};
/// final list4 = tryToList<int>(object4, mapKey: 'a'); // [1, 2]
///
/// final object5 = [[1, 2], [3, 4]];
/// final list5 = tryToList<int>(object5, listIndex: 0); // [1, 3]
///
/// final object6 = 'Hello';
/// final list6 = tryToList<int>(object6); // null (logs an error)
///
/// final object7 = null;
/// final list7 = tryToList<int>(object7); // null
/// ```
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
    error:
        'Unsupported type detected. Please ensure that the type you are attempting to convert to is either a primitive type or a valid data type: $T.',
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
      parsingInfo: 'tryToType',
      stackTrace: s,
    );
  }
  throw ParsingException(
    error: 'Unsupported type: $T',
    parsingInfo: 'tryToType',
  );
}

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
Map<String, dynamic> makeMapEncodable(Map<dynamic, dynamic> inputMap) {
  final result = <String, dynamic>{};
  inputMap.forEach((key, value) {
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
/// String jsonOutput = formattedJsonString(yourMap);
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
String formattedJsonString(Map<dynamic, dynamic> map) =>
    const JsonEncoder.withIndent('  ').convert(makeMapEncodable(map));

/// Determines whether a given value is of a primitive type for JSON serialization.
///
/// This function checks if the provided [value] is a type that can be directly
/// serialized into JSON. The types considered as primitives for this purpose are:
/// `num` (which includes both `int` and `double`), `bool`, `String`, `BigInt`,
/// `DateTime`, and `Uint8List`. Additionally, collections (lists, sets) exclusively
/// containing primitives are also considered primitive.
///
/// Returns `true` if [value] is a primitive type or a collection of primitives, and
/// `false` otherwise.
///
/// Example:
/// ```dart
/// bool isNumPrimitive = isPrimitiveType(10); // true
/// bool isStringPrimitive = isPrimitiveType('Hello'); // true
/// bool isComplexObjectPrimitive = isPrimitiveType(MyCustomClass()); // false
/// ```
bool isPrimitiveType(dynamic value) {
  return value is num || // Includes both int and double
      value is bool ||
      value is String ||
      value is BigInt ||
      value is DateTime ||
      value is Uint8List ||
      _isCollectionOfPrimitives(value);
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

bool _isCollectionOfPrimitives(dynamic value) {
  if (value is List) return value.every(isPrimitiveType);
  if (value is Set) return value.every(isPrimitiveType);
  if (value is Map) {
    return value.keys.every(isPrimitiveType) &&
        value.values.every(isPrimitiveType);
  }
  return false;
}

bool isEqual<T>(T value1, T value2) {
  if (value1 is List && value2 is List) return value1.isEqual(value2);
  if (value1 is Set && value2 is Set) return value1.isEqual(value2);
  if (value1 is Map && value2 is Map) return value1.isEqual(value2);
  return value1 == value2;
}
