---
title: Navigator Extension
---

# Navigator Extension

Page helpers construct `material_ui.MaterialPageRoute`. Navigator and Route
primitives remain shared Flutter types.

## popPage

Request back navigation through `Navigator.maybePop`; `PopScope` may veto it.
Use `context.forcePopPage()` for a direct `Navigator.pop` that bypasses the veto.

```dart
context.popPage();
```

## popRoot

To pop the root navigator, useful for dismissing dialogs.

```dart
context.popRoot();
```

## navigator

Get the `NavigatorState` of the current or root navigator.

```dart
var navState = context.navigator();
var rootNavState = context.navigator(rootNavigator: true);
```

## canPopPage

Check if the current route can be popped.

```dart
bool canPop = context.canPopPage;
```

## pushPage

To push a new page onto the navigation stack.

```dart
context.pushPage(MyNewPage());
```

## pushReplacementPage

To replace the current page with a new one.

```dart
context.pushReplacementPage(MyNewPage());
```

## pushPageAndClearStack

To push a page and remove all routes below it.

```dart
context.pushPageAndClearStack(MyNewPage());
```

## pushNamedRouteAndClearStack

To push a named route and remove all routes below it.

```dart
context.pushNamedRouteAndClearStack('/myNewPage');
```

## pushNamedRoute

To push a named route.

```dart
context.pushNamedRoute('/myNewPage');
```

## pushReplacementNamedRoute

To replace the current route with a named one.

```dart
context.pushReplacementNamedRoute('/myNewPage');
```

## popUntilNamed

To pop routes until a specific named route is reached.

```dart
context.popUntilNamed('/home');
```

## dismissAllPopups

To dismiss any active pop-up like dialogs, modal bottom sheets, or Cupertino modal popups.

```dart
context.dismissAllPopups();
```