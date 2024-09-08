import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A widget that detects multiple taps on its child within a specified duration.
///
/// The [onTap] callback is triggered when the specified number of taps ([tapCount])
/// occurs within the given [duration].
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
  int _currentTapCount = 0;
  DateTime? _lastTapTime;

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

              // Reset if time between taps is too long
              if (_lastTapTime == null ||
                  now.difference(_lastTapTime!) > widget.duration) {
                _currentTapCount = 0;
              }

              _currentTapCount++;
              _lastTapTime = now;

              if (_currentTapCount == widget.tapCount) {
                widget.onTap();
                _currentTapCount = 0; // Reset after successful tap sequence
              }
            };
          },
        ),
      },
      child: widget.child,
    );
  }
}
