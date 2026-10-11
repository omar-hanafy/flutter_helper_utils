---
name: upgrade-flutter-helper-utils
description: Use when bumping the flutter_helper_utils package version in a project or auditing an upgrade's impact - detecting the installed version, sequencing migration hops across v7/v8/v8.5/v9/v10, patch-level bumps, or answering "is it safe to upgrade flutter_helper_utils".
---

# Upgrade flutter_helper_utils across versions

Version-aware audit. Determine the CURRENT resolved version first, apply
only the hops that cross it, and verify with the project's own tests.

## Step 1: Detect versions

```bash
grep -n "flutter_helper_utils" pubspec.yaml       # declared constraint
grep -A2 "  flutter_helper_utils:" pubspec.lock   # resolved version
```

If the resolved version already equals the target: report "no migration
needed" and stop (do not invent work).

## Hop table (apply in order, oldest first)

| From | To | Size | What changes |
|---|---|---|---|
| 7.x | 8.0 | medium | `SingleAxisWrap` extracted to the `single_axis_wrap` package (param renames: `preferredDirection` to `primaryDirection`, `MainAxisAlignment` to `WrapAlignment`, per-axis params collapsed - table in the repo's `migration_guides.md`); dart_helper_utils jumped to v5 (Object conversion helpers removed, `addOrRemoveYears` to `addOrSubtractYears`) |
| 8.0-8.4 | 8.5 | small | `TypedListView.itemBuilder` became `(context, index, item)`; `headerBuilder`/`footerBuilder` became `header`/`footer` widget slots; new `spacing`, `emptyBuilder`, `showScrollbar`, `onEndReached`, `itemKeyBuilder` |
| 8.x | 9.x | LARGE | use the dedicated migrate-flutter-helper-utils-v8-to-v9 skill (notifier extraction, color `add*` to `set*`, navigation renames, `dataWhen` to `when`, dart_helper_utils v6 cascade) |
| 9.0 | 9.1 | none | additive: `scrollCacheExtent` (`ScrollCacheExtent.pixels`/`.viewport`); numeric `cacheExtent` deprecated but still works |
| 9.1 | 9.2 | none | additive: `popPage`/`forcePopPage`; `maybePopPage` deprecated (use `popPage`) |
| 9.x | 10.x | LARGE | use migrate-flutter-helper-utils-v9-to-v10 for Material package type identities, theme/scaffold ancestors, carousel controllers, and SDK/dependency floors |

Shortcut when crossing several majors: pre-8.5 `TypedListView` call sites
can be rewritten once, directly to the current signature. Versions below
7.x predate the repo's migration guides - diff against the pub.dev
CHANGELOG (`https://pub.dev/packages/flutter_helper_utils/changelog`) and
treat every "Breaking" bullet as its own hop.

## Step 2: Execute

1. Update the pubspec constraint; `flutter pub get` (or
   `flutter pub upgrade flutter_helper_utils`).
2. Work through ONLY the hops crossed, oldest first, using the hop table
   and the dedicated migration skill for each major hop.
3. `flutter analyze` and run the full test suite; compare failures against
   the pre-upgrade baseline (record it first).

## Failure handling

- Solver conflict: 10.x needs Flutter `>=3.47.7`, Dart `>=3.13.5`,
  `material_ui ^1.6.0`, `dart_helper_utils ^6.1.0`, and `intl ^0.20.3`.
  Declare `material_ui` directly if you import it.
- For the historical 9.x hop: 9.x needs Dart SDK `>=3.11.0`, Flutter `>=3.41.0`, and
  `dart_helper_utils ^6`; a direct dependency pinning `dart_helper_utils <6`
  (or an old SDK) blocks resolution.
- Undefined members that are NOT flutter_helper_utils names: the
  dart_helper_utils cascade (v5 in the v8 hop, v6 in the v9 hop) renamed
  Dart-side utilities - see that package's own migration guides/skills.
- If the installed or target version is NEWER than 10.0.x, this skill may
  predate it: read the package CHANGELOG for entries above 10.0.0 and treat
  any "breaking" bullet as its own hop.
