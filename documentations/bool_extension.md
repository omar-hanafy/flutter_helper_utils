## Bool Extension in `flutter_helper_utils`

### Overview
`BoolExtension` in the `flutter_helper_utils` package offers a set of extensions on `num` to simplify common operations and checks.

### isTrue

Checks if the Boolean value is true, considering null safety.
```dart
bool? flag = true;
print(flag.isTrue);  // Output: true
```

### isFalse

Checks if the Boolean value is false or null.
```dart
bool? flag = null;
print(flag.isFalse);  // Output: true
```

### val

Returns the Boolean value or false if it is null.
```dart
bool? flag = null;
print(flag.val);  // Output: false
```

### binary

Returns 1 if the Boolean is true and 0 if it is false or null.
```dart
bool? flag = true;
print(flag.binary);  // Output: 1
```

### binaryText

Returns '1' if the Boolean is true and '0' if it is false or null.
```dart
bool? flag = false;
print(flag.binaryText);  // Output: 0
```
