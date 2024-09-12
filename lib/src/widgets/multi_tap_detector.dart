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
///
/// ## Properties:
///
/// * **child:** The widget to which the multi-tap detection will be applied.
/// * **onTap:** The callback function to be executed when the multi-tap gesture is detected.
/// * **tapCount:** The number of taps required to trigger the [onTap] callback. Defaults to 3.
/// * **duration:** The maximum duration allowed between consecutive taps within a multi-tap sequence. Defaults to 300 milliseconds.
///
/// ## Example Usage:
///
/// ```dart
/// MultiTapDetector(
///   tapCount: 2, // Detect double taps
///   duration: const Duration(milliseconds: 500),
///   onTap: () {
///     print('Double tap detected!');
///   },
///   child: Container(
///     color: Colors.blue,
///     width: 100,
///     height: 100,
///   ),
/// )
/// ```
class MultiTapDetector extends StatefulWidget {
  const MultiTapDetector({
    required this.child,
    required this.onTap,
    this.tapCount = 3,
    this.duration = const Duration(milliseconds: 300),
    super.key,
  });

  /// The widget to which the multi-tap detection will be applied.
  final Widget child;

  /// The callback function to be executed when the multi-tap gesture is detected.
  final VoidCallback onTap;

  /// The number of taps required to trigger the [onTap] callback.
  final int tapCount;

  /// The maximum duration allowed between consecutive taps within a multi-tap sequence.
  final Duration duration;

  @override
  State<MultiTapDetector> createState() => _MultiTapDetectorState();
}

class _MultiTapDetectorState extends State<MultiTapDetector> {
  int _currentTapCount = 0; // Tracks how many taps have been made
  DateTime? _firstTapTime; // Tracks when the first tap was made

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        SerialTapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<SerialTapGestureRecognizer>(
          SerialTapGestureRecognizer.new,
          (SerialTapGestureRecognizer instance) {
            instance.onSerialTapDown = (SerialTapDownDetails details) {
              final now = DateTime.now();

              // Reset if this is the first tap in the sequence or if too much time passed between taps
              if (_firstTapTime == null ||
                  now.difference(_firstTapTime!) > widget.duration) {
                _currentTapCount = 0;
                _firstTapTime =
                    now; // Start tracking the sequence from the first tap
              }

              // Increment the tap count
              _currentTapCount++;

              // Check if the number of taps matches the desired count
              if (_currentTapCount == widget.tapCount) {
                widget.onTap();
                _resetTapSequence(); // Reset after successful tap sequence
              }
            };
          },
        ),
      },
      child: widget.child,
    );
  }

  /// Resets the tap count and the timing variables after a successful tap sequence or timeout.
  void _resetTapSequence() {
    _currentTapCount = 0;
    _firstTapTime = null;
  }
}
