import 'package:flutter/foundation.dart';

extension NullableSetExt<E> on Set<E>? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;

  bool get isNotEmptyOrNull => !isEmptyOrNull;
  bool isEqual(Set<E>? other) => setEquals(this, other);
}
