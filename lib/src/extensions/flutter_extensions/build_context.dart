import 'package:flutter/material.dart';

extension OtherBuildContextExtension on BuildContext {
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}
