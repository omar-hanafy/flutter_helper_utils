import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/src/value_notifier/notifier_classes/notifier_classes.dart';

/// Extension on any non-nullable [Object].
///
/// Allows you to directly create a [ValueNotifier] instance from the object.
///
/// Example:
/// ```dart
/// // Creates ValueNotifier<User>(User()) where User is your custom type/class.
/// final userNotifier = User().notifier;
/// ```
extension FHUValueNotifierExtension<T extends Object> on T {
  /// Creates a [ValueNotifier] for the current instance.
  ValueNotifier<T> get notifier => ValueNotifier<T>(this);
}

/// Extension on `bool` to provide easy access to creating a [ValueNotifier] for boolean values.
extension FHUBoolNotifierEx on bool {
  /// Creates a [BoolNotifier] instance from the current `bool` value.
  BoolNotifier get notifier => BoolNotifier(this);
}

/// Extension on `num` to provide easy access to creating a [ValueNotifier] for numeric types.
extension FHUNumNotifierEx on num {
  /// Creates a [NumNotifier] instance from the current `num` value.
  NumNotifier get notifier => NumNotifier(this);
}

/// Extension on `double` to provide easy access to creating a [ValueNotifier] for double values.
extension FHUDoubleNotifierEx on double {
  /// Creates a [DoubleNotifier] instance from the current `double` value.
  DoubleNotifier get notifier => DoubleNotifier(this);
}

/// Extension on `int` to provide easy access to creating a [ValueNotifier] for integer values.
extension FHUIntNotifierEx on int {
  /// Creates an [IntNotifier] instance from the current `int` value.
  IntNotifier get notifier => IntNotifier(this);
}

/// Extension on `DateTime` to provide easy access to creating a [ValueNotifier] for `DateTime` objects.
extension FHUDateTimeNotifierEx on DateTime {
  /// Creates a [DateTimeNotifier] instance from the current `DateTime` value.
  DateTimeNotifier get notifier => DateTimeNotifier(this);
}

/// Extension on `String` to provide easy access to creating a [ValueNotifier] for `String` values.
extension FHUStringNotifierEx on String {
  /// Creates a [StringNotifier] instance from the current `String` value.
  StringNotifier get notifier => StringNotifier(this);
}

/// Extension on `Color` to provide easy access to creating a [ValueNotifier] for `Color` objects.
extension FHUColorNotifierEx on Color {
  /// Creates a [ColorNotifier] instance from the current `Color` value.
  ColorNotifier get notifier => ColorNotifier(this);
}

/// Extension on `Uri` to provide easy access to creating a [ValueNotifier] for `Uri` objects.
extension FHUUriNotifierEx on Uri {
  /// Creates a [UriNotifier] instance from the current `Uri` value.
  UriNotifier get notifier => UriNotifier(this);
}

/// Extension on `ThemeMode` to provide easy access to creating a [ValueNotifier] for `ThemeMode`.
extension FHUThemeModeNotifierEx on ThemeMode {
  /// Creates a [ThemeModeNotifier] instance from the current `ThemeMode` value.
  ThemeModeNotifier get notifier => ThemeModeNotifier(this);
}

/// Extension on `Brightness` to provide easy access to creating a [ValueNotifier] for `Brightness`.
extension FHUBrightnessNotifierEx on Brightness {
  /// Creates a [BrightnessNotifier] instance from the current `Brightness` value.
  BrightnessNotifier get notifier => BrightnessNotifier(this);
}

/// Extension on `Iterable<E>` to provide easy access to creating various [ValueNotifier] instances.
///
/// - [ListNotifier] for lists.
/// - [SetNotifier] for sets.
/// - [DoublyLinkedListNotifier] for doubly linked lists.
extension FHUIterableNotifierEx<E> on Iterable<E> {
  /// Creates a [ListNotifier] instance from the current `Iterable<E>`.
  ListNotifier<E> get listNotifier => ListNotifier.from(this);

  /// Creates a [SetNotifier] instance from the current `Iterable<E>`.
  SetNotifier<E> get setNotifier => SetNotifier.from(this);

  /// Creates a [DoublyLinkedListNotifier] instance from the current `Iterable<E>`.
  DoublyLinkedListNotifier<E> get doublyLinkedListNotifier =>
      DoublyLinkedListNotifier.from(this);
}

/// Extension on `List<E>` to provide easy access to creating a [ValueNotifier] for lists.
extension FHUListNotifierEx<E> on List<E> {
  /// Creates a [ListNotifier] instance from the current `List<E>`.
  ListNotifier<E> get notifier => ListNotifier(this);
}

/// Extension on `DoublyLinkedList<E>` to provide easy access to creating a [ValueNotifier] for doubly linked lists.
///
/// [DoublyLinkedList] is a part of the `dart:collection` library.
extension FHUDoublyLinkedListNotifierEx<E> on DoublyLinkedList<E> {
  /// Creates a [DoublyLinkedListNotifier] instance from the current `DoublyLinkedList<E>`.
  DoublyLinkedListNotifier<E> get notifier => DoublyLinkedListNotifier(this);
}

/// Extension on `Set<E>` to provide easy access to creating a [ValueNotifier] for sets.
extension FHUSetNotifierEx<E> on Set<E> {
  /// Creates a [SetNotifier] instance from the current `Set<E>`.
  SetNotifier<E> get notifier => SetNotifier(this);
}

/// Extension on `Map<K, V>` to provide easy access to creating a [ValueNotifier] for maps.
///
/// Allows creating a [MapNotifier] instance from a `Map<K, V>`.
extension FHUMapNotifierEx<K, V> on Map<K, V> {
  /// Creates a [MapNotifier] instance from the current `Map<K, V>`.
  MapNotifier<K, V> get notifier => MapNotifier(this);
}
