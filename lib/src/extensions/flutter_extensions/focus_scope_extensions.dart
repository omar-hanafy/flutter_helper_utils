import 'package:flutter/widgets.dart';

/// Focus helpers for reading and updating the nearest [FocusScopeNode].
extension FHUFocusScopeExtension on BuildContext {
  /// Returns the nearest [FocusScopeNode] that encloses this context.
  ///
  /// If there is no [Focus] or [FocusScope] ancestor, [FocusManager.rootScope]
  /// is returned.
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// Same as [focusScope], but does not register an inherited dependency.
  ///
  /// Prefer this in callbacks (for example, `onTap`) to avoid triggering
  /// rebuilds when focus changes.
  FocusScopeNode get focusScopeNoDependency =>
      FocusScope.of(this, createDependency: false);

  /// Removes focus from the currently focused node.
  ///
  /// This cancels any outstanding request to focus it, and moves focus
  /// according to [disposition].
  ///
  /// It is safe to call even if nothing is focused.
  void unfocus({UnfocusDisposition disposition = UnfocusDisposition.scope}) {
    FocusManager.instance.primaryFocus?.unfocus(disposition: disposition);
  }

  /// A callback that calls [unfocus].
  ///
  /// Useful for `onTap: context.unfocusCall`.
  VoidCallback get unfocusCall => unfocus;

  /// Whether this node has input focus.
  ///
  /// A [FocusNode] has focus when it is an ancestor of a node that returns true
  /// from [hasPrimaryFocus], or it has the primary focus itself.
  bool get hasFocus => focusScope.hasFocus;

  /// Returns true if this node currently has the application-wide input focus.
  ///
  /// A [FocusNode] has the primary focus when the node is focused in its
  /// nearest ancestor [FocusScopeNode] and [hasFocus] is true for all its
  /// ancestor nodes, but none of its descendants.
  ///
  /// This is different from [hasFocus] in that [hasFocus] is true if the node
  /// is anywhere in the focus chain, but here the node has to be at the end of
  /// the chain to return true.
  bool get hasPrimaryFocus => focusScope.hasPrimaryFocus;
}
