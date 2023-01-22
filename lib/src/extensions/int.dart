extension IntExtensions on int {
  /// Return the min if this number is smaller then minimum
  /// Return the max if this number is bigger the the maximum
  /// Return this number if it's between the range
  int inRangeOf(int min, int max) {
    if (min.isNull || max.isNull) throw Exception('min or max cannot be null');
    if (min > max) throw ArgumentError('min must be smaller the max');

    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  // ignore: unnecessary_null_comparison
  bool get isNull => this == null;

  /// Returns the absolute value
  int get absolute => abs();

  /// Returns number of digits in this number
  int get numberOfDigits => toString().length;

  /// Returns if the number is positive
  bool get isPositive => this > 0;

  /// Returns if the number is negative
  bool get isNegative => this < 0;

  /// Returns tenth of the number
  double get tenth => this / 10;

  /// Returns fourth of the number
  double get fourth => this / 4;

  /// Returns third of the number
  double get third => this / 3;

  /// Returns half of the number
  double get half => this / 2;

  /// Return this number time two
  int get doubled => this * 2;

  /// Return this number time three
  int get tripled => this * 3;

  /// Return this number time four
  int get quadrupled => this * 4;

  /// Return squared number
  int get squared => this * this;

  /// Convert this integer into boolean.
  ///
  /// Returns `true` if this integer is greater than *0*.
  bool get asBool => this > 0;
}
