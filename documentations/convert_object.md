## ConvertObject in `flutter_helper_utils`

## Why Use ConvertObject?

When dealing with data from APIs, we frequently encounter `Map<String, Dynamic>` types. Parsing these dynamic types into your models can often result in type casting issues. The `ConvertObject` class alleviates these issues, offering simple methods to perform accurate type conversions.

## Examples

### Converting to Integer

You can convert a `double` price value from an API response to an `int`.

```dart
int price = ConvertObject.toInt(map['price']);
```

### Converting to List

Easily convert a list of integers to a list of strings.

```dart
final strList = ConvertObject.toList<String>(map['score']);
```

### Using Global Variables

For even more simplified usage, you can use global variables defined in `convert_types_global.dart`.

```dart
int price = toInt(map['price']);
final strList = toList<String>(map['score']);
```

### Using `toType` and `tryToType` Global Variables

`toType` and `tryToType` are also available as global variables. They offer the same functionality but with global scope.

```dart
// Using toType
final myString = toType<String>(map['score']);

// Using tryToType
String? myStringNullable = tryToType<String>(map['score']);
```

## NOTES:

## Global Variables

The package allows the use of global variables for these conversions. If there's a naming conflict with your existing code, you can always revert to using `ConvertObject` explicitly.

## `toType` and `tryToType` Functionality

The global variables `toType` and `tryToType` serve to add even more flexibility. While `toType` performs the conversion and throws an exception if it fails, `tryToType` attempts the conversion and returns `null` if unsuccessful.

Here is a list of all supported conversions in the `ConvertObject` class:

| Method Name                                                                      | Description                                                                                                           |
|----------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `toString1(dynamic object, {Object? mapKey, int? listIndex}) => String`          | Converts dynamic data to a `String` if the object is not null. Throws a `ParsingException` if the object is null.     |
| `tryToString(dynamic object, {Object? mapKey, int? listIndex}) => String?`       | Converts dynamic data to a `String` or returns null if the object is null.                                            |
| `toNum(dynamic object, {Object? mapKey, int? listIndex}) => num`                 | Converts dynamic data to a `num`. Throws a `ParsingException` if the object is null or if the conversion fails.       |
| `tryToNum(dynamic object, {Object? mapKey, int? listIndex}) => num?`             | Converts dynamic data to a `num` or returns null if the object is null or if the conversion fails.                    |
| `toInt(dynamic object, {Object? mapKey, int? listIndex}) => int`                 | Converts dynamic data to an `int`. Throws a `ParsingException` if the object is null or if the conversion fails.      |
| `tryToInt(dynamic object, {Object? mapKey, int? listIndex}) => int?`             | Converts dynamic data to an `int` or returns null if the object is null or if the conversion fails.                   |
| `toDouble(dynamic object, {Object? mapKey, int? listIndex}) => double`           | Converts dynamic data to a `double`. Throws a `ParsingException` if the object is null or if the conversion fails.    |
| `tryToDouble(dynamic object, {Object? mapKey, int? listIndex}) => double?`       | Converts dynamic data to a `double` or returns null if the object is null or if the conversion fails.                 |
| `toBool(dynamic object, {Object? mapKey, int? listIndex}) => bool`               | Converts dynamic data to a `bool`. Returns `false` by default.                                                        |
| `tryToBool(dynamic object, {Object? mapKey, int? listIndex}) => bool?`           | Converts dynamic data to a `bool` or returns null if the conversion fails. Returns `false` by default.                |
| `toDateTime(dynamic object, {Object? mapKey, int? listIndex}) => DateTime`       | Converts dynamic data to a `DateTime`. Throws a `ParsingException` if the object is null or if the conversion fails.  |
| `tryToDateTime(dynamic object, {Object? mapKey, int? listIndex}) => DateTime?`   | Converts dynamic data to a `DateTime` or returns null if the object is null or if the conversion fails.               |
| `toMap<K, V>(dynamic object, {Object? mapKey, int? listIndex}) => Map<K, V>`     | Converts dynamic data to a `Map<K, V>`. Throws a `ParsingException` if the object is null or if the conversion fails. |
| `tryToMap<K, V>(dynamic object, {Object? mapKey, int? listIndex}) => Map<K, V>?` | Converts dynamic data to a `Map<K, V>` or returns null if the object is null or if the conversion fails.              |
| `toSet<T>(dynamic object, {Object? mapKey, int? listIndex}) => Set<T>`           | Converts dynamic data to a `Set<T>`. Throws a `ParsingException` if the object is null or if the conversion fails.    |
| `tryToSet<T>(dynamic object, {Object? mapKey, int? listIndex}) => Set<T>?`       | Converts dynamic data to a `Set<T>` or returns null if the object is null or if the conversion fails.                 |
| `toList<T>(dynamic object, {Object? mapKey, int? listIndex}) => List<T>`         | Converts dynamic data to a `List<T>`. Throws a `ParsingException` if the object is null or if the conversion fails.   |
| `tryToList<T>(dynamic object, {Object? mapKey, int? listIndex}) => List<T>?`     | Converts dynamic data to a `List<T>` or returns null if the object is null or if the conversion fails.                |
