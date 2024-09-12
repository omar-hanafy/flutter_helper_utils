export 'package:dart_helper_utils/dart_helper_utils.dart';

export 'extensions/extensions.dart';
export 'platform_env/platform_env.dart';
export 'value_notifier/value_notifier.dart';
export 'widgets/widgets.dart';
//
// class MediaQuery extends InheritedModel<_MediaQueryAspect> {
//   const MediaQuery({
//     super.key,
//     required this.data,
//     required super.child,
//   });
//
//   MediaQuery.removePadding({
//     super.key,
//     required BuildContext context,
//     bool removeLeft = false,
//     bool removeTop = false,
//     bool removeRight = false,
//     bool removeBottom = false,
//     required super.child,
//   }) : data = MediaQuery.of(context).removePadding(
//           removeLeft: removeLeft,
//           removeTop: removeTop,
//           removeRight: removeRight,
//           removeBottom: removeBottom,
//         );
//
//   MediaQuery.removeViewInsets({
//     super.key,
//     required BuildContext context,
//     bool removeLeft = false,
//     bool removeTop = false,
//     bool removeRight = false,
//     bool removeBottom = false,
//     required super.child,
//   }) : data = MediaQuery.of(context).removeViewInsets(
//           removeLeft: removeLeft,
//           removeTop: removeTop,
//           removeRight: removeRight,
//           removeBottom: removeBottom,
//         );
//
//   MediaQuery.removeViewPadding({
//     super.key,
//     required BuildContext context,
//     bool removeLeft = false,
//     bool removeTop = false,
//     bool removeRight = false,
//     bool removeBottom = false,
//     required super.child,
//   }) : data = MediaQuery.of(context).removeViewPadding(
//           removeLeft: removeLeft,
//           removeTop: removeTop,
//           removeRight: removeRight,
//           removeBottom: removeBottom,
//         );
//
//   @Deprecated('Use MediaQuery.fromView instead. '
//       'This constructor was deprecated in preparation for the upcoming multi-window support. '
//       'This feature was deprecated after v3.7.0-32.0.pre.')
//   static Widget fromWindow({
//     Key? key,
//     required Widget child,
//   }) {
//     return _MediaQueryFromView(
//       key: key,
//       view: WidgetsBinding.instance.window,
//       ignoreParentData: true,
//       child: child,
//     );
//   }
//
//   static Widget fromView({
//     Key? key,
//     required FlutterView view,
//     required Widget child,
//   }) {
//     return _MediaQueryFromView(
//       key: key,
//       view: view,
//       child: child,
//     );
//   }
//
//   static Widget withNoTextScaling({
//     Key? key,
//     required Widget child,
//   }) {
//     return Builder(
//       key: key,
//       builder: (BuildContext context) {
//         assert(debugCheckHasMediaQuery(context));
//         return MediaQuery(
//           data:
//               MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
//           child: child,
//         );
//       },
//     );
//   }
//
//   static Widget withClampedTextScaling({
//     Key? key,
//     double minScaleFactor = 0.0,
//     double maxScaleFactor = double.infinity,
//     required Widget child,
//   }) {
//     assert(maxScaleFactor >= minScaleFactor);
//     assert(!maxScaleFactor.isNaN);
//     assert(minScaleFactor.isFinite);
//     assert(minScaleFactor >= 0);
//
//     return Builder(builder: (BuildContext context) {
//       assert(debugCheckHasMediaQuery(context));
//       final MediaQueryData data = MediaQuery.of(context);
//       return MediaQuery(
//         data: data.copyWith(
//           textScaler: data.textScaler.clamp(
//               minScaleFactor: minScaleFactor, maxScaleFactor: maxScaleFactor),
//         ),
//         child: child,
//       );
//     });
//   }
//
//   final MediaQueryData data;
//
//   static MediaQueryData of(BuildContext context) {
//     return _of(context);
//   }
//
//   static MediaQueryData _of(BuildContext context, [_MediaQueryAspect? aspect]) {
//     assert(debugCheckHasMediaQuery(context));
//     return InheritedModel.inheritFrom<MediaQuery>(context, aspect: aspect)!
//         .data;
//   }
//
//   static MediaQueryData? maybeOf(BuildContext context) {
//     return _maybeOf(context);
//   }
//
//   static MediaQueryData? _maybeOf(BuildContext context,
//       [_MediaQueryAspect? aspect]) {
//     return InheritedModel.inheritFrom<MediaQuery>(context, aspect: aspect)
//         ?.data;
//   }
//
//   static Size sizeOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.size).size;
//
//   static Size? maybeSizeOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.size)?.size;
//
//   static Orientation orientationOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.orientation).orientation;
//
//   static Orientation? maybeOrientationOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.orientation)?.orientation;
//
//   static double devicePixelRatioOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.devicePixelRatio).devicePixelRatio;
//
//   static double? maybeDevicePixelRatioOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.devicePixelRatio)?.devicePixelRatio;
//
//   @Deprecated(
//     'Use textScalerOf instead. '
//     'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
//     'This feature was deprecated after v3.12.0-2.0.pre.',
//   )
//   static double textScaleFactorOf(BuildContext context) =>
//       maybeTextScaleFactorOf(context) ?? 1.0;
//
//   @Deprecated(
//     'Use maybeTextScalerOf instead. '
//     'Use of textScaleFactor was deprecated in preparation for the upcoming nonlinear text scaling support. '
//     'This feature was deprecated after v3.12.0-2.0.pre.',
//   )
//   static double? maybeTextScaleFactorOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.textScaleFactor)?.textScaleFactor;
//
//   static TextScaler textScalerOf(BuildContext context) =>
//       maybeTextScalerOf(context) ?? TextScaler.noScaling;
//
//   static TextScaler? maybeTextScalerOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.textScaler)?.textScaler;
//
//   static Brightness platformBrightnessOf(BuildContext context) =>
//       maybePlatformBrightnessOf(context) ?? Brightness.light;
//
//   static Brightness? maybePlatformBrightnessOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.platformBrightness)
//           ?.platformBrightness;
//
//   static EdgeInsets paddingOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.padding).padding;
//
//   static EdgeInsets? maybePaddingOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.padding)?.padding;
//
//   static EdgeInsets viewInsetsOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.viewInsets).viewInsets;
//
//   static EdgeInsets? maybeViewInsetsOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.viewInsets)?.viewInsets;
//
//   static EdgeInsets systemGestureInsetsOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.systemGestureInsets).systemGestureInsets;
//
//   static EdgeInsets? maybeSystemGestureInsetsOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.systemGestureInsets)
//           ?.systemGestureInsets;
//
//   static EdgeInsets viewPaddingOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.viewPadding).viewPadding;
//
//   static EdgeInsets? maybeViewPaddingOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.viewPadding)?.viewPadding;
//
//   static bool alwaysUse24HourFormatOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.alwaysUse24HourFormat)
//           .alwaysUse24HourFormat;
//
//   static bool? maybeAlwaysUse24HourFormatOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.alwaysUse24HourFormat)
//           ?.alwaysUse24HourFormat;
//
//   static bool accessibleNavigationOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.accessibleNavigation).accessibleNavigation;
//
//   static bool? maybeAccessibleNavigationOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.accessibleNavigation)
//           ?.accessibleNavigation;
//
//   static bool invertColorsOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.invertColors).invertColors;
//
//   static bool? maybeInvertColorsOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.invertColors)?.invertColors;
//
//   static bool highContrastOf(BuildContext context) =>
//       maybeHighContrastOf(context) ?? false;
//
//   static bool? maybeHighContrastOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.highContrast)?.highContrast;
//
//   static bool onOffSwitchLabelsOf(BuildContext context) =>
//       maybeOnOffSwitchLabelsOf(context) ?? false;
//
//   static bool? maybeOnOffSwitchLabelsOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.onOffSwitchLabels)?.onOffSwitchLabels;
//
//   static bool disableAnimationsOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.disableAnimations).disableAnimations;
//
//   static bool? maybeDisableAnimationsOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.disableAnimations)?.disableAnimations;
//
//   static bool boldTextOf(BuildContext context) =>
//       maybeBoldTextOf(context) ?? false;
//
//   static bool? maybeBoldTextOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.boldText)?.boldText;
//
//   static NavigationMode navigationModeOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.navigationMode).navigationMode;
//
//   static NavigationMode? maybeNavigationModeOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.navigationMode)?.navigationMode;
//
//   static DeviceGestureSettings gestureSettingsOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.gestureSettings).gestureSettings;
//
//   static DeviceGestureSettings? maybeGestureSettingsOf(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.gestureSettings)?.gestureSettings;
//
//   static List<ui.DisplayFeature> displayFeaturesOf(BuildContext context) =>
//       _of(context, _MediaQueryAspect.displayFeatures).displayFeatures;
//
//   static List<ui.DisplayFeature>? maybeDisplayFeaturesOf(
//           BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.displayFeatures)?.displayFeatures;
//
//   static bool supportsShowingSystemContextMenu(BuildContext context) =>
//       _of(context, _MediaQueryAspect.supportsShowingSystemContextMenu)
//           .supportsShowingSystemContextMenu;
//
//   static bool? maybeSupportsShowingSystemContextMenu(BuildContext context) =>
//       _maybeOf(context, _MediaQueryAspect.supportsShowingSystemContextMenu)
//           ?.supportsShowingSystemContextMenu;
//
//   @override
//   bool updateShouldNotify(MediaQuery oldWidget) => data != oldWidget.data;
//
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(
//         DiagnosticsProperty<MediaQueryData>('data', data, showName: false));
//   }
//
//   @override
//   bool updateShouldNotifyDependent(
//       MediaQuery oldWidget, Set<Object> dependencies) {
//     return dependencies.any((Object dependency) =>
//         dependency is _MediaQueryAspect &&
//         switch (dependency) {
//           _MediaQueryAspect.size => data.size != oldWidget.data.size,
//           _MediaQueryAspect.orientation =>
//             data.orientation != oldWidget.data.orientation,
//           _MediaQueryAspect.devicePixelRatio =>
//             data.devicePixelRatio != oldWidget.data.devicePixelRatio,
//           _MediaQueryAspect.textScaleFactor =>
//             data.textScaleFactor != oldWidget.data.textScaleFactor,
//           _MediaQueryAspect.textScaler =>
//             data.textScaler != oldWidget.data.textScaler,
//           _MediaQueryAspect.platformBrightness =>
//             data.platformBrightness != oldWidget.data.platformBrightness,
//           _MediaQueryAspect.padding => data.padding != oldWidget.data.padding,
//           _MediaQueryAspect.viewInsets =>
//             data.viewInsets != oldWidget.data.viewInsets,
//           _MediaQueryAspect.viewPadding =>
//             data.viewPadding != oldWidget.data.viewPadding,
//           _MediaQueryAspect.invertColors =>
//             data.invertColors != oldWidget.data.invertColors,
//           _MediaQueryAspect.highContrast =>
//             data.highContrast != oldWidget.data.highContrast,
//           _MediaQueryAspect.onOffSwitchLabels =>
//             data.onOffSwitchLabels != oldWidget.data.onOffSwitchLabels,
//           _MediaQueryAspect.disableAnimations =>
//             data.disableAnimations != oldWidget.data.disableAnimations,
//           _MediaQueryAspect.boldText =>
//             data.boldText != oldWidget.data.boldText,
//           _MediaQueryAspect.navigationMode =>
//             data.navigationMode != oldWidget.data.navigationMode,
//           _MediaQueryAspect.gestureSettings =>
//             data.gestureSettings != oldWidget.data.gestureSettings,
//           _MediaQueryAspect.displayFeatures =>
//             data.displayFeatures != oldWidget.data.displayFeatures,
//           _MediaQueryAspect.systemGestureInsets =>
//             data.systemGestureInsets != oldWidget.data.systemGestureInsets,
//           _MediaQueryAspect.accessibleNavigation =>
//             data.accessibleNavigation != oldWidget.data.accessibleNavigation,
//           _MediaQueryAspect.alwaysUse24HourFormat =>
//             data.alwaysUse24HourFormat != oldWidget.data.alwaysUse24HourFormat,
//           _MediaQueryAspect.supportsShowingSystemContextMenu =>
//             data.supportsShowingSystemContextMenu !=
//                 oldWidget.data.supportsShowingSystemContextMenu,
//         });
//   }
// }
