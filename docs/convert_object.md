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
