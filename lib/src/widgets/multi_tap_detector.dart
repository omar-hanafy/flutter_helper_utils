import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// Detects repeated taps on one child within a rolling time window.
///
/// [MultiTapDetector] is useful for hidden actions, debug affordances, or
/// deliberate confirmation gestures where a single tap would be too easy to
/// trigger by accident.
///
/// The sequence resets when:
/// - too much time passes between taps
/// - the recognizer is cancelled by another gesture
/// - [tapCount] is reached and [onTap] fires
class MultiTapDetector extends StatefulWidget {
  /// Creates a detector that fires [onTap] after [tapCount] taps within
  /// [duration].
  ///
  /// [tapCount] must be greater than `1`.
  const MultiTapDetector({
    required this.child,
    required this.onTap,
    this.tapCount = 3,
    this.duration = const Duration(milliseconds: 500),
    this.onTapProgress,
    super.key,
  }) : assert(tapCount > 1, 'tapCount must be greater than 1');

  /// The widget that receives the tap sequence.
  final Widget child;

  /// Called when the configured tap sequence completes successfully.
  final VoidCallback onTap;

  /// Reports the current tap count as the sequence progresses.
  ///
  /// The callback is also invoked with `0` when the sequence is reset after a
  /// timeout, cancellation, or successful completion.
  final void Function(int currentCount)? onTapProgress;

  /// The number of consecutive taps required before [onTap] is called.
  final int tapCount;

  /// The maximum gap from one tap release to the next tap press.
  ///
  /// An in-progress tap does not expire while the pointer remains down.
  final Duration duration;

  @override
  State<MultiTapDetector> createState() => _MultiTapDetectorState();
}

class _MultiTapDetectorState extends State<MultiTapDetector> {
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        _SequenceTapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<_SequenceTapGestureRecognizer>(
              _SequenceTapGestureRecognizer.new,
              (instance) => instance.configure(
                tapCount: widget.tapCount,
                duration: widget.duration,
                onTap: widget.onTap,
                onTapProgress: widget.onTapProgress,
              ),
            ),
      },
      child: widget.child,
    );
  }
}

// Owns the sequence and its gap timer while preserving the public serial-tap
// contract: nearby taps with matching buttons, cancellation on movement or
// arena rejection, and victory over competing tap recognizers on pointer-up.
class _SequenceTapGestureRecognizer extends GestureRecognizer {
  int _tapCount = 3;
  Duration _duration = const Duration(milliseconds: 500);
  VoidCallback? _onTap;
  ValueChanged<int>? _onTapProgress;
  int _completedCount = 0;
  Timer? _gapTimer;
  _SequenceTap? _pendingTap;
  _SequenceTap? _lastTap;

  void configure({
    required int tapCount,
    required Duration duration,
    required VoidCallback onTap,
    required ValueChanged<int>? onTapProgress,
  }) {
    if (_tapCount != tapCount || _duration != duration) {
      _reset(reportProgress: false);
    }
    _tapCount = tapCount;
    _duration = duration;
    _onTap = onTap;
    _onTapProgress = onTapProgress;
  }

  @override
  void addAllowedPointer(PointerDownEvent event) {
    if (_pendingTap != null) {
      _reset();
    } else if (_lastTap case final previous?) {
      if (!previous.minimumTimeElapsed ||
          previous.event.buttons != event.buttons ||
          (previous.event.position - event.position).distance >
              kDoubleTapSlop) {
        _reset(reportProgress: false);
      }
    }
    _gapTimer?.cancel();
    _gapTimer = null;
    final tap = _SequenceTap(
      event,
      GestureBinding.instance.gestureArena.add(event.pointer, this),
    );
    _pendingTap = tap;
    GestureBinding.instance.pointerRouter.addRoute(
      event.pointer,
      _handleEvent,
      event.transform,
    );
    _reportProgress(_completedCount + 1);
  }

  void _handleEvent(PointerEvent event) {
    final tap = _pendingTap;
    if (tap == null || tap.event.pointer != event.pointer) return;
    if (event is PointerUpEvent) {
      _registerTap(tap);
    } else if (event is PointerCancelEvent ||
        (event is PointerMoveEvent &&
            (tap.event.position - event.position).distance >
                kDoubleTapTouchSlop)) {
      _reset();
    }
  }

  @override
  void acceptGesture(int pointer) {
    final tap = _pendingTap;
    if (tap != null && tap.event.pointer == pointer) {
      tap.disposition = GestureDisposition.accepted;
    }
  }

  @override
  void rejectGesture(int pointer) {
    final tap = _pendingTap;
    if (tap != null && tap.event.pointer == pointer) {
      tap.disposition = GestureDisposition.rejected;
      _reset();
    }
  }

  void _registerTap(_SequenceTap tap) {
    if (tap.disposition == null) {
      tap.entry.resolve(GestureDisposition.accepted);
    }
    if (_pendingTap != tap) return;
    GestureBinding.instance.pointerRouter.removeRoute(
      tap.event.pointer,
      _handleEvent,
    );
    _pendingTap = null;
    _lastTap?.dispose();
    _lastTap = tap;
    _completedCount++;
    if (_completedCount == _tapCount) {
      final onTap = _onTap;
      final onTapProgress = _onTapProgress;
      _reset(reportProgress: false);
      if (onTap != null) invokeCallback<void>('onTap', onTap);
      if (onTapProgress != null) {
        invokeCallback<void>('onTapProgress', () => onTapProgress(0));
      }
    } else {
      _gapTimer = Timer(_duration, _reset);
    }
  }

  void _reportProgress(int count) {
    final callback = _onTapProgress;
    if (callback != null) {
      invokeCallback<void>('onTapProgress', () => callback(count));
    }
  }

  void _reset({bool reportProgress = true}) {
    final tap = _pendingTap;
    final hadProgress = tap != null || _completedCount > 0;
    _pendingTap = null;
    _completedCount = 0;
    _gapTimer?.cancel();
    _gapTimer = null;
    _lastTap?.dispose();
    _lastTap = null;
    if (tap != null) {
      GestureBinding.instance.pointerRouter.removeRoute(
        tap.event.pointer,
        _handleEvent,
      );
      tap.dispose();
      if (tap.disposition == null) {
        tap.entry.resolve(GestureDisposition.rejected);
      }
    }
    if (reportProgress && hadProgress) _reportProgress(0);
  }

  @override
  void dispose() {
    _reset(reportProgress: false);
    super.dispose();
  }

  @override
  String get debugDescription => 'multi tap sequence';
}

class _SequenceTap {
  _SequenceTap(this.event, this.entry) {
    _minimumTimeTimer = Timer(kDoubleTapMinTime, () {
      minimumTimeElapsed = true;
    });
  }

  final PointerDownEvent event;
  final GestureArenaEntry entry;
  GestureDisposition? disposition;
  late final Timer _minimumTimeTimer;
  bool minimumTimeElapsed = false;

  void dispose() => _minimumTimeTimer.cancel();
}
