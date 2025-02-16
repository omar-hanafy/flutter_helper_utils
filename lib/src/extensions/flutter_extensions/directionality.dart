import 'package:flutter/material.dart';

/// A collection of utility extensions for working with text directionality and localization.
///
/// These extensions provide convenient methods for handling RTL/LTR text direction
/// and locale-specific functionality in Flutter applications.
///
/// Example usage:
/// ```dart
/// // Check text direction
/// if (context.isRTL) {
///   // Handle RTL layout
/// }
///
/// // Get locale information
/// print(context.languageCode); // e.g., 'en'
/// ```
extension FHUTextDirection on TextDirection {
  /// Whether the text direction is right-to-left.
  bool get isRTL => this == TextDirection.rtl;

  /// Whether the text direction is left-to-right.
  bool get isLTR => this == TextDirection.ltr;

  /// Converts the text direction to a string representation.
  String get name => this == TextDirection.ltr ? 'ltr' : 'rtl';

  /// Returns the opposite text direction.
  TextDirection get opposite => isRTL ? TextDirection.ltr : TextDirection.rtl;

  /// Returns a multiplier (-1 or 1) useful for RTL-aware calculations.
  ///
  /// Returns:
  /// * 1 for LTR
  /// * -1 for RTL
  double get multiplier => isRTL ? -1.0 : 1.0;
}

/// Extension methods for accessing text directionality from a [BuildContext].
extension FHUContextDirectionality on BuildContext {
  /// The current text direction from the ambient [Directionality].
  TextDirection get directionality => Directionality.of(this);

  /// Whether the current text direction is left-to-right.
  bool get isLTR => directionality.isLTR;

  /// Whether the current text direction is right-to-left.
  bool get isRTL => directionality.isRTL;

  /// The current locale from [Localizations].
  Locale get locale => Localizations.localeOf(this);

  /// A string representation of the current locale.
  ///
  /// Examples:
  /// * "en" for English
  /// * "en_US" for US English
  /// * "ar" for Arabic
  /// * "zh_Hant" for Traditional Chinese
  String get localeString {
    final currentLocale = locale;
    if (currentLocale.scriptCode != null) {
      return '${currentLocale.languageCode}_${currentLocale.scriptCode}';
    } else if (currentLocale.countryCode != null) {
      return '${currentLocale.languageCode}_${currentLocale.countryCode}';
    }
    return currentLocale.languageCode;
  }

  /// The language code of the current locale (e.g., "en" for English).
  String get languageCode => locale.languageCode;

  /// The country code of the current locale (e.g., "US" for United States).
  String? get countryCode => locale.countryCode;

  /// The script code of the current locale (e.g., "Hant" for Traditional Chinese).
  String? get scriptCode => locale.scriptCode;

  /// Returns true if the current locale matches the given language code.
  bool isLanguageCode(String languageCode) => this.languageCode == languageCode;

  /// Returns true if the current locale matches the given script code.
  bool isScriptCode(String scriptCode) => this.scriptCode == scriptCode;

  /// Returns true if the current locale matches the given country code.
  bool isCountryCode(String? countryCode) => this.countryCode == countryCode;

  /// Helper for RTL-aware logical start position.
  /// Returns 1.0 for RTL and 0.0 for LTR.
  double get logicalStart => isRTL ? 1.0 : 0.0;

  /// Helper for RTL-aware logical end position.
  /// Returns 0.0 for RTL and 1.0 for LTR.
  double get logicalEnd => isRTL ? 0.0 : 1.0;

  /// Returns an RTL-aware alignment for logical start position.
  AlignmentGeometry get logicalStartAlignment =>
      isRTL ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart;

  /// Returns an RTL-aware alignment for logical end position.
  AlignmentGeometry get logicalEndAlignment =>
      isRTL ? AlignmentDirectional.centerStart : AlignmentDirectional.centerEnd;

  /// Creates RTL-aware directional padding.
  ///
  /// Example:
  /// ```dart
  /// Container(
  ///   padding: context.logicalPadding(start: 16, end: 8),
  ///   child: Text('Hello'),
  /// )
  /// ```
  EdgeInsetsGeometry logicalPadding({
    double start = 0.0,
    double end = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) =>
      EdgeInsetsDirectional.fromSTEB(start, top, end, bottom);

  /// Creates RTL-aware directional margin.
  EdgeInsetsGeometry logicalMargin({
    double start = 0.0,
    double end = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) =>
      EdgeInsetsDirectional.fromSTEB(start, top, end, bottom);

  /// Common language checks
  bool get isArabic => languageCode == 'ar';

  bool get isEnglish => languageCode == 'en';

  bool get isPersian => languageCode == 'fa';

  bool get isHebrew => languageCode == 'he';

  bool get isUrdu => languageCode == 'ur';

  /// Returns true if the current language is typically written RTL.
  bool get isRTLLanguage => isArabic || isPersian || isHebrew || isUrdu;

  /// Returns a direction-aware translation offset.
  ///
  /// Useful for animations and positioning that need to respect text direction.
  Offset directionAwareOffset(double x, double y) =>
      Offset(x * directionality.multiplier, y);

  /// Returns a size adjusted for text direction.
  ///
  /// Useful when you need to flip dimensions based on text direction.
  Size directionAwareSize(double width, double height) =>
      isRTL ? Size(height, width) : Size(width, height);
}

/// Extension for RTL-aware list operations.
extension FHUDirectionalIterable<T> on Iterable<T> {
  /// Returns the iterable in logical order based on the given text direction.
  ///
  /// For RTL, the iterable is reversed.
  Iterable<T> inDirection(TextDirection direction) =>
      direction.isRTL ? toList().reversed : this;

  /// Returns the iterable in logical order based on the current context's direction.
  List<T> inContextDirection(BuildContext context) =>
      inDirection(context.directionality).toList();
}
