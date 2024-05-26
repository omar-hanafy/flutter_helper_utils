import 'package:flutter_helper_utils/flutter_helper_utils.dart';

bool isEqual<T>(T value1, T value2) {
  if (value1 is List && value2 is List) return value1.isEqual(value2);
  if (value1 is Set && value2 is Set) return value1.isEqual(value2);
  if (value1 is Map && value2 is Map) return value1.isEqual(value2);
  return value1 == value2;
}
