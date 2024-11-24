import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef TypedListViewBuilder<T> = Widget Function(int index, T item);

/// Extension on [Iterable] to build a [TypedListView] directly.
extension IterableTypedListViewExtension<E> on Iterable<E> {
  Widget buildListView({
    required TypedListViewBuilder<E> itemBuilder,
    Widget? header,
    Widget? footer,
    IndexedWidgetBuilder? separatorBuilder,
    Widget? paginationWidget,
    Key? key,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    double? itemExtent,
    Widget? prototypeItem,
    ChildIndexGetter? findChildIndexCallback,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return TypedListView<E>(
      items: toList(),
      // Convert to List for efficient access
      itemBuilder: itemBuilder,
      header: header,
      footer: footer,
      separatorBuilder: separatorBuilder,
      paginationWidget: paginationWidget,
      key: key,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      itemExtent: itemExtent,
      prototypeItem: prototypeItem,
      findChildIndexCallback: findChildIndexCallback,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
    );
  }
}

/// A type-safe ListView that allows for easy customization with headers,
/// footers, separators, and pagination.
///
/// This widget extends Flutter's `ListView.builder` and provides a convenient
/// way to build lists with optional headers, footers, separators, and a
/// pagination widget.
///
/// The `itemBuilder` is a required parameter that takes the current index and
/// item as arguments and returns a widget to be displayed at that position.
///
/// The `header`, `footer`, and `paginationWidget` parameters are optional and
/// allow you to add widgets at the beginning, end, or before the last item
/// of the list, respectively.
///
/// The `separatorBuilder` parameter is also optional and allows you to add
/// separators between items in the list.
///
/// Example usage:
/// ```dart
/// TypedListView<String>(
///   items: ['Item 1', 'Item 2', 'Item 3'],
///   itemBuilder: (index, item) => ListTile(title: Text(item)),
///   header: const Text('Header'),
///   footer: const Text('Footer'),
///   separatorBuilder: (context, index) => const Divider(),
///   paginationWidget: const CircularProgressIndicator(),
/// )
/// ```
class TypedListView<E> extends StatelessWidget {
  const TypedListView({
    required List<E> items,
    required TypedListViewBuilder<E> itemBuilder,
    super.key,
    Widget? header,
    Widget? footer,
    IndexedWidgetBuilder? separatorBuilder,
    Widget? paginationWidget,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    double? itemExtent,
    Widget? prototypeItem,
    ChildIndexGetter? findChildIndexCallback,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
  })  : _items = items,
        _itemBuilder = itemBuilder,
        _header = header,
        _footer = footer,
        _separatorBuilder = separatorBuilder,
        _paginationWidget = paginationWidget,
        _padding = padding,
        _physics = physics,
        _shrinkWrap = shrinkWrap,
        _addAutomaticKeepAlives = addAutomaticKeepAlives,
        _addRepaintBoundaries = addRepaintBoundaries,
        _addSemanticIndexes = addSemanticIndexes,
        _scrollDirection = scrollDirection,
        _reverse = reverse,
        _controller = controller,
        _primary = primary,
        _itemExtent = itemExtent,
        _prototypeItem = prototypeItem,
        _findChildIndexCallback = findChildIndexCallback,
        _cacheExtent = cacheExtent,
        _semanticChildCount = semanticChildCount,
        _dragStartBehavior = dragStartBehavior,
        _keyboardDismissBehavior = keyboardDismissBehavior,
        _restorationId = restorationId,
        _clipBehavior = clipBehavior;

  final List<E> _items;
  final TypedListViewBuilder<E> _itemBuilder;
  final Widget? _header;
  final Widget? _footer;
  final IndexedWidgetBuilder? _separatorBuilder;
  final Widget? _paginationWidget;

  final EdgeInsetsGeometry? _padding;
  final ScrollPhysics? _physics;
  final bool _shrinkWrap;
  final bool _addAutomaticKeepAlives;
  final bool _addRepaintBoundaries;
  final bool _addSemanticIndexes;
  final Axis _scrollDirection;
  final bool _reverse;
  final ScrollController? _controller;
  final bool? _primary;
  final double? _itemExtent;
  final Widget? _prototypeItem;
  final ChildIndexGetter? _findChildIndexCallback;
  final double? _cacheExtent;
  final int? _semanticChildCount;
  final DragStartBehavior _dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior _keyboardDismissBehavior;
  final String? _restorationId;
  final Clip _clipBehavior;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: key,
      padding: _padding,
      physics: _physics,
      shrinkWrap: _shrinkWrap,
      itemCount: _calculateItemCount(
        _items.length,
        header: _header,
        footer: _footer,
        separatorBuilder: _separatorBuilder,
        paginationWidget: _paginationWidget,
      ),
      itemBuilder: (context, index) => _buildItem(
        context,
        index,
        items: _items,
        itemBuilder: _itemBuilder,
        header: _header,
        footer: _footer,
        separatorBuilder: _separatorBuilder,
        paginationWidget: _paginationWidget,
      ),
      addAutomaticKeepAlives: _addAutomaticKeepAlives,
      addRepaintBoundaries: _addRepaintBoundaries,
      addSemanticIndexes: _addSemanticIndexes,
      scrollDirection: _scrollDirection,
      reverse: _reverse,
      controller: _controller,
      primary: _primary,
      itemExtent: _itemExtent,
      prototypeItem: _prototypeItem,
      findChildIndexCallback: _findChildIndexCallback,
      cacheExtent: _cacheExtent,
      semanticChildCount: _semanticChildCount,
      dragStartBehavior: _dragStartBehavior,
      keyboardDismissBehavior: _keyboardDismissBehavior,
      restorationId: _restorationId,
      clipBehavior: _clipBehavior,
    );
  }

  /// Calculates the total number of items in the list, including headers,
  /// footers, separators, and pagination widgets.
  static int _calculateItemCount(
    int itemCount, {
    Widget? header,
    Widget? footer,
    IndexedWidgetBuilder? separatorBuilder,
    Widget? paginationWidget,
  }) {
    // Start with the base item count
    var count = itemCount;

    // Add separators between items if there are at least two items
    if (separatorBuilder != null && itemCount > 1) {
      count += itemCount - 1;
    }

    // Add header, footer, and paginationWidget if they exist
    if (header != null) count += 1;
    if (paginationWidget != null) count += 1;
    if (footer != null) count += 1;

    return count;
  }

  /// Builds the appropriate widget for the given index, handling headers,
  /// footers, separators, and pagination widgets.
  static Widget _buildItem<E>(
    BuildContext context,
    int index, {
    required List<E> items,
    required TypedListViewBuilder<E> itemBuilder,
    Widget? header,
    Widget? footer,
    IndexedWidgetBuilder? separatorBuilder,
    Widget? paginationWidget,
  }) {
    final headerOffset = header != null ? 1 : 0;
    final footerOffset = footer != null ? 1 : 0;
    final paginationOffset = paginationWidget != null ? 1 : 0;
    final separatorCount =
        (separatorBuilder != null && items.length > 1) ? items.length - 1 : 0;
    final totalItemCount = headerOffset +
        items.length +
        separatorCount +
        paginationOffset +
        footerOffset;

    // Handle header
    if (header != null && index == 0) return header;

    // Handle footer
    if (footer != null && index == totalItemCount - 1) {
      return footer;
    }

    // Handle paginationWidget
    if (paginationWidget != null &&
        index == totalItemCount - footerOffset - 1) {
      return paginationWidget;
    }

    // Adjust index for header
    var adjustedIndex = index - headerOffset;

    // Handle separators
    if (separatorBuilder != null && items.length > 1) {
      if (adjustedIndex.isOdd) {
        // This is a separator
        return separatorBuilder(context, adjustedIndex ~/ 2);
      }
      // This is an item
      adjustedIndex = adjustedIndex ~/ 2;
    }

    // Build item
    if (adjustedIndex >= 0 && adjustedIndex < items.length) {
      return itemBuilder(adjustedIndex, items[adjustedIndex]);
    }

    // Return an empty widget if index is out of bounds
    return const SizedBox.shrink();
  }
}
