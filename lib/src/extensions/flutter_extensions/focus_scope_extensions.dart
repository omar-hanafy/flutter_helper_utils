import 'package:flutter/material.dart';

extension FHUFocusScopeExtension on BuildContext {
  /// Returns the [FocusNode.nearestScope] of the [Focus] or [FocusScope] that
  /// most tightly encloses the given [context].
  ///
  /// If this node doesn't have a [Focus] or [FocusScope] widget ancestor, then
  /// the [FocusManager.rootScope] is returned.
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// Removes the focus on this node by moving the primary focus to another node.
  ///
  /// This method removes focus from a node that has the primary focus, cancels
  /// any outstanding requests to focus it, while setting the primary focus to
  /// another node according to the `disposition`.
  ///
  /// It is safe to call regardless of whether this node has ever requested
  /// focus or not. If this node doesn't have focus or primary focus, nothing
  /// happens.
  void get unFocus => focusScope.unfocus();

  /// is commonly used to hide keyboard on onTap/onPress call. Usage could be
  /// `onTap: () => context.requestFocus` or `onTap: context.requestFocusCall`.
  void get requestFocus => focusScope.requestFocus(FocusNode());

  GestureTapCallback get requestFocusCall =>
      () => focusScope.requestFocus(FocusNode());

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
