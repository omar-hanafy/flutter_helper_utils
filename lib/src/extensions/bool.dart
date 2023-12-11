import 'package:flutter_helper_utils/flutter_helper_utils.dart';

extension BoolEx on bool {
  bool get toggled => !this;

  BoolWatcher get watch {
    return BoolWatcher(this);
  }
}

extension BoolNullablelEx on bool? {
  bool get isTrue => val;

  bool get val => this ?? false;

  bool get isFalse => !(this ?? true);

  int get binary => (this ?? false) ? 1 : 0;

  String get binaryText => (this ?? false) ? '1' : '0';

  bool? get toggled => this == null ? null : !this!;
}
