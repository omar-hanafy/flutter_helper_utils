// ignore_for_file: avoid_dynamic_calls
import 'package:dart_helper_utils/dart_helper_utils.dart';
import 'package:flutter/material.dart';

/// An enum representing the rounding mode used to compute the current item index.
///
/// - [round]: Rounds the fractional index to the nearest integer.
/// - [floor]: Always rounds the fractional index down.
/// - [ceil]: Always rounds the fractional index up.
enum RoundingMode { round, floor, ceil }

/// An extension on [CarouselController] that provides a comprehensive API for controlling carousel scroll behavior.
///
/// This extension supports both uniform and weighted carousel layouts. It includes methods to:
/// - Animate or jump to a specific item index.
/// - Navigate to the next or previous item.
/// - Jump or animate by a relative number of items.
/// - Snap to the nearest item using custom rounding logic.
/// - Handle infinite scrolling by wrapping indices.
/// - Animate based on scroll velocity.
///
/// It also allows you to override the default item extent calculation via an optional builder.
extension FHUCarouselControllerExtension on CarouselController {
  /// Returns the first attached [ScrollPosition].
  ///
  /// Throws an assertion error if the controller is not attached to any scroll views.
  ScrollPosition get _pos {
    assert(positions.isNotEmpty,
        'ScrollController not attached to any scroll views.');
    return positions.first;
  }

  /// Computes the default item extent based on the viewport dimensions.
  ///
  /// For a uniform carousel layout, this value is computed as a fraction of the viewport.
  /// For a weighted layout (such as with [CarouselView.weighted]), the extent is derived from the first weight.
  ///
  /// [viewportFraction] specifies the fraction of the viewport used for each item's extent.
  /// Returns 0 if there are no attached clients.
  double _defaultItemExtent(double viewportFraction) {
    if (!hasClients) return 0;
    final pos = _pos;
    try {
      // Use dynamic to attempt accessing internal properties.
      final dynamic cp = pos;
      if (cp.itemExtent != null) {
        return ConvertObject.toDouble(
          cp.viewportDimension * viewportFraction,
          defaultValue: 0,
        );
      } else if (cp.flexWeights != null) {
        final weights = cp.flexWeights as List<int>;
        final total = weights.reduce((a, b) => a + b);
        return ConvertObject.toDouble(
          cp.viewportDimension * (weights.first / total),
          defaultValue: 0,
        );
      }
    } catch (e) {
      // Fallback to uniform behavior if accessing internal properties fails.
    }
    return pos.viewportDimension * viewportFraction;
  }

  /// Determines the item extent using an optional custom builder.
  ///
  /// If [itemExtentBuilder] is provided, it will be called with the current [ScrollPosition]
  /// and [viewportFraction] to compute the item extent. Otherwise, [_defaultItemExtent] is used.
  ///
  /// [viewportFraction] specifies the fraction of the viewport used for each item.
  double _getItemExtent({
    double viewportFraction = 1.0,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) {
    if (!hasClients) return 0;
    return itemExtentBuilder?.call(_pos, viewportFraction) ??
        _defaultItemExtent(viewportFraction);
  }

  /// Animates the carousel to the specified item index.
  ///
  /// The target scroll offset is computed as `index * itemExtent` and then clamped between
  /// the minimum and maximum scroll extents.
  ///
  /// - [index]: The target item index.
  /// - [duration]: The duration of the animation (default: 300 milliseconds).
  /// - [curve]: The animation curve (default: [Curves.easeInOut]).
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  Future<void> animateToItem(
    int index, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    double viewportFraction = 1.0,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) async {
    if (!hasClients) return;
    final extent = _getItemExtent(
        viewportFraction: viewportFraction,
        itemExtentBuilder: itemExtentBuilder);
    if (extent == 0) return;
    final targetOffset =
        (index * extent).clamp(_pos.minScrollExtent, _pos.maxScrollExtent);
    await animateTo(targetOffset, duration: duration, curve: curve);
  }

  /// Immediately jumps to the specified item index without animation.
  ///
  /// The target scroll offset is computed similarly to [animateToItem].
  ///
  /// - [index]: The target item index.
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  void jumpToItem(
    int index, {
    double viewportFraction = 1.0,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) {
    if (!hasClients) return;
    final extent = _getItemExtent(
        viewportFraction: viewportFraction,
        itemExtentBuilder: itemExtentBuilder);
    if (extent == 0) return;
    final targetOffset =
        (index * extent).clamp(_pos.minScrollExtent, _pos.maxScrollExtent);
    jumpTo(targetOffset);
  }

  /// Animates the carousel to the next item.
  ///
  /// Uses [RoundingMode.floor] to compute the current item index and increments it by 1.
  /// No action is taken if the carousel cannot scroll forward.
  Future<void> animateToNextItem({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    double viewportFraction = 1.0,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) async {
    if (!hasClients || !canGoNext) return;
    final nextIndex = getCurrentIndex(
          viewportFraction: viewportFraction,
          roundingMode: RoundingMode.floor,
          itemExtentBuilder: itemExtentBuilder,
        ) +
        1;
    await animateToItem(
      nextIndex,
      duration: duration,
      curve: curve,
      viewportFraction: viewportFraction,
      itemExtentBuilder: itemExtentBuilder,
    );
  }

  /// Animates the carousel to the previous item.
  ///
  /// Uses [RoundingMode.ceil] to compute the current item index and decrements it by 1.
  /// No action is taken if the carousel cannot scroll backward.
  Future<void> animateToPreviousItem({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    double viewportFraction = 1.0,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) async {
    if (!hasClients || !canGoPrevious) return;
    final prevIndex = getCurrentIndex(
          viewportFraction: viewportFraction,
          roundingMode: RoundingMode.ceil,
          itemExtentBuilder: itemExtentBuilder,
        ) -
        1;
    await animateToItem(
      prevIndex,
      duration: duration,
      curve: curve,
      viewportFraction: viewportFraction,
      itemExtentBuilder: itemExtentBuilder,
    );
  }

  /// Returns the current carousel position as a fractional item index.
  ///
  /// The fractional index is computed by dividing the current scroll position (in pixels)
  /// by the item extent.
  ///
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  double getCurrentFractionalItem({
    double viewportFraction = 1.0,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) {
    if (!hasClients) return 0;
    final extent = _getItemExtent(
        viewportFraction: viewportFraction,
        itemExtentBuilder: itemExtentBuilder);
    if (extent == 0) return 0;
    return _pos.pixels / extent;
  }

  /// Returns the current item index as an integer, computed using the specified [roundingMode].
  ///
  /// - [roundingMode]: Determines whether to round the fractional index (default: [RoundingMode.round]).
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  @Deprecated(
    'Use getCurrentIndex instead. This function will be removed in a future version.',
  )
  int getCurrentItem({
    double viewportFraction = 1.0,
    RoundingMode roundingMode = RoundingMode.round,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) {
    final fractional = getCurrentFractionalItem(
        viewportFraction: viewportFraction,
        itemExtentBuilder: itemExtentBuilder);
    return switch (roundingMode) {
      RoundingMode.floor => fractional.floor(),
      RoundingMode.ceil => fractional.ceil(),
      RoundingMode.round => fractional.round(),
    };
  }

  /// Returns the current item index as an integer, computed using the specified [roundingMode].
  ///
  /// - [roundingMode]: Determines whether to round the fractional index (default: [RoundingMode.round]).
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  int getCurrentIndex({
    double viewportFraction = 1.0,
    RoundingMode roundingMode = RoundingMode.round,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) {
    final fractional = getCurrentFractionalItem(
        viewportFraction: viewportFraction,
        itemExtentBuilder: itemExtentBuilder);
    return switch (roundingMode) {
      RoundingMode.floor => fractional.floor(),
      RoundingMode.ceil => fractional.ceil(),
      RoundingMode.round => fractional.round(),
    };
  }

  /// Estimates the total number of items in the carousel based on the current item extent.
  ///
  /// For weighted layouts, this value is an approximation.
  ///
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  int getMaxItems({
    double viewportFraction = 1.0,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) {
    if (!hasClients) return 0;
    final extent = _getItemExtent(
        viewportFraction: viewportFraction,
        itemExtentBuilder: itemExtentBuilder);
    if (extent == 0) return 0;
    return (_pos.maxScrollExtent / extent).ceil() + 1;
  }

  /// Returns `true` if the carousel can scroll forward.
  bool get canGoNext =>
      hasClients && _pos.pixels < _pos.maxScrollExtent && !_pos.outOfRange;

  /// Returns `true` if the carousel can scroll backward.
  bool get canGoPrevious =>
      hasClients && _pos.pixels > _pos.minScrollExtent && !_pos.outOfRange;

  // --- Additional Utility Methods ---

  /// Wraps the provided [index] for infinite scrolling.
  ///
  /// If the carousel is configured for infinite scrolling, this method returns the
  /// wrapped index based on the total number of items.
  int _wrapIndex(int index) {
    final total = getMaxItems();
    if (total == 0) return 0;
    return ((index % total) + total) % total;
  }

  /// Animates the carousel to the specified [index] with optional infinite scrolling.
  ///
  /// When [infinite] is `true`, the [index] is wrapped around the total number of items.
  ///
  /// - [index]: The target item index.
  /// - [duration]: The duration of the animation (default: 300 milliseconds).
  /// - [curve]: The animation curve (default: [Curves.easeInOut]).
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  Future<void> animateToInfiniteItem(
    int index, {
    bool infinite = true,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    double viewportFraction = 1.0,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) async {
    if (!hasClients) return;
    final targetIndex = infinite ? _wrapIndex(index) : index;
    await animateToItem(
      targetIndex,
      duration: duration,
      curve: curve,
      viewportFraction: viewportFraction,
      itemExtentBuilder: itemExtentBuilder,
    );
  }

  /// Immediately jumps to the specified [index] with optional infinite scrolling.
  ///
  /// When [infinite] is `true`, the [index] is wrapped around the total number of items.
  ///
  /// - [index]: The target item index.
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  void jumpToInfiniteItem(
    int index, {
    bool infinite = true,
    double viewportFraction = 1.0,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) {
    if (!hasClients) return;
    final targetIndex = infinite ? _wrapIndex(index) : index;
    jumpToItem(
      targetIndex,
      viewportFraction: viewportFraction,
      itemExtentBuilder: itemExtentBuilder,
    );
  }

  /// Animates the carousel by a relative number of items specified by [delta].
  ///
  /// - [delta]: The number of items to move (positive or negative).
  /// If [infinite] is `true`, the resulting index is wrapped around the total number of items.
  /// - [duration]: The duration of the animation (default: 300 milliseconds).
  /// - [curve]: The animation curve (default: [Curves.easeInOut]).
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  Future<void> animateByItems(
    int delta, {
    bool infinite = false,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    double viewportFraction = 1.0,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) async {
    final current = getCurrentIndex(
        viewportFraction: viewportFraction,
        itemExtentBuilder: itemExtentBuilder);
    var target = current + delta;
    if (infinite) target = _wrapIndex(target);
    await animateToItem(
      target,
      duration: duration,
      curve: curve,
      viewportFraction: viewportFraction,
      itemExtentBuilder: itemExtentBuilder,
    );
  }

  /// Immediately jumps by a relative number of items specified by [delta].
  ///
  /// - [delta]: The number of items to move (positive or negative).
  /// If [infinite] is `true`, the resulting index is wrapped around the total number of items.
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  void jumpByItems(
    int delta, {
    bool infinite = false,
    double viewportFraction = 1.0,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) {
    final current = getCurrentIndex(
        viewportFraction: viewportFraction,
        itemExtentBuilder: itemExtentBuilder);
    var target = current + delta;
    if (infinite) target = _wrapIndex(target);
    jumpToItem(
      target,
      viewportFraction: viewportFraction,
      itemExtentBuilder: itemExtentBuilder,
    );
  }

  /// Snaps the carousel to the nearest item using custom rounding behavior.
  ///
  /// The current item is computed using the specified [roundingMode] and the carousel animates
  /// to that item.
  ///
  /// - [duration]: The duration of the snapping animation.
  /// - [curve]: The animation curve (default: [Curves.easeInOut]).
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [roundingMode]: Determines how to round the fractional index (default: [RoundingMode.round]).
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  Future<void> snapToNearestItem({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    double viewportFraction = 1.0,
    RoundingMode roundingMode = RoundingMode.round,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) async {
    final targetIndex = getCurrentIndex(
      viewportFraction: viewportFraction,
      roundingMode: roundingMode,
      itemExtentBuilder: itemExtentBuilder,
    );
    await animateToItem(
      targetIndex,
      duration: duration,
      curve: curve,
      viewportFraction: viewportFraction,
      itemExtentBuilder: itemExtentBuilder,
    );
  }

  /// Animates the carousel to a target item based on the provided scroll [velocity].
  ///
  /// If the absolute value of [velocity] exceeds [velocityThreshold], the carousel will animate
  /// to the next or previous item using a faster animation. Otherwise, it remains on the current item.
  ///
  /// - [velocity]: The current scroll velocity.
  /// - [velocityThreshold]: The threshold above which a fast animation is used (default: 300.0).
  /// - [fastDuration]: The animation duration for fast transitions (default: 200 milliseconds).
  /// - [normalDuration]: The animation duration for normal transitions (default: 300 milliseconds).
  /// - [curve]: The animation curve (default: [Curves.easeInOut]).
  /// - [viewportFraction]: The fraction of the viewport used for each item's extent.
  /// - [roundingMode]: The rounding mode used to compute the current item index.
  /// - [itemExtentBuilder]: Optional function to override the default item extent calculation.
  Future<void> animateToItemWithVelocity({
    required double velocity,
    double velocityThreshold = 300.0,
    Duration fastDuration = const Duration(milliseconds: 200),
    Duration normalDuration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    double viewportFraction = 1.0,
    RoundingMode roundingMode = RoundingMode.round,
    double Function(ScrollPosition, double)? itemExtentBuilder,
  }) async {
    if (!hasClients) return;
    final current = getCurrentIndex(
      viewportFraction: viewportFraction,
      roundingMode: roundingMode,
      itemExtentBuilder: itemExtentBuilder,
    );
    int target;
    if (velocity > velocityThreshold) {
      target = current + 1;
    } else if (velocity < -velocityThreshold) {
      target = current - 1;
    } else {
      target = current;
    }
    final chosenDuration = (target == current) ? normalDuration : fastDuration;
    await animateToItem(
      target,
      duration: chosenDuration,
      curve: curve,
      viewportFraction: viewportFraction,
      itemExtentBuilder: itemExtentBuilder,
    );
  }
}
