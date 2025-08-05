import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A widget that detects multiple taps on its child within a specified duration.
///
/// The [onTap] callback is triggered when the specified number of taps ([tapCount])
/// occurs within the given [duration].
///
/// This widget can detect gestures where the user taps multiple times on the child
/// widget within a configurable time interval. It handles both rapid tapping
/// and accidental taps where the user pauses or performs other gestures.
class MultiTapDetector extends StatefulWidget {
  const MultiTapDetector({
    required this.child,
    required this.onTap,
    this.tapCount = 3,
    this.duration = const Duration(milliseconds: 500),
    this.onTapProgress,
    super.key,
  }) : assert(tapCount > 1, 'tapCount must be greater than 1');

  /// The widget to which the multi-tap detection will be applied.
  final Widget child;

  /// The callback function to be executed when the multi-tap gesture is detected.
  final VoidCallback onTap;

  /// Optional callback that reports the progress of tapping sequence.
  /// The integer parameter represents the current tap count.
  final void Function(int currentCount)? onTapProgress;

  /// The number of taps required to trigger the [onTap] callback.
  final int tapCount;

  /// The maximum duration allowed between consecutive taps within a multi-tap sequence.
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
