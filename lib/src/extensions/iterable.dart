import 'dart:collection';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_helper_utils/src/extensions/extensions.dart';

/* SUGGESTIONS:
When designing utility extensions for a language like Dart, which is used extensively in Flutter development, it’s crucial to consider both the common use cases and the pain points that developers might encounter. Here are some suggestions to consider adding to your `ListExtensions` class, which might provide additional value to users of your `flutter_helper_utils` package:

1. **Safe Element Replacement:**
   - A null-safe version of the `replaceRange` method could be beneficial. It could replace a range of elements with other elements without throwing an exception if the range is out of bounds.

2. **Batching:**
   - A method to divide the list into batches of a specified size could be very useful when dealing with pagination or processing large datasets in chunks.

3. **Null-Safe Concatenation:**
   - Extending the idea of `concatWithSingleList` and `concatWithMultipleList`, you could provide a null-safe concatenation that ignores null lists instead of considering them empty lists.

4. **Shuffling:**
   - A null-safe `shuffle` method that shuffles the list in place, but only if the list is not null or empty.

5. **Mapping with Index:**
   - A version of `map` that provides the index along with the element could be useful for operations that require the element's position within the list.

6. **Null-Safe Sort:**
   - Null-safe `sort` and `sortBy` extensions that sort the list based on a comparator or by a specific key. It won't perform the operation if the list is null or contains null values that can't be compared.

7. **Deep Equality Check:**
   - A method to check if two lists are deeply equal, i.e., they contain the same elements in the same order.

8. **Finding Sublists:**
   - Methods for finding sublists within a list, either by matching a sequence of elements or by a specific condition.

9. **Null-Safe Accumulate/Reduce:**
   - Accumulate or reduce the list to a single value in a null-safe way, with an option to specify a default value if the list is null or empty.

10. **Partition:**
    - A `partition` function that divides the list into two lists based on a predicate: one list for items that match the predicate and another for items that don't.

11. **Folding with Index:**
    - A version of the `fold` method that includes the index of the element along with the accumulator and the element itself.

Remember that when adding new functionality, it’s essential to ensure that it doesn’t clash with existing methods and that it adheres to the idiomatic practices of the language and the framework it’s used with. Also, consider the performance implications of adding more complex operations, especially for large lists.

Would you like any specific implementation details or examples for any of these suggestions?
*/

typedef IndexedPredicate<T> = bool Function(int index, T);
typedef Predicate<T> = bool Function(T);

extension FHUNullableListExtensions<E> on List<E>? {
  bool isEqual(List<E>? other) => listEquals(this, other);

  /// similar to list[index] but it is null safe.
  E? of(int index) {
    if (isNotEmptyOrNull && index >= 0 && this!.length > index) {
      return this![index];
    }
    return null;
  }

  /// same behavior as [removeAt] but it is null safe which means
  /// it do nothing when [List] return [isEmptyOrNull] to true.
  void tryRemoveAt(int index) {
    if (isNotEmptyOrNull) this!.removeAt(index);
  }

  /// same behavior as [indexOf] but it is null safe which means
  /// it do nothing when [List] return [isEmptyOrNull] to true.
  int? indexOfOrNull(E? element) =>
      isEmptyOrNull || element == null ? null : this!.indexOf(element);

  /// same behavior as [indexWhere] but it is null safe which means
  /// it do nothing when [List] return [isEmptyOrNull] to true.
  int? indexWhereOrNull(Predicate<E> test, [int start = 0]) {
    if (isEmptyOrNull) return null;
    try {
      return this!.indexWhere(test, start);
    } catch (e, s) {
      dev.log('$e', stackTrace: s);
      return null;
    }
  }

  /// same behavior as [removeWhere] but it is null safe which means
  /// it do nothing when [List] return [isEmptyOrNull] to true.
  void tryRemoveWhere(int element) =>
      isEmptyOrNull ? null : this!.removeWhere((element) => false);
}

extension CollectionsExtensionsNS<T> on Iterable<T>? {
  ///Returns [true] if this nullable iterable is either null or empty.
  bool get isEmptyOrNull => isNull || this!.isEmpty;

  ///Returns [false] if this nullable iterable is either null or empty.
  bool get isNotEmptyOrNull => !isEmptyOrNull;

  // get an element at specific index or return null
  T? _elementAtOrNull(int index) {
    return _elementOrNull(index, (_) => null);
  }

  T? _elementOrNull(int index, T? Function(int index) defaultElement) {
    if (isEmptyOrNull) return null;
    if (index < 0) return defaultElement(index);
    var counter = 0;
    for (final element in this!) {
      if (index == counter++) {
        return element;
      }
    }
    return defaultElement(index);
  }

  /// get the first element return null
  T? get firstOrNull => _elementAtOrNull(0);

  /// get the last element if the list is not empty or return null
  T? get lastOrNull => isNotEmptyOrNull ? this!.last : null;

  T? firstWhereOrNull(Predicate<T> predicate) {
    if (isEmptyOrNull) return null;
    for (final element in this!) {
      if (predicate(element)) return element;
    }
    return null;
  }

  /// get the last element or provider default
  /// example:
  /// var name = [danny, ronny, james].lastOrDefault["jack"]; // james
  /// var name = [].lastOrDefault["jack"]; // jack
  T? lastOrDefault(T defaultValue) => lastOrNull ?? defaultValue;

  /// get the first element or provider default
  /// example:
  /// var name = [danny, ronny, james].firstOrDefault["jack"]; // danny
  /// var name = [].firstOrDefault["jack"]; // jack
  T firstOrDefault(T defaultValue) => firstOrNull ?? defaultValue;
}

extension CollectionsExtensions<T> on Iterable<T> {
  /// Returns this Iterable if it's not `null` and the empty list otherwise.
  Iterable<T> orEmpty() => this;

  /// Returns `true` if at least one element matches the given [predicate].
  bool any(Predicate<T> predicate) {
    if (isEmptyOrNull) return false;
    for (final element in orEmpty()) {
      if (predicate(element)) return true;
    }
    return false;
  }

  /// Return a list concatenates the output of the current list and another [iterable]
  List<T> concatWithSingleList(Iterable<T> iterable) {
    if (isEmptyOrNull || iterable.isEmptyOrNull) return [];

    return <T>[...orEmpty(), ...iterable];
  }

  /// Return a list concatenates the output of the current list and multiple [iterables]
  List<T> concatWithMultipleList(List<Iterable<T>> iterables) {
    if (isEmptyOrNull || iterables.isEmptyOrNull) return [];
    final list = iterables.toList(growable: false).expand((i) => i);
    return <T>[...orEmpty(), ...list];
  }

  /// Convert iterable to set
  Set<T> toMutableSet() => Set.from(this);

  /// Returns a set containing all elements that are contained
  /// by both this set and the specified collection.
  Set<T> intersect(Iterable<T> other) => toMutableSet()..addAll(other);

  /// Groups the elements in values by the value returned by key.
  ///
  /// Returns a map from keys computed by key to a list of all values for which
  /// key returns that key. The values appear in the list in the same
  /// relative order as in values.
  // ignore: avoid_shadowing_type_parameters
  Map<K, List<T>> groupBy<T, K>(K Function(T e) key) {
    final map = <K, List<T>>{};
    for (final element in this) {
      map.putIfAbsent(key(element as T), () => []).add(element);
    }
    return map;
  }

  /// Returns a list containing only elements matching the given [predicate].
  List<T> filter(Predicate<T> test) {
    final result = <T>[];
    forEach((e) {
      if (e != null && test(e)) {
        result.add(e);
      }
    });
    return result;
  }

  /// Returns a list containing all elements not matching the given [predicate] and will filter nulls as well.
  List<T> filterNot(Predicate<T> test) {
    final result = <T>[];
    forEach((e) {
      if (e != null && !test(e)) {
        result.add(e);
      }
    });
    return result;
  }

// return the half size of a list
  int get halfLength => (length / 2).floor();

  /// Returns a list containing first [n] elements.
  List<T> takeOnly(int n) {
    if (n == 0) return [];

    final list = List<T>.empty();
    final thisList = toList();
    final resultSize = length - n;
    if (resultSize <= 0) return [];
    if (resultSize == 1) return [last];

    List.generate(n, (index) {
      list.add(thisList[index]);
    });

    return list;
  }

  /// Returns a list containing all elements except first [n] elements.
  List<T> drop(int n) {
    if (n == 0) return [];

    final list = List<T>.empty();
    final originalList = toList();
    final resultSize = length - n;
    if (resultSize <= 0) return [];
    if (resultSize == 1) return [last];

    originalList
      ..removeRange(0, n)
      ..forEach(list.add);

    return list;
  }

  // Returns map operation as a List
  List<E> mapList<E>(E Function(T e) f) => map(f).toList();

  // Takes the first half of a list
  List<T> firstHalf() => take(halfLength).toList();

  // Takes the second half of a list
  List<T> secondHalf() => drop(halfLength).toList();

  /// returns a list with two swapped items
  /// [i] first item
  /// [j] second item
  List<T> swap(int i, int j) {
    final list = toList();
    final aux = list[i];
    list[i] = list[j];
    list[j] = aux;
    return list;
  }

  T getRandom() {
    final generator = Random();
    final index = generator.nextInt(length);
    return toList()[index];
  }

  /// Will retrun new [Iterable] with all elements that satisfy the predicate [predicate],
  Iterable<T> whereIndexed(IndexedPredicate<T> predicate) =>
      _IndexedWhereIterable(this, predicate);

  ///
  /// Performs the given action on each element on iterable, providing sequential index with the element.
  /// [item] the element on the current iteration
  /// [index] the index of the current iteration
  ///
  /// example:
  /// ["a","b","c"].forEachIndexed((element, index) {
  ///    print("$element, $index");
  ///  });
  /// result:
  /// a, 0
  /// b, 1
  /// c, 2
  void forEachIndexed(void Function(T element, int index) action) {
    var index = 0;
    for (final element in this) {
      action(element, index++);
    }
  }

  /// Returns a new list with all elements sorted according to descending
  /// natural sort order.
  List<T> sortedDescending() =>
      toList()..sort((a, b) => -(a as Comparable).compareTo(b));

  /// Checks if all elements in the specified [collection] are contained in
  /// this collection.
  bool containsAll(Iterable<T> collection) {
    for (final element in collection) {
      if (!contains(element)) return false;
    }
    return true;
  }

  /// Return a number of the existing elements by a specific predicate
  /// example:
  ///  final aboveTwenty = [
  ///    User(33, "chicko"),
  ///    User(45, "ronit"),
  ///    User(19, "amsalam"),
  ///  ].count((user) => user.age > 20); // 2
  int count([Predicate<T>? predicate]) {
    var count = 0;
    if (predicate == null) {
      return length;
    } else {
      for (final current in this) {
        if (predicate(current)) {
          count++;
        }
      }
    }

    return count;
  }

  /// Returns `true` if all elements match the given predicate.
  /// Example:
  /// [5, 19, 2].all(isEven), isFalse)
  /// [6, 12, 2].all(isEven), isTrue)
  bool all(Predicate<T>? predicate) {
    for (final e in this) {
      if (!predicate!(e)) return false;
    }
    return true;
  }

  /// Returns a list containing only the elements from given collection having distinct keys.
  ///
  /// Basically it's just like distinct function but with a predicate
  /// example:
  /// [
  ///    User(22, "Sasha"),
  ///    User(23, "Mika"),
  ///    User(23, "Miryam"),
  ///    User(30, "Josh"),
  ///    User(36, "Ran"),
  ///  ].distinctBy((u) => u.age).forEach((user) {
  ///    print("${user.age} ${user.name}");
  ///  });
  ///
  /// result:
  /// 22 Sasha
  /// 23 Mika
  /// 30 Josh
  /// 36 Ran
  // ignore: inference_failure_on_function_return_type
  List<T> distinctBy(Predicate<T> predicate) {
    // ignore: inference_failure_on_instance_creation
    final set = HashSet();
    final list = <T>[];
    toList().forEach((e) {
      if (set.add(predicate(e))) {
        list.add(e);
      }
    });
    return list;
  }

  /// Returns a set containing all elements that are contained by this collection
  /// and not contained by the specified collection.
  /// The returned set preserves the element iteration order of the original collection.
  ///
  /// example:
  ///
  /// [1,2,3,4,5,6].subtract([4,5,6])
  ///
  /// result:
  /// 1,2,3

  dynamic subtract(Iterable<T> other) => toSet()..removeAll(other);

  /// Returns the first element matching the given [predicate], or `null`
  /// if element was not found.
  T? find(Predicate<T> predicate) {
    for (final element in this) {
      if (predicate(element)) {
        return element;
      }
    }

    return null;
  }
}

// A lazy [Iterable] skip elements do **NOT** match the predicate [_f].
class _IndexedWhereIterable<E> extends Iterable<E> {
  _IndexedWhereIterable(this._iterable, this._f);

  final Iterable<E> _iterable;
  final IndexedPredicate<E> _f;

  @override
  Iterator<E> get iterator => _IndexedWhereIterator<E>(_iterable.iterator, _f);
}

/// [Iterator] for [_IndexedWhereIterable]
class _IndexedWhereIterator<E> implements Iterator<E> {
  _IndexedWhereIterator(this._iterator, this._f);

  final Iterator<E> _iterator;
  final IndexedPredicate<E> _f;
  int _index = 0;

  @override
  bool moveNext() {
    while (_iterator.moveNext()) {
      if (_f(_index++, _iterator.current)) {
        return true;
      }
    }
    return false;
  }

  @override
  E get current => _iterator.current;
}
