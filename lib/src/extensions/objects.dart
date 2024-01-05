import 'package:flutter_helper_utils/flutter_helper_utils.dart';

extension ObjectNullableExtensions on Object? {
  bool get isNull => this == null;

  bool get isNotNull => this != null;

  /// *Rules*:
  ///  * Object is true only if
  ///    1. Object is bool and true.
  ///    2. Object is num and is greater than zero.
  ///    3. Object is string and is equal to 'yes', 'true', '1', or 'ok'.
  /// * any other conditions including null will return false.
  bool get asBool {
    if (this is bool?) return (this as bool?) ?? false;
    if (this is num?) return (this as num?).asBool;
    return '$this'.asBool;
  }
}
