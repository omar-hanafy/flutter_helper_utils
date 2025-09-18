import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Item builder for [TypedListView]. Includes [BuildContext] for idiomatic Flutter
/// usage and access to inherited widgets, plus the item index and value.
typedef TypedListViewBuilder<T> = Widget Function(
  BuildContext context,
  int index,
  T item,
);

/// Builder that returns a stable key for an item. Used to compute a correct
/// flattened index for keyed children when headers/separators/etc. are present.
typedef ItemKeyBuilder<T> = Key Function(T item);

/// Extension on [Iterable] to build a [TypedListView] directly.
extension IterableTypedListViewExtension<E> on Iterable<E> {
  Widget buildListView({
    // Content
    required TypedListViewBuilder<E> itemBuilder,
    Widget? header,
    Widget? footer,

    // Decorations
    IndexedWidgetBuilder? separatorBuilder,
    double? spacing,
    Widget? paginationWidget,
    WidgetBuilder? emptyBuilder,

    // Scrolling/behavior
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
    ItemKeyBuilder<E>? itemKeyBuilder,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,

    // Quality-of-life
    bool showScrollbar = false,
    Future<void> Function()? onRefresh,
    Future<void> Function()? onEndReached,
    double onEndReachedThreshold = 200,
    bool isLoadingMore = false,
  }) {
    return TypedListView<E>(
      // Content
      items: toList(),
      // Convert to List for efficient access
      itemBuilder: itemBuilder,
      header: header,
      footer: footer,

      // Decorations
      separatorBuilder: separatorBuilder,
      spacing: spacing,
      paginationWidget: paginationWidget,
      emptyBuilder: emptyBuilder,

      // Scrolling/behavior
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
      itemKeyBuilder: itemKeyBuilder,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,

      // QoL
      showScrollbar: showScrollbar,
      onRefresh: onRefresh,
      onEndReached: onEndReached,
      onEndReachedThreshold: onEndReachedThreshold,
      isLoadingMore: isLoadingMore,
    );
  }
}

/// A type-safe ListView with optional header, footer, separators/spacing,
/// empty state, pagination widget, and end-reached callback.
///
/// Notes and best practices:
/// - `itemBuilder` includes `BuildContext` for idiomatic Flutter usage.
/// - `itemKeyBuilder` enables stable keys and a correct flattened
///   `findChildIndexCallback` under the hood, even with header/separators/etc.
/// - `itemExtent`/`prototypeItem` must only be used when every child has the
///   same extent (no header/footer/separators/pagination/spacing).
class TypedListView<E> extends StatelessWidget {
  const TypedListView({
    // Content
    required List<E> items,
    required TypedListViewBuilder<E> itemBuilder,
    super.key,
    Widget? header,
    Widget? footer,

    // Decorations
    IndexedWidgetBuilder? separatorBuilder,
    double? spacing,
    Widget? paginationWidget,
    WidgetBuilder? emptyBuilder,

    // Scrolling/behavior
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
    ItemKeyBuilder<E>? itemKeyBuilder,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,

    // Quality-of-life
    bool showScrollbar = false,
    Future<void> Function()? onRefresh,
    Future<void> Function()? onEndReached,
    double onEndReachedThreshold = 200,
    bool isLoadingMore = false,
  })  : assert(!(separatorBuilder != null && spacing != null),
            'Provide either separatorBuilder or spacing, not both.'),
        assert(itemExtent == null || prototypeItem == null,
            'Use either itemExtent or prototypeItem, not both.'),
        assert(
          itemExtent == null ||
              (header == null &&
                  footer == null &&
                  paginationWidget == null &&
                  separatorBuilder == null &&
                  spacing == null),
          'itemExtent cannot be used with header/footer/separators/pagination/spacing.',
        ),
        assert(
          prototypeItem == null ||
              (header == null &&
                  footer == null &&
                  paginationWidget == null &&
                  separatorBuilder == null &&
                  spacing == null),
          'prototypeItem cannot be used with header/footer/separators/pagination/spacing.',
        ),
        _items = items,
        _itemBuilder = itemBuilder,
        _header = header,
        _footer = footer,
        _separatorBuilder = separatorBuilder,
        _spacing = spacing,
        _paginationWidget = paginationWidget,
        _emptyBuilder = emptyBuilder,
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
        _itemKeyBuilder = itemKeyBuilder,
        _cacheExtent = cacheExtent,
        _semanticChildCount = semanticChildCount,
        _dragStartBehavior = dragStartBehavior,
        _keyboardDismissBehavior = keyboardDismissBehavior,
        _restorationId = restorationId,
        _clipBehavior = clipBehavior,
        _showScrollbar = showScrollbar,
        _onRefresh = onRefresh,
        _onEndReached = onEndReached,
        _onEndReachedThreshold = onEndReachedThreshold,
        _isLoadingMore = isLoadingMore;

  // Content
  final List<E> _items;
  final TypedListViewBuilder<E> _itemBuilder;
  final Widget? _header;
  final Widget? _footer;

  // Decorations
  final IndexedWidgetBuilder? _separatorBuilder;
  final double? _spacing;
  final Widget? _paginationWidget;
  final WidgetBuilder? _emptyBuilder;

  // Scrolling/behavior
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
  final ItemKeyBuilder<E>? _itemKeyBuilder;
  final double? _cacheExtent;
  final int? _semanticChildCount;
  final DragStartBehavior _dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior _keyboardDismissBehavior;
  final String? _restorationId;
  final Clip _clipBehavior;

  // QoL
  final bool _showScrollbar;
  final Future<void> Function()? _onRefresh;
  final Future<void> Function()? _onEndReached;
  final double _onEndReachedThreshold;
  final bool _isLoadingMore;

  bool get _hasSeparators =>
      (_separatorBuilder != null || _spacing != null) && _items.length > 1;

  IndexedWidgetBuilder? get _effectiveSeparatorBuilder {
    if (_separatorBuilder != null) return _separatorBuilder;
    if (_spacing == null) return null;
    return (context, _) => _scrollDirection == Axis.vertical
        ? SizedBox(height: _spacing)
        : SizedBox(width: _spacing);
  }

  @override
  Widget build(BuildContext context) {
    final showEmpty = _items.isEmpty && _emptyBuilder != null;

    // Build a flattened findChildIndexCallback that accounts for header/separators/etc.
    ChildIndexGetter? effectiveFindChildIndexCallback;
    if (_itemKeyBuilder != null) {
      effectiveFindChildIndexCallback = (key) {
        for (var i = 0; i < _items.length; i++) {
          if (_itemKeyBuilder(_items[i]) == key) {
            return _flattenedIndexForItem(i);
          }
        }
        return null;
      };
    }

    Widget list = ListView.builder(
      // Do not forward this widget's key; it's the identity of the parent.
      padding: _padding,
      physics: _physics,
      shrinkWrap: _shrinkWrap,
      itemCount: _calculateItemCount(
        _items.length,
        header: _header,
        footer: _footer,
        separatorBuilder: _effectiveSeparatorBuilder,
        paginationWidget: _paginationWidget,
        showEmpty: showEmpty,
      ),
      itemBuilder: (context, index) => _buildItem(
        context,
        index,
        items: _items,
        itemBuilder: _itemBuilder,
        header: _header,
        footer: _footer,
        separatorBuilder: _effectiveSeparatorBuilder,
        paginationWidget: _paginationWidget,
        emptyBuilder: _emptyBuilder,
        scrollDirection: _scrollDirection,
        itemKeyBuilder: _itemKeyBuilder,
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
      findChildIndexCallback: effectiveFindChildIndexCallback,
      cacheExtent: _cacheExtent,
      semanticChildCount: _semanticChildCount,
      dragStartBehavior: _dragStartBehavior,
      keyboardDismissBehavior: _keyboardDismissBehavior,
      restorationId: _restorationId,
      clipBehavior: _clipBehavior,
    );

    // Compose QoL wrappers
    if (_onEndReached != null) {
      list = NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          final metrics = notification.metrics;
          if (metrics.extentAfter <= _onEndReachedThreshold &&
              !_isLoadingMore) {
            _onEndReached.call();
          }
          return false;
        },
        child: list,
      );
    }

    if (_onRefresh != null) {
      list = RefreshIndicator(onRefresh: _onRefresh, child: list);
    }

    if (_showScrollbar) {
      list = Scrollbar(controller: _controller, child: list);
    }

    return list;
  }

  int _flattenedIndexForItem(int itemIndex) {
    final headerOffset = _header != null ? 1 : 0;
    final sepStride = _hasSeparators ? 2 : 1;
    return headerOffset + itemIndex * sepStride;
  }

  /// Calculates the total item count, including headers, footers, separators,
  /// pagination, and empty state.
  static int _calculateItemCount(
    int itemCount, {
    required Widget? header,
    required Widget? footer,
    required IndexedWidgetBuilder? separatorBuilder,
    required Widget? paginationWidget,
    required bool showEmpty,
  }) {
    var count = 0;

    if (header != null) count += 1;

    if (itemCount > 0) {
      count += itemCount;
      if (separatorBuilder != null && itemCount > 1) {
        count += itemCount - 1;
      }
    } else if (showEmpty) {
      count += 1; // the empty widget
    }

    if (paginationWidget != null) count += 1;
    if (footer != null) count += 1;

    return count;
  }

  /// Builds header, items, separators, empty, pagination, and footer.
  static Widget _buildItem<E>(
    BuildContext context,
    int index, {
    required List<E> items,
    required TypedListViewBuilder<E> itemBuilder,
    required Widget? header,
    required Widget? footer,
    required IndexedWidgetBuilder? separatorBuilder,
    required Widget? paginationWidget,
    required WidgetBuilder? emptyBuilder,
    required Axis scrollDirection,
    required ItemKeyBuilder<E>? itemKeyBuilder,
  }) {
    final hasSeparators = separatorBuilder != null && items.length > 1;

    final headerOffset = header != null ? 1 : 0;
    final footerOffset = footer != null ? 1 : 0;
    final paginationOffset = paginationWidget != null ? 1 : 0;
    final separatorCount = hasSeparators ? items.length - 1 : 0;
    final showEmpty = items.isEmpty && emptyBuilder != null;

    final contentCount =
        items.isEmpty ? (showEmpty ? 1 : 0) : items.length + separatorCount;

    final totalItemCount =
        headerOffset + contentCount + paginationOffset + footerOffset;

    // Header
    if (header != null && index == 0) return header;

    // Footer
    if (footer != null && index == totalItemCount - 1) return footer;

    // Pagination (always placed before footer if present)
    if (paginationWidget != null &&
        index == totalItemCount - footerOffset - 1) {
      return paginationWidget;
    }

    // Empty state (placed right after header)
    if (showEmpty && index == headerOffset) {
      return emptyBuilder(context);
    }

    // Adjust for header
    var adjustedIndex = index - headerOffset;

    // Adjust for empty slot if present
    if (showEmpty) {
      adjustedIndex -= 1; // consume the empty slot
    }

    // Separators (odd indices)
    if (hasSeparators) {
      if (adjustedIndex.isOdd) {
        return separatorBuilder(context, adjustedIndex ~/ 2);
      }
      adjustedIndex = adjustedIndex ~/ 2;
    }

    // Build item
    if (adjustedIndex >= 0 && adjustedIndex < items.length) {
      var child = itemBuilder(context, adjustedIndex, items[adjustedIndex]);
      if (itemKeyBuilder != null) {
        child = KeyedSubtree(
          key: itemKeyBuilder(items[adjustedIndex]),
          child: child,
        );
      }
      return child;
    }

    return const SizedBox.shrink();
  }
}
