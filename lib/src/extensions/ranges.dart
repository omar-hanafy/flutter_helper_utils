import 'exceptions/range_exception.dart';

extension RangeExtensions on int {
  /// Returns a sequence of integer, starting from [this],
  /// increments by [step] and ends at [end]
  Iterable<int> until(int end, {int step = 1}) sync* {
    if (step == 0) {
      // ignore: only_throw_errors
      throw RException.steps();
    }

    var currentNumber = this;

    if (step > 0) {
      while (currentNumber < end) {
        yield currentNumber;
        currentNumber += step;
      }
    } else {
      while (currentNumber > end) {
        yield currentNumber;
        currentNumber += step;
      }
    }
  }
}
