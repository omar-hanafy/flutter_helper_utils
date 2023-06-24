import 'package:flutter/material.dart';

extension ScaffoldMessengerExtension on BuildContext {
  /// The state from the closest instance of this class that encloses the given
  /// context.
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// Shows a [MaterialBanner] across all registered [Scaffold]s. Scaffolds register
  /// to receive material banners from their closest [ScaffoldMessenger] ancestor.
  /// If there are several registered scaffolds the material banner is shown
  /// simultaneously on all of them.
  ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>
      showMaterialBanner(MaterialBanner materialBanner) =>
          scaffoldMessenger.showMaterialBanner(materialBanner);

  /// Shows a [SnackBar] across all registered [Scaffold]s. Scaffolds register
  /// to receive snack bars from their closest [ScaffoldMessenger] ancestor.
  /// If there are several registered scaffolds the snack bar is shown
  /// simultaneously on all of them.
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
          SnackBar snackBar) =>
      scaffoldMessenger.showSnackBar(snackBar);

  /// Removes the current [MaterialBanner] by running its normal exit animation.
  ///
  /// The closed completer is called after the animation is complete.
  void get hideCurrentMaterialBanner =>
      scaffoldMessenger.hideCurrentMaterialBanner();

  /// Removes the current [SnackBar] by running its normal exit animation.
  ///
  /// The closed completer is called after the animation is complete.
  void get hideCurrentSnackBar => scaffoldMessenger.hideCurrentSnackBar();

  /// Removes the current [MaterialBanner] (if any) immediately from registered
  /// [Scaffold]s.
  ///
  /// The removed material banner does not run its normal exit animation. If there are
  /// any queued material banners, they begin their entrance animation immediately.
  void get removeCurrentMaterialBanner =>
      scaffoldMessenger.removeCurrentMaterialBanner();

  /// Removes the current [SnackBar] (if any) immediately from registered
  /// [Scaffold]s.
  ///
  /// The removed snack bar does not run its normal exit animation. If there are
  /// any queued snack bars, they begin their entrance animation immediately.
  void get removeCurrentSnackBar => scaffoldMessenger.removeCurrentSnackBar();

  /// Removes all the [MaterialBanner]s currently in queue by clearing the queue
  /// and running normal exit animation on the current [MaterialBanner].
  void get clearMaterialBanners => scaffoldMessenger.clearMaterialBanners();

  /// Removes all the snackBars currently in queue by clearing the queue
  /// and running normal exit animation on the current snackBar.
  void get clearSnackBars => scaffoldMessenger.clearSnackBars();
}
