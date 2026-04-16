# API Curation Checklist

Use this file to mark the direction you want for v9.

How to use:
- Check one option per item where possible.
- Add notes under any item if you want exceptions inside a group.
- Groups are used where the APIs are repetitive and should be decided together.
- "Recommended" means my current recommendation after auditing the repo.

---

## 1. Export And Barrel Organization

### 1.1 Public entrypoint split
Files:
- `lib/flutter_helper_utils.dart`
- `lib/core.dart`
- `lib/colors.dart`
- `lib/notifiers.dart`
- `lib/widgets.dart`
- `lib/sugar.dart`

Current state:
- The top-level split exists.
- The `lib/src` subdirectories already have matching barrel files.
- Remaining work is mostly about ownership and routing, not creating missing `dir_name.dart` files.

Recommended: keep the split, then make ownership clearer.

- [ ] Keep the current top-level split exactly as-is
- [ ] Keep the split but reorganize what each entrypoint exports
- [ ] Collapse some entrypoints
- [ ] Add more entrypoints

Notes:

### 1.2 Barrel-to-barrel export routing
Scope:
- Prefer exporting directory barrel files where they already exist instead of deep individual files when possible.
- Example question: should top-level files point only to stable barrel files?

Recommended: yes.

- [x] Normalize exports to go through barrel files wherever possible
- [ ] Keep direct deep exports where they are today

Notes:

### 1.3 `ListenablesBuilder` ownership
Files:
- `lib/notifiers.dart`
- `lib/widgets.dart`
- `lib/src/value_notifier/widgets/widgets.dart`

Current state:
- `ListenablesBuilder` is reachable from both `notifiers.dart` and `widgets.dart`.

Recommended: choose one home only.

- [ ] Keep `ListenablesBuilder` in `notifiers.dart` only
- [x] Keep `ListenablesBuilder` in `widgets.dart` only
- [ ] Keep it in both
- [ ] Remove it

Notes:

### 1.4 Aggregate entrypoint philosophy
Files:
- `lib/flutter_helper_utils.dart`
- `README.md`
- `migration_guides.md`

Current state:
- Aggregate import still reads like the main default in docs.

Recommended: keep it for compatibility, but document it as the full-surface import, not the recommended default.

- [x] Keep aggregate import and document it as compatibility/full surface
- [ ] Keep aggregate import as the main recommended import
- [ ] Reduce aggregate import scope
- [ ] Remove aggregate import

Notes:

---

## 2. APIs Recommended To Keep

### 2.1 Color setter family
Files:
- `lib/src/extensions/flutter_extensions/colors/on_colors.dart`

APIs:
- `setOpacity`
- `setAlpha`
- `setRed`
- `setGreen`
- `setBlue`

Why this is on the keep list:
- These are meaningful migration helpers.
- `setOpacity` is clearer and more ergonomic than manually converting to alpha values.
- They are small, stable, and still genuinely useful.

Recommended: keep.

- [x] Keep
- [ ] Move to `sugar.dart` only
- [ ] Remove

Notes:

### 2.2 Color parsing and conversion family
Files:
- `lib/colors.dart`
- `lib/src/extensions/flutter_extensions/colors/convert_colors_dart.dart`
- `lib/src/extensions/flutter_extensions/colors/on_string.dart`
- `lib/src/extensions/flutter_extensions/colors/on_colors.dart`

APIs:
- `toColor`
- `tryToColor`
- `FConvertObject.toColor`
- `FConvertObject.tryToColor`
- color parsing helpers and accessibility helpers

Recommended: keep.

- [x] Keep
- [ ] Keep only parsing/conversion and trim the rest
- [ ] Move part of this to opt-in only
- [ ] Remove

Notes:

### 2.3 Async snapshot helpers
Files:
- `lib/src/extensions/flutter_extensions/future.dart`

APIs:
- `when`
- `maybeWhen`
- `dataOr`
- `mapData`
- `isWaitingWithData`
- `isSuccess`

Recommended: keep.

- [x] Keep
- [ ] Keep only `when` and `maybeWhen`
- [ ] Move to `sugar.dart` only
- [ ] Remove

Notes:

### 2.4 Derived listenable family
Files:
- `lib/src/value_notifier/extensions/value_notifier_extensions.dart`

APIs:
- `DerivedValueListenable<T>`
- `map`
- `select`
- `combine`
- `distinct`

Recommended: keep.

- [x] Keep
- [ ] Move to opt-in only
- [ ] Remove

Notes:

### 2.5 Stream to notifier bridge
Files:
- `lib/src/value_notifier/extensions/stream_to_notifier.dart`

APIs:
- `StreamValueNotifier<T>`
- `Stream.toValueNotifier(...)`

Recommended: keep.

- [x] Keep
- [ ] Keep but hide `StreamValueNotifier` and expose only factory-style API
- [ ] Move to opt-in only
- [ ] Remove

Notes:

### 2.6 Adaptive UI core
Files:
- `lib/src/widgets/adaptive_ui.dart`

APIs:
- `Breakpoint`
- `PlatformTypeProvider`
- `watchBreakpoint`
- `readBreakpoint`
- `platformSizeInfo`
- `PlatformInfoLayoutBuilder`
- `BreakpointLayoutBuilder`

Recommended: keep.

- [x] Keep
- [ ] Keep only core breakpoint/provider pieces
- [ ] Move to a future `adaptive.dart`
- [ ] Remove

Notes:

### 2.7 Typed list widgets
Files:
- `lib/src/widgets/typed_list_view.dart`
- `lib/src/widgets/typed_sliver_list.dart`

APIs:
- `TypedListView`
- `TypedSliverList`
- iterable builder sugar for them

Recommended: keep.

- [x] Keep
- [ ] Keep widgets but remove iterable sugar
- [ ] Move to opt-in only
- [ ] Remove

Notes:

### 2.8 Platform environment API
Files:
- `lib/core.dart`
- `lib/src/platform_env/platform_env.dart`
- `lib/src/platform_env/platform_env_io.dart`
- `lib/src/platform_env/platform_env_web.dart`

APIs:
- `PlatformEnv`

Recommended: keep.

- [x] Keep
- [ ] Move to its own entrypoint later
- [ ] Remove

Notes:

---

## 3. APIs Recommended To Remove

### 3.1 Deprecated color aliases
Files:
- `lib/src/extensions/flutter_extensions/colors/on_colors.dart`

APIs:
- `addOpacity`
- `addAlpha`
- `addRed`
- `addGreen`
- `addBlue`

Recommended: remove in v9.

- [x] Remove
- [ ] Keep for one more version
- [ ] Keep indefinitely do not deprecate

Notes:

### 3.2 Deprecated color notifier alias
Files:
- `lib/src/value_notifier/notifier_classes/color_notifier.dart`

API:
- `ColorValueNotifierExtension.opacity`

Recommended: remove in v9.

- [x] Remove
- [ ] Keep for one more version
- [ ] Keep indefinitely do not deprecate

Notes:

### 3.3 Deprecated `GradientWidget.gradientAlignment`
Files:
- `lib/src/widgets/gradient_widget.dart`

API:
- `gradientAlignment`

Recommended: remove in v9.

- [x] Remove
- [ ] Keep for one more version
- [ ] Keep indefinitely

Notes:

### 3.4 Thin shorthand alias: `int.color`
Files:
- `lib/colors.dart`
- `lib/src/extensions/num_extensions.dart`

API:
- `123.color`

Recommended: remove.

- [ ] Remove
- [ ] Keep
- [x] Move to opt-in only

Notes:

### 3.5 Thin shorthand alias: `ValueNotifier.v`
Files:
- `lib/src/value_notifier/extensions/value_notifier_extensions.dart`

API:
- `notifier.v`

Recommended: remove.

- [x] Remove
- [ ] Keep
- [ ] Move to opt-in only

Notes:

---

## 4. APIs Recommended To Keep But Modify

### 4.1 Carousel jump helpers with internal inference
Files:
- `lib/src/extensions/flutter_extensions/carousel_controller.dart`

Current issue:
- `jumpToItem` can infer carousel internals using `dynamic`.
- The file itself documents that this depends on Flutter internals.

Recommended: keep the carousel helpers, but remove the unstable inference path.

- [x] Keep as-is
- [ ] Keep but require explicit config instead of internal inference
- [ ] Move to opt-in only
- [ ] Remove entirely

Notes:

### 4.2 Docs and positioning of curated imports
Files:
- `README.md`
- `migration_guides.md`
- `CHANGELOG.md`

Current issue:
- Docs still lean toward the aggregate import more than the curated import surfaces.

Recommended: keep all docs, but reposition the messaging.

- [x] keep all docs, but reposition the messaging
- [ ] Update docs to make curated imports the recommended default
- [ ] Keep aggregate import as the documented default

Notes:

### 4.3 Barrel organization follow-through
Files:
- public entrypoints and export chains

Current issue:
- The directory barrels mostly exist already.
- The remaining question is whether we want stricter barrel usage and cleaner ownership.

Recommended: keep the current files, then clean the export routing.

- [x] keep the current files, then clean the export routing.
- [ ] Clean up barrel routing only
- [ ] Reorganize barrel structure more aggressively

Notes:

---

## 5. Borderline Groups That Need Your Decision

### 5.1 Navigation basic helper layer
Files:
- `lib/src/extensions/flutter_extensions/navigation.dart`

Examples:
- `pushPage`
- `pushRoute`
- `pushNamedRoute`
- `maybeRouteArgs`
- `routeArgs`
- `dismissAllPopups`

Context:
- The explicit naming is much better than the old naming.
- Some of this is useful and readable.
- Some of it is still fairly thin wrapper sugar.

Recommended: keep the basic high-use layer only.

- [x] Keep the full current navigation file
- [ ] Keep only the basic push/pop/args helpers
- [ ] Move navigation helpers to `sugar.dart` only
- [ ] Remove navigation helpers entirely

Notes:

### 5.2 Navigation advanced route surgery/restoration layer
Files:
- `lib/src/extensions/flutter_extensions/navigation.dart`

Examples:
- `replaceRoute`
- `replaceRouteBelow`
- `removeRoute`
- `removeRouteBelow`
- all `restorable*` helpers

Recommended: remove these wrappers and call `NavigatorState` directly when needed.

- [x] Keep
- [ ] Move to opt-in only
- [ ] Remove

Notes:

### 5.3 Theme sugar group
Files:
- `lib/src/extensions/flutter_extensions/theme_extension.dart`

This group includes:
- `context.themeData`, `textTheme`, `colorScheme`, `brightness`, etc.
- component theme getters like `appBarTheme`, `badgeTheme`, `checkboxTheme`, etc.
- `TextStyle` copy wrapper family like `displayLargeCopy`, `titleMediumCopy`, etc.
- `ThemeData` color scheme alias family like `theme.primary`, `theme.onPrimary`, etc.
- `colorFromScheme`, `colorByName`
- `ThemeWithoutEffects`, `withoutEffects`

Recommended: keep only the pieces with real leverage, remove the mass aliasing.

- [x] Keep the full current theme file
- [ ] Keep only high-value pieces (`themeExtension<T>()`, `schemeColor`, `colorFromScheme`, `ThemeWithoutEffects`, `withoutEffects`)
- [ ] Move the whole file to opt-in only
- [ ] Remove the whole file

Notes:

### 5.4 MediaQuery sugar group
Files:
- `lib/src/extensions/flutter_extensions/media_query_extension.dart`

This group includes:
- direct mirrors like `mq`, `padding`, `viewInsets`, `platformBrightness`
- width/height aliases
- many `nullable*` mirrors
- accessibility and context-menu mirrors

Recommended: trim heavily or remove.

- [x] Keep the full current media query file
- [ ] Keep only a very small subset
- [ ] Move to `sugar.dart` only
- [ ] Remove

Notes:

### 5.5 Platform extension sugar group
Files:
- `lib/src/platform_env/platform_extension.dart`

This group includes:
- `BuildContext.targetPlatform`
- `BuildContext?` platform booleans
- `ThemeData?` platform booleans
- `TargetPlatform?` platform booleans including web variants

Recommended: trim heavily or remove. `PlatformEnv` already covers the more important cross-platform need.

- [x] Keep the full current platform extension file
- [ ] Keep only `TargetPlatform?` helpers
- [ ] Move to `sugar.dart` only
- [ ] Remove

Notes:

### 5.6 Focus helper group
Files:
- `lib/src/extensions/flutter_extensions/focus_scope_extensions.dart`

Examples:
- `focusScope`
- `focusScopeNoDependency`
- `unfocus`
- `unfocusCall`
- `hasFocus`
- `hasPrimaryFocus`

Recommended: keep only if you want this style of ergonomic sugar in `sugar.dart`.

- [x] Keep
- [ ] Move to `sugar.dart` only
- [ ] Remove

Notes:

### 5.7 ScaffoldMessenger helper group
Files:
- `lib/src/extensions/flutter_extensions/scaffold_messenger_extension.dart`

Recommended: borderline. Useful, but mostly forwarding sugar.

- [x] Keep
- [ ] Move to `sugar.dart` only
- [ ] Remove

Notes:

### 5.8 Directionality and locale helper group
Files:
- `lib/src/extensions/flutter_extensions/directionality.dart`

Recommended: likely okay if you want practical UI sugar, but still optional.

- [x] Keep
- [ ] Move to `sugar.dart` only
- [ ] Remove

Notes:

### 5.9 Number UI sugar group
Files:
- `lib/src/extensions/flutter_extensions/on_numbers.dart`

Examples:
- `edgeInsetsAll`
- `edgeInsetsHorizontal`
- `widthBox`
- `heightBox`
- `squareBox`
- `allCircular`
- `circular`

Recommended: valid candidate for accepted sugar, but only in opt-in surfaces.

- [x] Keep only in opt-in surfaces
- [ ] Keep in `sugar.dart` only
- [ ] Remove

Notes:

### 5.10 `GradientWidget`
Files:
- `lib/src/widgets/gradient_widget.dart`

Recommended: borderline. Fine if you want a small visual utility layer in `widgets.dart`.

- [ ] Keep
- [x] Keep after removing deprecated field only
- [ ] Move to opt-in only
- [ ] Remove

Notes:

### 5.11 `MultiTapDetector`
Files:
- `lib/src/widgets/multi_tap_detector.dart`

Recommended: borderline. It is more niche than the core widgets.

- [x] Keep and enhance if needed
- [ ] Move to opt-in only
- [ ] Remove

Notes:

### 5.12 Typed notifier family (SKIP THIS ALREADY REMOVED)
Files:
- `lib/src/value_notifier/notifier_classes/*.dart`

Subgroups:
- Simple scalar wrappers:
  - `BoolNotifier`
  - `IntNotifier`
  - `DoubleNotifier`
  - `NumNotifier`
  - `StringNotifier`
  - `ColorNotifier`
  - `ThemeModeNotifier`
  - `BrightnessNotifier`
- Heavy SDK-mirroring wrappers:
  - `DateTimeNotifier implements DateTime`
  - `DurationNotifier implements Duration`
  - `UriNotifier implements Uri`
  - `ListNotifier implements List`
  - `SetNotifier implements Set`
  - `MapNotifier implements Map`

Current concern:
- Many override `notifyListeners()` with `catch (_) {}`.
- Some wrappers are very large and mirror SDK interfaces.

Recommended: this needs an explicit product decision.

- [ ] Keep all typed notifiers
- [ ] Keep only scalar wrappers
- [ ] Keep all, but remove silent error swallowing
- [ ] Keep scalars, remove heavy interface-mirroring wrappers
- [ ] Remove the whole typed notifier family

Notes:

---

## 6. Possible Additions Or Structural Tweaks

### 6.1 `experimental.dart` or `legacy_sugar.dart`
Purpose:
- A quarantine place for unstable helpers, noisy sugar, or APIs we do not want to bless in `core.dart` or normal curated imports.

Recommended: consider this only if you want to keep more sugar without pretending it is core.

- [ ] Add
- [ ] Skip

Notes:

### 6.2 Future dedicated entrypoints
Examples:
- `adaptive.dart`
- `theme.dart`
- `navigation.dart`

Recommended: only if the package stays large after pruning.

- [ ] Add more dedicated entrypoints now
- [ ] Keep current entrypoints only
- [ ] Revisit after pruning

Notes:

---

## 7. Pre-Agreed Decision

This one is based on what you already told me in chat.

### 7.1 `Color.setOpacity`
Status:
- You explicitly said this is acceptable sugar and should stay.
- [ ] ya ya if thats not deprecated keep it.
