import 'dart:async';

extension TryGetNumUtils on num? {
  int? get tryToInt => this?.toInt();

  double? get tryToDouble => this?.toDouble();
}

extension GetNumUtils on num {
  // bool isLowerThan(num b) => GetUtils.isLowerThan(this, b);

  // bool isGreaterThan(num b) => GetUtils.isGreaterThan(this, b);

  // bool isEqual(num b) => GetUtils.isEqual(this, b);

  /// Utility to delay some callback (or code execution).
  // TODO(Omar): Add a separated implementation of delay() with the ability
  /// to stop it.
  ///
  /// Sample:
  /// ```
  /// void main() async {
  ///   print('+ wait for 2 seconds');
  ///   await 2.delay();
  ///   print('- 2 seconds completed');
  ///   print('+ callback in 1.2sec');
  ///   1.delay(() => print('- 1.2sec callback called'));
  ///   print('currently running callback 1.2sec');
  /// }
  ///```
  Future<void> delay([FutureOr<dynamic> Function()? callback]) async =>
      Future.delayed(
        Duration(milliseconds: (this * 1000).round()),
        callback,
      );

  Future<void> get daysDelay => Future.delayed(days);

  Future<void> get hoursDelay => Future.delayed(hours);

  Future<void> get minDelay => Future.delayed(milliseconds);

  Future<void> get secDelay => Future.delayed(seconds);

  Future<void> get millisecondsDelay => Future.delayed(milliseconds);

  /// Easy way to make Durations from numbers.
  ///
  /// Sample:
  /// ```
  /// print(1.seconds + 200.milliseconds);
  /// print(1.hours + 30.minutes);
  /// print(1.5.hours);
  ///```
  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  Duration get minutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  Duration get hours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  Duration get days => Duration(hours: (this * Duration.hoursPerDay).round());
//final _delayMaps = <Function, Future>{};
// TODO(Omar): create a proper Future and control the Timer.
//  Future delay([double seconds = 0, VoidCallback callback]) async {
//    final ms = (seconds * 1000).round();
//    return Future.delayed(Duration(milliseconds: ms), callback);
//  return _delayMaps[callback];
//  }
//killDelay(VoidCallback callback) {
//  if (_delayMaps.containsKey(callback)) {
//    _delayMaps[callback]?.timeout(Duration.zero, onTimeout: () {
//      print('callbacl eliminado!');
//    });
//    _delayMaps.remove(callback);
//  }
//}
}
