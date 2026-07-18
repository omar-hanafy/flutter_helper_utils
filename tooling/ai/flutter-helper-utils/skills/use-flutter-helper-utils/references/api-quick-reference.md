# flutter_helper_utils 9.x - API quick reference

Complete per-domain member tables, verified against the package source.
(g) marks getters. Workflow guidance lives in [../SKILL.md](../SKILL.md).

## Imports

| Import | Contents |
|---|---|
| `package:flutter_helper_utils/flutter_helper_utils.dart` | everything: FHU + all of dart_helper_utils (which re-exports collection, convert_object, and `Bidi`/`BidiFormatter`/`DateFormat`/`Intl`/`NumberFormat` from intl) |
| `package:flutter_helper_utils/sugar.dart` | opt-in subset: context extensions (carousel, directionality, focus, media query, navigation, on-numbers, scaffold messenger, scroll, theme), num/Size sugar, `int.color`, string `textSize`, platform checks |

## BuildContext - theme (FHUThemeExtension)

`themeData` (g), `textTheme` (g), `primaryTextTheme` (g), `colorScheme` (g),
`brightness` (g, THEME), `sysBrightness` (g, MediaQuery platform),
`isDark`/`isLight` (g, theme-based), `themeExtension<T>()`,
`themeWithExtension<T>()` -> `(ThemeData, T?)` record,
`schemeColor(String name, {caseSensitive = true})` -> `Color?`,
`scaffold` (g, throws) / `scaffoldOrNull` (g), `defaultTabController` (g).

Component theme getters: `actionIconTheme`, `appBarTheme`, `badgeTheme`,
`bannerTheme`, `bottomAppBarTheme`, `buttonTheme`, `cardTheme`,
`carouselViewTheme`, `checkboxTheme`, `chipTheme`, `dataTableTheme`,
`datePickerTheme`, `dialogTheme`, `dividerTheme`, `drawerTheme`,
`dropdownMenuTheme`, `expansionTileTheme`, `filledButtonTheme`,
`iconButtonTheme`, `listTileTheme`, `menuBarTheme`, `menuButtonTheme`,
`menuTheme`, `navigationBarTheme`, `popupMenuTheme`, `radioTheme`,
`scrollbarTheme`, `searchBarTheme`, `searchViewTheme`, `sliderTheme`,
`switchTheme`, `tabBarTheme`, `textButtonTheme`, `textSelectionTheme`,
`timePickerTheme`, `toggleButtonsTheme`, `tooltipTheme`.

## ThemeData extensions

- `isDark`/`isLight` (g).
- Text styles directly: `displayLarge` ... `labelSmall` (g, nullable), plus
  `displayLargeCopy({fontSize, fontWeight, color, ...})` copy methods for
  every style.
- Every ColorScheme role directly: `primary`, `onPrimary`,
  `primaryContainer`, `secondary`, `tertiary`, `error`, `surface`,
  `onSurface`, `onSurfaceVariant`, `outline`, `outlineVariant`, `shadow`,
  `scrim`, `inverseSurface`, `inversePrimary`, `surfaceTint`,
  `primaryFixed`/`primaryFixedDim`/`onPrimaryFixed`/`onPrimaryFixedVariant`
  (same for secondary/tertiary), `surfaceDim`, `surfaceBright`,
  `surfaceContainerLowest`/`Low`/`surfaceContainer`/`High`/`Highest` (g).
- `colorFromScheme(String name, {caseSensitive = true})` -> `Color?`.

`ThemeMode?`: `getBrightness(context)`, `isDark`/`isLight`/`isSystem` (g).
`Brightness?`: `isDark`/`isLight` (g).
`ColorScheme`: `toThemeData({appBarTheme, textTheme, ...})`,
`colorByName(String, {caseSensitive})` -> `Color?`.

## BuildContext - MediaQuery (FHUMediaQueryExtension)

`mq` (g, full MediaQueryData) / `nullableMQ` (g), `sizePx`, `widthPx`,
`heightPx`, `shortestSide`, `longestSide`, `deviceOrientation`,
`padding`, `viewInsets`, `viewPadding`, `systemGestureInsets`,
`pixelRatio`, `textScaler`, `platformBrightness`,
`alwaysUse24HourFormat`, `accessibleNavigation`, `invertColors`,
`highContrast`, `onOffSwitchLabels`, `supportsAnnounce`,
`navigationMode` - each with a `nullableX` maybe-variant (g).
`Orientation?`: `isLandscape`/`isPortrait` (g).

## BuildContext - navigation (FHUNavigatorExtension)

Access: `navigator({rootNavigator})`, `maybeNavigator({rootNavigator})`.
Introspection: `modalRoute<T>()`, `routeSettings` (g), `routeName` (g),
`maybeRouteArgs<T>()`, `routeArgs<T>({debugLabel})` (throws),
`requireRouteArgs<T>()`, `isRouteNamed(name)`, `isCurrentRoute` (g),
`isFirstRoute` (g), `isActiveRoute` (g), `isUserGestureInProgress` (g).
Pop: `canPopPage` (g, ignores PopScope), `canPopRootPage` (g),
`popPage([result])` -> `Future<bool>` (maybePop), `forcePopPage([result])`
(direct), `tryPopPage([result])`, `popRoot([result])`,
`tryPopRoot([result])`, `maybePopRootPage([result])`,
`popUntilRoute(pred)`, `popUntilNamed(name)`, `popToRoot()`,
`dismissAllPopups({rootNavigator = true})`.
Push widgets: `pushPage(screen, {rootNavigator, settings, maintainState,
fullscreenDialog, allowSnapshotting})`, `pushReplacementPage`,
`pushPageAndRemoveUntil(screen, predicate)`, `pushPageAndClearStack`.
Push routes: `pushRoute`, `pushReplacementRoute`,
`pushRouteAndRemoveUntil`, `pushRouteAndClearStack`.
Named: `pushNamedRoute(name, {arguments})`,
`pushReplacementNamedRoute`, `popAndPushNamedRoute`,
`pushNamedRouteAndRemoveUntil`, `pushNamedRouteAndClearStack`.
Replace/remove: `replaceRoute(oldRoute:, newRoute:)`,
`replaceRouteBelow(anchorRoute:, newRoute:)`, `removeRoute(route)`,
`removeRouteBelow(anchorRoute)`.
Restorable: `restorablePushNamedRoute`,
`restorablePushReplacementNamedRoute`, `restorablePopAndPushNamedRoute`,
`restorablePushNamedRouteAndRemoveUntil`,
`restorablePushNamedRouteAndClearStack`, `restorablePushRoute`,
`restorablePushReplacementRoute`, `restorablePushRouteAndRemoveUntil`,
`restorablePushRouteAndClearStack`, `restorableReplaceRoute`,
`restorableReplaceRouteBelow` - route builders must be STATIC and
annotated `@pragma('vm:entry-point')`.

## Platform detection

`PlatformEnv` (static, works on web): `targetPlatform`, `isWeb`, `isIOS`,
`isAndroid`, `isMobile`, `isDesktop`, `isMacOS`, `isWindows`, `isLinux`,
`isFuchsia`, `isApple`, `isWasm`, `userAgent`, `browserEngine`,
`isChromium`, `isSafari`, `isFirefox`, `isEdge`, `operatingSystem`,
`operatingSystemVersion`, `numberOfProcessors`, `pathSeparator`,
`localHostname`, `version`, `localeName`, `environment` (empty map on
web), `executable`, `resolvedExecutable`, `script`,
`executableArguments`.

`BuildContext` (theme-platform based, also on `BuildContext?` and
`ThemeData?`): `targetPlatform`, `isMobile`, `isIOS`, `isAndroid`,
`isDesktop`, `isMacOS`, `isWindows`, `isLinux`, `isFuchsia`, `isApple`,
`isMobileWeb`, `isIOSWeb`, `isAndroidWeb`, `isDesktopWeb`, `isMacOsWeb`,
`isWindowsWeb`, `isLinuxWeb`, `isFuchsiaWeb`, `isAppleWeb` (g).

## AsyncSnapshot<T> (FHUAsyncSnapshot)

`dataOr(defaultValue)`, `mapData<R>(transform)` -> `R?`,
`isWaitingWithData` (g), `isSuccess` (g, true for completed
`Future<void>`), `when({required none, waiting, active, done, error})`
(state handlers get `T? data`; error gets
`(Object, StackTrace, ConnectionState)`; errors win),
`maybeWhen({required orElse, ...optional handlers})`.

## ScrollController (ScrollControllerEx)

`hasSingleClient` (g), `isScrollingListenable` (g),
`animateToPosition(offset, {duration, curve, clamp})`,
`jumpToPosition(offset, {clamp})`, `moveToPosition(offset, {animate, ...})`,
`animateToStart()`, `jumpToStart()`, `animateToEnd()`, `jumpToEnd()`,
`animateToTop()`/`animateToBottom()` (aliases),
`animateBy(delta)`, `jumpBy(delta)`, `pageScroll({forward, viewportFraction})`,
`scrollToPercentage(percent)`, `scrollByPercentage(percent)`,
`snapToClosest({itemExtent})`, `snapToIndex(index, {itemExtent})`,
`scrollProgress` (g, 0-1), `isAtStart`/`isAtEnd`/`isAtEdge` (g),
`isAtTop`/`isAtBottom` (aliases), `canScroll` (g),
`isNearStart({threshold = 50})`, `isNearEnd({threshold = 50})`,
`isItemVisible(itemOffset, itemExtent)`, `userScrollDirectionOrIdle` (g),
`isUserScrollIdle`/`isUserScrollingForward`/`isUserScrollingReverse` (g),
`scrollToStartIfNeeded()`, `scrollToEndIfNeeded()`,
`debugPrintScrollInfo({label})`.
`ScrollDirection?`: `isIdle` (g).

## CarouselController (FHUCarouselControllerExtension)

Fixed extent: `jumpToItem(index, {itemExtent})`,
`getCurrentFractionalItem({required itemExtent})` /
`tryGetCurrentFractionalItem`, `getCurrentIndex({itemExtent, roundingMode})`
/ `tryGetCurrentIndex`, `canGoNext` (g), `canGoPrevious` (g).
Weighted (flexWeights): `jumpToItemWeighted`,
`getWeightedLeadingItemExtent({required flexWeights})` / `tryGet...`,
`getCurrentFractionalItemWeighted` / `tryGet...`,
`getCurrentIndexWeighted` / `tryGet...`.
`RoundingMode`: `round`, `floor`, `ceil`.

## Focus, scaffold messenger, directionality

Focus: `context.focusScope` (g), `focusScopeNoDependency` (g),
`unfocus({disposition})`, `unfocusCall` (g, tear-off), `hasFocus` (g),
`hasPrimaryFocus` (g).
Messenger: `context.scaffoldMessenger` (g) / `maybeScaffoldMessenger` (g),
`showSnackBar(snackBar)`, `showMaterialBanner(banner)`,
`hideCurrentSnackBar()`, `hideCurrentMaterialBanner()`,
`removeCurrentSnackBar()`, `removeCurrentMaterialBanner()`,
`clearSnackBars()`, `clearMaterialBanners()`.
Directionality: `context.directionality` (g), `isLTR`/`isRTL` (g),
`locale` (g), `localeString` (g), `languageCode`/`countryCode`/`scriptCode`
(g), `isLanguageCode(x)`, `logicalStart`/`logicalEnd` (g),
`logicalStartAlignment`/`logicalEndAlignment` (g),
`logicalPadding({start, end, top, bottom})`, `logicalMargin({...})`,
`directionAwareOffset(x, y)`.
`TextDirection`: `isRTL`/`isLTR`/`name`/`opposite`/`multiplier` (g);
intl `TextDirection.toFlutterTextDirection()`.
`Iterable<T>`: `inDirection(direction)`, `inContextDirection(context)`.

## Sugar - num, Size, int, String

num: `edgeInsetsAll`, `edgeInsetsHorizontal`, `edgeInsetsVertical`,
`edgeInsetsTop`, `edgeInsetsBottom`, `edgeInsetsLeft`, `edgeInsetsRight`,
`edgeInsetsStart`, `edgeInsetsEnd` (g); `widthBox({child})`,
`heightBox({child})`, `squareBox({child})`; `allCircular` (g,
BorderRadius), `circular` (g, Radius).
Size: `toSizedBox({child})`, `scaled(factor)`, `aspectRatio()`,
`withWidth(w)`, `withHeight(h)`, `transpose()`, `isEmpty` (g),
`maxDimension`/`minDimension` (g).
int: `color` (g, `Color(this)` - sugar surface).
String?: `textSize` (g, measured `Size` via TextPainter).

## Widgets (non-list)

`GradientWidget({required child, required gradient, blendMode =
BlendMode.srcIn, opacity = 1.0, childAlignment =
AlignmentDirectional.center})` - ShaderMask over the child; configure
direction on the Gradient itself.
`MultiTapDetector({required child, required onTap, tapCount = 3,
duration = 500ms, onTapProgress})` - tapCount must be > 1;
`onTapProgress` also fires 0 on reset.

Adaptive UI (`PlatformTypeProvider`, `Breakpoint`, builders) and typed
lists (`TypedListView`, `TypedSliverList`, `buildListView`) are covered in
the adaptive-ui-and-lists skill; colors in the colors skill.
