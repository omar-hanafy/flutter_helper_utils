<table style="border:none;">
  <tr style="border:none;">
    <td style="vertical-align:top; border:none;">
      <h1 style="border:none; min-width:400px;">Flutter Helper Utils</h1>
      <p style="min-width:400px;">Flutter Helper Utils is a toolkit that streamlines common tasks in Flutter projects. It’s packed with useful extensions and helpers to handle everything from scrolling animations and platform detection to color manipulation and adaptive layout. Our goal is to reduce boilerplate, so you can focus on creating delightful apps without reinventing the wheel.</p>
    </td>
    <td style="vertical-align:top; border:none;">
      <a href="https://pub.dev/packages/flutter_helper_utils" target="_blank">
        <img src="https://raw.githubusercontent.com/omar-hanafy/flutter_helper_utils/main/dash-tools.png" alt="Flutter Helper Utils Logo" style="max-width:400px;"/>
      </a>
    </td>
  </tr>
</table>

> **Dart-only?** We’ve separated the purely Dart-related helpers into [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils). If you need those features in a non-Flutter environment (like a CLI app), feel free to use that package directly. Don’t worry—`flutter_helper_utils` exports it internally, so you can still access all of the Dart helpers without changing your existing imports.

## Getting Started

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  flutter_helper_utils: <latest_version>
```

Then import it into your Dart code:

```dart
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
```

You’ll also automatically get the [`dart_helper_utils`](https://pub.dev/packages/dart_helper_utils) exports, so everything’s in one place.

# Highlights

## PlatformEnv

A modern Web-compatible replacement for `dart:io`'s `Platform` class that works seamlessly across all platforms, including web. The `PlatformEnv` class provides:

```dart
// Simple platform checks
if (PlatformEnv.isIOS) {
  // iOS-specific code
}

// Get detailed platform info
final report = PlatformEnv.report();
print('Operating System: ${report['operatingSystem']}');

// Access system properties
final processors = PlatformEnv.numberOfProcessors;
final pathSeparator = PlatformEnv.pathSeparator;
```

## ValueNotifier Supercharged

Enhanced ValueNotifier functionality with type-safe notifiers and convenient extensions:

- Create notifiers instantly from any value
- Type-safe specialized notifiers
- Simplified builder syntax
- Advanced collection handling

```dart
// Quick notifier creation
final counter = 0.notifier;  // Creates IntNotifier
final isLoading = false.notifier;  // Creates BoolNotifier
final items = <String>[].notifier;  // Creates ListNotifier<String>

// Easy builder syntax
counter.builder((value) => Text('Count: $value'));

// Type-safe operations
counter.increment();  // Built-in methods for specific types
isLoading.toggle();  // Toggles boolean value

// Collection operations with automatic notifications
items.add('New Item');  // Notifies listeners automatically
```

## TypedListView Widget

A powerful, type-safe list view widget with built-in support for headers, footers, separators, and pagination:

- Type safety for list items
- Optional headers and footers
- Custom separators
- Built-in pagination support
- Optimized performance

```dart
TypedListView<Product>(
  items: products,
  itemBuilder: (context, product) => ProductCard(product: product),
  headerBuilder: (context) => CategoryHeader(),
  footerBuilder: (context) => LoadMoreButton(),
  separatorBuilder: (context) => Divider(),
  paginationWidget: CircularProgressIndicator(),
  padding: EdgeInsets.all(16),
  onScrollEnd: () => loadMoreProducts(),
);
```

## Adaptive UI

Create responsive layouts for different screen sizes and platforms (mobile, tablet, desktop).

### Features

- **Efficient:** Rebuilds only when the platform type changes.
- **Easy-to-use context extensions:** Access platform/orientation information directly.
- **Customizable:** Define your own breakpoints and helper extensions.
- **Layout builders:** Convenient widgets for building adaptive UI.

### Basic Usage

```dart
PlatformTypeProvider( // Wrap your app
  child: MyApp(),
); // optionally receive custom breakpoints.

@override
Widget build(BuildContext context) {
  final breakpoint = context.breakpoint; // rebuilds on change.
  return breakpoint.isMobile ? const MobileLayout() : const TabletLayout();
}
```

See the [detailed documentation](https://github.com/omar-hanafy/flutter_helper_utils/blob/main/documentations/adaptive_ui_with_platform_type_detection.md) for adaptive ui
to explore more.

# Extensions

## Theme Extensions

```dart
// Get theme instance
final theme = context.themeData;

// Direct TextStyle access
Text('Some Text', style: theme.bodyMedium)
Text('Some Text', style: theme.titleLarge)
Text('Some Text', style: theme.labelSmall)

// Copy TextStyles with modifications
Text('Some Text', style: theme.labelSmallCopy(color: theme.primary))

// Direct ColorScheme access
final primary = theme.primary;        // Instead of theme.colorScheme.primary
final onSurface = theme.onSurface;    // Instead of theme.colorScheme.onSurface
final isLight = theme.isLight;        // Check if light theme
```

## Color Extensions

Comprehensive color manipulation with support for wide gamut colors and modern color operations:

### New Color API

```dart
final color = Colors.blue;

// New color operations
final contrast = color.contrastColor;  // Gets contrasting color
final isDark = color.isDark;  // Checks if color is dark
final hex = color.toHex(
  includeAlpha: true,
  omitAlphaIfFullOpacity: true,
  uppercase: true
);

// Color transformations
final darker = color.darken(0.2);
final lighter = color.lighten(0.3);
final complementary = color.complementary;
```

### Wide Gamut Support

```dart
// Modern color handling
final wideColor = color.convertToColorSpace(ColorSpace.srgb);
final isInSpace = color.isInColorSpace(ColorSpace.displayP3);

// Opacity operations
final withOpacity = color.addOpacity(0.5); // replaces deprecated withOpacity form the FlutterSDK
final scaled = color.scaleOpacity(0.8);
```

## Scroll Extensions

Rich set of scroll controller extensions for enhanced scrolling functionality:

### Basic Animations

```dart
// Smooth scrolling animations
controller.animateToPosition(500.0);
controller.animateToBottom();
controller.smoothScrollTo(250.0);

// Percentage-based scrolling
controller.scrollToPercentage(0.5);  // Scroll to 50%
```

### Position Detection

```dart
// Position checks
if (controller.isAtTop) {
  // At the top of the scroll view
}

if (controller.isNearBottom(threshold: 50)) {
  // Near the bottom with custom threshold
}

// Get scroll progress
final progress = controller.scrollProgress;  // 0.0 to 1.0
```

## Future & AsyncSnapshot Extensions

Simplified Future handling and AsyncSnapshot state management:

```dart
// Future extensions
myFuture.builder(
  onLoading: () => LoadingSpinner(),
  onSuccess: (data) => SuccessView(data),
  onError: (error) => ErrorView(error),
);

// AsyncSnapshot extensions
snapshot.dataWhen(
  loading: () => LoadingSpinner(),
  error: (error) => ErrorView(error),
  success: (data) => SuccessView(data),
);
```

## BuildContext Extensions

```dart
// Navigation
context.pushPage(NewScreen());
context.pReplacement(ReplacementScreen());
context.popPage();
context.dismissActivePopup();

// Theme access
final theme = context.themeData;
final isDarkMode = context.isDark;
final primaryColor = theme.primaryColor;

// Media queries
final width = context.screenWidth;
final height = context.screenHeight;
final padding = context.padding;
final orientation = context.deviceOrientation;

// Focus handling
context.unFocus(); // Hide keyboard
context.requestFocus; // Request focus

// Scaffold interactions
context.showSnackBar(SnackBar(content: Text('Hello!')));
context.showMaterialBanner(MaterialBanner(...));
```

## Number Extensions

Type-safe number extensions for common UI operations:

### EdgeInsets & Padding

```dart
// Create EdgeInsets
final padding = 16.edgeInsetsAll;
final horizontal = 8.edgeInsetsHorizontal;

// Create Padding widgets
final paddedWidget = 16.paddingAll(child: MyWidget());
```

### BorderRadius & Border

```dart
// Border radius
final radius = 8.allCircular;
final topRadius = 12.onlyTopRounded;
final diagonal = 10.diagonalBLTR;

// Matrix transformations
final matrix = 45.rotationZ;
```

### Box Constraints & Size

```dart
// Size creation
final size = 100.size;
final box = 50.squareBox;

// Constraints
final constraints = 200.boxConstraints;
```

# Widgets

## TypedListView

A type-safe, high-performance list view widget with built-in support for headers, footers, separators, and pagination:

```dart
// Basic usage
TypedListView<Product>(
  items: products,
  itemBuilder: (context, product) => ProductCard(product),
);

// Advanced usage with all features
TypedListView<Product>(
  items: products,
  itemBuilder: (context, product) => ProductCard(product),
  headerBuilder: (context) => CategoryHeader(),
  footerBuilder: (context) => LoadMoreButton(),
  separatorBuilder: (context) => const Divider(),
  paginationWidget: const CircularProgressIndicator(),
  padding: 16.edgeInsetsAll,
  onScrollEnd: () => loadMoreProducts(),
);
```

## GradientWidget

Apply gradient effects to any widget with ease:

```dart
GradientWidget(
  gradient: const LinearGradient(
    colors: [Colors.blue, Colors.purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  child: const Text('Gradient Text'),
);
```

## MultiTapDetector

Detect and handle multi-tap gestures with configurable tap count:

```dart
MultiTapDetector(
  tapCount: 2, // Double tap
  onTap: () => print('Double tapped!'),
  child: Container(
    height: 100,
    color: Colors.blue,
    child: const Center(
      child: Text('Double tap me!'),
    ),
  ),
);
```

## ThemeWithoutEffects

Selectively disable visual feedback effects (splash, highlight, hover) for specific parts of your app:

```dart
// Disable all effects
ThemeWithoutEffects(
  child: MyWidget(),
);

// Customize which effects to disable
ThemeWithoutEffects.custom(
  disableSplash: true,
  disableHighlight: true,
  disableHover: false,
  child: MyWidget(),
);
```

## PlatformTypeProvider

Enable adaptive UI features and platform-specific behavior:

```dart
PlatformTypeProvider(
  // Optional custom breakpoints
  breakpoints: const PlatformBreakpoints(
    mobileMax: 600,
    tabletMax: 1000,
  ),
  child: MaterialApp(
    home: Builder(
      builder: (context) {
        // Access platform info
        final info = context.platformSizeInfo;
        
        // Build responsive layout
        return info.when(
          mobile: () => MobileLayout(),
          tablet: () => TabletLayout(),
          desktop: () => DesktopLayout(),
        );
      },
    ),
  ),
);
```

## ListenablesBuilder

Efficiently manage and respond to changes in multiple Listenable objects:

```dart
// Multiple controllers/notifiers
final controllers = [
  textController,
  scrollController,
  valueNotifier,
];

ListenablesBuilder(
  listenables: controllers,
  builder: (context) {
    return Column(
      children: [
        Text(textController.text),
        Text('Scroll offset: ${scrollController.offset}'),
        Text('Value: ${valueNotifier.value}'),
      ],
    );
  },
  // Optional: Control when to rebuild
  buildWhen: (previous, current) {
    return previous != current; // default.
  },
  // Optional: Debounce rapid changes
  threshold: const Duration(milliseconds: 100),
);
```

# Utilities

## File Handling

Enhanced file handling with robust MIME type detection and processing:

```dart
// Check file types
'image.png'.isImage;  // true
'document.pdf'.isPDF;  // true
'video.mp4'.isVideo;  // true

// Get MIME type
final mimeType = 'file.jpg'.mimeType();  // 'image/jpeg'
```

## Platform Detection

Comprehensive platform detection across web and native platforms:

```dart
// Basic platform checks
context.isMobile;      // true on iOS/Android
context.isDesktop;     // true on Windows/macOS/Linux
context.isWeb;         // true on web platforms

// Specific platform + web checks
context.isMobileWeb;   // true on mobile browsers
context.isDesktopWeb;  // true on desktop browsers
context.isIOSWeb;      // true on iOS Safari
```

## Theme Utilities

Utilities for theme manipulation and management:

```dart
// Remove specific effects
final cleanTheme = themeData.withoutEffects(
  disableSplash: true,
  disableHover: true,
);

// Access theme colors directly
final surface = theme.surface;  // Instead of theme.colorScheme.surface
final primary = theme.primary;  // Instead of theme.colorScheme.primary
```

## Contributions

Contributions to this package are welcome. If you have any suggestions, issues, or feature requests, please create a pull request in the [repository](https://github.com/omar-hanafy/flutter_helper_utils).

## License

`flutter_helper_utils` is available under the [BSD 3-Clause License](https://opensource.org/license/bsd-3-clause/).

<a href="https://www.buymeacoffee.com/omar.hanafy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
