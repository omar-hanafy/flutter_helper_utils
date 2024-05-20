import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/src/value_notifier/notifier_classes/notifier_classes.dart';

/// extension on [T] where [T] is any non-nullable [Object],
/// Its used to directly make [Notifier] instance from that [T].
extension FHUValueNotifierExtension<T extends Object> on T {
  /// using .notifier on any [Objects] allows you to create an instance of [Notifier] that holds a value of type [T]
  /// for example:
  /// ```dart
  /// // creates ValueNotifier<User>(User()) where user is your custom type/class.
  /// final userNotifier = User().notifier;
  /// ```
  ValueNotifier<T> get notifier => ValueNotifier<T>(this);
}

/// BoolNotifierEx
///
/// Extension on boolean values to provide easy access to creating a [Notifier] and [CachedNotifier] for booleans.
extension FHUBoolNotifierEx on bool {
  /// directly make [Notifier] instance from [bool].
  BoolNotifier get notifier => BoolNotifier(this);
}

/// NumNotifierEx
///
/// Extension on numeric values to provide easy access to creating a [Notifier] and [CachedNotifier] for numeric types.
extension FHUNumNotifierEx on num {
  /// directly make [Notifier] instance from [num].
  NumNotifier get notifier => NumNotifier(this);
}

/// DoubleNotifierEx
///
/// Extension on double values to provide easy access to creating a [Notifier] and [CachedNotifier] for double types.
extension FHUDoubleNotifierEx on double {
  /// directly make [Notifier] instance from [double].
  DoubleNotifier get notifier => DoubleNotifier(this);
}

/// IntNotifierEx
///
/// Extension on integer values to provide easy access to creating a [Notifier] and [CachedNotifier] for integers.
extension FHUIntNotifierEx on int {
  /// directly make [Notifier] instance from [int].
  IntNotifier get notifier => IntNotifier(this);
}

/// DateTimeNotifierEx
///
/// Extension on DateTime to provide easy access to creating a [Notifier] and [CachedNotifier] for DateTime objects.
extension FHUDateTimeNotifierEx on DateTime {
  /// directly make [Notifier] instance from [DateTime].
  DateTimeNotifier get notifier => DateTimeNotifier(this);
}

/// StringNotifierEx
///
/// Extension on String to provide easy access to creating a [Notifier] and [CachedNotifier] for String values.
extension FHUStringNotifierEx on String {
  /// directly make [Notifier] instance from [String].
  StringNotifier get notifier => StringNotifier(this);
}

/// ColorNotifierEx
///
/// Extension on Color to provide easy access to creating a [Notifier] and [CachedNotifier] for Color objects.
extension FHUColorNotifierEx on Color {
  /// directly make [Notifier] instance from [Color].
  ColorNotifier get notifier => ColorNotifier(this);
}

/// UriNotifierEx
///
/// Extension on Uri to provide easy access to creating a [Notifier] and [CachedNotifier] for Uri objects.
extension FHUUriNotifierEx on Uri {
  /// directly make [Notifier] instance from [Uri].
  UriNotifier get notifier => UriNotifier(this);
}

/// ListNotifierEx<T>
///
/// Extension on List<T> to provide easy access to creating a [Notifier] and [CachedNotifier] for lists of any (primitive types)[https://dart.dev/language/built-in-types].
extension FHUListNotifierEx<E> on List<E> {
  /// directly make [Notifier] instance from [List].
  ListNotifier<E> get notifier => ListNotifier(this);
}

/// SetNotifierEx<T>
///
/// Extension on List<T> to provide easy access to creating a [Notifier] and [CachedNotifier] for lists of any (primitive types)[https://dart.dev/language/built-in-types].
extension FHUSetNotifierEx<E> on Set<E> {
  /// directly make [Notifier] instance from [List].
  SetNotifier<E> get notifier => SetNotifier(this);
}

/// MapNotifierEx<K, V>
///
/// Extension on Map<K, V> to provide easy access to creating a [Notifier] and [CachedNotifier] for maps of any key-value (primitive types)[https://dart.dev/language/built-in-types].
extension FHUMapNotifierEx<K, V> on Map<K, V> {
  /// directly make [Notifier] instance from [Map].
  MapNotifier<K, V> get notifier => MapNotifier(this);
}
