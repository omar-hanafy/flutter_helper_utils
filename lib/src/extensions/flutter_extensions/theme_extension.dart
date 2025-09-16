import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/src/extensions/flutter_extensions/flutter_extensions.dart';

/// Provides extensions on [BuildContext] to easily access theme data and custom theme extensions.
extension FHUThemeExtension on BuildContext {
  /// Returns the [ThemeData] of the nearest [Theme] ancestor.
  ThemeData get themeData => Theme.of(this);

  /// Added new themeExtension which returns a custom theme extension of type [T] from the nearest [Theme] ancestor.
  /// Returns a custom theme extension of type [T] from the nearest [Theme] ancestor.
  T? themeExtension<T>() => Theme.of(this).extension<T>();

  /// Added new `themeWithExtension` which Returns a tuple containing the [ThemeData] and a custom theme extension of type [T].
  /// Returns a tuple containing the [ThemeData] and a custom theme extension of type [T].
  (ThemeData theme, T? extension) themeWithExtension<T>() {
    final theme = themeData;
    return (theme, theme.extension());
  }

  /// Returns the platform's brightness setting (light or dark).
  Brightness get sysBrightness => mq.platformBrightness;

  /// Returns the [TextTheme] from the current theme.
  TextTheme get txtTheme => themeData.textTheme;

  /// Returns the [Brightness] of the current theme.
  Brightness get brightness => themeData.brightness;

  /// Returns `true` if the current theme's brightness is dark.
  bool get isDark => brightness == Brightness.dark;

  /// Returns `true` if the current theme's brightness is light.
  bool get isLight => brightness == Brightness.light;

  /// Returns a color from the current theme's [ColorScheme] by its exact name.
  ///
  /// Example:
  ///   `context.schemeColor('primary')`
  ///
  /// Set [caseSensitive] to `false` to allow case-insensitive lookup.
  /// Returns `null` if the name does not match any color in the scheme.
  Color? schemeColor(String name, {bool caseSensitive = true}) =>
      themeData.colorFromScheme(name, caseSensitive: caseSensitive);
}

/// Provides extensions on [ThemeData] to easily access text styles and check brightness.
extension FHUThemeDataExtension on ThemeData {
  /// Returns `true` if the theme's brightness is dark.
  bool get isDark => brightness == Brightness.dark;

  /// Returns `true` if the theme's brightness is light.
  bool get isLight => brightness == Brightness.light;

  /// Returns the `displayLarge` text style from the theme's [TextTheme].
  TextStyle? get displayLarge => textTheme.displayLarge;

  /// Returns the `displayMedium` text style from the theme's [TextTheme].
  TextStyle? get displayMedium => textTheme.displayMedium;

  /// Returns the `displaySmall` text style from the theme's [TextTheme].
  TextStyle? get displaySmall => textTheme.displaySmall;

  /// Returns the `headlineLarge` text style from the theme's [TextTheme].
  TextStyle? get headlineLarge => textTheme.headlineLarge;

  /// Returns the `headlineMedium` text style from the theme's [TextTheme].
  TextStyle? get headlineMedium => textTheme.headlineMedium;

  /// Returns the `headlineSmall` text style from the theme's [TextTheme].
  TextStyle? get headlineSmall => textTheme.headlineSmall;

  /// Returns the `titleLarge` text style from the theme's [TextTheme].
  TextStyle? get titleLarge => textTheme.titleLarge;

  /// Returns the `titleMedium` text style from the theme's [TextTheme].
  TextStyle? get titleMedium => textTheme.titleMedium;

  /// Returns the `titleSmall` text style from the theme's [TextTheme].
  TextStyle? get titleSmall => textTheme.titleSmall;

  /// Returns the `bodyLarge` text style from the theme's [TextTheme].
  TextStyle? get bodyLarge => textTheme.bodyLarge;

  /// Returns the `bodyMedium` text style from the theme's [TextTheme].
  TextStyle? get bodyMedium => textTheme.bodyMedium;

  /// Returns the `bodySmall` text style from the theme's [TextTheme].
  TextStyle? get bodySmall => textTheme.bodySmall;

  /// Returns the `labelLarge` text style from the theme's [TextTheme].
  TextStyle? get labelLarge => textTheme.labelLarge;

  /// Returns the `labelMedium` text style from the theme's [TextTheme].
  TextStyle? get labelMedium => textTheme.labelMedium;

  /// Returns the `labelSmall` text style from the theme's [TextTheme].
  TextStyle? get labelSmall => textTheme.labelSmall;

  TextStyle? displayLargeCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.displayLarge?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? displayMediumCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.displayMedium?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? displaySmallCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.displaySmall?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? headlineLargeCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.headlineLarge?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? headlineMediumCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.headlineMedium?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? headlineSmallCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.headlineSmall?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? titleLargeCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.titleLarge?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? titleMediumCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.titleMedium?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? titleSmallCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.titleSmall?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? bodyLargeCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.bodyLarge?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? bodyMediumCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.bodyMedium?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? bodySmallCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.bodySmall?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? labelLargeCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.labelLarge?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? labelMediumCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.labelMedium?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  TextStyle? labelSmallCopy({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) =>
      textTheme.labelSmall?.copyWith(
        inherit: inherit,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      );

  /// Modifies the current [ThemeData] to optionally remove various visual feedback effects.
  ///
  /// This method returns a copy of the original [ThemeData] with modifications based
  /// on the provided boolean arguments:
  ///
  /// - `noSplashColor` (default: `true`): If true, sets `splashColor` to transparent.
  /// - `noHighlightColor` (default: `true`): If true, sets `highlightColor` to transparent.
  /// - `noHoverColor` (default: `true`): If true, sets `hoverColor` to transparent.
  /// - `noDividerColor` (default: `true`): If true, sets `dividerColor` to transparent.
  /// - `noFocusColor` (default: `true`): If true, sets `focusColor` to transparent.
  /// - `noSplashFactory` (default: `true`): If true, replaces `splashFactory` with a custom implementation
  ///   that prevents splash effects.
  ///
  /// You can selectively disable individual effects by setting the corresponding argument to `false`.
  /// For example, to keep the splash color while removing other effects, you would call:
  ///
  /// ```dart
  /// ThemeData newTheme = theme.withoutEffects(noSplashColor: false);
  /// ```
  ThemeData withoutEffects({
    bool noSplashColor = true,
    bool noHighlightColor = true,
    bool noHoverColor = true,
    bool noDividerColor = true,
    bool noFocusColor = true,
    bool noSplashFactory = true,
  }) =>
      copyWith(
        splashColor: noSplashColor ? Colors.transparent : null,
        highlightColor: noHighlightColor ? Colors.transparent : null,
        hoverColor: noHoverColor ? Colors.transparent : null,
        dividerColor: noDividerColor ? Colors.transparent : null,
        focusColor: noFocusColor ? Colors.transparent : null,
        splashFactory: noSplashFactory ? NoSplash.splashFactory : null,
      );
}

extension FHUThemeDataColorSchemeEx on ThemeData {
  /// gets the primary from the ColorScheme of this ThemeData
  /// calling `themeData.primary` is
  /// same as calling `themeData.colorScheme.primary`
  Color get primary => colorScheme.primary;

  /// gets the onPrimary from the ColorScheme of this ThemeData
  /// calling `themeData.onPrimary` is
  /// same as calling `themeData.colorScheme.onPrimary`
  Color get onPrimary => colorScheme.onPrimary;

  /// gets the primaryContainer from the ColorScheme of this ThemeData
  /// calling `themeData.primaryContainer` is
  /// same as calling `themeData.colorScheme.primaryContainer`
  Color get primaryContainer => colorScheme.primaryContainer;

  /// gets the onPrimaryContainer from the ColorScheme of this ThemeData
  /// calling `themeData.onPrimaryContainer` is
  /// same as calling `themeData.colorScheme.onPrimaryContainer`
  Color get onPrimaryContainer => colorScheme.onPrimaryContainer;

  /// gets the secondary from the ColorScheme of this ThemeData
  /// calling `themeData.secondary` is
  /// same as calling `themeData.colorScheme.secondary`
  Color get secondary => colorScheme.secondary;

  /// gets the onSecondary from the ColorScheme of this ThemeData
  /// calling `themeData.onSecondary` is
  /// same as calling `themeData.colorScheme.onSecondary`
  Color get onSecondary => colorScheme.onSecondary;

  /// gets the secondaryContainer from the ColorScheme of this ThemeData
  /// calling `themeData.secondaryContainer` is
  /// same as calling `themeData.colorScheme.secondaryContainer`
  Color get secondaryContainer => colorScheme.secondaryContainer;

  /// gets the onSecondaryContainer from the ColorScheme of this ThemeData
  /// calling `themeData.onSecondaryContainer` is
  /// same as calling `themeData.colorScheme.onSecondaryContainer`
  Color get onSecondaryContainer => colorScheme.onSecondaryContainer;

  /// gets the tertiary from the ColorScheme of this ThemeData
  /// calling `themeData.tertiary` is
  /// same as calling `themeData.colorScheme.tertiary`
  Color get tertiary => colorScheme.tertiary;

  /// gets the onTertiary from the ColorScheme of this ThemeData
  /// calling `themeData.onTertiary` is
  /// same as calling `themeData.colorScheme.onTertiary`
  Color get onTertiary => colorScheme.onTertiary;

  /// gets the tertiaryContainer from the ColorScheme of this ThemeData
  /// calling `themeData.tertiaryContainer` is
  /// same as calling `themeData.colorScheme.tertiaryContainer`
  Color get tertiaryContainer => colorScheme.tertiaryContainer;

  /// gets the onTertiaryContainer from the ColorScheme of this ThemeData
  /// calling `themeData.onTertiaryContainer` is
  /// same as calling `themeData.colorScheme.onTertiaryContainer`
  Color get onTertiaryContainer => colorScheme.onTertiaryContainer;

  /// gets the error from the ColorScheme of this ThemeData
  /// calling `themeData.error` is
  /// same as calling `themeData.colorScheme.error`
  Color get error => colorScheme.error;

  /// gets the onError from the ColorScheme of this ThemeData
  /// calling `themeData.onError` is
  /// same as calling `themeData.colorScheme.onError`
  Color get onError => colorScheme.onError;

  /// gets the errorContainer from the ColorScheme of this ThemeData
  /// calling `themeData.errorContainer` is
  /// same as calling `themeData.colorScheme.errorContainer`
  Color get errorContainer => colorScheme.errorContainer;

  /// gets the onErrorContainer from the ColorScheme of this ThemeData
  /// calling `themeData.onErrorContainer` is
  /// same as calling `themeData.colorScheme.onErrorContainer`
  Color get onErrorContainer => colorScheme.onErrorContainer;

  /// gets the surface from the ColorScheme of this ThemeData
  /// calling `themeData.surface` is
  /// same as calling `themeData.colorScheme.surface`
  Color get surface => colorScheme.surface;

  /// gets the onSurface from the ColorScheme of this ThemeData
  /// calling `themeData.onSurface` is
  /// same as calling `themeData.colorScheme.onSurface`
  Color get onSurface => colorScheme.onSurface;

  /// gets the surfaceContainerHighest from the ColorScheme of this ThemeData
  /// calling `themeData.surfaceContainerHighest` is
  /// same as calling `themeData.colorScheme.surfaceContainerHighest`
  Color get surfaceContainerHighest => colorScheme.surfaceContainerHighest;

  /// gets the onSurfaceVariant from the ColorScheme of this ThemeData
  /// calling `themeData.onSurfaceVariant` is
  /// same as calling `themeData.colorScheme.onSurfaceVariant`
  Color get onSurfaceVariant => colorScheme.onSurfaceVariant;

  /// gets the outline from the ColorScheme of this ThemeData
  /// calling `themeData.outline` is
  /// same as calling `themeData.colorScheme.outline`
  Color get outline => colorScheme.outline;

  /// gets the outlineVariant from the ColorScheme of this ThemeData
  /// calling `themeData.outlineVariant` is
  /// same as calling `themeData.colorScheme.outlineVariant`
  Color get outlineVariant => colorScheme.outlineVariant;

  /// gets the shadow from the ColorScheme of this ThemeData
  /// calling `themeData.shadow` is
  /// same as calling `themeData.colorScheme.shadow`
  Color get shadow => colorScheme.shadow;

  /// gets the scrim from the ColorScheme of this ThemeData
  /// calling `themeData.scrim` is
  /// same as calling `themeData.colorScheme.scrim`
  Color get scrim => colorScheme.scrim;

  /// gets the inverseSurface from the ColorScheme of this ThemeData
  /// calling `themeData.inverseSurface` is
  /// same as calling `themeData.colorScheme.inverseSurface`
  Color get inverseSurface => colorScheme.inverseSurface;

  /// gets the onInverseSurface from the ColorScheme of this ThemeData
  /// calling `themeData.onInverseSurface` is
  /// same as calling `themeData.colorScheme.onInverseSurface`
  Color get onInverseSurface => colorScheme.onInverseSurface;

  /// gets the inversePrimary from the ColorScheme of this ThemeData
  /// calling `themeData.inversePrimary` is
  /// same as calling `themeData.colorScheme.inversePrimary`
  Color get inversePrimary => colorScheme.inversePrimary;

  /// gets the surfaceTint from the ColorScheme of this ThemeData
  /// calling `themeData.surfaceTint` is
  /// same as calling `themeData.colorScheme.surfaceTint`
  Color get surfaceTint => colorScheme.surfaceTint;

  /// gets the primaryFixed from the ColorScheme of this ThemeData
  /// calling `themeData.primaryFixed` is
  /// same as calling `themeData.colorScheme.primaryFixed`
  Color get primaryFixed => colorScheme.primaryFixed;

  /// gets the primaryFixedDim from the ColorScheme of this ThemeData
  /// calling `themeData.primaryFixedDim` is
  /// same as calling `themeData.colorScheme.primaryFixedDim`
  Color get primaryFixedDim => colorScheme.primaryFixedDim;

  /// gets the onPrimaryFixed from the ColorScheme of this ThemeData
  /// calling `themeData.onPrimaryFixed` is
  /// same as calling `themeData.colorScheme.onPrimaryFixed`
  Color get onPrimaryFixed => colorScheme.onPrimaryFixed;

  /// gets the onPrimaryFixedVariant from the ColorScheme of this ThemeData
  /// calling `themeData.onPrimaryFixedVariant` is
  /// same as calling `themeData.colorScheme.onPrimaryFixedVariant`
  Color get onPrimaryFixedVariant => colorScheme.onPrimaryFixedVariant;

  /// gets the secondaryFixed from the ColorScheme of this ThemeData
  /// calling `themeData.secondaryFixed` is
  /// same as calling `themeData.colorScheme.secondaryFixed`
  Color get secondaryFixed => colorScheme.secondaryFixed;

  /// gets the secondaryFixedDim from the ColorScheme of this ThemeData
  /// calling `themeData.secondaryFixedDim` is
  /// same as calling `themeData.colorScheme.secondaryFixedDim`
  Color get secondaryFixedDim => colorScheme.secondaryFixedDim;

  /// gets the onSecondaryFixed from the ColorScheme of this ThemeData
  /// calling `themeData.onSecondaryFixed` is
  /// same as calling `themeData.colorScheme.onSecondaryFixed`
  Color get onSecondaryFixed => colorScheme.onSecondaryFixed;

  /// gets the onSecondaryFixedVariant from the ColorScheme of this ThemeData
  /// calling `themeData.onSecondaryFixedVariant` is
  /// same as calling `themeData.colorScheme.onSecondaryFixedVariant`
  Color get onSecondaryFixedVariant => colorScheme.onSecondaryFixedVariant;

  /// gets the tertiaryFixed from the ColorScheme of this ThemeData
  /// calling `themeData.tertiaryFixed` is
  /// same as calling `themeData.colorScheme.tertiaryFixed`
  Color get tertiaryFixed => colorScheme.tertiaryFixed;

  /// gets the tertiaryFixedDim from the ColorScheme of this ThemeData
  /// calling `themeData.tertiaryFixedDim` is
  /// same as calling `themeData.colorScheme.tertiaryFixedDim`
  Color get tertiaryFixedDim => colorScheme.tertiaryFixedDim;

  /// gets the onTertiaryFixed from the ColorScheme of this ThemeData
  /// calling `themeData.onTertiaryFixed` is
  /// same as calling `themeData.colorScheme.onTertiaryFixed`
  Color get onTertiaryFixed => colorScheme.onTertiaryFixed;

  /// gets the onTertiaryFixedVariant from the ColorScheme of this ThemeData
  /// calling `themeData.onTertiaryFixedVariant` is
  /// same as calling `themeData.colorScheme.onTertiaryFixedVariant`
  Color get onTertiaryFixedVariant => colorScheme.onTertiaryFixedVariant;

  /// gets the surfaceDim from the ColorScheme of this ThemeData
  /// calling `themeData.surfaceDim` is
  /// same as calling `themeData.colorScheme.surfaceDim`
  Color get surfaceDim => colorScheme.surfaceDim;

  /// gets the surfaceBright from the ColorScheme of this ThemeData
  /// calling `themeData.surfaceBright` is
  /// same as calling `themeData.colorScheme.surfaceBright`
  Color get surfaceBright => colorScheme.surfaceBright;

  /// gets the surfaceContainerLowest from the ColorScheme of this ThemeData
  /// calling `themeData.surfaceContainerLowest` is
  /// same as calling `themeData.colorScheme.surfaceContainerLowest`
  Color get surfaceContainerLowest => colorScheme.surfaceContainerLowest;

  /// gets the surfaceContainerLow from the ColorScheme of this ThemeData
  /// calling `themeData.surfaceContainerLow` is
  /// same as calling `themeData.colorScheme.surfaceContainerLow`
  Color get surfaceContainerLow => colorScheme.surfaceContainerLow;

  /// gets the surfaceContainer from the ColorScheme of this ThemeData
  /// calling `themeData.surfaceContainer` is
  /// same as calling `themeData.colorScheme.surfaceContainer`
  Color get surfaceContainer => colorScheme.surfaceContainer;

  /// gets the surfaceContainerHigh from the ColorScheme of this ThemeData
  /// calling `themeData.surfaceContainerHigh` is
  /// same as calling `themeData.colorScheme.surfaceContainerHigh`
  Color get surfaceContainerHigh => colorScheme.surfaceContainerHigh;

  /// Looks up a color from this theme's [ColorScheme] by its exact property name.
  ///
  /// Example names include: `primary`, `onPrimary`, `primaryContainer`,
  /// `onPrimaryContainer`, `secondary`, `onSecondary`, `secondaryContainer`,
  /// `onSecondaryContainer`, `tertiary`, `onTertiary`, `tertiaryContainer`,
  /// `onTertiaryContainer`, `error`, `onError`, `errorContainer`,
  /// `onErrorContainer`, `surface`, `onSurface`, `surfaceContainerHighest`,
  /// `onSurfaceVariant`, `outline`, `outlineVariant`, `shadow`, `scrim`,
  /// `inverseSurface`, `onInverseSurface`, `inversePrimary`, `surfaceTint`,
  /// `primaryFixed`, `primaryFixedDim`, `onPrimaryFixed`,
  /// `onPrimaryFixedVariant`, `secondaryFixed`, `secondaryFixedDim`,
  /// `onSecondaryFixed`, `onSecondaryFixedVariant`, `tertiaryFixed`,
  /// `tertiaryFixedDim`, `onTertiaryFixed`, `onTertiaryFixedVariant`,
  /// `surfaceDim`, `surfaceBright`, `surfaceContainerLowest`,
  /// `surfaceContainerLow`, `surfaceContainer`, `surfaceContainerHigh`.
  ///
  /// Set [caseSensitive] to `false` for case-insensitive lookup.
  /// Returns `null` if the name does not match any color.
  Color? colorFromScheme(String name, {bool caseSensitive = true}) =>
      colorScheme.colorByName(name, caseSensitive: caseSensitive);
}

extension FHUThemeModeEx on ThemeMode? {
  Brightness getBrightness(BuildContext context) {
    switch (this) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        return context.sysBrightness;
      case null:
        return context.sysBrightness;
    }
  }

  bool get isDark => this == ThemeMode.dark;

  bool get isLight => this == ThemeMode.light;

  bool get isSystem => this == ThemeMode.system;
}

extension FHUBrightnessExtension on Brightness? {
  bool get isDark => this == Brightness.dark;

  bool get isLight => this == Brightness.light;
}

extension FHUColorSchemeEx on ColorScheme {
  /// Converts ThemeColors to ThemeData based on brightness.
  ThemeData toThemeData({
    ToggleButtonsThemeData? toggleButtonsTheme,
    SwitchThemeData? switchTheme,
    AppBarTheme? appBarTheme,
    TextTheme? textTheme,
    ElevatedButtonThemeData? elevatedButtonTheme,
    TextButtonThemeData? textButtonTheme,
    FloatingActionButtonThemeData? floatingActionButtonTheme,
    InputDecorationTheme? inputDecorationTheme,
    IconThemeData? iconTheme,
    SnackBarThemeData? snackBarTheme,
    DividerThemeData? dividerTheme,
    NavigationBarThemeData? navigationBarTheme,
    SegmentedButtonThemeData? segmentedButtonTheme,
  }) {
    return ThemeData(
      colorScheme: this,
      toggleButtonsTheme: toggleButtonsTheme,
      switchTheme: switchTheme,
      appBarTheme: appBarTheme,
      textTheme: textTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      textButtonTheme: textButtonTheme,
      floatingActionButtonTheme: floatingActionButtonTheme,
      inputDecorationTheme: inputDecorationTheme,
      iconTheme: iconTheme,
      snackBarTheme: snackBarTheme,
      dividerTheme: dividerTheme,
      navigationBarTheme: navigationBarTheme,
      segmentedButtonTheme: segmentedButtonTheme,
    );
  }

  /// Returns a color from this [ColorScheme] by its property [name].
  ///
  /// Example: `scheme.colorByName('primary')`.
  ///
  /// Set [caseSensitive] to `false` to allow case-insensitive lookup.
  /// Returns `null` if the name does not match any color in this scheme.
  Color? colorByName(String name, {bool caseSensitive = true}) {
    final key = caseSensitive ? name : name.toLowerCase();

    // Build a lookup map from property names to their current values.
    final m = <String, Color>{
      'primary': primary,
      'onPrimary': onPrimary,
      'primaryContainer': primaryContainer,
      'onPrimaryContainer': onPrimaryContainer,
      'secondary': secondary,
      'onSecondary': onSecondary,
      'secondaryContainer': secondaryContainer,
      'onSecondaryContainer': onSecondaryContainer,
      'tertiary': tertiary,
      'onTertiary': onTertiary,
      'tertiaryContainer': tertiaryContainer,
      'onTertiaryContainer': onTertiaryContainer,
      'error': error,
      'onError': onError,
      'errorContainer': errorContainer,
      'onErrorContainer': onErrorContainer,
      'surface': surface,
      'onSurface': onSurface,
      'surfaceContainerHighest': surfaceContainerHighest,
      'onSurfaceVariant': onSurfaceVariant,
      'outline': outline,
      'outlineVariant': outlineVariant,
      'shadow': shadow,
      'scrim': scrim,
      'inverseSurface': inverseSurface,
      'onInverseSurface': onInverseSurface,
      'inversePrimary': inversePrimary,
      'surfaceTint': surfaceTint,
      'primaryFixed': primaryFixed,
      'primaryFixedDim': primaryFixedDim,
      'onPrimaryFixed': onPrimaryFixed,
      'onPrimaryFixedVariant': onPrimaryFixedVariant,
      'secondaryFixed': secondaryFixed,
      'secondaryFixedDim': secondaryFixedDim,
      'onSecondaryFixed': onSecondaryFixed,
      'onSecondaryFixedVariant': onSecondaryFixedVariant,
      'tertiaryFixed': tertiaryFixed,
      'tertiaryFixedDim': tertiaryFixedDim,
      'onTertiaryFixed': onTertiaryFixed,
      'onTertiaryFixedVariant': onTertiaryFixedVariant,
      'surfaceDim': surfaceDim,
      'surfaceBright': surfaceBright,
      'surfaceContainerLowest': surfaceContainerLowest,
      'surfaceContainerLow': surfaceContainerLow,
      'surfaceContainer': surfaceContainer,
      'surfaceContainerHigh': surfaceContainerHigh,
    };

    if (!caseSensitive) {
      // Build a lower-cased view for case-insensitive lookups.
      final lowerMap = <String, Color>{
        for (final entry in m.entries) entry.key.toLowerCase(): entry.value
      };
      return lowerMap[key];
    }

    return m[key];
  }
}

/// A widget that optionally removes various visual feedback effects from its child subtree.
///
/// This widget wraps its child in a [Theme] with modified theme data. The modifications
/// include optionally setting the following properties to transparent:
///
/// - `splashColor`
/// - `highlightColor`
/// - `hoverColor`
/// - `dividerColor`
/// - `focusColor`
///
/// Additionally, it optionally replaces the `splashFactory` with a custom implementation that
/// prevents splash effects from being generated.
///
/// Use this widget to selectively disable visual feedback in specific parts of your
/// application where such effects are not desired.
class ThemeWithoutEffects extends StatelessWidget {
  /// Creates a [ThemeWithoutEffects] widget.
  ///
  /// The [child] is the widget subtree from which visual feedback effects
  /// should be removed.
  ///
  /// The following arguments are booleans that determine if a specific effect should be removed:
  ///
  /// - `noSplashColor` (default: `true`)
  /// - `noHighlightColor` (default: `true`)
  /// - `noHoverColor` (default: `true`)
  /// - `noDividerColor` (default: `true`)
  /// - `noFocusColor` (default: `true`)
  /// - `noSplashFactory` (default: `true`)
  const ThemeWithoutEffects({
    required this.child,
    this.noSplashColor = true,
    this.noHighlightColor = true,
    this.noHoverColor = true,
    this.noDividerColor = true,
    this.noFocusColor = true,
    this.noSplashFactory = true,
    super.key,
  });

  /// The widget subtree to apply the effect to.
  final Widget child;

  /// Whether to remove the `splashColor` effect.
  final bool noSplashColor;

  /// Whether to remove the `highlightColor` effect.
  final bool noHighlightColor;

  /// Whether to remove the `hoverColor` effect.
  final bool noHoverColor;

  /// Whether to remove the `dividerColor` effect.
  final bool noDividerColor;

  /// Whether to remove the `focusColor` effect.
  final bool noFocusColor;

  /// Whether to remove the `splashFactory` effect.
  final bool noSplashFactory;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.themeData.withoutEffects(
        noSplashColor: noSplashColor,
        noHighlightColor: noHighlightColor,
        noHoverColor: noHoverColor,
        noDividerColor: noDividerColor,
        noFocusColor: noFocusColor,
        noSplashFactory: noSplashFactory,
      ),
      child: child,
    );
  }
}
