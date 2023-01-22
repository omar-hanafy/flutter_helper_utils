import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  void pop<T extends Object?>([T? result]) => Navigator.pop(this, result);
}
