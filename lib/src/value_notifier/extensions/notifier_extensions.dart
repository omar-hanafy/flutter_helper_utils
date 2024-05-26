import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/src/value_notifier/notifier_classes/notifier_classes.dart';

/// extension on [T] where [T] is any non-nullable [Object],
/// Its used to directly make [ValueNotifier] instance from that [T].
extension FHUValueNotifierExtension<T extends Object> on T {
  /// using .notifier on any [Objects] allows you to create an instance of [ValueNotifier] that holds a value of type [T]
  /// for example:
  /// ```dart
  /// // creates ValueNotifier<User>(User()) where user is your custom type/class.
  /// final userNotifier = User().notifier;
  /// ```
  ValueNotifier<T> get notifier => ValueNotifier<T>(this);
}

/// BoolNotifierEx
///
/// Extension on boolean values to provide easy access to creating a [ValueNotifier] for booleans.
extension FHUBoolNotifierEx on bool {
  /// directly make [ValueNotifier] instance from [bool].
  BoolNotifier get notifier => BoolNotifier(this);
}

/// NumNotifierEx
///
/// Extension on numeric values to provide easy access to creating a [ValueNotifier] for numeric types.
extension FHUNumNotifierEx on num {
  /// directly make [ValueNotifier] instance from [num].
  NumNotifier get notifier => NumNotifier(this);
}

/// DoubleNotifierEx
///
/// Extension on double values to provide easy access to creating a [ValueNotifier] for double types.
extension FHUDoubleNotifierEx on double {
  /// directly make [ValueNotifier] instance from [double].
  DoubleNotifier get notifier => DoubleNotifier(this);
}

/// IntNotifierEx
///
/// Extension on integer values to provide easy access to creating a [ValueNotifier] for integers.
extension FHUIntNotifierEx on int {
  /// directly make [ValueNotifier] instance from [int].
  IntNotifier get notifier => IntNotifier(this);
}

/// DateTimeNotifierEx
///
/// Extension on DateTime to provide easy access to creating a [ValueNotifier] for DateTime objects.
extension FHUDateTimeNotifierEx on DateTime {
  /// directly make [ValueNotifier] instance from [DateTime].
  DateTimeNotifier get notifier => DateTimeNotifier(this);
}

/// StringNotifierEx
///
/// Extension on String to provide easy access to creating a [ValueNotifier] for String values.
extension FHUStringNotifierEx on String {
  /// directly make [ValueNotifier] instance from [String].
  StringNotifier get notifier => StringNotifier(this);
}

/// ColorNotifierEx
///
/// Extension on Color to provide easy access to creating a [ValueNotifier] for Color objects.
extension FHUColorNotifierEx on Color {
  /// directly make [ValueNotifier] instance from [Color].
  ColorNotifier get notifier => ColorNotifier(this);
}

/// UriNotifierEx
///
/// Extension on Uri to provide easy access to creating a [ValueNotifier] for Uri objects.
extension FHUUriNotifierEx on Uri {
  /// directly make [ValueNotifier] instance from [Uri].
  UriNotifier get notifier => UriNotifier(this);
}

/// ThemeModeNotifierEx
///
/// Extension on ThemeMode to provide easy access to creating a [ValueNotifier]
extension FHUThemeModeNotifierEx on ThemeMode {
  /// directly make [ValueNotifier] instance from [ThemeMode].
  ThemeModeNotifier get notifier => ThemeModeNotifier(this);
}

/// BrightnessNotifierEx
///
/// Extension on Brightness to provide easy access to creating a [ValueNotifier]
extension FHUBrightnessNotifierEx on Brightness {
  /// directly make [ValueNotifier] instance from [ThemeMode].
  BrightnessNotifier get notifier => BrightnessNotifier(this);
}

/// ListNotifierEx<T>
///
/// Extension on List<T> to provide easy access to creating a [ValueNotifier] for lists of any (primitive types)[https://dart.dev/language/built-in-types].
extension FHUListNotifierEx<E> on List<E> {
  /// directly make [ValueNotifier] instance from [List].
  ListNotifier<E> get notifier => ListNotifier(this);
}

/// SetNotifierEx<T>
///
/// Extension on List<T> to provide easy access to creating a [ValueNotifier] for lists of any (primitive types)[https://dart.dev/language/built-in-types].
extension FHUSetNotifierEx<E> on Set<E> {
  /// directly make [ValueNotifier] instance from [List].
  SetNotifier<E> get notifier => SetNotifier(this);
}

/// MapNotifierEx<K, V>
///
/// Extension on Map<K, V> to provide easy access to creating a [ValueNotifier] for maps of any key-value (primitive types)[https://dart.dev/language/built-in-types].
extension FHUMapNotifierEx<K, V> on Map<K, V> {
  /// directly make [ValueNotifier] instance from [Map].
  MapNotifier<K, V> get notifier => MapNotifier(this);
}
