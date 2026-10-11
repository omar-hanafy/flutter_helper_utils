---
name: migrate-flutter-helper-utils-v9-to-v10
description: Migrate apps from flutter_helper_utils 9.x to 10.x when Material types, theme or scaffold lookups, snackbar/banner helpers, page routes, or carousel controllers still use SDK Material. Covers material_ui imports, minimum SDK and dependency constraints, and legacy compatibility bridge limits.
---

# Migrate Flutter Helper Utils 9 to 10

Inspect the resolved FHU version and existing Material imports first. This
hop applies only when crossing 9.x to 10.x; apply earlier hops separately.
Record the app's current analyzer/test results before changing it.

## SDKs and dependencies

Use Flutter >=3.47.7 with Dart >=3.13.5. Set FHU to ^10.0.0 and add
`material_ui: ^1.6.0` directly when importing it. FHU requires
`dart_helper_utils ^6.1.0` and `intl ^0.20.3`; resolve old direct pins.
Do not use dependency overrides to hide a conflicting contract.

Replace `package:flutter/material.dart` with
`package:material_ui/material_ui.dart` in migrated app files. Keep the FHU
main import or `sugar.dart`. FHU does not re-export Material UI. Prefix
imports if both Material libraries must coexist during migration.

## Migrate types and ancestors together

- `context.themeData`, text/color/component theme getters, theme extensions,
  ColorScheme extensions and `toThemeData()` use Material UI types.
- `context.scaffold` / `scaffoldOrNull` and scaffold-messenger helpers need
  Material UI Scaffold/ScaffoldMessenger ancestors. SnackBar, MaterialBanner,
  feature controllers and close-reason enums are Material UI types.
- Widget-to-page helpers create Material UI MaterialPageRoute.
- Carousel extensions apply to Material UI CarouselController.
- ThemeMode extensions, context.targetPlatform and nullable-context platform
  predicates read or extend Material UI themes and types.
- context.materialLocalizations reads Material UI localizations.
- context.defaultTabController/defaultTabControllerOrNull returns Material UI
  TabController and requires its DefaultTabController ancestor.
- ThemeWithoutEffects, typed-list scrollbars and TypedListView(onRefresh:)
  use Material UI widgets, including its RefreshIndicator.

Use Material UI MaterialApp, themes, Scaffold and feedback widgets. Merely
changing a leaf file's import does not migrate its inherited-widget ancestors.
Do not assign Material UI ThemeData/TextTheme/ColorScheme/controller values
to SDK Material types. They are distinct even when their names match.
Flutter BuildContext, Widget, Color, TextStyle, Navigator and Route are shared.
`popPage` still delegates to maybePop (PopScope can veto); `forcePopPage`
still pops directly. The deprecated maybePopPage alias remains available.
Route-taking and named-route helpers stay shared.

## Legacy dependencies

MaterialUiCompatibilityBridge in material_ui 1.6.0 is deprecated and
transitional. It supplies a mapped legacy theme and legacy localizations
under a modern app. It does not convert Material objects/controllers,
provide legacy Scaffold or ScaffoldMessenger states, or add modern ancestors
under a legacy app. It copies a theme subset, not arbitrary theme extensions
or every component theme. Verify remaining legacy subtrees at runtime.

## Re-exported Dart helpers

The main FHU import still exports all Dart Helper Utils, including stringo.
FHU 9.2.1 already allowed DHU 6.1.0; this release raises its minimum.
For a lockfile upgrading from DHU 6.0.x, inspect explicit extension names
(show/hide imports and explicit extension invocation). Moved names are
StringCaseExtensions, NullableStringCaseExtensions, StringTransformExtensions,
NullableStringTransformExtensions and StringChecksExtensions. Ordinary member
calls stay available. Title casing now capitalizes the first word; mask
rejects negative visible counts with ArgumentError. Read DHU's migration
notes for its full contract rather than treating these as new FHU helpers.

## Corrected helpers

String?.textSize now uses context-free left-to-right single-line measurement
(null is empty text), fixing the missing TextPainter direction exception.
MultiTapDetector honors its configured rolling gap for short and long custom
durations. Completion, timeout or gesture cancellation resets progress and
reports 0; competing scroll gestures cancel tap sequences.
TypedListView.onEndReached ignores nested scrollables and prevents overlapping
requests while its returned future is pending or isLoadingMore is true. Return
the complete loading operation so the pending guard survives parent rebuilds.

## Verify

Run pub get, analyze, and the app's tests with the selected SDK. Exercise theme
lookup, snackbars/banners, page transitions/back veto, carousel controllers,
tab controllers, refresh indicators, and typed-list pagination in the running app.
Record legacy-widget/platform
boundaries. The repository's migration_guides.md is authoritative for any
additional v10 changes; inspect it before claiming the migration complete.
