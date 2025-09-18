import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ItemExtentBuilder;

import 'typed_list_view.dart' show ItemKeyBuilder, TypedListViewBuilder;

/// Sugar: build a typed sliver list directly from an Iterable.
extension IterableTypedSliverListExtension<E> on Iterable<E> {
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
    ChildIndexGetter? findChildIndexCallback,

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
      findChildIndexCallback: findChildIndexCallback,
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
    this.findChildIndexCallback,

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
  })  : _items = items,
        _itemBuilder = itemBuilder,
        assert(!(separatorBuilder != null && spacing != null),
            'Provide either separatorBuilder or spacing, not both.'),
        assert(!(paginationWidget != null && paginationSliver != null),
            'Provide either paginationWidget or paginationSliver, not both.'),
        assert(!(header != null && sliverHeader != null),
            'Provide either header or sliverHeader, not both.'),
        assert(!(footer != null && sliverFooter != null),
            'Provide either footer or sliverFooter, not both.'),
        assert(
          (separatorBuilder == null && spacing == null) ||
              (itemExtent == null && prototypeItem == null && itemExtentBuilder == null),
          'Separators/spacing cannot be combined with itemExtent/prototypeItem/itemExtentBuilder.',
        );

  // Content
  final List<E> _items;
  final TypedListViewBuilder<E> _itemBuilder;
  final Widget? header;
  final Widget? footer;
  final Widget? sliverHeader;
  final Widget? sliverFooter;

  // Decorations
  final IndexedWidgetBuilder? separatorBuilder;
  final double? spacing;
  final Widget? paginationWidget;
  final Widget? paginationSliver;
  final WidgetBuilder? emptyBuilder;
  final bool fillRemainingWhenEmpty;

  // Behavior / perf
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final ItemKeyBuilder<E>? itemKeyBuilder;
  final ChildIndexGetter? findChildIndexCallback;

  // Extent options
  final double? itemExtent;
  final Widget? prototypeItem;
  final ItemExtentBuilder? itemExtentBuilder;

  // Layout niceties
  final Axis mainAxis;
  final EdgeInsetsGeometry? padding;
  final bool useSliverSafeArea;

  // Infinite scroll
  final FutureOr<void> Function()? onEndReached;
  final bool isLoadingMore;

  bool get _hasSeparators => (separatorBuilder != null || spacing != null) && _items.length > 1;

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
        group.add(_SliverOnEndReached(
          onEndReached: onEndReached!,
          isLoadingMore: isLoadingMore,
        ));
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
    if (padding != null) composed = SliverPadding(padding: padding!, sliver: composed);
    return composed;
  }

  /// Build the core item sliver with optional separators or extent variants.
  Widget _buildItemsSliver() {
    Widget itemBuilder(BuildContext ctx, int index) {
      final child = _itemBuilder(ctx, index, _items[index]);
      if (itemKeyBuilder == null) return child;
      return KeyedSubtree(key: itemKeyBuilder!(_items[index]), child: child);
    }

    // Child index getter based on keys -> flattened index when needed.
    ChildIndexGetter? effectiveIndexGetter;
    if (itemKeyBuilder != null) {
      effectiveIndexGetter = (Key key) {
        for (var i = 0; i < _items.length; i++) {
          if (itemKeyBuilder!(_items[i]) == key) {
            return _hasSeparators ? i * 2 : i;
          }
        }
        return null;
      };
    } else if (findChildIndexCallback != null) {
      effectiveIndexGetter = (Key key) {
        final itemIndex = findChildIndexCallback!(key);
        if (itemIndex == null) return null;
        return _hasSeparators ? itemIndex * 2 : itemIndex;
      };
    }

    // Separated list
    if (_hasSeparators) {
      final sep = _effectiveSeparatorBuilder!;
      return SliverList.separated(
        itemBuilder: itemBuilder,
        separatorBuilder: sep,
        itemCount: _items.length,
        findChildIndexCallback: effectiveIndexGetter,
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
            constraints.remainingPaintExtent > 0 || constraints.remainingCacheExtent > 0;

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
