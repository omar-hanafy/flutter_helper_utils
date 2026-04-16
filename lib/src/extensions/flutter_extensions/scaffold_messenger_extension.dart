import 'package:flutter/material.dart';

/// Convenience accessors and forwarding methods for [ScaffoldMessenger].
extension FHUScaffoldMessengerExtension on BuildContext {
  /// The state from the closest instance of [ScaffoldMessenger] that encloses
  /// the given context.
  ///
  /// Throws if no [ScaffoldMessenger] ancestor is found.
  ///
  /// See also:
  ///  * [maybeScaffoldMessenger], which returns null instead of throwing.
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// The state from the closest instance of [ScaffoldMessenger] that encloses
  /// the given context, if any.
  ///
  /// Returns null if no [ScaffoldMessenger] ancestor is found.
  ///
  /// See also:
  ///  * [scaffoldMessenger], which throws instead of returning null.
  ScaffoldMessengerState? get maybeScaffoldMessenger =>
      ScaffoldMessenger.maybeOf(this);

  /// Shows a [MaterialBanner] across all registered [Scaffold]s. Scaffolds
  /// register to receive material banners from their closest
  /// [ScaffoldMessenger] ancestor. If there are several registered scaffolds
  /// the material banner is shown simultaneously on all of them.
  ///
  /// A scaffold can show at most one material banner at a time. If this
  /// function is called while another material banner is already visible, the
  /// given material banner will be added to a queue and displayed after the
  /// earlier material banners have closed.
  ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>
  showMaterialBanner(MaterialBanner materialBanner) =>
      scaffoldMessenger.showMaterialBanner(materialBanner);

  /// Shows a [SnackBar] across all registered [Scaffold]s. Scaffolds register
  /// to receive snack bars from their closest [ScaffoldMessenger] ancestor.
  /// If there are several registered scaffolds the snack bar is shown
  /// simultaneously on all of them.
  ///
  /// A scaffold can show at most one snack bar at a time. If this function is
  /// called while another snack bar is already visible, the given snack bar
  /// will be added to a queue and displayed after the earlier snack bars have
  /// closed.
  ///
  /// If [snackBarAnimationStyle] is provided, it will be used to override
  /// the snack bar's show and hide animation durations. Use
  /// [AnimationStyle.noAnimation] to disable the animation.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar, {
    AnimationStyle? snackBarAnimationStyle,
  }) => scaffoldMessenger.showSnackBar(
    snackBar,
    snackBarAnimationStyle: snackBarAnimationStyle,
  );

  /// Removes the current [MaterialBanner] by running its normal exit animation.
  ///
  /// The closed completer is called after the animation is complete.
  ///
  /// The [reason] defaults to [MaterialBannerClosedReason.hide].
  void hideCurrentMaterialBanner({
    MaterialBannerClosedReason reason = MaterialBannerClosedReason.hide,
  }) => scaffoldMessenger.hideCurrentMaterialBanner(reason: reason);

  /// Removes the current [SnackBar] by running its normal exit animation.
  ///
  /// The closed completer is called after the animation is complete.
  ///
  /// The [reason] defaults to [SnackBarClosedReason.hide].
  void hideCurrentSnackBar({
    SnackBarClosedReason reason = SnackBarClosedReason.hide,
  }) => scaffoldMessenger.hideCurrentSnackBar(reason: reason);

  /// Removes the current [MaterialBanner] (if any) immediately from registered
  /// [Scaffold]s.
  ///
  /// The removed material banner does not run its normal exit animation. If
  /// there are any queued material banners, they begin their entrance animation
  /// immediately.
  ///
  /// The [reason] defaults to [MaterialBannerClosedReason.remove].
  void removeCurrentMaterialBanner({
    MaterialBannerClosedReason reason = MaterialBannerClosedReason.remove,
  }) => scaffoldMessenger.removeCurrentMaterialBanner(reason: reason);

  /// Removes the current [SnackBar] (if any) immediately from registered
  /// [Scaffold]s.
  ///
  /// The removed snack bar does not run its normal exit animation. If there are
  /// any queued snack bars, they begin their entrance animation immediately.
  ///
  /// The [reason] defaults to [SnackBarClosedReason.remove].
  void removeCurrentSnackBar({
    SnackBarClosedReason reason = SnackBarClosedReason.remove,
  }) => scaffoldMessenger.removeCurrentSnackBar(reason: reason);

  /// Removes all the [MaterialBanner]s currently in queue by clearing the queue
  /// and running normal exit animation on the current [MaterialBanner].
  void clearMaterialBanners() => scaffoldMessenger.clearMaterialBanners();

  /// Removes all the snackBars currently in queue by clearing the queue
  /// and running normal exit animation on the current snackBar.
  void clearSnackBars() => scaffoldMessenger.clearSnackBars();
}
