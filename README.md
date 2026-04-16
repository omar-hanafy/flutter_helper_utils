<table style="border:none;">
  <tr style="border:none;">
    <td style="vertical-align:top; border:none; min-width:400px;">
      <h1 style="border:none;">Flutter Helper Utils</h1>
      <p>
        <code>flutter_helper_utils</code> is a curated Flutter utility package
        focused on a few high-value areas:
      </p>
      <ul>
        <li>adaptive UI and breakpoint helpers</li>
        <li>color parsing, transformation, and accessibility utilities</li>
        <li>typed list and sliver list widgets</li>
        <li>focused <code>BuildContext</code> and UI extensions</li>
        <li>
          <code>dart_helper_utils</code> re-exported for the Dart-only helpers
          that still fit the package surface
        </li>
      </ul>
    </td>
    <td style="vertical-align:top; border:none;">
      <a href="https://pub.dev/packages/flutter_helper_utils" target="_blank">
        <img
          src="https://raw.githubusercontent.com/omar-hanafy/flutter_helper_utils/main/dash-tools.png"
          alt="Flutter Helper Utils Logo"
          style="max-width:220px;"
        />
      </a>
    </td>
  </tr>
</table>

Version 9 intentionally makes the package smaller and more deliberate.

## Install

```yaml
dependencies:
  flutter_helper_utils: ^9.0.0
```

## Imports

Most users should import the package once:

```dart
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
```

If you only want the shortcut-heavy surface, use the opt-in sugar import:

```dart
import 'package:flutter_helper_utils/sugar.dart';
```

## Notifiers

Notifier utilities were extracted from this package in v9.

If you need the old notifier-style workflows, use [`better_value_notifier`](https://pub.dev/packages/better_value_notifier)

## Highlights

### Adaptive UI

```dart
runApp(
  const PlatformTypeProvider(
    child: MyApp(),
  ),
);

@override
Widget build(BuildContext context) {
  final breakpoint = context.watchBreakpoint;

  if (breakpoint.isMobile) {
    return const MobileLayout();
  }
  if (breakpoint.isTablet) {
    return const TabletLayout();
  }
  return const DesktopLayout();
}
```

### PlatformEnv

```dart
final report = PlatformEnv.report();
final os = PlatformEnv.operatingSystem;
final locale = PlatformEnv.localeName;
final processors = PlatformEnv.numberOfProcessors;
```

### Color Toolkit

```dart
final brand = tryToColor('#F97316') ?? Colors.orange;
final accent = tryToColor('rgb(14 165 233)') ?? Colors.blue;

final hex = brand.toHex(includeAlpha: true);
final readableText = brand.contrastColor();
final passesAA = brand.meetsWCAG(
  readableText,
  level: WCAGLevel.aa,
  context: WCAGContext.normalText,
);
```

Color parsing supports:

- hex strings
- `rgb(...)` and `rgba(...)`
- `hsl(...)` and `hsla(...)`
- `hwb(...)`
- CSS named colors

### Typed Lists

```dart
TypedListView<Product>(
  items: products,
  itemBuilder: (context, index, product) {
    return ProductTile(product: product);
  },
  spacing: 12,
  header: const Text('Products'),
);
```

```dart
CustomScrollView(
  slivers: [
    const SliverAppBar(title: Text('Products')),
    products.buildSliverList(
      itemBuilder: (context, index, product) {
        return ProductTile(product: product);
      },
      spacing: 12,
    ),
  ],
);
```

### BuildContext and UI Helpers

```dart
context.pushPage(const DetailsPage());
context.showSnackBar(const SnackBar(content: Text('Saved')));
context.unfocus();

final theme = context.themeData;
final width = context.widthPx;
final height = context.heightPx;
```

### Opt-in Sugar

```dart
final padding = 16.edgeInsetsAll;
final hSpace = 12.heightBox();
final radius = 24.allCircular;
final rawColor = 0xFFF97316.color;
```

`0xFFF97316.color` lives in `sugar.dart`, not in the main color toolkit.

## Widgets

Included widgets and widget systems:

- `PlatformTypeProvider`
- `PlatformInfoLayoutBuilder`
- `BreakpointLayoutBuilder`
- `TypedListView`
- `TypedSliverList`
- `GradientWidget`
- `MultiTapDetector`
- `ThemeWithoutEffects`

## Migration

Version 9 includes several breaking changes:

- notifier utilities moved to `better_value_notifier`
- deprecated `Color.add*` aliases removed
- `GradientWidget.gradientAlignment` removed
- explicit navigation naming finalized
- focus helper naming finalized

For the full v9 migration guide, read
[`migration_guides.md`](migration_guides.md).

## Example

The example app in `example/` was rebuilt for v9 and acts as the current visual
reference for the package surface.

## License

MIT
