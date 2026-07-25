---
title: Bool Extension
---

# Bool Extension

## isTrue

Checks if the Boolean value is true, considering null safety.
```dart
bool? flag = true;
print(flag.isTrue);  // Output: true
```

## isFalse

Checks if the Boolean value is false or null.
```dart
bool? flag = null;
print(flag.isFalse);  // Output: true
```

## val

Returns the Boolean value or false if it is null.
```dart
bool? flag = null;
print(flag.val);  // Output: false
```

## binary

Returns 1 if the Boolean is true and 0 if it is false or null.
```dart
bool? flag = true;
print(flag.binary);  // Output: 1
```

## binaryText

Returns '1' if the Boolean is true and '0' if it is false or null.
```dart
bool? flag = false;
print(flag.binaryText);  // Output: 0
```
