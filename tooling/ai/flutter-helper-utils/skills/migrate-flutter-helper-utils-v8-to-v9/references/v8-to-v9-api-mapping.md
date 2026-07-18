# flutter_helper_utils v8 to v9 - full API mapping

Complete rename/removal tables. The workflow, ordering, and validation
steps live in [../SKILL.md](../SKILL.md).

## Removed root entrypoints

| v8 import | v9 replacement |
|---|---|
| `package:flutter_helper_utils/core.dart` | `package:flutter_helper_utils/flutter_helper_utils.dart` |
| `package:flutter_helper_utils/colors.dart` | main import |
| `package:flutter_helper_utils/widgets.dart` | main import |
| `package:flutter_helper_utils/sugar.dart` | unchanged (opt-in shortcuts) |

## Extracted to other packages

| v8 API | New home |
|---|---|
| All notifier utilities (ValueNotifier helpers, notifier builders) | `package:better_value_notifier/better_value_notifier.dart` |
| `SingleAxisWrap` (removed earlier, in v8.0) | `package:single_axis_wrap/single_axis_wrap.dart` |

## Color members

| v8 (removed) | v9 |
|---|---|
| `addOpacity(double)` | `setOpacity(double)` - 0.0 to 1.0 |
| `addAlpha(int)` | `setAlpha(int)` - 0 to 255 |
| `addRed(int)` | `setRed(int)` |
| `addGreen(int)` | `setGreen(int)` |
| `addBlue(int)` | `setBlue(int)` |
| `int.color` (main import) | `int.color` (sugar import only) |

v9 additions with no v8 equivalent: `scaleOpacity(factor)`, harmonies
(`triadic`, `tetradic`, `splitComplementary`, `analogous`, `monochromatic`),
`meetsWCAG`, `suggestAccessibleColors`, `simulateColorBlindness`,
`isDistinguishableFor`.

## Navigation members

| v8 (removed) | v9 |
|---|---|
| `state.navigateTo(route: r)` | `context.pushRoute(r)` |
| `state.navigatePushReplacement(route: r)` | `context.pushReplacementRoute(r)` |
| `state.navigateByRouteName(name, args: a)` | `context.pushNamedRoute(name, arguments: a)` |
| `context.pReplacement(screen)` | `context.pushReplacementPage(screen)` |
| `context.pAndRemoveUntil(screen, pred)` | `context.pushPageAndRemoveUntil(screen, pred)` |
| `context.pNamed(name, arguments: a)` | `context.pushNamedRoute(name, arguments: a)` |
| `context.pReplacementNamed(name, ...)` | `context.pushReplacementNamedRoute(name, ...)` |
| `context.pNamedAndRemoveUntil(name, pred, ...)` | `context.pushNamedRouteAndRemoveUntil(name, pred, ...)` |
| `context.dismissActivePopup(...)` | `context.dismissAllPopups(...)` |
| `context.maybePopPage()` (deprecated 9.2) | `context.popPage()` or `context.forcePopPage()` |

The v9 naming convention: "Page" methods wrap a widget in a
`MaterialPageRoute`; "Route" methods take a prebuilt `Route`; "NamedRoute"
methods take a route name string.

## Focus and snapshot members

| v8 | v9 |
|---|---|
| `context.unFocus()` | `context.unfocus()` |
| `snapshot.dataWhen(loading:, error:, success:)` | `snapshot.when(none:, waiting:, active:, done:, error:)` |
| - | `snapshot.maybeWhen(orElse:, ...)` (new) |

`when` handler signatures: state handlers receive `T? data`; the error
handler receives `(Object error, StackTrace stackTrace, ConnectionState
state)`. Errors win over connection state.

## Widget parameters

| v8 | v9 |
|---|---|
| `GradientWidget(gradientAlignment: ...)` | removed - configure the `Gradient`'s own `begin`/`end`/`center` |
| `TypedListView(itemBuilder: (item) => ...)` (pre-8.5) | `itemBuilder: (context, index, item) => ...` |
| `TypedListView(headerBuilder: ..., footerBuilder: ...)` (pre-8.5) | `header: <Widget>`, `footer: <Widget>` |
| `TypedListView(cacheExtent: 300)` (deprecated 9.1) | `scrollCacheExtent: ScrollCacheExtent.pixels(300)` or `.viewport(...)` |

## Behavior changes without compile errors

| Area | v8 behavior | v9 behavior |
|---|---|---|
| `'#RGBA'` / `'#RRGGBBAA'` parsing | incorrect channel order | CSS order - alpha LAST; `0x` strings keep Dart ARGB (alpha FIRST) |
| `'hwb(...)'` parsing | incorrect | CSS-correct with white+black normalization |
| `PlatformTypeProvider` above `MaterialApp` | could throw (no MediaQuery) | root-safe (LayoutBuilder, then MediaQuery, then View fallback) |
| `TypedSliverList` | older sliver API | current Flutter sliver API |

## dart_helper_utils cascade (v5 -> v6)

FHU 9.x requires dart_helper_utils >=6.0.0. Direct users of DHU APIs must
apply its own migration (conversion moved to `convert_object`,
`altKeys` -> `alternativeKeys`, `firstValueForKeys` -> `tryGetRaw`,
`httpFormat` -> `httpDateFormat`, `flatJson` -> `flatMap`, paginators and
DoublyLinkedList removed). Use the dart-helper-utils plugin's
migrate-dart-helper-utils-v5-to-v6 skill when installed.
