import 'dart:math' as math;

import 'package:flutter/material.dart';

/// An enum representing the rounding mode used to compute the current item index.
///
/// - [RoundingMode.round]: Rounds the fractional index to the nearest integer.
/// - [RoundingMode.floor]: Always rounds the fractional index down.
/// - [RoundingMode.ceil]: Always rounds the fractional index up.
enum RoundingMode {
  /// Rounds the fractional index to the nearest integer.
  round,

  /// Always rounds the fractional index down.
  floor,

  /// Always rounds the fractional index up.
  ceil,
}

/// Adds jump and position helpers to [CarouselController].
extension FHUCarouselControllerExtension on CarouselController {
  ScrollPosition? get _maybePosition => hasClients ? positions.first : null;

  int _roundIndex(double value, RoundingMode roundingMode) {
    return switch (roundingMode) {
      RoundingMode.floor => value.floor(),
      RoundingMode.ceil => value.ceil(),
      RoundingMode.round => value.round(),
    };
  }

  double _normalizedPixels(ScrollPosition pos) {
    final clampedPixels = pos.pixels.clamp(
      pos.minScrollExtent,
      pos.maxScrollExtent,
    );
    return math.max(0, clampedPixels - pos.minScrollExtent).toDouble();
  }

  /// Immediately jumps to make the item at [index] the leading item.
  ///
  /// This is the non-animated equivalent of [CarouselController.animateToItem]
  /// for fixed-extent carousels, using `index * itemExtent` as the target offset.
  ///
  /// If [itemExtent] is not provided, this attempts to infer the carousel
  /// configuration from the attached [ScrollPosition] (which is backed by
  /// Flutter's internal carousel scroll position) and will jump for either
  /// fixed-extent or weighted carousels.
  ///
  /// Does nothing if the controller is not attached.
  void jumpToItem(int index, {double? itemExtent}) {
    final pos = _maybePosition;
    if (pos == null) {
      return;
    }

    if (itemExtent != null) {
      if (itemExtent <= 0) {
        throw ArgumentError.value(itemExtent, 'itemExtent', 'Must be > 0.');
      }
      _jumpToFixedExtentItem(index, itemExtent: itemExtent, pos: pos);
      return;
    }

    final inferredItemExtent = _tryInferFixedItemExtent(pos);
    if (inferredItemExtent != null && inferredItemExtent > 0) {
      _jumpToFixedExtentItem(index, itemExtent: inferredItemExtent, pos: pos);
      return;
    }

    final weights = _tryInferFlexWeights(pos);
    if (weights != null) {
      final inferredConsumeMaxWeight = _tryInferConsumeMaxWeight(pos) ?? true;
      _jumpToWeightedItem(
        index,
        flexWeights: weights,
        consumeMaxWeight: inferredConsumeMaxWeight,
        pos: pos,
      );
      return;
    }

    throw StateError(
      'Unable to infer carousel configuration from the attached ScrollPosition. '
      'Pass `itemExtent` (fixed-extent) or use `jumpToItemWeighted(...)`.',
    );
  }

  /// Immediately jumps to make the item at [index] occupy the primary position
  /// (the position determined by the largest weight) in a weighted carousel.
  ///
  /// This mirrors Flutter's weighted [CarouselController.animateToItem] target
  /// offset logic, without relying on private Flutter internals:
  /// `leadingIndex * viewportDimension * (flexWeights.first / flexWeights.sum)`.
  ///
  /// When [consumeMaxWeight] is false, the [index] refers to the primary item
  /// (largest weight) and the leading index is adjusted by the max weight index.
  ///
  /// Does nothing if the controller is not attached or the viewport dimension is 0.0.
  void jumpToItemWeighted(
    int index, {
    required List<int> flexWeights,
    bool consumeMaxWeight = true,
  }) {
    final pos = _maybePosition;
    if (pos == null) {
      return;
    }
    _jumpToWeightedItem(
      index,
      flexWeights: flexWeights,
      consumeMaxWeight: consumeMaxWeight,
      pos: pos,
    );
  }

  void _jumpToFixedExtentItem(
    int index, {
    required double itemExtent,
    required ScrollPosition pos,
  }) {
    final targetPixels = (index * itemExtent).clamp(
      pos.minScrollExtent,
      pos.maxScrollExtent,
    );
    jumpTo(targetPixels);
  }

  void _jumpToWeightedItem(
    int index, {
    required List<int> flexWeights,
    required bool consumeMaxWeight,
    required ScrollPosition pos,
  }) {
    final extent = tryGetWeightedLeadingItemExtent(flexWeights: flexWeights);
    if (extent == null) {
      return;
    }

    final maxWeightIndex = flexWeights.indexOf(flexWeights.reduce(math.max));
    final leadingIndex = consumeMaxWeight ? index : index - maxWeightIndex;

    final targetPixels = (leadingIndex * extent).clamp(
      pos.minScrollExtent,
      pos.maxScrollExtent,
    );
    jumpTo(targetPixels);
  }

  double? _tryInferFixedItemExtent(ScrollPosition pos) {
    // This relies on Flutter's internal carousel position exposing `itemExtent`
    // as a public getter. It will throw if SDK internals change.
    //
    // ignore: avoid_dynamic_calls
    final dynamicPos = pos as dynamic;
    try {
      // ignore: avoid_dynamic_calls
      final Object? value = dynamicPos.itemExtent;
      return value is double ? value : null;
      // ignore: avoid_catching_errors
    } on NoSuchMethodError {
      return null;
      // ignore: avoid_catching_errors
    } on TypeError {
      return null;
    }
  }

  List<int>? _tryInferFlexWeights(ScrollPosition pos) {
    // This relies on Flutter's internal carousel position exposing `flexWeights`
    // as a public getter. It will throw if SDK internals change.
    //
    // ignore: avoid_dynamic_calls
    final dynamicPos = pos as dynamic;
    try {
      // ignore: avoid_dynamic_calls
      final Object? value = dynamicPos.flexWeights;
      return value is List<int> && value.isNotEmpty ? value : null;
      // ignore: avoid_catching_errors
    } on NoSuchMethodError {
      return null;
      // ignore: avoid_catching_errors
    } on TypeError {
      return null;
    }
  }

  bool? _tryInferConsumeMaxWeight(ScrollPosition pos) {
    // This relies on Flutter's internal carousel position exposing
    // `consumeMaxWeight` as a public getter. It will throw if SDK internals
    // change.
    //
    // ignore: avoid_dynamic_calls
    final dynamicPos = pos as dynamic;
    try {
      // ignore: avoid_dynamic_calls
      final Object? value = dynamicPos.consumeMaxWeight;
      return value is bool ? value : null;
      // ignore: avoid_catching_errors
    } on NoSuchMethodError {
      return null;
      // ignore: avoid_catching_errors
    } on TypeError {
      return null;
    }
  }

  /// Returns the current carousel position as a fractional item index.
  ///
  /// The fractional index is computed by dividing the current scroll position
  /// (in pixels) by [itemExtent].
  ///
  /// For a fixed-extent [CarouselView], pass the same `itemExtent` you provide to
  /// the widget.
  ///
  /// For [CarouselView.weighted], pass `getWeightedLeadingItemExtent(...)` which
  /// matches the unit Flutter uses internally for weighted carousels.
  ///
  /// Throws if the controller is not attached.
  double getCurrentFractionalItem({required double itemExtent}) {
    final value = tryGetCurrentFractionalItem(itemExtent: itemExtent);
    if (value == null) {
      throw StateError(
        'CarouselController has no attached position (hasClients == false).',
      );
    }
    return value;
  }

  /// Tries to return the current carousel position as a fractional item index.
  ///
  /// Returns null if the controller is not attached.
  double? tryGetCurrentFractionalItem({required double itemExtent}) {
    if (itemExtent <= 0) {
      throw ArgumentError.value(itemExtent, 'itemExtent', 'Must be > 0.');
    }
    final pos = _maybePosition;
    if (pos == null) {
      return null;
    }
    return _normalizedPixels(pos) / itemExtent;
  }

  /// Returns the current item index as an integer, computed using the specified [roundingMode].
  ///
  /// - [roundingMode]: Determines whether to round the fractional index (default: [RoundingMode.round]).
  /// - [itemExtent]: The base unit used to compute indices.
  ///
  /// For [CarouselView.weighted], use [getWeightedLeadingItemExtent] as the
  /// `itemExtent` to compute the leading item index.
  int getCurrentIndex({
    required double itemExtent,
    RoundingMode roundingMode = RoundingMode.round,
  }) {
    final value = tryGetCurrentIndex(
      itemExtent: itemExtent,
      roundingMode: roundingMode,
    );
    if (value == null) {
      throw StateError(
        'CarouselController has no attached position (hasClients == false).',
      );
    }
    return value;
  }

  /// Returns `true` if the carousel can scroll forward.
  bool get canGoNext {
    final pos = _maybePosition;
    if (pos == null) {
      return false;
    }
    return pos.pixels < pos.maxScrollExtent && !pos.outOfRange;
  }

  /// Returns `true` if the carousel can scroll backward.
  bool get canGoPrevious {
    final pos = _maybePosition;
    if (pos == null) {
      return false;
    }
    return pos.pixels > pos.minScrollExtent && !pos.outOfRange;
  }

  /// Tries to return the current item index as an integer, computed using the
  /// specified [roundingMode].
  ///
  /// Returns null if the controller is not attached.
  ///
  int? tryGetCurrentIndex({
    required double itemExtent,
    RoundingMode roundingMode = RoundingMode.round,
  }) {
    final fractional = tryGetCurrentFractionalItem(itemExtent: itemExtent);
    if (fractional == null) {
      return null;
    }
    return _roundIndex(fractional, roundingMode);
  }

  /// Returns the leading item extent in pixels for a weighted carousel.
  ///
  /// This matches the unit used internally by Flutter's [CarouselView.weighted]:
  /// `viewportDimension * (flexWeights.first / flexWeights.sum)`.
  double getWeightedLeadingItemExtent({required List<int> flexWeights}) {
    final value = tryGetWeightedLeadingItemExtent(flexWeights: flexWeights);
    if (value == null) {
      throw StateError(
        'CarouselController has no attached position (hasClients == false), '
        'or viewportDimension is 0.0. Wait for layout before calling this method.',
      );
    }
    return value;
  }

  /// Tries to return the leading item extent in pixels for a weighted carousel.
  ///
  /// Returns null if the controller is not attached or if the viewport dimension
  /// is 0.0.
  double? tryGetWeightedLeadingItemExtent({required List<int> flexWeights}) {
    if (flexWeights.isEmpty) {
      throw ArgumentError.value(
        flexWeights,
        'flexWeights',
        'Must not be empty.',
      );
    }
    if (flexWeights.any((w) => w <= 0)) {
      throw ArgumentError.value(
        flexWeights,
        'flexWeights',
        'All weights must be positive integers.',
      );
    }

    final pos = _maybePosition;
    if (pos == null) {
      return null;
    }
    if (pos.viewportDimension <= 0.0) {
      return null;
    }

    final total = flexWeights.fold<int>(0, (sum, w) => sum + w);
    if (total <= 0) {
      throw ArgumentError.value(
        flexWeights,
        'flexWeights',
        'Sum of weights must be > 0.',
      );
    }

    return pos.viewportDimension * (flexWeights.first / total);
  }

  /// Returns the current carousel position as a fractional item index for a
  /// weighted carousel.
  ///
  /// This computes the leading item index (the first visible item).
  double getCurrentFractionalItemWeighted({required List<int> flexWeights}) {
    final value = tryGetCurrentFractionalItemWeighted(flexWeights: flexWeights);
    if (value == null) {
      throw StateError(
        'CarouselController has no attached position (hasClients == false), '
        'or viewportDimension is 0.0. Wait for layout before calling this method.',
      );
    }
    return value;
  }

  /// Tries to return the current carousel position as a fractional item index
  /// for a weighted carousel.
  ///
  /// Returns null if the controller is not attached or if the viewport dimension
  /// is 0.0.
  double? tryGetCurrentFractionalItemWeighted({
    required List<int> flexWeights,
  }) {
    final extent = tryGetWeightedLeadingItemExtent(flexWeights: flexWeights);
    if (extent == null) {
      return null;
    }
    return tryGetCurrentFractionalItem(itemExtent: extent);
  }

  /// Returns the current item index for a weighted carousel.
  ///
  /// This computes the leading item index (the first visible item).
  int getCurrentIndexWeighted({
    required List<int> flexWeights,
    RoundingMode roundingMode = RoundingMode.round,
  }) {
    final value = tryGetCurrentIndexWeighted(
      flexWeights: flexWeights,
      roundingMode: roundingMode,
    );
    if (value == null) {
      throw StateError(
        'CarouselController has no attached position (hasClients == false), '
        'or viewportDimension is 0.0. Wait for layout before calling this method.',
      );
    }
    return value;
  }

  /// Tries to return the current item index for a weighted carousel.
  ///
  /// Returns null if the controller is not attached or if the viewport dimension
  /// is 0.0.
  int? tryGetCurrentIndexWeighted({
    required List<int> flexWeights,
    RoundingMode roundingMode = RoundingMode.round,
  }) {
    final fractional = tryGetCurrentFractionalItemWeighted(
      flexWeights: flexWeights,
    );
    if (fractional == null) {
      return null;
    }
    return _roundIndex(fractional, roundingMode);
  }
}
