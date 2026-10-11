---
title: FocusScope Extension
---

# FocusScope Extension

## Getting the Nearest FocusScopeNode

You can obtain the nearest `FocusScopeNode` using the following code:
```dart
var nearestFocusScope = context.focusScope;
```

## Removing Focus

To remove focus, you can use the following code:
```dart
context.unfocus();
```

## Requesting Focus

Request focus for a `FocusNode` owned and disposed by your widget:
```dart
onTap: () => context.focusScopeNoDependency.requestFocus(targetNode),
```
Or use the node's callback directly:
```dart
onTap: targetNode.requestFocus,
```

## Checking if a Node Has Focus

You can check if a node has focus using the following code:
```dart
bool hasFocus = context.hasFocus;
```

## Checking if a Node Has Primary Focus

You can check if a node has primary focus with the following code:
```dart
bool hasPrimaryFocus = context.hasPrimaryFocus;
```
