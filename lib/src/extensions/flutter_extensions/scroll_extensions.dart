import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

extension ScrollControllerEx on ScrollController {
  // Basic scroll animations
  Future<void> animateToPosition(
    double offset, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    await animateTo(offset, duration: duration, curve: curve);
  }

  Future<void> animateToBottom({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    await animateToPosition(position.maxScrollExtent,
        duration: duration, curve: curve);
  }

  Future<void> animateToTop({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
  }) async {
    await animateToPosition(0, duration: duration, curve: curve);
  }

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

  // Advanced scroll controls
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

  Future<void> scrollToPercentage(
    double percentage, {
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCubic,
  }) async {
    assert(percentage >= 0.0 && percentage <= 1.0);
    final targetOffset = position.maxScrollExtent * percentage;
    await animateToPosition(targetOffset, duration: duration, curve: curve);
  }

  // Position checking
  bool get isAtEdge => position.atEdge;
  bool get isAtBottom => position.pixels >= position.maxScrollExtent;
  double get scrollProgress => position.pixels / position.maxScrollExtent;
  bool isNearTop({double threshold = 50.0}) => position.pixels <= threshold;
  bool isNearBottom({double threshold = 50.0}) =>
      position.pixels >= position.maxScrollExtent - threshold;
}

extension ScrollControllerNEx on ScrollController? {
  bool? get isInTop => this != null && this!.hasClients && this!.offset == 0;
  bool get canScroll =>
      this?.hasClients == true &&
      this!.position.maxScrollExtent > this!.position.minScrollExtent;

  Future<bool> get didScrollToTop async {
    if (this == null) return false;
    if (this!.hasClients && this!.position.pixels > 0) {
      await this!.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
      return true;
    }
    return false;
  }

  // Direction checking
  bool get isScrollReverse => (this?.position.userScrollDirection).isReverse;
  bool get isScrollIdle => (this?.position.userScrollDirection).isIdle;
  bool get isScrollForward => (this?.position.userScrollDirection).isForward;
}

extension ScrollDirectionEx on ScrollDirection? {
  bool get isIdle => this == ScrollDirection.idle;
  bool get isForward => this == ScrollDirection.forward;
  bool get isReverse => this == ScrollDirection.reverse;
}
