## FocusScopeExtension in `flutter_helper_utils`

The `FocusScopeExtension` in the `flutter_helper_utils` package provides easy access to common functionalities related to focus handling in a Flutter application. This extension operates on `BuildContext` and helps you manage `FocusNode` and `FocusScopeNode` objects more intuitively.

### Getting the Nearest FocusScopeNode

You can obtain the nearest `FocusScopeNode` using the following code:
```dart
var nearestFocusScope = context.focusScope;
```

### Removing Focus

To remove focus, you can use the following code:
```dart
context.unFocus;
```

### Requesting Focus

You can request focus directly within a callback like this:
```dart
onTap: () => context.requestFocus
```
Or you can use the provided `GestureTapCallback`:
```dart
onTap: context.requestFocusCall
```

### Checking if a Node Has Focus

You can check if a node has focus using the following code:
```dart
bool hasFocus = context.hasFocus;
```

### Checking if a Node Has Primary Focus

You can check if a node has primary focus with the following code:
```dart
bool hasPrimaryFocus = context.hasPrimaryFocus;
```
