---
title: Converting Objects
---

# Converting Objects

The main Flutter Helper Utils import re-exports `convert_object` through
`dart_helper_utils`. Use `Convert` for static conversions, `Converter` for
fluent navigation, or the `convertToX` top-level functions.

```dart
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

final Map<String, Object?> data = {
  'price': '42',
  'scores': <String>['10', '20'],
};

final int price = Convert.toInt(data, mapKey: 'price'); // 42
final List<int> scores = convertToList<int>(data['scores']); // [10, 20]
final String label = Convert.string(price); // '42'
```

## Entry points

| Result | Static API | Top-level API |
| --- | --- | --- |
| `int` | `Convert.toInt(value)` | `convertToInt(value)` |
| `double` | `Convert.toDouble(value)` | `convertToDouble(value)` |
| `bool` | `Convert.toBool(value)` | `convertToBool(value)` |
| `String` | `Convert.string(value)` | `convertToString(value)` |
| `List<T>` | `Convert.toList<T>(value)` | `convertToList<T>(value)` |
| `Set<T>` | `Convert.toSet<T>(value)` | `convertToSet<T>(value)` |
| `Map<K, V>` | `Convert.toMap<K, V>(value)` | `convertToMap<K, V>(value)` |

The `.convert` extension wraps a value in a `Converter`. Select nested values
before choosing the result type:

```dart
final Converter selected = data.convert.fromMap('price');
final int fluentPrice = selected.toInt(); // 42
final int secondScore = Convert.toInt(<String>['10', '20'], listIndex: 1); // 20
```

## Handling failed conversions

Strict conversions throw `ConversionException` when conversion fails without
a fallback. Supply `defaultValue` when a fallback is appropriate, or use a
nullable `tryToX` / `tryConvertToX` result:

```dart
final int? missing = Convert.tryToInt('not a number'); // null
final int? alsoMissing = tryConvertToInt('not a number'); // null
final int fallback = Convert.toInt('not a number', defaultValue: 0); // 0
final String? text = Convert.tryToString(null); // null
```

For configuration, date/URI/enum conversion, custom converters, and full error
contracts, read the upstream [convert_object documentation](https://pub.dev/documentation/convert_object/latest/)
and [Convert API reference](https://pub.dev/documentation/convert_object/latest/convert_object/Convert-class.html).
