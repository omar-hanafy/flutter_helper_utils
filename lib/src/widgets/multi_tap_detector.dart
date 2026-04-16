import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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

  /// The maximum allowed gap between taps before progress resets.
  final Duration duration;

  @override
  State<MultiTapDetector> createState() => _MultiTapDetectorState();
}

class _MultiTapDetectorState extends State<MultiTapDetector> {
  Timer? _resetTimer;

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  void _startResetTimer() {
    _resetTimer?.cancel();
    _resetTimer = Timer(widget.duration, () {
      // Reset timer expired without completing the sequence
      if (widget.onTapProgress != null) {
        widget.onTapProgress?.call(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        SerialTapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<SerialTapGestureRecognizer>(
              SerialTapGestureRecognizer.new,
              (SerialTapGestureRecognizer instance) {
                instance
                  ..onSerialTapDown = (SerialTapDownDetails details) {
                    _startResetTimer();

                    // Report progress if callback is provided
                    if (widget.onTapProgress != null) {
                      widget.onTapProgress?.call(details.count);
                    }
                  }
                  ..onSerialTapUp = (SerialTapUpDetails details) {
                    if (details.count == widget.tapCount) {
                      _resetTimer?.cancel();
                      widget.onTap();

                      // Reset progress
                      if (widget.onTapProgress != null) {
                        widget.onTapProgress?.call(0);
                      }
                    }
                  }
                  ..onSerialTapCancel = (SerialTapCancelDetails details) {
                    _resetTimer?.cancel();

                    // Reset progress
                    if (widget.onTapProgress != null) {
                      widget.onTapProgress?.call(0);
                    }
                  };
              },
            ),
      },
      child: widget.child,
    );
  }
}
