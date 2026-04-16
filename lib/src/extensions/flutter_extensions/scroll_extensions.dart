import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Extension methods for enhancing [ScrollController] functionality.
///
/// Design goals:
/// - Guarded access: never crashes when the controller has no clients.
/// - Multi-client aware: methods that mutate scroll position operate on all
///   attached [ScrollPosition]s (matching [ScrollController.animateTo]/[jumpTo]).
/// - Metrics-safe: extent-based getters return conservative defaults if metrics
///   are not available yet (before first layout).
extension ScrollControllerEx on ScrollController {
  // ---------------------------------------------------------------------------
  // MARK: - Internal helpers
  // ---------------------------------------------------------------------------

  /// Returns the only attached [ScrollPosition], or null if there are 0 or >1.
  ScrollPosition? get _singlePosition =>
      hasClients && positions.length == 1 ? positions.first : null;

  /// Returns the only attached [ScrollPosition] if pixels/viewport/extents are ready.
  ScrollPosition? get _metricsReadyPosition {
    final p = _singlePosition;
    if (p == null) return null;
    if (!p.hasPixels || !p.hasViewportDimension || !p.hasContentDimensions) {
      return null;
    }
    return p;
  }

  // ---------------------------------------------------------------------------
  // MARK: - Safe access
  // ---------------------------------------------------------------------------

  /// True when this controller is attached to exactly one [ScrollPosition].
  bool get hasSingleClient => hasClients && positions.length == 1;

  /// The single attached position, or null if there are 0 or multiple clients.
  ScrollPosition? get maybePosition => _singlePosition;

  /// The current scroll offset for the single attached position, or null.
  double? get maybeOffset => _singlePosition?.pixels;

  /// A listenable that becomes true while scrolling (drag, fling, or animateTo).
  ///
  /// Returns null unless there is exactly one attached position.
  ValueListenable<bool>? get isScrollingListenable =>
      _singlePosition?.isScrollingNotifier;

  // ---------------------------------------------------------------------------
  // MARK: - Core scrolling (multi-client safe)
  // ---------------------------------------------------------------------------

  /// Animates all attached positions to [offset].
  ///
  /// If [clamp] is true (default), the target offset is clamped to each
  /// position's extents when those extents are available (after layout).
  ///
  /// If [duration] is `Duration.zero` (or negative), this falls back to [jumpToPosition].
  Future<void> animateToPosition(
    double offset, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
    bool clamp = true,
  }) async {
    if (!hasClients) return;

    if (duration <= Duration.zero) {
      jumpToPosition(offset, clamp: clamp);
      return;
    }

    await Future.wait<void>(<Future<void>>[
      for (final ScrollPosition p in positions)
        p.animateTo(
          clamp && p.hasContentDimensions
              ? clampDouble(offset, p.minScrollExtent, p.maxScrollExtent)
              : offset,
          duration: duration,
          curve: curve,
        ),
    ]);
  }

  /// Jumps all attached positions to [offset] without animation.
  ///
  /// If [clamp] is true (default), the target offset is clamped to each
  /// position's extents when those extents are available.
  void jumpToPosition(double offset, {bool clamp = true}) {
    if (!hasClients) return;

    for (final p in positions) {
      final target = clamp && p.hasContentDimensions
          ? clampDouble(offset, p.minScrollExtent, p.maxScrollExtent)
          : offset;
      p.jumpTo(target);
    }
  }

  /// Like [ScrollPosition.moveTo], but for a controller (multi-client safe).
  ///
  /// If [duration] is null or `Duration.zero`, jumps. Otherwise animates.
  Future<void> moveToPosition(
    double offset, {
    Duration? duration,
    Curve curve = Curves.ease,
    bool clamp = true,
  }) async {
    if (duration == null || duration <= Duration.zero) {
      jumpToPosition(offset, clamp: clamp);
      return;
    }
    await animateToPosition(
      offset,
      duration: duration,
      curve: curve,
      clamp: clamp,
    );
  }

  /// Animates to the start (min scroll extent) for each attached position.
  ///
  /// Does nothing for positions that don't have content dimensions yet.
  Future<void> animateToStart({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    if (!hasClients) return;

    if (duration <= Duration.zero) {
      jumpToStart();
      return;
    }

    await Future.wait<void>(<Future<void>>[
      for (final ScrollPosition p in positions)
        if (p.hasContentDimensions)
          p.animateTo(p.minScrollExtent, duration: duration, curve: curve),
    ]);
  }

  /// Jumps to the start (min scroll extent) for each attached position.
  ///
  /// Does nothing for positions that don't have content dimensions yet.
  void jumpToStart() {
    if (!hasClients) return;

    for (final p in positions) {
      if (!p.hasContentDimensions) continue;
      p.jumpTo(p.minScrollExtent);
    }
  }

  /// Animates to the end (max scroll extent) for each attached position.
  ///
  /// Does nothing for positions that don't have content dimensions yet.
  Future<void> animateToEnd({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    if (!hasClients) return;

    if (duration <= Duration.zero) {
      jumpToEnd();
      return;
    }

    await Future.wait<void>(<Future<void>>[
      for (final ScrollPosition p in positions)
        if (p.hasContentDimensions)
          p.animateTo(p.maxScrollExtent, duration: duration, curve: curve),
    ]);
  }

  /// Jumps to the end (max scroll extent) for each attached position.
  ///
  /// Does nothing for positions that don't have content dimensions yet.
  void jumpToEnd() {
    if (!hasClients) return;

    for (final p in positions) {
      if (!p.hasContentDimensions) continue;
      p.jumpTo(p.maxScrollExtent);
    }
  }

  /// Backwards-friendly alias for [animateToStart].
  Future<void> animateToTop({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
  }) => animateToStart(duration: duration, curve: curve);

  /// Backwards-friendly alias for [animateToEnd].
  Future<void> animateToBottom({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
  }) => animateToEnd(duration: duration, curve: curve);

  /// Animates each attached position by [delta] pixels.
  ///
  /// If [duration] is `Duration.zero` (or negative), falls back to [jumpBy].
  Future<void> animateBy(
    double delta, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCubic,
    bool clamp = true,
  }) async {
    if (!hasClients) return;

    if (duration <= Duration.zero) {
      jumpBy(delta, clamp: clamp);
      return;
    }

    await Future.wait<void>(<Future<void>>[
      for (final ScrollPosition p in positions)
        p.animateTo(
          clamp && p.hasContentDimensions
              ? clampDouble(
                  p.pixels + delta,
                  p.minScrollExtent,
                  p.maxScrollExtent,
                )
              : p.pixels + delta,
          duration: duration,
          curve: curve,
        ),
    ]);
  }

  /// Jumps each attached position by [delta] pixels.
  void jumpBy(double delta, {bool clamp = true}) {
    if (!hasClients) return;

    for (final p in positions) {
      final target = clamp && p.hasContentDimensions
          ? clampDouble(p.pixels + delta, p.minScrollExtent, p.maxScrollExtent)
          : p.pixels + delta;
      p.jumpTo(target);
    }
  }

  // ---------------------------------------------------------------------------
  // MARK: - Page & percentage scrolling
  // ---------------------------------------------------------------------------

  /// Scrolls by one viewport "page".
  ///
  /// [viewportFraction] is clamped to 0.0..1.0 and defaults to 0.8.
  Future<void> pageScroll({
    bool forward = true,
    double viewportFraction = 0.8,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCubic,
    bool clamp = true,
  }) async {
    if (!hasClients) return;

    viewportFraction = viewportFraction.clamp(0.0, 1.0);

    Future<void> movePosition(ScrollPosition p) {
      if (!p.hasViewportDimension) return Future<void>.value();

      final rawTarget =
          p.pixels +
          p.viewportDimension * viewportFraction * (forward ? 1.0 : -1.0);

      final target = clamp && p.hasContentDimensions
          ? clampDouble(rawTarget, p.minScrollExtent, p.maxScrollExtent)
          : rawTarget;

      if (duration <= Duration.zero) {
        p.jumpTo(target);
        return Future<void>.value();
      }
      return p.animateTo(target, duration: duration, curve: curve);
    }

    await Future.wait<void>(<Future<void>>[
      for (final ScrollPosition p in positions) movePosition(p),
    ]);
  }

  /// Scrolls to an absolute [percentage] of the scroll extent.
  ///
  /// - 0.0 = start ([ScrollPosition.minScrollExtent])
  /// - 1.0 = end ([ScrollPosition.maxScrollExtent])
  ///
  /// Does nothing until content dimensions are available.
  Future<void> scrollToPercentage(
    double percentage, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCubic,
  }) async {
    if (!hasClients) return;

    assert(
      percentage >= 0.0 && percentage <= 1.0,
      'percentage must be between 0.0 and 1.0',
    );
    final p = percentage.clamp(0.0, 1.0);

    Future<void> movePosition(ScrollPosition pos) {
      if (!pos.hasContentDimensions) return Future<void>.value();

      final target =
          pos.minScrollExtent + (pos.maxScrollExtent - pos.minScrollExtent) * p;

      if (duration <= Duration.zero) {
        pos.jumpTo(target);
        return Future<void>.value();
      }
      return pos.animateTo(target, duration: duration, curve: curve);
    }

    await Future.wait<void>(<Future<void>>[
      for (final ScrollPosition pos in positions) movePosition(pos),
    ]);
  }

  /// Scrolls by a relative [percentage] (-1.0..1.0) of the total scroll extent.
  ///
  /// Does nothing until content dimensions are available.
  Future<void> scrollByPercentage(
    double percentage, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCubic,
  }) async {
    if (!hasClients) return;

    assert(
      percentage >= -1.0 && percentage <= 1.0,
      'percentage must be between -1.0 and 1.0',
    );
    final p = percentage.clamp(-1.0, 1.0);

    Future<void> movePosition(ScrollPosition pos) {
      if (!pos.hasContentDimensions) return Future<void>.value();

      final extent = pos.maxScrollExtent - pos.minScrollExtent;
      final target = clampDouble(
        pos.pixels + extent * p,
        pos.minScrollExtent,
        pos.maxScrollExtent,
      );

      if (duration <= Duration.zero) {
        pos.jumpTo(target);
        return Future<void>.value();
      }
      return pos.animateTo(target, duration: duration, curve: curve);
    }

    await Future.wait<void>(<Future<void>>[
      for (final ScrollPosition pos in positions) movePosition(pos),
    ]);
  }

  // ---------------------------------------------------------------------------
  // MARK: - Snap scrolling
  // ---------------------------------------------------------------------------

  /// Snaps to the nearest item boundary for fixed-extent lists/carousels.
  Future<void> snapToClosest({
    required double itemExtent,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) async {
    if (!hasClients || itemExtent <= 0) return;

    await Future.wait<void>(<Future<void>>[
      for (final ScrollPosition pos in positions)
        () {
          final rawTarget = (pos.pixels / itemExtent).round() * itemExtent;
          final target = pos.hasContentDimensions
              ? clampDouble(rawTarget, pos.minScrollExtent, pos.maxScrollExtent)
              : rawTarget;

          if (duration <= Duration.zero) {
            pos.jumpTo(target);
            return Future<void>.value();
          }
          return pos.animateTo(target, duration: duration, curve: curve);
        }(),
    ]);
  }

  /// Snaps to a specific [index] for fixed-extent lists/carousels.
  Future<void> snapToIndex(
    int index, {
    required double itemExtent,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) => moveToPosition(
    index * itemExtent,
    duration: duration,
    curve: curve,
    clamp: true,
  );

  // ---------------------------------------------------------------------------
  // MARK: - Queries (single-client, metrics-safe)
  // ---------------------------------------------------------------------------

  /// True if there is a single client and its pixels, viewport, and extents are ready.
  bool get hasMetrics => _metricsReadyPosition != null;

  /// Amount of content above the viewport.
  double get extentBefore => _metricsReadyPosition?.extentBefore ?? 0.0;

  /// Amount of content inside the viewport.
  double get extentInside => _metricsReadyPosition?.extentInside ?? 0.0;

  /// Amount of content below the viewport.
  double get extentAfter => _metricsReadyPosition?.extentAfter ?? 0.0;

  /// Total content extent (before + inside + after).
  double get extentTotal => _metricsReadyPosition?.extentTotal ?? 0.0;

  /// Scroll progress in the range 0.0..1.0.
  ///
  /// Returns 0.0 unless [hasMetrics] is true.
  double get scrollProgress {
    final p = _metricsReadyPosition;
    if (p == null) return 0.0;

    final extent = p.maxScrollExtent - p.minScrollExtent;
    if (extent <= 0) return 0.0;

    return ((p.pixels - p.minScrollExtent) / extent).clamp(0.0, 1.0);
  }

  /// True if at (or slightly past) the start edge.
  bool get isAtStart {
    final p = _metricsReadyPosition;
    if (p == null) return false;
    return p.pixels <= p.minScrollExtent + precisionErrorTolerance;
  }

  /// True if at (or slightly past) the end edge.
  bool get isAtEnd {
    final p = _metricsReadyPosition;
    if (p == null) return false;
    return p.pixels >= p.maxScrollExtent - precisionErrorTolerance;
  }

  /// Backwards-friendly aliases.
  bool get isAtTop => isAtStart;

  /// Backwards-compatible alias for [isAtEnd].
  bool get isAtBottom => isAtEnd;

  /// True if at either edge.
  bool get isAtEdge => isAtStart || isAtEnd;

  /// True if the content is scrollable (max > min).
  bool get canScroll {
    final p = _metricsReadyPosition;
    if (p == null) return false;
    return p.maxScrollExtent > p.minScrollExtent;
  }

  /// True if the scroll position is currently out of range (overscrolled).
  bool get isOutOfRange => _metricsReadyPosition?.outOfRange ?? false;

  /// True if within [threshold] pixels of the start edge.
  bool isNearStart({double threshold = 50.0}) {
    final p = _metricsReadyPosition;
    if (p == null) return false;
    final t = threshold < 0 ? 0 : threshold;
    return p.pixels <= p.minScrollExtent + t;
  }

  /// True if within [threshold] pixels of the end edge.
  bool isNearEnd({double threshold = 50.0}) {
    final p = _metricsReadyPosition;
    if (p == null) return false;
    final t = threshold < 0 ? 0 : threshold;
    return p.pixels >= p.maxScrollExtent - t;
  }

  /// Backwards-friendly aliases.
  bool isNearTop({double threshold = 50.0}) =>
      isNearStart(threshold: threshold);

  /// Backwards-compatible alias for [isNearEnd].
  bool isNearBottom({double threshold = 50.0}) =>
      isNearEnd(threshold: threshold);

  /// Checks if an item at [itemOffset] with size [itemExtent] is visible.
  ///
  /// This is a simple arithmetic check and doesn't require render-object lookup.
  bool isItemVisible(double itemOffset, double itemExtent) {
    final p = _singlePosition;
    if (p == null || !p.hasPixels || !p.hasViewportDimension) return false;

    final viewportStart = p.pixels;
    final viewportEnd = viewportStart + p.viewportDimension;
    return (itemOffset + itemExtent > viewportStart) &&
        (itemOffset < viewportEnd);
  }

  // ---------------------------------------------------------------------------
  // MARK: - Direction (single-client safe)
  // ---------------------------------------------------------------------------

  /// The current user scroll direction, or [ScrollDirection.idle] if unavailable.
  ScrollDirection get userScrollDirectionOrIdle =>
      _singlePosition?.userScrollDirection ?? ScrollDirection.idle;

  /// Whether the current user scroll direction is idle.
  bool get isUserScrollIdle =>
      userScrollDirectionOrIdle == ScrollDirection.idle;

  /// Whether the user is currently scrolling toward smaller offsets.
  bool get isUserScrollingForward =>
      userScrollDirectionOrIdle == ScrollDirection.forward;

  /// Whether the user is currently scrolling toward larger offsets.
  bool get isUserScrollingReverse =>
      userScrollDirectionOrIdle == ScrollDirection.reverse;

  /// True while scrolling (drag, ballistic, or animateTo).
  bool get isScrolling => _singlePosition?.isScrollingNotifier.value ?? false;

  // ---------------------------------------------------------------------------
  // MARK: - Conditional actions (single-client only)
  // ---------------------------------------------------------------------------

  /// Animates to start only if needed. Returns true if a scroll was triggered.
  Future<bool> scrollToStartIfNeeded({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    if (!hasMetrics || isAtStart) return false;
    await animateToStart(duration: duration, curve: curve);
    return true;
  }

  /// Animates to end only if needed. Returns true if a scroll was triggered.
  Future<bool> scrollToEndIfNeeded({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    if (!hasMetrics || isAtEnd) return false;
    await animateToEnd(duration: duration, curve: curve);
    return true;
  }

  // ---------------------------------------------------------------------------
  // MARK: - Debug
  // ---------------------------------------------------------------------------

  /// Prints a snapshot of the scroll state (debug only).
  void debugPrintScrollInfo({String? label}) {
    assert(() {
      final prefix = label == null ? '' : '$label - ';
      final p = _singlePosition;

      if (p == null) {
        debugPrint(
          '${prefix}ScrollController: clients=${positions.length} (need exactly 1 for metrics)',
        );
        return true;
      }

      final pixels = p.hasPixels ? p.pixels.toStringAsFixed(1) : 'n/a';
      final viewport = p.hasViewportDimension
          ? p.viewportDimension.toStringAsFixed(1)
          : 'n/a';
      final min = p.hasContentDimensions
          ? p.minScrollExtent.toStringAsFixed(1)
          : 'n/a';
      final max = p.hasContentDimensions
          ? p.maxScrollExtent.toStringAsFixed(1)
          : 'n/a';

      debugPrint(
        '${prefix}pixels=$pixels, range=$min..$max, viewport=$viewport, '
        'userDir=${p.userScrollDirection}, isScrolling=${p.isScrollingNotifier.value}, '
        'progress=${(scrollProgress * 100).toStringAsFixed(1)}%',
      );
      return true;
    }(), 'TODO ADD MESSAGE HERE TO STOP WARNING MESSAGE');
  }
}

/// Extension methods for [ScrollDirection] (nullable).
extension ScrollDirectionEx on ScrollDirection? {
  /// Whether the scroll direction is idle (or null).
  bool get isIdle => this == null || this == ScrollDirection.idle;

  /// Whether the scroll direction is forward.
  bool get isForward => this == ScrollDirection.forward;

  /// Whether the scroll direction is reverse.
  bool get isReverse => this == ScrollDirection.reverse;
}
