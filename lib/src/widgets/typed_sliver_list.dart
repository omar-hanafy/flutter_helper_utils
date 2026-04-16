import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ItemExtentBuilder;

import 'package:flutter_helper_utils/src/widgets/typed_list_view.dart'
    show ItemKeyBuilder, TypedListViewBuilder;

/// Sugar: build a typed sliver list directly from an Iterable.
extension IterableTypedSliverListExtension<E> on Iterable<E> {
  /// Builds a [TypedSliverList] from this iterable.
  ///
  /// The iterable is eagerly converted to a list so the sliver can access items
  /// by index and keep stable ordering for keyed children.
  Widget buildSliverList({
    // Content
    required TypedListViewBuilder<E> itemBuilder,
    Widget? header,
    Widget? footer,
    Widget? sliverHeader,
    Widget? sliverFooter,

    // Decorations
    IndexedWidgetBuilder? separatorBuilder,
    double? spacing,
    Widget? paginationWidget,
    Widget? paginationSliver,
    WidgetBuilder? emptyBuilder,
    bool fillRemainingWhenEmpty = true,

    // Behavior / perf
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    ItemKeyBuilder<E>? itemKeyBuilder,
    ChildIndexGetter? findItemIndexCallback,

    // Extent options (cannot be combined with separators/spacing)
    double? itemExtent,
    Widget? prototypeItem,
    ItemExtentBuilder? itemExtentBuilder,

    // Layout niceties
    Axis mainAxis = Axis.vertical,
    EdgeInsetsGeometry? padding,
    bool useSliverSafeArea = false,

    // Infinite scroll sentinel
    FutureOr<void> Function()? onEndReached,
    bool isLoadingMore = false,
  }) {
    return TypedSliverList<E>(
      items: toList(),
      itemBuilder: itemBuilder,
      header: header,
      footer: footer,
      sliverHeader: sliverHeader,
      sliverFooter: sliverFooter,
      separatorBuilder: separatorBuilder,
      spacing: spacing,
      paginationWidget: paginationWidget,
      paginationSliver: paginationSliver,
      emptyBuilder: emptyBuilder,
      fillRemainingWhenEmpty: fillRemainingWhenEmpty,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      itemKeyBuilder: itemKeyBuilder,
      findItemIndexCallback: findItemIndexCallback,
      itemExtent: itemExtent,
      prototypeItem: prototypeItem,
      itemExtentBuilder: itemExtentBuilder,
      mainAxis: mainAxis,
      padding: padding,
      useSliverSafeArea: useSliverSafeArea,
      onEndReached: onEndReached,
      isLoadingMore: isLoadingMore,
    );
  }
}

/// A type-safe sliver section for CustomScrollView.slivers.
///
/// Composes: optional sliver/box header, typed SliverList (with separators or
/// extent variants), empty state, optional pagination widget/sliver, and
/// optional sliver/box footer.
class TypedSliverList<E> extends StatelessWidget {
  /// Creates a typed sliver section with optional headers, footers, and loading UI.
  const TypedSliverList({
    // Content
    required List<E> items,
    required TypedListViewBuilder<E> itemBuilder,
    super.key,
    this.header,
    this.footer,
    this.sliverHeader,
    this.sliverFooter,

    // Decorations
    this.separatorBuilder,
    this.spacing,
    this.paginationWidget,
    this.paginationSliver,
    this.emptyBuilder,
    this.fillRemainingWhenEmpty = true,

    // Behavior / perf
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.itemKeyBuilder,
    this.findItemIndexCallback,

    // Extent options (exclusive with separators/spacing)
    this.itemExtent,
    this.prototypeItem,
    this.itemExtentBuilder,

    // Layout niceties
    this.mainAxis = Axis.vertical,
    this.padding,
    this.useSliverSafeArea = false,

    // Infinite scroll sentinel
    this.onEndReached,
    this.isLoadingMore = false,
  }) : _items = items,
       _itemBuilder = itemBuilder,
       assert(
         !(separatorBuilder != null && spacing != null),
         'Provide either separatorBuilder or spacing, not both.',
       ),
       assert(
         !(paginationWidget != null && paginationSliver != null),
         'Provide either paginationWidget or paginationSliver, not both.',
       ),
       assert(
         !(header != null && sliverHeader != null),
         'Provide either header or sliverHeader, not both.',
       ),
       assert(
         !(footer != null && sliverFooter != null),
         'Provide either footer or sliverFooter, not both.',
       ),
       assert(
         (separatorBuilder == null && spacing == null) ||
             (itemExtent == null &&
                 prototypeItem == null &&
                 itemExtentBuilder == null),
         'Separators/spacing cannot be combined with itemExtent/prototypeItem/itemExtentBuilder.',
       );

  // Content
  final List<E> _items;
  final TypedListViewBuilder<E> _itemBuilder;

  /// Optional box widget inserted before the item sliver.
  final Widget? header;

  /// Optional box widget inserted after the item sliver.
  final Widget? footer;

  /// Optional sliver inserted before the item sliver.
  final Widget? sliverHeader;

  /// Optional sliver inserted after the item sliver.
  final Widget? sliverFooter;

  // Decorations

  /// Builder used to insert separators between items.
  final IndexedWidgetBuilder? separatorBuilder;

  /// Fixed gap inserted between items when [separatorBuilder] is null.
  final double? spacing;

  /// Box widget shown after the items, typically for pagination UI.
  final Widget? paginationWidget;

  /// Sliver shown after the items, typically for pagination UI.
  final Widget? paginationSliver;

  /// Builder used when the item list is empty.
  final WidgetBuilder? emptyBuilder;

  /// Whether the empty state should occupy the remaining viewport space.
  final bool fillRemainingWhenEmpty;

  // Behavior / perf

  /// Whether item children should keep their state alive when offscreen.
  final bool addAutomaticKeepAlives;

  /// Whether item children should be wrapped in repaint boundaries.
  final bool addRepaintBoundaries;

  /// Whether semantic indexes should be assigned to item children.
  final bool addSemanticIndexes;

  /// Stable key builder used to preserve child identity across rebuilds.
  final ItemKeyBuilder<E>? itemKeyBuilder;

  /// Optional key-to-index lookup for custom child indexing.
  final ChildIndexGetter? findItemIndexCallback;

  // Extent options

  /// Fixed extent used for every item when no separators are present.
  final double? itemExtent;

  /// Prototype widget used to estimate a shared item extent.
  final Widget? prototypeItem;

  /// Per-index extent builder used by sliver extent list variants.
  final ItemExtentBuilder? itemExtentBuilder;

  // Layout niceties

  /// Main scroll axis used to interpret [spacing].
  final Axis mainAxis;

  /// Optional padding applied around the composed sliver group.
  final EdgeInsetsGeometry? padding;

  /// Whether to wrap the composed sliver group in [SliverSafeArea].
  final bool useSliverSafeArea;

  // Infinite scroll

  /// Callback triggered when the end-reached sentinel becomes visible.
  final FutureOr<void> Function()? onEndReached;

  /// Whether additional content is currently loading after the last item.
  final bool isLoadingMore;

  bool get _hasSeparators =>
      (separatorBuilder != null || spacing != null) && _items.length > 1;

  IndexedWidgetBuilder? get _effectiveSeparatorBuilder {
    if (separatorBuilder != null) return separatorBuilder;
    if (spacing == null) return null;
    return (ctx, _) => mainAxis == Axis.vertical
        ? SizedBox(height: spacing)
        : SizedBox(width: spacing);
  }

  @override
  Widget build(BuildContext context) {
    final group = <Widget>[];

    if (sliverHeader != null) group.add(sliverHeader!);
    if (header != null) group.add(SliverToBoxAdapter(child: header));

    if (_items.isEmpty && emptyBuilder != null) {
      final emptyChild = emptyBuilder!(context);
      if (fillRemainingWhenEmpty) {
        group.add(SliverFillRemaining(hasScrollBody: false, child: emptyChild));
      } else {
        group.add(SliverToBoxAdapter(child: emptyChild));
      }
    } else {
      group.add(_buildItemsSliver());
      if (onEndReached != null) {
        group.add(
          _SliverOnEndReached(
            onEndReached: onEndReached!,
            isLoadingMore: isLoadingMore,
          ),
        );
      }
      if (paginationSliver != null) group.add(paginationSliver!);
      if (paginationWidget != null) {
        group.add(SliverToBoxAdapter(child: paginationWidget));
      }
    }

    if (sliverFooter != null) group.add(sliverFooter!);
    if (footer != null) group.add(SliverToBoxAdapter(child: footer));

    Widget composed = SliverMainAxisGroup(slivers: group);
    if (useSliverSafeArea) composed = SliverSafeArea(sliver: composed);
    if (padding != null) {
      composed = SliverPadding(padding: padding!, sliver: composed);
    }
    return composed;
  }

  /// Build the core item sliver with optional separators or extent variants.
  Widget _buildItemsSliver() {
    Widget itemBuilder(BuildContext ctx, int index) {
      final child = _itemBuilder(ctx, index, _items[index]);
      if (itemKeyBuilder == null) return child;
      return KeyedSubtree(key: itemKeyBuilder!(_items[index]), child: child);
    }

    // Item index getter based on keys.
    ChildIndexGetter? effectiveIndexGetter;
    if (itemKeyBuilder != null) {
      effectiveIndexGetter = (Key key) {
        for (var i = 0; i < _items.length; i++) {
          if (itemKeyBuilder!(_items[i]) == key) {
            return i;
          }
        }
        return null;
      };
    } else if (findItemIndexCallback != null) {
      effectiveIndexGetter = findItemIndexCallback;
    }

    // Separated list
    if (_hasSeparators) {
      final sep = _effectiveSeparatorBuilder!;
      return SliverList.separated(
        itemBuilder: itemBuilder,
        separatorBuilder: sep,
        itemCount: _items.length,
        findItemIndexCallback: effectiveIndexGetter,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
      );
    }

    // Fixed extent
    if (itemExtent != null) {
      return SliverFixedExtentList.builder(
        itemExtent: itemExtent!,
        itemBuilder: itemBuilder,
        findChildIndexCallback: effectiveIndexGetter,
        itemCount: _items.length,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
      );
    }

    // Varied extent
    if (itemExtentBuilder != null) {
      return SliverVariedExtentList.builder(
        itemBuilder: itemBuilder,
        itemExtentBuilder: itemExtentBuilder!,
        findChildIndexCallback: effectiveIndexGetter,
        itemCount: _items.length,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
      );
    }

    // Prototype extent
    if (prototypeItem != null) {
      return SliverPrototypeExtentList(
        prototypeItem: prototypeItem!,
        delegate: SliverChildBuilderDelegate(
          itemBuilder,
          childCount: _items.length,
          findChildIndexCallback: effectiveIndexGetter,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
      );
    }

    // Default
    return SliverList.builder(
      itemBuilder: itemBuilder,
      itemCount: _items.length,
      findChildIndexCallback: effectiveIndexGetter,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
    );
  }
}

/// A zero-dependency end-reached sentinel for slivers.
class _SliverOnEndReached extends StatefulWidget {
  const _SliverOnEndReached({
    required this.onEndReached,
    required this.isLoadingMore,
  });

  final FutureOr<void> Function() onEndReached;
  final bool isLoadingMore;

  @override
  State<_SliverOnEndReached> createState() => _SliverOnEndReachedState();
}

class _SliverOnEndReachedState extends State<_SliverOnEndReached> {
  bool _armed = true;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (ctx, constraints) {
        final visibleOrCached =
            constraints.remainingPaintExtent > 0 ||
            constraints.remainingCacheExtent > 0;

        if (visibleOrCached && _armed && !widget.isLoadingMore) {
          _armed = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) widget.onEndReached();
          });
        } else if (!visibleOrCached) {
          _armed = true;
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
