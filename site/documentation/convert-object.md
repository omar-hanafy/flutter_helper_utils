---
title: Converting Objects
---

# Converting Objects

The `ConvertObject` class and the global methods help you convert objects between different types easily and reliably. They are handy when working with data from APIs, where you often encounter dynamic types. They offer simple and flexible methods to perform accurate type conversions.

## ConvertObject Methods

The `ConvertObject` class provides a set of static methods to convert objects to various types, such as `int`, `double`, `bool`, `String`, `List`, `Set` and `Map`. Each method takes an object as the first parameter, and returns the converted value of the desired type. If the conversion fails, an exception is thrown.

The methods are:

- `ConvertObject.toInt(dynamic)` or `tryToInt`
- `ConvertObject.toDouble(dynamic)` or `tryToDouble`
- `ConvertObject.toBool(dynamic)` or `tryToBool`
- `ConvertObject.toString1(dynamic)` or `tryToString1`
- `ConvertObject.toList<T>(dynamic)` or `tryToList`
- `ConvertObject.toSet<T>(dynamic)` or `tryToSet`
- `ConvertObject.toMap<K, V>(dynamic)` or `tryToMap`

## Global Methods

For even more simplified usage, you can use global methods which uses the `ConvertObject`'s static methods under the hood.

```dart
int price = toInt(map['price']);
final strList = toList<String>(map['score']);
```

**NOTE:** if you already have a method named `toList` in your code, it might conflict with our global one and Using the `ConvertObject.toList` method within your code should help avoid such naming conflicts.

## Optional Parameters

Each method accepts two optional parameters: `listIndex` and `mapKey`. These parameters allow you to extract and convert specific values within a `List` or a `Map` object, respectively. For example, if you have a list of strings representing numbers, you can use the `listIndex` parameter to convert a particular element to an integer:

```dart
dynamic dynamic1 = ['10', '20', '30'];
final int number = toInt(dynamic1, listIndex: 1); // 20
```

Similarly, if you have a map of strings representing different types of values, you can use the `mapKey` parameter to convert a particular value to a boolean:

```dart
dynamic dynamic2 = { 'name': 'John',
	                   'age': '30',
  	                 'isHuman': 'yes',
                  };
final bool isHuman = toBool(dynamic2, mapKey: 'isHuman'); // true
```
