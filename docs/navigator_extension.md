# Documentation for NavigatorExtension in flutter_helper_utils

## NavigatorExtension on BuildContext

The `NavigatorExtension` is an extension on `BuildContext`, providing a rich set of methods to interact with navigation stacks in Flutter. It encapsulates common navigation actions such as `pop`, `push`, and `replace` in an intuitive API that can be used directly on a `BuildContext`.

### Pop Page

To pop the current page and optionally pass back a result.

```dart
context.popPage();
```

### Pop Root

To pop the root navigator, useful for dismissing dialogs.

```dart
context.popRoot();
```

### Navigator State

Get the `NavigatorState` of the current or root navigator.

```dart
var navState = context.navigator();
var rootNavState = context.navigator(rootNavigator: true);
```

### Can Pop

Check if the current route can be popped.

```dart
bool canPop = context.canPop;
```

### Push Page

To push a new page onto the navigation stack.

```dart
context.pushPage(MyNewPage());
```

### Push Replacement

To replace the current page with a new one.

```dart
context.pReplacement(MyNewPage());
```

### Push And Remove Until

To push a page and remove all routes below it.

```dart
context.pAndRemoveUntil(MyNewPage());
```

### Push Named And Remove Until

To push a named route and remove all routes below it.

```dart
context.pNamedAndRemoveUntil('/myNewPage');
```

### Push Named

To push a named route.

```dart
context.pNamed('/myNewPage');
```

### Push Replacement Named

To replace the current route with a named one.

```dart
context.pReplacementNamed('/myNewPage');
```

### Pop Until

To pop routes until a specific named route is reached.

```dart
context.popUntil('/home');
```

### Dismiss Active Popup

To dismiss any active pop-up like dialogs, modal bottom sheets, or Cupertino modal popups.

```dart
context.dismissActivePopup();
```
