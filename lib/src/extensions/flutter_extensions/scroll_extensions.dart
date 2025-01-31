import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

/// Extension methods for enhancing ScrollController functionality
extension ScrollControllerEx on ScrollController {
  // MARK: - Basic Scroll Animations

  /// Animates the scroll view to a specific offset position
  ///
  /// [offset] The target scroll offset
  /// [duration] How long the animation should take
  /// [curve] The animation curve to use
  Future<void> animateToPosition(
    double offset, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    await animateTo(
      offset,
      duration: duration,
      curve: curve,
    );
  }

  /// Animates the scroll view to its maximum scroll extent (bottom)
  Future<void> animateToBottom({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    await animateToPosition(
      position.maxScrollExtent,
      duration: duration,
      curve: curve,
    );
  }

  /// Animates the scroll view to its minimum scroll extent (top)
  Future<void> animateToTop({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    await animateToPosition(
      0,
      duration: duration,
      curve: curve,
    );
  }

  /// Smoothly scrolls to a specific offset with bounds checking
  Future<void> smoothScrollTo(
    double offset, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCubic,
  }) async {
    if (!hasClients) return;
    await animateTo(
      offset.clamp(position.minScrollExtent, position.maxScrollExtent),
      duration: duration,
      curve: curve,
    );
  }

  // MARK: - Advanced Scroll Controls

  /// Scrolls the view by one page, either forward or backward
  ///
  /// [forward] If true, scrolls forward; if false, scrolls backward
  /// [viewportFraction] The fraction of the viewport to scroll
  Future<void> pageScroll({
    bool forward = true,
    double viewportFraction = 0.8,
  }) async {
    if (!hasClients) return;
    final viewportDimension = position.viewportDimension;
    final currentOffset = position.pixels;
    final targetOffset = currentOffset +
        (forward ? viewportDimension : -viewportDimension) * viewportFraction;
    await smoothScrollTo(targetOffset);
  }

  /// Scrolls to a specific percentage of the total scrollable content
  ///
  /// [percentage] Value between 0.0 and 1.0 representing the target position
  Future<void> scrollToPercentage(
    double percentage, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCubic,
  }) async {
    assert(percentage >= 0.0 && percentage <= 1.0,
        'percentage must be between 0.0 and 1.0');
    final targetOffset = position.maxScrollExtent * percentage;
    await animateToPosition(targetOffset, duration: duration, curve: curve);
  }

  /// Scrolls by a relative percentage from the current position
  ///
  /// [percentage] Value between -1.0 and 1.0 representing the relative movement
  Future<void> scrollByPercentage(
    double percentage, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCubic,
  }) async {
    assert(percentage >= -1.0 && percentage <= 1.0,
        'percentage must be between -1.0 and 1.0');
    final currentOffset = position.pixels;
    final maxOffset = position.maxScrollExtent;
    final targetOffset = currentOffset + (maxOffset * percentage);
    await smoothScrollTo(targetOffset, duration: duration, curve: curve);
  }

  /// Performs a velocity-based scroll animation
  ///
  /// [velocity] The initial velocity to use for the scroll
  /// [duration] Optional duration for the animation
  /// [curve] The animation curve to use
  Future<void> flingWithVelocity(
    double velocity, {
    Duration? duration,
    Curve curve = Curves.easeOut,
  }) async {
    if (!hasClients) return;

    final distance = velocity.abs() * 0.3; // Adjust multiplier as needed
    final direction = velocity.sign;
    final targetOffset = (position.pixels + (distance * direction))
        .clamp(position.minScrollExtent, position.maxScrollExtent);

    await animateTo(
      targetOffset,
      duration: duration ?? Duration(milliseconds: (distance / 2).round()),
      curve: curve,
    );
  }

  /// Snaps the scroll position to the closest item based on item extent
  ///
  /// [itemExtent] The size of each item in the scroll view
  Future<void> snapToClosest({
    required double itemExtent,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) async {
    if (!hasClients) return;

    final currentOffset = position.pixels;
    final targetIndex = (currentOffset / itemExtent).round();
    final targetOffset = targetIndex * itemExtent;

    await animateToPosition(targetOffset, duration: duration, curve: curve);
  }

  // MARK: - Position Checking

  /// Whether the scroll view is at either edge
  bool get isAtEdge => position.atEdge;

  /// Whether the scroll view is at its maximum extent
  bool get isAtBottom => position.pixels >= position.maxScrollExtent;

  /// Whether the scroll view is at its minimum extent
  bool? get isAtTop => hasClients && offset == 0;

  /// The current scroll progress as a value between 0.0 and 1.0
  double get scrollProgress => position.pixels / position.maxScrollExtent;

  /// Whether the scroll position is near the top
  bool isNearTop({double threshold = 50.0}) => position.pixels <= threshold;

  /// Whether the scroll position is near the bottom
  bool isNearBottom({double threshold = 50.0}) =>
      position.pixels >= position.maxScrollExtent - threshold;

  /// Whether the scroll view can actually scroll
  bool get canScroll =>
      hasClients && position.maxScrollExtent > position.minScrollExtent;

  /// Attempts to scroll to the top and returns whether it actually scrolled
  Future<bool> get didScrollToTop async {
    if (hasClients && position.pixels > 0) {
      await animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
      return true;
    }
    return false;
  }

  /// Checks if a specific item is currently visible in the viewport
  bool isItemVisible(double itemOffset, double itemExtent) {
    if (!hasClients) return false;
    final start = position.pixels;
    final end = start + position.viewportDimension;
    return (itemOffset + itemExtent > start) && (itemOffset < end);
  }

  // MARK: - Direction Checking

  /// Whether the scroll view is being scrolled in reverse
  bool get isScrollReverse => position.userScrollDirection.isReverse;

  /// Whether the scroll view is not being scrolled
  bool get isScrollIdle => position.userScrollDirection.isIdle;

  /// Whether the scroll view is being scrolled forward
  bool get isScrollForward => position.userScrollDirection.isForward;

  // MARK: - Debug Helpers

  /// Prints detailed information about the current scroll state
  void debugPrintScrollInfo() {
    debugPrint('Scroll Position: ${position.pixels}');
    debugPrint('Viewport Dimension: ${position.viewportDimension}');
    debugPrint('Max Extent: ${position.maxScrollExtent}');
    debugPrint('Min Extent: ${position.minScrollExtent}');
    debugPrint('Scroll Direction: ${position.userScrollDirection}');
    debugPrint('Progress: $scrollProgress');
  }
}

/// Extension methods for ScrollDirection enum
extension ScrollDirectionEx on ScrollDirection? {
  /// Whether the scroll direction is idle
  bool get isIdle => this == ScrollDirection.idle;

  /// Whether the scroll direction is forward
  bool get isForward => this == ScrollDirection.forward;

  /// Whether the scroll direction is reverse
  bool get isReverse => this == ScrollDirection.reverse;
}
