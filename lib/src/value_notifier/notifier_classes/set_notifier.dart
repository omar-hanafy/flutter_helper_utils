import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

/// create a [ValueNotifier] of type Set, which reacts just like normal [Set],
/// but with notifier capabilities.
class SetNotifier<E> extends ValueNotifier<Set<E>> implements Set<E> {
  SetNotifier(super.initial);

  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (_) {}
  }

  void refresh() => notifyListeners();

  /// similar to value setter but this one force trigger the notifyListeners()
  /// event if newValue == value.
  void update(Set<E> newValue) {
    value = newValue;
    refresh();
  }

  /// Will notifyListeners after a specific [action] has been made,
  /// and optionally return a result [R] of certain type.
  R _updateOnAction<R>(R Function() action) {
    final result = action();
    refresh();
    return result;
  }

  /// Provides a view of this [ValueNotifier]'s value as a set of [R] instances.
  ///
  /// If this [ValueNotifier]'s value contains only instances of [R], all read operations
  /// will work correctly. If any operation tries to access an element
  /// that is not an instance of [R], the access will throw instead.
  ///
  /// Elements added to this [ValueNotifier]'s value (e.g., by using [add] or [addAll])
  /// must be instances of [R] to be valid arguments to the adding function,
  /// and they must be instances of [E] as well to be accepted by
  /// this [ValueNotifier]'s value as well.
  ///
  /// Methods which accept one or more `Object?` as argument,
  /// like [contains], [remove] and [removeAll],
  /// will pass the argument directly to the this [ValueNotifier]'s value's method
  /// without any checks.
  /// That means that you can do `setOfStrings.cast<int>().remove("a")`
  /// successfully, even if it looks like it shouldn't have any effect.
  @override
  Set<R> cast<R>() => _updateOnAction(() => value.cast());

  /// An iterator that iterates over the elements of this [ValueNotifier]'s value.
  ///
  /// The order of iteration is defined by the individual `Set` implementation,
  /// but must be consistent between changes to this [ValueNotifier]'s value.
  @override
  Iterator<E> get iterator => value.iterator;

  /// Whether [value] is in this [ValueNotifier]'s value.
  /// ```dart
  /// final charactersValueNotifier = <String>{'A', 'B', 'C'}.notifier;
  /// final containsB = characters.contains('B'); // true
  /// final containsD = characters.contains('D'); // false
  /// ```
  @override
  bool contains(Object? value) =>
      _updateOnAction(() => this.value.contains(value));

  /// Adds [value] to this [ValueNotifier]'s value.
  ///
  /// Returns `true` if [value] (or an equal value) was not yet in this [ValueNotifier]'s value.
  /// Otherwise returns `false` and this [ValueNotifier]'s value is not changed.
  ///
  /// Example:
  /// ```dart
  /// final dateTimesValueNotifier = <DateTime>{}.notifier;
  /// final time1 = DateTime.fromMillisecondsSinceEpoch(0);
  /// final time2 = DateTime.fromMillisecondsSinceEpoch(0);
  /// // time1 and time2 are equal, but not identical.
  /// assert(time1 == time2);
  /// assert(!identical(time1, time2));
  /// final time1Added = dateTimes.add(time1);
  /// print(time1Added); // true
  /// // A value equal to time2 exists already in this [ValueNotifier]'s value, and the call to
  /// // add doesn't change this [ValueNotifier]'s value.
  /// final time2Added = dateTimes.add(time2);
  /// print(time2Added); // false
  ///
  /// print(dateTimes); // {1970-01-01 02:00:00.000}
  /// assert(dateTimes.length == 1);
  /// assert(identical(time1, dateTimes.first));
  /// print(dateTimes.length);
  /// ```
  @override
  bool add(E value) => _updateOnAction(() => this.value.add(value));

  /// Adds all [elements] to this [ValueNotifier]'s value.
  ///
  /// Equivalent to adding each element in [elements] using [add],
  /// but some collections may be able to optimize it.
  /// ```dart
  /// final charactersValueNotifier = <String>{'A', 'B'}.notifier;
  /// characters.addAll({'A', 'B', 'C'});
  /// print(characters); // {A, B, C}
  /// ```
  @override
  void addAll(Iterable<E> elements) =>
      _updateOnAction(() => value.addAll(elements));

  /// Removes [value] from this [ValueNotifier]'s value.
  ///
  /// Returns `true` if [value] was in this [ValueNotifier]'s value, and `false` if not.
  /// The method has no effect if [value] was not in this [ValueNotifier]'s value.
  /// ```dart
  /// final charactersValueNotifier = <String>{'A', 'B', 'C'}.notifier.notifier;
  /// final didRemoveB = characters.remove('B'); // true
  /// final didRemoveD = characters.remove('D'); // false
  /// print(characters); // {A, C}
  /// ```
  @override
  bool remove(Object? value) => _updateOnAction(() => this.value.remove(value));

  /// If an object equal to [object] is in this [ValueNotifier]'s value, return it.
  ///
  /// Checks whether [object] is in this [ValueNotifier]'s value, like [contains], and if so,
  /// returns the object in this [ValueNotifier]'s value, otherwise returns `null`.
  ///
  /// If the equality relation used by this [ValueNotifier]'s value is not identity,
  /// then the returned object may not be *identical* to [object].
  /// Some set implementations may not be able to implement this method.
  /// If the [contains] method is computed,
  /// rather than being based on an actual object instance,
  /// then there may not be a specific object instance representing the
  /// set element.
  /// ```dart
  /// final charactersValueNotifier = <String>{'A', 'B', 'C'}.notifier;
  /// final containsB = characters.lookup('B');
  /// print(containsB); // B
  /// final containsD = characters.lookup('D');
  /// print(containsD); // null
  /// ```
  @override
  E? lookup(Object? object) => _updateOnAction(() => value.lookup(object));

  /// Removes each element of [elements] from this [ValueNotifier]'s value.
  /// ```dart
  /// final charactersValueNotifier = <String>{'A', 'B', 'C'}.notifier;
  /// characters.removeAll({'A', 'B', 'X'});
  /// print(characters); // {C}
  /// ```
  @override
  void removeAll(Iterable<Object?> elements) =>
      _updateOnAction(() => value.removeAll(elements));

  /// Removes all elements of this [ValueNotifier]'s value that are not elements in [elements].
  ///
  /// Checks for each element of [elements] whether there is an element in this
  /// set that is equal to it (according to `this.contains`), and if so, the
  /// equal element in this [ValueNotifier]'s value is retained, and elements that are not equal
  /// to any element in [elements] are removed.
  /// ```dart
  /// final charactersValueNotifier = <String>{'A', 'B', 'C'}.notifier;
  /// characters.retainAll({'A', 'B', 'X'});
  /// print(characters); // {A, B}
  /// ```
  @override
  void retainAll(Iterable<Object?> elements) =>
      _updateOnAction(() => value.retainAll(elements));

  /// Removes all elements of this [ValueNotifier]'s value that satisfy [test].
  /// ```dart
  /// final charactersValueNotifier = <String>{'A', 'B', 'C'}.notifier;
  /// characters.removeWhere((element) => element.startsWith('B'));
  /// print(characters); // {A, C}
  /// ```
  @override
  void removeWhere(bool Function(E element) test) =>
      _updateOnAction(() => value.removeWhere(test));

  /// Removes all elements of this [ValueNotifier]'s value that fail to satisfy [test].
  /// ```dart
  /// final charactersValueNotifier = <String>{'A', 'B', 'C'}.notifier;
  /// characters.retainWhere(
  ///     (element) => element.startsWith('B') || element.startsWith('C'));
  /// print(characters); // {B, C}
  /// ```
  @override
  void retainWhere(bool Function(E element) test) =>
      _updateOnAction(() => value.retainWhere(test));

  /// Whether this [ValueNotifier]'s value contains all the elements of [other].
  /// ```dart
  /// final charactersValueNotifier = <String>{'A', 'B', 'C'}.notifier;
  /// final containsAB = characters.containsAll({'A', 'B'});
  /// print(containsAB); // true
  /// final containsAD = characters.containsAll({'A', 'D'});
  /// print(containsAD); // false
  /// ```
  @override
  bool containsAll(Iterable<Object?> other) =>
      _updateOnAction(() => value.containsAll(other));

  /// Creates a new set which is the intersection between this [ValueNotifier]'s value and [other].
  ///
  /// That is, the returned set contains all the elements of this [Set] that
  /// are also elements of [other] according to `other.contains`.
  /// ```dart
  /// final characters1ValueNotifier = <String>{'A', 'B', 'C'}.notifier;
  /// final characters2 = <String>{'A', 'E', 'F'};
  /// final intersectionSet = characters1.intersection(characters2);
  /// print(intersectionSet); // {A}
  /// ```
  @override
  Set<E> intersection(Set<Object?> other) =>
      _updateOnAction(() => value.intersection(other));

  /// Creates a new set which contains all the elements of this [ValueNotifier]'s value and [other].
  ///
  /// That is, the returned set contains all the elements of this [Set] and
  /// all the elements of [other].
  /// ```dart
  /// final characters1ValueNotifier = <String>{'A', 'B', 'C'}.notifier;
  /// final characters2 = <String>{'A', 'E', 'F'};
  /// final unionSet1 = characters1.union(characters2);
  /// print(unionSet1); // {A, B, C, E, F}
  /// final unionSet2 = characters2.union(characters1);
  /// print(unionSet2); // {A, E, F, B, C}
  /// ```
  @override
  Set<E> union(Set<E> other) => _updateOnAction(() => value.union(other));

  /// Creates a new set with the elements of this that are not in [other].
  ///
  /// That is, the returned set contains all the elements of this [Set] that
  /// are not elements of [other] according to `other.contains`.
  /// ```dart
  /// final characters1ValueNotifier = <String>{'A', 'B', 'C'}.notifier;
  /// final characters2 = <String>{'A', 'E', 'F'};
  /// final differenceSet1 = characters1.difference(characters2);
  /// print(differenceSet1); // {B, C}
  /// final differenceSet2 = characters2.difference(characters1);
  /// print(differenceSet2); // {E, F}
  /// ```
  @override
  Set<E> difference(Set<Object?> other) =>
      _updateOnAction(() => value.difference(other));

  /// Removes all elements from this [ValueNotifier]'s value.
  /// ```dart
  /// final charactersValueNotifier = <String>{'A', 'B', 'C'}.notifier;
  /// characters.clear(); // {}
  /// ```
  @override
  void clear() => _updateOnAction(() => value.clear());

  /// Creates a [Set] with the same elements and behavior as this `Set`.
  ///
  /// The returned set behaves the same as this set
  /// with regard to adding and removing elements.
  /// It initially contains the same elements.
  /// If this set specifies an ordering of the elements,
  /// the returned set will have the same order.
  @override
  Set<E> toSet() => _updateOnAction(() => value.toSet());

  /// Creates the lazy concatenation of this iterable and [other].
  ///
  /// The returned iterable will provide the same elements as this iterable,
  /// and, after that, the elements of [other], in the same order as in the
  /// original iterables.
  ///
  /// Example:
  /// ```dart
  /// var planetsValueNotifier = <String>{'Earth', 'Jupiter'}.notifier;
  /// var updated = planets.followedBy({'Mars', 'Venus'});
  /// print(updated); // (Earth, Jupiter, Mars, Venus)
  /// ```
  @override
  Iterable<E> followedBy(Iterable<E> other) =>
      _updateOnAction(() => value.followedBy(other));

  /// The current elements of this iterable modified by [toElement].
  ///
  /// Returns a new lazy [Iterable] with elements that are created by
  /// calling `toElement` on each element of this `Iterable` in
  /// iteration order.
  ///
  /// The returned iterable is lazy, so it won't iterate the elements of
  /// this iterable until it is itself iterated, and then it will apply
  /// [toElement] to create one element at a time.
  /// The converted elements are not cached.
  /// Iterating multiple times over the returned [Iterable]
  /// will invoke the supplied [toElement] function once per element
  /// for on each iteration.
  ///
  /// Methods on the returned iterable are allowed to omit calling `toElement`
  /// on any element where the result isn't needed.
  /// For example, [elementAt] may call `toElement` only once.
  ///
  /// Equivalent to:
  /// ```dart
  /// Iterable<T> map<T>(T toElement(E e)) sync* {
  ///   for (var value in this) {
  ///     yield toElement(value);
  ///   }
  /// }
  /// ```
  /// Example:
  /// ```dart import:convert
  /// var products = jsonDecode('''
  /// [
  ///   {"name": "Screwdriver", "price": 42.00},
  ///   {"name": "Wingnut", "price": 0.50}
  /// ]
  /// ''');
  /// var values = products.map((product) => product['price'] as double);
  /// var totalPrice = values.fold(0.0, (a, b) => a + b); // 42.5.
  /// ```
  @override
  Iterable<T> map<T>(T Function(E e) toElement) =>
      _updateOnAction(() => value.map(toElement));

  /// Creates a new lazy [Iterable] with all elements that satisfy the
  /// predicate [test].
  ///
  /// The matching elements have the same order in the returned iterable
  /// as they have in [iterator].
  ///
  /// This method returns a view of the mapped elements.
  /// As long as the returned [Iterable] is not iterated over,
  /// the supplied function [test] will not be invoked.
  /// Iterating will not cache results, and thus iterating multiple times over
  /// the returned [Iterable] may invoke the supplied
  /// function [test] multiple times on the same element.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// var result = numbers.where((x) => x < 5); // (1, 2, 3)
  /// result = numbers.where((x) => x > 5); // (6, 7)
  /// result = numbers.where((x) => x.isEven); // (2, 6)
  /// ```
  @override
  Iterable<E> where(bool Function(E element) test) =>
      _updateOnAction(() => value.where(test));

  /// Creates a new lazy [Iterable] with all elements that have type [T].
  ///
  /// The matching elements have the same order in the returned iterable
  /// as they have in [iterator].
  ///
  /// This method returns a view of the mapped elements.
  /// Iterating will not cache results, and thus iterating multiple times over
  /// the returned [Iterable] may yield different results,
  /// if the underlying elements change between iterations.
  @override
  Iterable<T> whereType<T>() => _updateOnAction(() => value.whereType<T>());

  /// Expands each element of this [Iterable] into zero or more elements.
  ///
  /// The resulting Iterable runs through the elements returned
  /// by [toElements] for each element of this, in iteration order.
  ///
  /// The returned [Iterable] is lazy, and calls [toElements] for each element
  /// of this iterable every time the returned iterable is iterated.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int> count(int n) sync* {
  ///   for (var i = 1; i <= n; i++) {
  ///     yield i;
  ///    }
  ///  }
  ///
  /// var numbers = [1, 3, 0, 2];
  /// print(numbers.expand(count)); // (1, 1, 2, 3, 1, 2)
  /// ```
  ///
  /// Equivalent to:
  /// ```dart
  /// Iterable<T> expand<T>(Iterable<T> toElements(E e)) sync* {
  ///   for (var value in this) {
  ///     yield* toElements(value);
  ///   }
  /// }
  /// ```
  @override
  Iterable<T> expand<T>(
    Iterable<T> Function(E element) toElements,
  ) =>
      _updateOnAction(() => value.expand(toElements));

  /// Whether the collection contains an element equal to [element].
  ///
  /// This operation will check each element in order for being equal to
  /// [element], unless it has a more efficient way to find an element
  /// equal to [element].
  /// Stops iterating on the first equal element.
  ///
  /// The equality used to determine whether [element] is equal to an element of
  /// the iterable defaults to the [Object.==] of the element.
  ///
  /// Some types of iterable may have a different equality used for its elements.
  /// For example, a [Set] may have a custom equality
  /// (see [Set.identity]) that its `contains` uses.
  /// Likewise the `Iterable` returned by a [Map.keys] call
  /// should use the same equality that the `Map` uses for keys.
  ///
  /// Example:
  /// ```dart
  /// final gasPlanets = <int, String>{1: 'Jupiter', 2: 'Saturn'};
  /// final containsOne = gasPlanets.keys.contains(1); // true
  /// final containsFive = gasPlanets.keys.contains(5); // false
  /// final containsJupiter = gasPlanets.values.contains('Jupiter'); // true
  /// final containsMercury = gasPlanets.values.contains('Mercury'); // false
  /// ```
  @override
  void forEach(void Function(E element) action) =>
      _updateOnAction(() => value.forEach(action));

  @override
  E reduce(E Function(E value, E element) combine) =>
      _updateOnAction(() => value.reduce(combine));

  /// Reduces a collection to a single value by iteratively combining elements
  /// of the collection using the provided function.
  ///
  /// The iterable must have at least one element.
  /// If it has only one element, that element is returned.
  ///
  /// Otherwise this method starts with the first element from the iterator,
  /// and then combines it with the remaining elements in iteration order,
  /// as if by:
  /// ```dart
  /// E value = iterable.first;
  /// iterable.skip(1).forEach((element) {
  ///   value = combine(value, element);
  /// });
  /// return value;
  /// ```
  /// Example of calculating the sum of an iterable:
  /// ```dart
  /// final numbers = <double>[10, 2, 5, 0.5];
  /// final result = numbers.reduce((value, element) => value + element);
  /// print(result); // 17.5
  /// ```
  @override
  T fold<T>(
    T initialValue,
    T Function(T previousValue, E element) combine,
  ) =>
      _updateOnAction(() => value.fold<T>(initialValue, combine));

  /// Reduces a collection to a single value by iteratively combining each
  /// element of the collection with an existing value
  ///
  /// Uses [initialValue] as the initial value,
  /// then iterates through the elements and updates the value with
  /// each element using the [combine] function, as if by:
  /// ```dart
  /// var value = initialValue;
  /// for (E element in this) {
  ///   value = combine(value, element);
  /// }
  /// return value;
  /// ```
  /// Example of calculating the sum of an iterable:
  /// ```dart
  /// final numbers = <double>[10, 2, 5, 0.5];
  /// const initialValue = 100.0;
  /// final result = numbers.fold<double>(
  ///     initialValue, (previousValue, element) => previousValue + element);
  /// print(result); // 117.5
  /// ```
  @override
  bool every(bool Function(E element) test) =>
      _updateOnAction(() => value.every(test));

  /// Checks whether every element of this iterable satisfies [test].
  ///
  /// Checks every element in iteration order, and returns `false` if
  /// any of them make [test] return `false`, otherwise returns `true`.
  /// Returns `true` if the iterable is empty.
  ///
  /// Example:
  /// ```dart
  /// final planetsByMass = <double, String>{0.06: 'Mercury', 0.81: 'Venus',
  ///   0.11: 'Mars'};
  /// // Checks whether all keys are smaller than 1.
  /// final every = planetsByMass.keys.every((key) => key < 1.0); // true
  /// ```
  @override
  String join([String separator = '']) =>
      _updateOnAction(() => value.join(separator));

  /// Converts each element to a [String] and concatenates the strings.
  ///
  /// Iterates through elements of this iterable,
  /// converts each one to a [String] by calling [Object.toString],
  /// and then concatenates the strings, with the
  /// [separator] string interleaved between the elements.
  ///
  /// Example:
  /// ```dart
  /// final planetsByMass = <double, String>{0.06: 'Mercury', 0.81: 'Venus',
  ///   0.11: 'Mars'};
  /// final joinedNames = planetsByMass.values.join('-'); // Mercury-Venus-Mars
  /// ```
  @override
  bool any(bool Function(E element) test) =>
      _updateOnAction(() => value.any(test));

  /// Checks whether any element of this iterable satisfies [test].
  ///
  /// Checks every element in iteration order, and returns `true` if
  /// any of them make [test] return `true`, otherwise returns false.
  /// Returns `false` if the iterable is empty.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// var result = numbers.any((element) => element >= 5); // true;
  /// result = numbers.any((element) => element >= 10); // false;
  /// ```
  @override
  List<E> toList({bool growable = true, bool refresh = true}) =>
      _updateOnAction(() => value.toList(growable: growable));

  @override
  int get length => value.length;

  @override
  bool get isEmpty => value.isEmpty;

  @override
  bool get isNotEmpty => value.isNotEmpty;

  @override
  Iterable<E> take(int count) => _updateOnAction(() => value.take(count));

  /// Reduces a collection to a single value by iteratively combining elements
  /// of the collection using the provided function.
  ///
  /// The iterable must have at least one element.
  /// If it has only one element, that element is returned.
  ///
  /// Otherwise this method starts with the first element from the iterator,
  /// and then combines it with the remaining elements in iteration order,
  /// as if by:
  /// ```dart
  /// E value = iterable.first;
  /// iterable.skip(1).forEach((element) {
  ///   value = combine(value, element);
  /// });
  /// return value;
  /// ```
  /// Example of calculating the sum of an iterable:
  /// ```dart
  /// final numbers = <double>[10, 2, 5, 0.5];
  /// final result = numbers.reduce((value, element) => value + element);
  /// print(result); // 17.5
  /// ```
  @override
  Iterable<E> takeWhile(bool Function(E value) test) =>
      _updateOnAction(() => value.takeWhile(test));

  /// Reduces a collection to a single value by iteratively combining each
  /// element of the collection with an existing value
  ///
  /// Uses [initialValue] as the initial value,
  /// then iterates through the elements and updates the value with
  /// each element using the [combine] function, as if by:
  /// ```dart
  /// var value = initialValue;
  /// for (E element in this) {
  ///   value = combine(value, element);
  /// }
  /// return value;
  /// ```
  /// Example of calculating the sum of an iterable:
  /// ```dart
  /// final numbers = <double>[10, 2, 5, 0.5];
  /// const initialValue = 100.0;
  /// final result = numbers.fold<double>(
  ///     initialValue, (previousValue, element) => previousValue + element);
  /// print(result); // 117.5
  /// ```
  @override
  Iterable<E> skip(int count) => _updateOnAction(() => value.skip(count));

  /// Checks whether every element of this iterable satisfies [test].
  ///
  /// Checks every element in iteration order, and returns `false` if
  /// any of them make [test] return `false`, otherwise returns `true`.
  /// Returns `true` if the iterable is empty.
  ///
  /// Example:
  /// ```dart
  /// final planetsByMass = <double, String>{0.06: 'Mercury', 0.81: 'Venus',
  ///   0.11: 'Mars'};
  /// // Checks whether all keys are smaller than 1.
  /// final every = planetsByMass.keys.every((key) => key < 1.0); // true
  /// ```
  @override
  Iterable<E> skipWhile(bool Function(E value) test) =>
      _updateOnAction(() => value.skipWhile(test));

  @override
  E get first => value.first;

  @override
  E get last => value.last;

  @override
  E get single => value.single;

  /// The first element that satisfies the given predicate [test].
  ///
  /// Iterates through elements and returns the first to satisfy [test].
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// var result = numbers.firstWhere((element) => element < 5); // 1
  /// result = numbers.firstWhere((element) => element > 5); // 6
  /// result =
  ///     numbers.firstWhere((element) => element > 10, orElse: () => -1); // -1
  /// ```
  ///
  /// If no element satisfies [test], the result of invoking the [orElse]
  /// function is returned.
  /// If [orElse] is omitted, it defaults to throwing a [StateError].
  /// Stops iterating on the first matching element.
  @override
  E firstWhere(bool Function(E element) test,
          {E Function()? orElse, bool refresh = true}) =>
      _updateOnAction(() => value.firstWhere(test, orElse: orElse));

  /// The last element that satisfies the given predicate [test].
  ///
  /// An iterable that can access its elements directly may check its
  /// elements in any order (for example a list starts by checking the
  /// last element and then moves towards the start of the list).
  /// The default implementation iterates elements in iteration order,
  /// checks `test(element)` for each,
  /// and finally returns that last one that matched.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7].notifier;
  /// var result = numbers.lastWhere((element) => element < 5); // 3
  /// result = numbers.lastWhere((element) => element > 5); // 7
  /// result = numbers.lastWhere((element) => element > 10,
  ///     orElse: () => -1); // -1
  /// ```
  ///
  /// If no element satisfies [test], the result of invoking the [orElse]
  /// function is returned.
  /// If [orElse] is omitted, it defaults to throwing a [StateError].
  @override
  E lastWhere(bool Function(E element) test,
          {E Function()? orElse, bool refresh = true}) =>
      _updateOnAction(() => value.lastWhere(test, orElse: orElse));

  /// The single element that satisfies [test].
  ///
  /// Checks elements to see if `test(element)` returns true.
  /// If exactly one element satisfies [test], that element is returned.
  /// If more than one matching element is found, throws [StateError].
  /// If no matching element is found, returns the result of [orElse].
  /// If [orElse] is omitted, it defaults to throwing a [StateError].
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[2, 2, 10];
  /// var result = numbers.singleWhere((element) => element > 5); // 10
  /// ```
  /// When no matching element is found, the result of calling [orElse] is
  /// returned instead.
  /// ```dart continued
  /// result = numbers.singleWhere((element) => element == 1,
  ///     orElse: () => -1); // -1
  /// ```
  /// There must not be more than one matching element.
  /// ```dart continued
  /// result = numbers.singleWhere((element) => element == 2); // Throws Error.
  /// ```
  @override
  E singleWhere(bool Function(E element) test,
          {E Function()? orElse, bool refresh = true}) =>
      _updateOnAction(() => value.singleWhere(test, orElse: orElse));

  /// Returns the [index]th element.
  ///
  /// The [index] must be non-negative and less than [length].
  /// Index zero represents the first element (so `iterable.elementAt(0)` is
  /// equivalent to `iterable.first`).
  ///
  /// May iterate through the elements in iteration order, ignoring the
  /// first [index] elements and then returning the next.
  /// Some iterables may have a more efficient way to find the element.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// final elementAt = numbers.elementAt(4); // 6
  /// ```
  @override
  E elementAt(int index) => _updateOnAction(() => value.elementAt(index));

  /// Compares two sets for element-by-element equality.
  ///
  /// Returns true if this [ValueNotifier]'s values are both null, or if they are both non-null, have
  /// the same length, and contain the same members. Returns false otherwise.
  /// Order is not compared.
  ///
  /// If the elements are maps, lists, sets, or other collections/composite
  /// objects, then the contents of those elements are not compared element by
  /// element unless their equality operators ([Object.==]) do so. For checking
  /// deep equality, consider using the [DeepCollectionEquality] class.
  bool isEqual(Set<E> other) => value.isEqual(other);
}
