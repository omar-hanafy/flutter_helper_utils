---
name: migrate-flutter-helper-utils-v8-to-v9
description: Use when upgrading a Flutter project from flutter_helper_utils 8.x (or 7.x) to 9.x, or when code hits removed v8 APIs after a version bump - notifier utilities gone, addOpacity/addAlpha undefined, pReplacement/pNamed undefined, dataWhen undefined, core.dart/colors.dart/widgets.dart imports failing, or dart_helper_utils v6 conflicts.
---

# Migrate flutter_helper_utils v8 to v9

Version 9 is a surface-cleanup release: notifier utilities were extracted,
deprecated aliases removed, navigation naming finalized, and the
`dart_helper_utils` dependency jumped to v6 (its own breaking migration).
Work through the sections in order; each has a detection grep.

## Preconditions

1. Clean working tree (commit or stash first). Never reset or discard the
   user's work without explicit confirmation.
2. Record a baseline: run the project's tests before touching anything.
3. Requirements for 9.2.x: Dart SDK `>=3.11.0`, Flutter `>=3.41.0`,
   `dart_helper_utils >=6.0.0 <7.0.0`. A direct dependency pinning
   `dart_helper_utils <6` blocks resolution - upgrade it first.
4. Detect the starting point: `grep -A2 'flutter_helper_utils' pubspec.lock`.
   If coming from 7.x, ALSO apply the v8 hop (see step 8).

## Step 1: Bump and resolve

```yaml
dependencies:
  flutter_helper_utils: ^9.2.0
```

`flutter pub get`. Solver conflicts almost always trace to a direct
`dart_helper_utils` or `single_axis_wrap` pin.

## Step 2: Root imports (detect: `grep -rn "flutter_helper_utils/\(core\|colors\|widgets\).dart" lib/`)

`core.dart`, `colors.dart`, and `widgets.dart` were removed. Use the main
import; `sugar.dart` remains the opt-in shortcut surface:

```dart
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
```

## Step 3: Notifiers (detect: `grep -rn "ValueNotifier\|Listenable" lib/ | grep -i "notifier"`)

All notifier utilities moved to the `better_value_notifier` package. Add it
and import alongside:

```yaml
dependencies:
  better_value_notifier: ^1.0.0
```

```dart
import 'package:better_value_notifier/better_value_notifier.dart';
```

## Step 4: Color API (detect: `grep -rnE "\.add(Opacity|Alpha|Red|Green|Blue)\(|\.color\b" lib/`)

| Removed (v8) | v9 replacement |
|---|---|
| `color.addOpacity(0.5)` | `color.setOpacity(0.5)` |
| `color.addAlpha(128)` | `color.setAlpha(128)` |
| `color.addRed(255)` / `addGreen` / `addBlue` | `color.setRed(255)` / `setGreen` / `setBlue` |
| `int.color` via main import | still exists, but only via `import 'package:flutter_helper_utils/sugar.dart';` |

SILENT behavior change: v9 corrected string color parsing for 4-digit and
8-digit hex and for `hwb(...)`. `#RGBA`/`#RRGGBBAA` are now parsed in CSS
channel order (alpha LAST); `0x`-prefixed strings keep Dart ARGB order
(alpha FIRST). Code that relied on the old, incorrect parsing changes
result colors without any compile error - re-verify any stored hex strings
with an alpha channel.

## Step 5: Navigation (detect: `grep -rnE "\.p(Replacement|AndRemoveUntil|Named)|navigateTo|navigateByRouteName|dismissActivePopup" lib/`)

Wrappers on `State` and `StatelessWidget` were removed - all navigation is
on `BuildContext` now:

| Removed (v8) | v9 replacement |
|---|---|
| `state.navigateTo(route: r)` | `context.pushRoute(r)` |
| `state.navigatePushReplacement(route: r)` | `context.pushReplacementRoute(r)` |
| `state.navigateByRouteName('/x', args: a)` | `context.pushNamedRoute('/x', arguments: a)` |
| `context.pReplacement(screen)` | `context.pushReplacementPage(screen)` |
| `context.pAndRemoveUntil(screen, pred)` | `context.pushPageAndRemoveUntil(screen, pred)` |
| `context.pNamed(name, arguments: a)` | `context.pushNamedRoute(name, arguments: a)` |
| `context.pReplacementNamed(name)` | `context.pushReplacementNamedRoute(name)` |
| `context.pNamedAndRemoveUntil(name, pred)` | `context.pushNamedRouteAndRemoveUntil(name, pred)` |
| `context.dismissActivePopup()` | `context.dismissAllPopups()` |

Also in 9.2: `context.maybePopPage()` is DEPRECATED (removal planned for
v10). Use `context.popPage()` (respects `PopScope` guards via `maybePop`)
or `context.forcePopPage()` (direct pop, bypasses guards).

## Step 6: Focus and AsyncSnapshot (detect: `grep -rnE "unFocus|dataWhen" lib/`)

- `context.unFocus()` becomes `context.unfocus()` (lowercase f).
- `snapshot.dataWhen(loading:, error:, success:)` becomes `snapshot.when`:

```dart
// Before (v8)
snapshot.dataWhen(
  loading: () => const CircularProgressIndicator(),
  error: (e) => Text('$e'),
  success: (data) => Text('$data'),
);

// After (v9) - all five states, data param is nullable T?
snapshot.when(
  none: (_) => const SizedBox.shrink(),
  waiting: (_) => const CircularProgressIndicator(),
  active: (_) => const CircularProgressIndicator(),
  done: (data) => Text('$data'),
  error: (error, stackTrace, state) => Text('$error'),
);
```

`maybeWhen(orElse: ...)` exists when only some states matter. Note: error
handling takes precedence over connection state.

## Step 7: GradientWidget (detect: `grep -rn "gradientAlignment" lib/`)

The `gradientAlignment` parameter was removed. Position the gradient
through the `Gradient` itself (`begin`, `end`, `center`, `radius`).

## Step 8: Coming from 7.x or early 8.x - extra hops

- 7.x -> 8.0: `SingleAxisWrap` moved to the `single_axis_wrap` package
  (renamed params: `preferredDirection` -> `primaryDirection`,
  `rowMainAxisAlignment` -> `horizontalAlignment` with `WrapAlignment`,
  etc. - full table in the repo's `migration_guides.md`). The
  dart_helper_utils dependency also jumped to v5 there.
- 8.0-8.4 -> 8.5: `TypedListView` `itemBuilder` gained its current
  `(context, index, item)` signature, and `headerBuilder`/`footerBuilder`
  became direct `header`/`footer` widget slots.

## Step 9: dart_helper_utils v6 cascade

FHU 9.x re-exports dart_helper_utils v6. If the project uses those Dart
utilities directly (conversions, `firstValueForKeys`, `altKeys:`,
`httpFormat`, paginators, string casing), apply the DHU v5-to-v6 migration
too - if the dart-helper-utils plugin is installed, use its
migrate-dart-helper-utils-v5-to-v6 skill; otherwise follow
`migration_guides.md` in the dart_helper_utils repository.

## Validation

1. `dart pub get`, then `flutter analyze` - every leftover v8 name surfaces
   as an undefined-member error; fix using the tables above.
2. Re-run detection greps from each step - all should return nothing.
3. `flutter test` and compare against the pre-migration baseline.
4. Manually verify screens that parse hex color strings WITH alpha
   (step 4's silent change) and any `PopScope`-guarded back navigation.

## Failure handling

- Version solving fails: find the pin with
  `grep -rn "dart_helper_utils\|single_axis_wrap" pubspec.yaml pubspec.lock`.
- An "undefined member" that is NOT in the tables above: it is probably a
  dart_helper_utils v6 rename (step 9), not an FHU rename.
- Already on 9.x with no v8 API hits: report "no migration needed" and
  stop - do not invent work.
- Rollback: restore the previous pubspec constraint and `flutter pub get`;
  no other state is touched until code edits begin.

Full rename tables:
[references/v8-to-v9-api-mapping.md](references/v8-to-v9-api-mapping.md)
