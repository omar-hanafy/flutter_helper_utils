// For Boolean
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueWatcher<T> extends StatelessWidget {
  const ValueWatcher({
    required this.builder,
    required this.watcher,
    super.key,
    this.child,
  });

  final ValueListenable<T> watcher;
  final Widget Function(BuildContext context, T value) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: watcher,
      builder: (context, value, _) => builder(context, value),
      child: child,
    );
  }
}

class Watcher<T> extends ValueNotifier<T> {
  Watcher(super.initial);

  @override
  String toString() => value.toString();
}

class BoolWatcher extends Watcher<bool> {
  BoolWatcher(super.initial);
}

// For Double
class DoubleWatcher extends Watcher<double> {
  DoubleWatcher(super.initial);

  @override
  String toString() => value.toStringAsFixed(2);
}

// For Integer
class IntWatcher extends Watcher<int> {
  IntWatcher(super.initial);
}

class ObjectWatcher extends Watcher<Object> {
  ObjectWatcher(super.initial);
}

// For Num (covers both int and double)
class NumWatcher extends Watcher<num> {
  NumWatcher(super.initial);
}

// For String
class StringWatcher extends Watcher<String> {
  StringWatcher(super.initial);

  @override
  String toString() => value;
}

// For Color
class ColorWatcher extends Watcher<Color> {
  ColorWatcher(super.initial);
}

// For Uri
class UriWatcher extends Watcher<Uri> {
  UriWatcher(super.initial);
}

// For Generic List<T>
class ListWatcher<T> extends Watcher<List<T>> {
  ListWatcher(super.initial);
}

// For Generic Iterable<T>
class IterableWatcher<E> extends Watcher<Iterable<E>> {
  IterableWatcher(super.initial);
}

// For Generic Map<K, V>
class MapWatcher<K, V> extends Watcher<Map<K, V>> {
  MapWatcher(super.initial);
}

// For Duration
class DurationWatcher extends Watcher<Duration> {
  DurationWatcher(super.initial);
}
