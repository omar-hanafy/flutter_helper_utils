# Documentation for PlatformExtension in flutter_helper_utils

## PlatformExtensionNullable on Buildcontext

`PlatformExtension` is an extension on `Buildcontext`, designed to provide a convenient way to query platform-specific properties. This extension can handle nullable `BuildContext` instances and returns null-safe results for various platform checks.

### Target Platform

To get the `TargetPlatform` of the current context.

```dart
var platform = context.targetPlatform;
```

### Is Mobile

To check if the platform is a mobile device.

```dart
bool isMobile = context.isMobile;
```

### Is iOS

To check if the platform is iOS.

```dart
bool isIOS = context.isIOS;
```

### Is Android

To check if the platform is Android.

```dart
bool isAndroid = context.isAndroid;
```

### Is Desktop

To check if the platform is a desktop.

```dart
bool isDesktop = context.isDesktop;
```

### Is macOS

To check if the platform is macOS.

```dart
bool isMacOS = context.isMacOS;
```

### Is Windows

To check if the platform is Windows.

```dart
bool isWindows = context.isWindows;
```

### Is Linux

To check if the platform is Linux.

```dart
bool isLinux = context.isLinux;
```

### Is Apple

To check if the platform is Apple (iOS or macOS).

```dart
bool isApple = context.isApple;
```

### Web Platform Checks

- Is Mobile Web: `context.isMobileWeb`
- Is iOS Web: `context.isIOSWeb`
- Is Android Web: `context.isAndroidWeb`
- Is Desktop Web: `context.isDesktopWeb`
- Is MacOs Web: `context.isMacOsWeb`
- Is Windows Web: `context.isWindowsWeb`
- Is Linux Web: `context.isLinuxWeb`
- Is Apple Web: `context.isAppleWeb`

