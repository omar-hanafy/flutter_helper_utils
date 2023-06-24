import 'package:flutter_helper_utils/flutter_helper_utils.dart';

extension BoolEx on bool? {
  bool get isTrue => isNotNull && this!;

  bool get isFalse => isNull || !this!;

  bool get val => this ?? false;

  int get binary => (this ?? false) ? 1 : 0;

  String get binaryText => (this ?? false) ? '1' : '0';
}
