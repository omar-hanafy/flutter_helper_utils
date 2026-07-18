---
name: use-flutter-helper-utils
description: Use when writing or reviewing Flutter code that uses the flutter_helper_utils package - BuildContext theme/text/colorScheme getters, MediaQuery shortcuts (sizePx, widthPx, textScaler), navigation helpers (pushPage, popPage, forcePopPage, dismissAllPopups, routeArgs), platform detection (PlatformEnv, isMobileWeb), AsyncSnapshot.when pattern matching, focus/scaffold-messenger/directionality helpers, num/Size sugar, or deciding between the main import and sugar.dart.
---

# Use flutter_helper_utils correctly

flutter_helper_utils (FHU) is a curated Flutter utility package. Agents
reliably produce v8 names that were REMOVED in v9 and invent members that
never existed - use the exact names below instead of memory.

## The import model

`import 'package:flutter_helper_utils/flutter_helper_utils.dart';` gives:

1. FHU's own surface: context extensions, colors, widgets, `PlatformEnv`,
   AsyncSnapshot helpers, and everything in `sugar.dart`.
2. ALL of `package:dart_helper_utils` (DHU) - which itself re-exports all
   of `collection`, all of `convert_object`, and exactly five intl symbols
   (`Bidi`, `BidiFormatter`, `DateFormat`, `Intl`, `NumberFormat`).

`import 'package:flutter_helper_utils/sugar.dart';` ALONE is the opt-in
shortcut subset (context navigation/media-query/theme/scroll extensions,
num/Size sugar, `int.color`, platform checks) WITHOUT the DHU re-export,
colors, `PlatformEnv`, or widgets.

Consequences:

- Do NOT add `dart_helper_utils`, `collection`, or `convert_object` imports
  next to the main FHU import - it already provides them, and duplicates
  invite ambiguous-extension errors.
- Layering: type conversion questions belong to convert_object; pure-Dart
  utilities (maps, strings, dates, debounce) belong to dart_helper_utils.
  If those plugins are installed, their skills are the deeper source.

## Step 0: Inspect the project first

1. Resolved version: `grep -A2 'flutter_helper_utils' pubspec.lock`. This
   skill documents 9.x. For 8.x-or-older projects, use the
   migrate-flutter-helper-utils-v8-to-v9 skill before writing new code.
2. Match existing style: `grep -rn "flutter_helper_utils" lib/ | head` to
   see which import the project uses; do not mix idioms in one file.

## Exact names agents get wrong (verified against source)

| Task | WRONG guesses | Actual API |
|---|---|---|
| Text theme | `context.txtTheme` | `context.textTheme` (also `primaryTextTheme`) |
| Screen size | `screenWidth`, `screenSize` | `context.widthPx`, `context.heightPx`, `context.sizePx` (+ `nullableWidthPx`, ...) |
| Close all dialogs | `dismissActivePopup()` (v8) | `context.dismissAllPopups()` - `rootNavigator:` defaults to TRUE here |
| Replace screen (named) | `pReplacementNamed` (v8) | `context.pushReplacementNamedRoute(name)` |
| Replace screen (widget) | `pReplacement` (v8) | `context.pushReplacementPage(HomeScreen())` |
| Back respecting PopScope | `maybePopPage` (deprecated 9.2) | `context.popPage([result])` - returns `Future<bool>` via `maybePop` |
| Back bypassing PopScope | - | `context.forcePopPage([result])` - direct `pop`, guards NOT asked |
| Snapshot matching | `when(loading:, error:, data:)` | `snapshot.when(none:, waiting:, active:, done:, error:)` - see below |
| Unfocus keyboard | `unFocus` (v8) | `context.unfocus()` (also `context.unfocusCall` as a tear-off) |
| Route arguments | `context.arguments` | `context.routeArgs<T>()` (throws) / `context.maybeRouteArgs<T>()` (null) |
| Text scale | `textScaleFactor` | `context.textScaler` (Flutter's `TextScaler`) |

## Navigation semantics

Naming convention: "Page" methods wrap a WIDGET in a `MaterialPageRoute`
(`pushPage`, `pushReplacementPage`, `pushPageAndRemoveUntil`,
`pushPageAndClearStack`); "Route" methods take a prebuilt `Route`
(`pushRoute`, ...); "NamedRoute" methods take a name string
(`pushNamedRoute`, ...). All accept `rootNavigator: false` by default
EXCEPT `dismissAllPopups` (root by default).

- `popPage` = `maybePop`: `PopScope`/`Page.canPop` guards can veto.
  `forcePopPage` = `pop`: guards are bypassed. `tryPopPage` pops only when
  `canPopPage` is true - and `canPopPage` does NOT consult `PopScope`.
- Dialogs/sheets above nested navigators: `popRoot()` / `tryPopRoot()`.
- `popUntilNamed('/home')`, `popToRoot()`, `pushPageAndClearStack(screen)`.
- Restorable variants exist (`restorablePushNamedRoute`, ...); a
  `RestorableRouteBuilder` passed to them must be a STATIC function
  annotated `@pragma('vm:entry-point')`.

## Theme access

- `context.themeData`, `context.textTheme`, `context.colorScheme`,
  `context.brightness` (THEME brightness) vs `context.sysBrightness`
  (platform brightness from MediaQuery) - `context.isDark`/`isLight`
  follow the THEME.
- Direct color shortcuts live on ThemeData: `context.themeData.primary`,
  `.onSurface`, `.surfaceContainerHigh`, ... (all ColorScheme roles).
- Name lookup (8.4+): `context.schemeColor('primary')` returns `Color?`;
  `caseSensitive: false` for lenient matching.
- Custom extensions: `context.themeExtension<MyTokens>()` or
  `final (theme, tokens) = context.themeWithExtension<MyTokens>();`
- ~40 component themes as getters: `context.appBarTheme`,
  `context.cardTheme`, `context.dialogTheme`, ...
- `themeMode.getBrightness(context)` resolves `system`/null via
  `sysBrightness`.

## Platform detection - two DIFFERENT sources

- `PlatformEnv` (static, host truth, safe on web): `PlatformEnv.isWeb`,
  `.isMobile`, `.isDesktop`, `.isApple`, `.targetPlatform`; web extras
  `.userAgent`, `.isSafari`, `.isChromium`, `.isWasm`; `.environment` is
  an EMPTY map on web, `.operatingSystem` works everywhere.
- `context.targetPlatform` reads `Theme.of(this).platform` - it follows a
  theme platform OVERRIDE (tests, previews). `context.isIOS`,
  `context.isMobileWeb`, `context.isDesktopWeb`, ... derive from it.
- Rule: use `PlatformEnv` for capability decisions (file system, plugins);
  use `context.*` for look-and-feel decisions that should respect the
  theme's platform.

## AsyncSnapshot helpers

```dart
snapshot.when(
  none: (data) => const SizedBox.shrink(),      // handlers get T? data
  waiting: (data) => const CircularProgressIndicator(),
  active: (data) => LiveView(data),
  done: (data) => Result(data),
  error: (error, stackTrace, state) => ErrorView(error),
);
snapshot.maybeWhen(orElse: () => const SizedBox.shrink(), done: (d) => Result(d));
```

- Errors take precedence over connection state.
- `isSuccess` is true for completed `Future<void>` even though `hasData`
  is false; `dataOr(fallback)` and `mapData(transform)` need non-null data.

## Small helpers worth exact names

- Scaffold messenger: `context.showSnackBar(SnackBar(...))`,
  `showMaterialBanner`, `hideCurrentSnackBar`, `clearSnackBars`.
- Directionality: `context.isRTL`/`isLTR`, `context.locale`,
  `context.logicalPadding(start:, end:, ...)`,
  `context.directionAwareOffset(x, y)`, `list.inContextDirection(context)`.
- Sugar (needs main or sugar import): `16.edgeInsetsAll`,
  `12.widthBox()`, `8.heightBox()`, `24.squareBox()`, `8.allCircular`
  (BorderRadius), `8.circular` (Radius), `size.toSizedBox()`,
  `0xFF2196F3.color` (sugar import surface).
- `MultiTapDetector(tapCount: 3, duration: ..., onTap: ..., child: ...)`
  for hidden/debug gestures (tapCount must be > 1);
  `GradientWidget(gradient: ..., blendMode: BlendMode.srcIn, child: ...)`
  masks the child's pixels with a gradient.

## Verification

After edits: `flutter analyze` the touched paths and run the project's
tests. Undefined-member errors on names from this skill mean a pre-9
package version (see the migrate skill) or a wrong name.

## Failure handling

- Breakpoints, `PlatformTypeProvider`, `TypedListView`/`TypedSliverList`,
  or scroll-position work: use the
  adaptive-ui-and-lists-with-flutter-helper-utils skill.
- Color parsing, manipulation, WCAG/contrast, or `Map`-to-`Color`
  conversion: use the colors-with-flutter-helper-utils skill.
- Ambiguous-extension errors: the file probably imports `dart_helper_utils`
  or `collection` alongside the main FHU import - keep one provider.

## Full API tables

Complete per-domain member lists (theme getters, media query, navigation,
scroll controller, carousel controller, platform, sugar, widgets):
[references/api-quick-reference.md](references/api-quick-reference.md).

## When NOT to use this package

- One trivial helper in a project that does not already depend on FHU:
  plain Flutter is better than adding a broad dependency.
- Pure-Dart needs only (no widgets/context): depend on `dart_helper_utils`
  directly; state management/notifiers: `better_value_notifier`.
