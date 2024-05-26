import 'package:flutter/foundation.dart';

extension FHUNullableListExtensions<E> on List<E>? {
  bool isEqual(List<E>? other) => listEquals(this, other);
}

extension FHUMapNullableExtension<K, V> on Map<K, V>? {
  bool isEqual(Map<K, V>? other) => mapEquals(this, other);
}

extension FHUNullableSetExt<E> on Set<E>? {
  bool isEqual(Set<E>? other) => setEquals(this, other);
}
