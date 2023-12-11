import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

extension ValueListenableBuilderExtension<T> on ValueListenable<T> {
  Stream<T> get stream =>
      Stream.periodic(Duration.zero, (_) => value).distinct();

  Widget watcher({
    required Widget Function(BuildContext, T) builder,
    Widget? child,
  }) {
    return ValueWatcher<T>(
      builder: builder,
      watcher: this,
      child: child,
    );
  }
}

extension ValueNotifierEx<T> on ValueNotifier<T> {
  // Update value if it meets a condition
  void updateIf(bool Function(T) condition, T newValue) {
    if (condition(value)) {
      value = newValue;
    }
  }

  // Perform an action on value change and return a function to remove the listener
  VoidCallback onChange(void Function(T value) action) {
    void listener() => action(value);
    addListener(listener);

    // Return a function that removes the listener
    return () => removeListener(listener);
  }

  VoidCallback debounce(Duration duration, void Function(T value) action) {
    Timer? debounceTimer;

    void listener() {
      debounceTimer?.cancel();
      debounceTimer = Timer(duration, () => action(value));
    }

    addListener(listener);

    return () => {
          debounceTimer?.cancel(),
          removeListener(listener),
        };
  }

// Transform the current value to another type
  ValueNotifier<R> map<R>(R Function(T) transform) {
    final result = ValueNotifier<R>(transform(value));
    addListener(() {
      result.value = transform(value);
    });
    return result;
  }

// Combine with another ValueNotifier
  ValueNotifier<R> combineWith<U, R>(
    ValueNotifier<U> other,
    R Function(T, U) combine,
  ) {
    final combined = ValueNotifier<R>(combine(value, other.value));
    void update() => combined.value = combine(value, other.value);
    addListener(update);
    other.addListener(update);
    return combined;
  }
}

extension BoolValueNotifierEx on ValueNotifier<bool> {
  void toggle() => value = !value;

  void toggleWithCallback(VoidCallback callback) {
    toggle();
    callback();
  }

  Future<void> delayedToggle(Duration delay) async {
    await delay.delayed<void>();
    toggle();
  }

  void conditionalToggle({required bool condition}) {
    if (condition) toggle();
  }

  void setTrue() => value = true;

  void setFalse() => value = false;
}

extension IterableValueNotifierEx<T> on ValueNotifier<Iterable<T>> {
  Iterator<T> get iterator => value.iterator;

  bool contains(Object? value) => this.value.contains(value);

  bool add(T value) => this.value.toSet().add(value);

  void addAll(Iterable<T> elements) => value = [...value, ...elements];

  bool remove(Object? value) {
    final updatedValue = this.value.toSet()..remove(value);
    this.value = updatedValue;
    return updatedValue.contains(value);
  }

  T? lookup(Object? object) {
    for (final element in value) {
      if (element == object) return element;
    }
    return null;
  }

  void removeAll(Iterable<Object?> elements) {
    final updatedValue = value.toSet()..removeAll(elements);
    value = updatedValue;
  }

  void retainAll(Iterable<Object?> elements) {
    final updatedValue = value.toSet()..retainAll(elements);
    value = updatedValue;
  }

  void removeWhere(bool Function(T element) test) {
    final updatedValue = value.where((element) => !test(element)).toList();
    value = updatedValue;
  }

  void retainWhere(bool Function(T element) test) {
    final updatedValue = value.where((element) => test(element)).toList();
    value = updatedValue;
  }

  bool containsAll(Iterable<Object?> other) => value.toSet().containsAll(other);

  Set<T> intersection(Set<Object?> other) => value.toSet().intersection(other);

  Set<T> union(Set<T> other) => value.toSet().union(other);

  Set<T> difference(Set<Object?> other) => value.toSet().difference(other);

  void clear() => value = [];

  Set<T> toSet() => value.toSet();
}

// Extension for ValueNotifier with List<T>
extension ListValueNotifierEx<E> on ValueNotifier<List<E>> {
  void add(E item) {
    value = List.from(value)..add(item);
  }

  void addAll(Iterable<E> items) {
    value = List.from(value)..addAll(items);
  }

  void remove(E item) {
    value = List.from(value)..remove(item);
  }

  void clear() {
    value = List.from(value)..clear();
  }

  E operator [](int index) => value[index];

  void operator []=(int index, E value) => this.value[index] = value;

  set first(E value) => this.value.first = value;

  set last(E value) => this.value.last = value;

  int get length => value.length;

  set length(int newLength) => value.length = newLength;

  Iterable<E> get reversed => value.reversed;

  void sort([int Function(E a, E b)? compare]) => value.sort(compare);

  void shuffle([Random? random]) => value.shuffle(random);

  int indexOf(E element, [int start = 0]) => value.indexOf(element, start);

  int indexWhere(bool Function(E element) test, [int start = 0]) =>
      value.indexWhere(test, start);

  int lastIndexWhere(bool Function(E element) test, [int? start]) =>
      value.lastIndexWhere(test, start);

  int lastIndexOf(E element, [int? start]) => value.lastIndexOf(element, start);

  void insert(int index, E element) => value.insert(index, element);

  void insertAll(int index, Iterable<E> iterable) =>
      value.insertAll(index, iterable);

  void setAll(int index, Iterable<E> iterable) => value.setAll(index, iterable);

  E removeAt(int index) => value.removeAt(index);

  E removeLast() => value.removeLast();

  void removeWhere(bool Function(E element) test) => value.removeWhere(test);

  void retainWhere(bool Function(E element) test) => value.retainWhere(test);

  List<E> operator +(List<E> other) => value + other;

  List<E> sublist(int start, [int? end]) => value.sublist(start, end);

  Iterable<E> getRange(int start, int end) => value.getRange(start, end);

  void setRange(int start, int end, Iterable<E> iterable,
          [int skipCount = 0]) =>
      value.setRange(start, end, iterable, skipCount);

  void removeRange(int start, int end) => value.removeRange(start, end);

  void fillRange(int start, int end, [E? fillValue]) =>
      value.fillRange(start, end, fillValue);

  void replaceRange(int start, int end, Iterable<E> replacements) =>
      value.replaceRange(start, end, replacements);

  Map<int, E> asMap() => value.asMap();
}

// Extension for ValueNotifier with Set<T>
extension SetValueNotifierEx<T> on ValueNotifier<Set<T>> {
  void add(T item) {
    value = Set.from(value)..add(item);
  }

  void addAll(Iterable<T> items) {
    value = Set.from(value)..addAll(items);
  }

  void remove(T item) {
    value = Set.from(value)..remove(item);
  }

  void clear() {
    value = Set.from(value)..clear();
  }
}

extension MapValueNotifierEx<K, V> on ValueNotifier<Map<K, V>> {
  // Adds all key-value pairs from the provided map.
  void addAll(Map<K, V> other) => value.addAll(other);

  // Removes all key-value pairs from the map.
  void clear() => value.clear();

  // Returns an iterable of all keys in the map.
  Iterable<K> get keys => value.keys;

  // Returns an iterable of all values in the map.
  Iterable<V> get values => value.values;

  // Removes the key and its associated value from the map and returns the value.
  V? remove(Object? key) => value.remove(key);

  // Checks if the map contains the specified key.
  bool containsKey(Object? key) => value.containsKey(key);

  // Returns the value associated with the given key, or a default value if the key is not found.
  V? operator [](Object? key) => value[key];

  // Associates a key with a value in the map.
  void operator []=(K key, V value) => this.value[key] = value;

  // Adds all the key-value pairs of the provided map to this map.
  void addEntries(Iterable<MapEntry<K, V>> newEntries) =>
      value.addEntries(newEntries);

  Iterable<MapEntry<K, V>> get entries => value.entries;

  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) convert) =>
      value.map<K2, V2>(convert);

  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) =>
      value.update(key, update, ifAbsent: ifAbsent);

  void updateAll(V Function(K key, V value) update) => value.updateAll(update);

  void removeWhere(bool Function(K key, V value) test) =>
      value.removeWhere(test);

  V putIfAbsent(K key, V Function() ifAbsent) =>
      value.putIfAbsent(key, ifAbsent);

  void forEach(void Function(K key, V value) action) => value.forEach(action);

  int get length => value.length;

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => value.isNotEmpty;
}

extension NumericValueNotifierEx on ValueNotifier<num> {
  // Increment the value by a given step (default is 1).
  void increment([num step = 1]) {
    value += step;
  }

  // Decrement the value by a given step (default is 1).
  void decrement([num step = 1]) {
    value -= step;
  }

  // Multiply the value by a given factor.
  void multiply(num factor) {
    value *= factor;
  }

  // Divide the value by a given divisor. Avoid division by zero.
  void divide(num divisor) {
    if (divisor != 0) {
      value /= divisor;
    }
  }

  // Modulo operation with a given divisor. Avoid division by zero.
  void modulo(num divisor) {
    if (divisor != 0) {
      value %= divisor;
    }
  }

  // Negate the value (change its sign).
  void negate() {
    value = -value;
  }

  // Absolute value (make the value non-negative).
  void abs() {
    value = value.abs();
  }

  // Minimum of the value and another num.
  void min(num other) {
    value = value < other ? value : other;
  }

  // Maximum of the value and another num.
  void max(num other) {
    value = value > other ? value : other;
  }

  // Round the value to the nearest integer.
  void round() {
    value = value.round();
  }

  // Floor the value (round down to the nearest integer).
  void floor() {
    value = value.floor();
  }

  // Ceiling the value (round up to the nearest integer).
  void ceil() {
    value = value.ceil();
  }

  int compareTo(num other) => value.compareTo(other);

  num operator +(num other) => value + other;

  num operator -(num other) => value - other;

  num operator *(num other) => value * other;

  num operator %(num other) => value % other;

  double operator /(num other) => value / other;

  int operator ~/(num other) => value ~/ other;

  num operator -() => -value;

  num remainder(num other) => value.remainder(other);

  bool operator <(num other) => value < other;

  bool operator <=(num other) => value <= other;

  bool operator >(num other) => value > other;

  bool operator >=(num other) => value >= other;

  bool get isNaN => value.isNaN;

  bool get isNegative => value.isNegative;

  bool get isInfinite => value.isInfinite;

  bool get isFinite => value.isFinite;

  num get sign => value.sign;

  int truncate() {
    value = value.truncate();
    return value.toInt();
  }

  double roundToDouble() {
    value = value.roundToDouble();
    return value.toDouble();
  }

  double floorToDouble() {
    value = value.floorToDouble();
    return value.toDouble();
  }

  double ceilToDouble() {
    value = value.ceilToDouble();
    return value.toDouble();
  }

  double truncateToDouble() {
    value = value.truncateToDouble();
    return value.toDouble();
  }

  num clamp(num lowerLimit, num upperLimit) =>
      value.clamp(lowerLimit, upperLimit);

  int toInt() {
    value = value.toInt();
    return value.toInt();
  }

  double toDouble() {
    value = value.toDouble();
    return value.toDouble();
  }

  String toStringAsFixed(int fractionDigits) =>
      value.toStringAsFixed(fractionDigits);

  String toStringAsExponential([int? fractionDigits]) =>
      value.toStringAsExponential(fractionDigits);

  String toStringAsPrecision(int precision) =>
      value.toStringAsPrecision(precision);
}

extension UriValueNotifierEx on ValueNotifier<Uri> {
  String get scheme => value.scheme;

  String get authority => value.authority;

  String get userInfo => value.userInfo;

  String get host => value.host;

  int get port => value.port;

  String get path => value.path;

  String get query => value.query;

  String get fragment => value.fragment;

  List<String> get pathSegments => value.pathSegments;

  Map<String, String> get queryParameters => value.queryParameters;

  Map<String, List<String>> get queryParametersAll => value.queryParametersAll;

  bool get isAbsolute => value.isAbsolute;

  bool get hasScheme => value.hasScheme;

  bool get hasAuthority => value.hasAuthority;

  bool get hasPort => value.hasPort;

  bool get hasQuery => value.hasQuery;

  bool get hasFragment => value.hasFragment;

  bool get hasEmptyPath => value.hasEmptyPath;

  bool get hasAbsolutePath => value.hasAbsolutePath;

  String get origin => value.origin;

  bool isScheme(String scheme) => value.isScheme(scheme);

  UriData? get data => value.data;

  Uri replace({
    String? scheme,
    String? userInfo,
    String? host,
    int? port,
    String? path,
    Iterable<String>? pathSegments,
    String? query,
    Map<String, dynamic /*String?|Iterable<String>*/ >? queryParameters,
    String? fragment,
  }) {
    return value.replace(
      scheme: scheme,
      userInfo: userInfo,
      host: host,
      port: port,
      path: path,
      pathSegments: pathSegments,
      query: query,
      queryParameters: queryParameters,
      fragment: fragment,
    );
  }

  Uri removeFragment() => value.removeFragment();

  Uri resolve(String reference) => value.resolve(reference);

  Uri resolveUri(Uri reference) => value.resolveUri(reference);

  Uri normalizePath() => value.normalizePath();
}
