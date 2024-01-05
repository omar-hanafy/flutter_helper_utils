import 'dart:async';

import 'package:flutter_helper_utils/flutter_helper_utils.dart';

extension DurationExt on Duration {
  /// Utility to delay some callback (or code execution).
  ///
  /// Sample:
  /// ```
  ///   await 3.seconds.delay(() {
  ///           ....
  ///   }
  ///
  ///```
  Future<T> delayed<T>([FutureOr<T> Function()? computation]) async =>
      Future<T>.delayed(this, computation);

  /// Adds the Duration to the current DateTime and returns a DateTime in the future
  DateTime get fromNow => DateTime.now() + this;

  /// Subtracts the Duration from the current DateTime and returns a DateTime in the past
  DateTime get ago => DateTime.now() - this;
}
