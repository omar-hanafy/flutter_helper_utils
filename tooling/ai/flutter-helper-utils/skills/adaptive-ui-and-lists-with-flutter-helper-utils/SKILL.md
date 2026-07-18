---
name: adaptive-ui-and-lists-with-flutter-helper-utils
description: Use when building responsive/adaptive Flutter layouts or list UIs with the flutter_helper_utils package - PlatformTypeProvider setup, Breakpoint detection (watchBreakpoint/readBreakpoint, mobile/tablet/desktop), BreakpointLayoutBuilder, TypedListView/TypedSliverList, buildListView on iterables, pull-to-refresh, infinite scroll (onEndReached), item spacing/separators, empty states, or scrollCacheExtent tuning.
---

# Adaptive UI and typed lists with flutter_helper_utils

Two surfaces where agents invent parameter names and misremember the
breakpoint model. Use the exact contracts below.

## Breakpoints: the matching rule is UPPER-bound

Defaults (`Breakpoint.defaults`): `mobile` width **600**, `tablet` width
**1200**, `desktop` width **1800**. Matching returns the FIRST breakpoint
whose `width >= available width` (widths are ceilings, NOT min-widths):

- 500 wide -> mobile; exactly 600 -> mobile (inclusive)
- 601-1200 -> tablet; 1201-1800 -> desktop; beyond the last -> last

Do not assume the common min-width model (mobile 0+, tablet 600+,
desktop 1200+) - boundaries land differently (600 exactly is MOBILE here).
Custom sets: `Breakpoint(width: 900, name: 'compact')`; the provider sorts
them by width. Comparisons: `bp.isMobile`/`isTablet`/`isDesktop` (name
match), `>`/`<`/`isBetween(lower, upper)` (width match).

## Setup and reading

```dart
runApp(PlatformTypeProvider(          // safe ABOVE MaterialApp (9.0+)
  // breakpoints: Breakpoint.defaults,
  child: MyApp(),
));

final bp = context.watchBreakpoint;   // rebuilds on change (NOT context.breakpoint)
final bp2 = context.readBreakpoint;   // one-shot, no rebuild (NOT .of(listen: false))
```

- Missing provider throws `FlutterError` - there is no null fallback;
  wrap the app root, not a subtree, unless scoping is intentional.
- `BreakpointLayoutBuilder(builder: (context, breakpoint) => ...)` and
  `PlatformInfoLayoutBuilder(builder: (context, info) => ...)` are the
  widget forms; `PlatformSizeInfo` carries `breakpoint`, `orientation`,
  and `platform` (from `PlatformEnv.targetPlatform`).
- The provider measures the LayoutBuilder constraints first, then falls
  back to MediaQuery, then the physical view - so it reflects the space
  the provider actually occupies.

## TypedListView - exact parameter names

```dart
TypedListView<Product>(
  items: products,
  itemBuilder: (context, index, item) => ProductTile(item),  // THIS order
  spacing: 12,                        // gap; do NOT also pass separatorBuilder
  emptyBuilder: (context) => const EmptyState(),   // NOT emptyWidget
  onRefresh: () => reload(),          // wraps in RefreshIndicator
  onEndReached: () => loadMore(),     // NOT onLoadMore/onPaginate
  onEndReachedThreshold: 200,         // px before the end (default 200)
  isLoadingMore: isLoading,           // gates repeat onEndReached calls
  header: const ListHeader(),         // direct widgets, not builders
  footer: const ListFooter(),
  paginationWidget: const LoadingSpinner(),  // shown before footer
  itemKeyBuilder: (item) => ValueKey(item.id), // stable keys + correct
)                                              // findChildIndexCallback

// Same surface as an extension:
products.buildListView(itemBuilder: (context, index, item) => ...);
```

Assert matrix (violations crash in debug):

- `separatorBuilder` XOR `spacing` - never both.
- `itemExtent` XOR `prototypeItem` - never both.
- `itemExtent`/`prototypeItem` require NO header/footer/pagination/
  separators/spacing (every child must have the same extent).
- `cacheExtent` (deprecated 9.1) XOR `scrollCacheExtent`; prefer
  `scrollCacheExtent: ScrollCacheExtent.pixels(300)` or
  `ScrollCacheExtent.viewport(1.5)`.

Behavior notes:

- `onEndReached` fires on scroll notifications whenever remaining extent
  <= threshold and `isLoadingMore` is false - keep `isLoadingMore` true
  until the fetch settles or it will re-fire.
- `showScrollbar: true` wraps in `Scrollbar` using the SAME `controller`
  you pass; provide one when you enable it.
- `buildListView` eagerly copies the iterable to a list.
- `TypedSliverList` mirrors items/itemBuilder/header/footer/separators/
  spacing/itemKeyBuilder for `CustomScrollView` use (no physics/refresh/
  scrollbar - those belong to the outer scroll view).

## Scroll position helpers (ScrollController)

`controller.animateToStart()` / `animateToEnd()` / `jumpToEnd()`,
`animateBy(delta)`, `pageScroll(...)`, `scrollToPercentage(50)`,
`snapToIndex(i, itemExtent: 72)`, `scrollProgress` (0-1),
`isAtStart`/`isAtEnd`, `isNearEnd(threshold: 50)`, `canScroll`,
`isUserScrollingForward`, `debugPrintScrollInfo()`. Guard multi-client
controllers with `hasSingleClient`.

## Step 0: Inspect the project first

1. Resolved version: `grep -A2 'flutter_helper_utils' pubspec.lock`
   (9.x documented here; `TypedListView` pre-8.5 had `itemBuilder(item)`
   and `headerBuilder`/`footerBuilder` - see the migrate skill).
2. Find existing providers: `grep -rn "PlatformTypeProvider" lib/` -
   nesting a second provider silently re-scopes breakpoints.

## Verification

- `flutter analyze`; assert-matrix violations only appear at RUNTIME in
  debug builds, so run the affected screen or a widget test.
- For breakpoint changes, add a widget test pumping two sizes across a
  boundary (e.g. 600 and 601) and assert which layout renders.

## Failure handling

- `FlutterError: ... does not contain a PlatformTypeProvider`: the
  provider is missing or below the calling context - move it up.
- List crashes with "Provide either separatorBuilder or spacing" (or the
  itemExtent variants): remove one side of the XOR pair.
- `onEndReached` firing repeatedly: `isLoadingMore` is not being set.
- Theme/media-query/navigation helpers: use-flutter-helper-utils skill;
  color parsing: colors-with-flutter-helper-utils skill.
