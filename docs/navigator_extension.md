# NavigatorExtension in `flutter_helper_utils`

The `NavigatorExtension` is an extension on `BuildContext`, providing a rich set of methods to interact with navigation stacks in Flutter. It encapsulates common navigation actions such as `pop`, `push`, and `replace` in an intuitive API that can be used directly on a `BuildContext`.

### popPage

To pop the current page and optionally pass back a result.

```dart
context.popPage();
```

### popRoot

To pop the root navigator, useful for dismissing dialogs.

```dart
context.popRoot();
```

### navigator

Get the `NavigatorState` of the current or root navigator.

```dart
var navState = context.navigator();
var rootNavState = context.navigator(rootNavigator: true);
```

### canPop

Check if the current route can be popped.

```dart
bool canPop = context.canPop;
```

### pushPage

To push a new page onto the navigation stack.

```dart
context.pushPage(MyNewPage());
```

### pushReplacement

To replace the current page with a new one.

```dart
context.pushReplacement(MyNewPage());
```

### pushAndRemoveUntil

To push a page and remove all routes below it.

```dart
context.pushAndRemoveUntil(MyNewPage());
```

### pushNamedAndRemoveUntil

To push a named route and remove all routes below it.

```dart
context.pushNamedAndRemoveUntil('/myNewPage');
```

### pushNamed

To push a named route.

```dart
context.pushNamed('/myNewPage');
```

### pushReplacementNamed

To replace the current route with a named one.

```dart
context.pushReplacementNamed('/myNewPage');
```

### popUntil

To pop routes until a specific named route is reached.

```dart
context.popUntil('/home');
```

### dismissActivePopup

To dismiss any active pop-up like dialogs, modal bottom sheets, or Cupertino modal popups.

```dart
context.dismissActivePopup();
```