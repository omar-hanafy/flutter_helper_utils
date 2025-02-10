// ignore_for_file: unnecessary_breaks
import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef OnLayoutDirectionChanged = void Function(Axis?);

/// A widget that lays out its children either all in a row or all in a column,
/// depending on whether they fit in the preferred (main) direction. For example,
/// if [preferredDirection] is horizontal and the total width of the children plus
/// spacing is within the parent’s maxWidth, then the children are arranged as a Row.
/// Otherwise they are arranged as a Column. (The reverse applies when preferredDirection
/// is vertical.)
///
/// In addition, you can configure separate layout parameters for the row and for the column,
/// and an optional [onLayoutModeChanged] callback is fired when the effective layout mode
/// changes.
class SingleAxisWrap extends MultiChildRenderObjectWidget {
  const SingleAxisWrap({
    required super.children,
    super.key,
    this.preferredDirection = Axis.horizontal,
    this.onLayoutModeChanged,
    this.clipBehavior = Clip.none,
    // Row configuration:
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.rowMainAxisSize = MainAxisSize.max,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center,
    this.rowTextDirection,
    this.rowVerticalDirection = VerticalDirection.down,
    this.rowTextBaseline,
    this.rowSpacing = 0.0,
    // Column configuration:
    this.columnMainAxisAlignment = MainAxisAlignment.start,
    this.columnMainAxisSize = MainAxisSize.max,
    this.columnCrossAxisAlignment = CrossAxisAlignment.center,
    this.columnTextDirection,
    this.columnVerticalDirection = VerticalDirection.down,
    this.columnTextBaseline,
    this.columnSpacing = 0.0,
  });

  /// The preferred layout direction.
  ///
  /// For example, if set to [Axis.horizontal] the widget first attempts to lay out its
  /// children in a single row.
  final Axis preferredDirection;

  /// Called when the effective layout mode changes (from “preferred” to “alternate” or vice‐versa).
  final OnLayoutDirectionChanged? onLayoutModeChanged;

  /// How to clip children that exceed the bounds.
  final Clip clipBehavior;

  // Row configuration.
  final MainAxisAlignment rowMainAxisAlignment;
  final MainAxisSize rowMainAxisSize;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final TextDirection? rowTextDirection;
  final VerticalDirection rowVerticalDirection;
  final TextBaseline? rowTextBaseline;
  final double rowSpacing;

  // Column configuration.
  final MainAxisAlignment columnMainAxisAlignment;
  final MainAxisSize columnMainAxisSize;
  final CrossAxisAlignment columnCrossAxisAlignment;
  final TextDirection? columnTextDirection;
  final VerticalDirection columnVerticalDirection;
  final TextBaseline? columnTextBaseline;
  final double columnSpacing;

  @override
  RenderSingleAxisWrap createRenderObject(BuildContext context) {
    return RenderSingleAxisWrap(
      preferredDirection: preferredDirection,
      onLayoutModeChanged: onLayoutModeChanged,
      clipBehavior: clipBehavior,
      rowMainAxisAlignment: rowMainAxisAlignment,
      rowMainAxisSize: rowMainAxisSize,
      rowCrossAxisAlignment: rowCrossAxisAlignment,
      rowTextDirection: rowTextDirection ?? Directionality.of(context),
      rowVerticalDirection: rowVerticalDirection,
      rowTextBaseline: rowTextBaseline,
      rowSpacing: rowSpacing,
      columnMainAxisAlignment: columnMainAxisAlignment,
      columnMainAxisSize: columnMainAxisSize,
      columnCrossAxisAlignment: columnCrossAxisAlignment,
      columnTextDirection: columnTextDirection ?? Directionality.of(context),
      columnVerticalDirection: columnVerticalDirection,
      columnTextBaseline: columnTextBaseline,
      columnSpacing: columnSpacing,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSingleAxisWrap renderObject) {
    renderObject
      ..preferredDirection = preferredDirection
      ..onLayoutModeChanged = onLayoutModeChanged
      ..clipBehavior = clipBehavior
      ..rowMainAxisAlignment = rowMainAxisAlignment
      ..rowMainAxisSize = rowMainAxisSize
      ..rowCrossAxisAlignment = rowCrossAxisAlignment
      ..rowTextDirection = rowTextDirection ?? Directionality.of(context)
      ..rowVerticalDirection = rowVerticalDirection
      ..rowTextBaseline = rowTextBaseline
      ..rowSpacing = rowSpacing
      ..columnMainAxisAlignment = columnMainAxisAlignment
      ..columnMainAxisSize = columnMainAxisSize
      ..columnCrossAxisAlignment = columnCrossAxisAlignment
      ..columnTextDirection = columnTextDirection ?? Directionality.of(context)
      ..columnVerticalDirection = columnVerticalDirection
      ..columnTextBaseline = columnTextBaseline
      ..columnSpacing = columnSpacing;
  }
}

/// ParentData for [RenderSingleAxisWrap].
class SingleAxisWrapParentData extends ContainerBoxParentData<RenderBox> {}

/// The RenderObject that performs the “all or nothing” layout. It first attempts to lay
/// out the children in the [preferredDirection] (for example, horizontally) by summing up
/// their sizes plus the spacing. If that total exceeds the corresponding constraint, it
/// re-lays them out in the alternate direction.
class RenderSingleAxisWrap extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, SingleAxisWrapParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, SingleAxisWrapParentData> {
  RenderSingleAxisWrap({
    required Axis preferredDirection,
    required OnLayoutDirectionChanged? onLayoutModeChanged,
    required Clip clipBehavior, // Row configuration:
    required MainAxisAlignment rowMainAxisAlignment,
    required MainAxisSize rowMainAxisSize,
    required CrossAxisAlignment rowCrossAxisAlignment,
    required TextDirection rowTextDirection,
    required VerticalDirection rowVerticalDirection,
    required double rowSpacing, // Column configuration:
    required MainAxisAlignment columnMainAxisAlignment,
    required MainAxisSize columnMainAxisSize,
    required CrossAxisAlignment columnCrossAxisAlignment,
    required TextDirection columnTextDirection,
    required VerticalDirection columnVerticalDirection,
    required double columnSpacing,
    List<RenderBox>? children,
    TextBaseline? rowTextBaseline,
    TextBaseline? columnTextBaseline,
  })  : _preferredDirection = preferredDirection,
        _onLayoutModeChanged = onLayoutModeChanged,
        _clipBehavior = clipBehavior,
        _rowMainAxisAlignment = rowMainAxisAlignment,
        _rowMainAxisSize = rowMainAxisSize,
        _rowCrossAxisAlignment = rowCrossAxisAlignment,
        _rowTextDirection = rowTextDirection,
        _rowVerticalDirection = rowVerticalDirection,
        _rowTextBaseline = rowTextBaseline,
        _rowSpacing = rowSpacing,
        _columnMainAxisAlignment = columnMainAxisAlignment,
        _columnMainAxisSize = columnMainAxisSize,
        _columnCrossAxisAlignment = columnCrossAxisAlignment,
        _columnTextDirection = columnTextDirection,
        _columnVerticalDirection = columnVerticalDirection,
        _columnTextBaseline = columnTextBaseline,
        _columnSpacing = columnSpacing {
    addAll(children);
  }

  // – Preferred layout mode and callback.
  Axis get preferredDirection => _preferredDirection;
  Axis _preferredDirection;

  set preferredDirection(Axis value) {
    if (_preferredDirection == value) return;
    _preferredDirection = value;
    markNeedsLayout();
  }

  OnLayoutDirectionChanged? get onLayoutModeChanged => _onLayoutModeChanged;
  OnLayoutDirectionChanged? _onLayoutModeChanged;

  set onLayoutModeChanged(OnLayoutDirectionChanged? value) {
    if (_onLayoutModeChanged == value) return;
    _onLayoutModeChanged = value;
  }

  Clip get clipBehavior => _clipBehavior;
  Clip _clipBehavior;

  set clipBehavior(Clip value) {
    if (_clipBehavior == value) return;
    _clipBehavior = value;
    markNeedsPaint();
  }

  // – Row configuration.
  MainAxisAlignment get rowMainAxisAlignment => _rowMainAxisAlignment;
  MainAxisAlignment _rowMainAxisAlignment;

  set rowMainAxisAlignment(MainAxisAlignment value) {
    if (_rowMainAxisAlignment == value) return;
    _rowMainAxisAlignment = value;
    markNeedsLayout();
  }

  MainAxisSize get rowMainAxisSize => _rowMainAxisSize;
  MainAxisSize _rowMainAxisSize;

  set rowMainAxisSize(MainAxisSize value) {
    if (_rowMainAxisSize == value) return;
    _rowMainAxisSize = value;
    markNeedsLayout();
  }

  CrossAxisAlignment get rowCrossAxisAlignment => _rowCrossAxisAlignment;
  CrossAxisAlignment _rowCrossAxisAlignment;

  set rowCrossAxisAlignment(CrossAxisAlignment value) {
    if (_rowCrossAxisAlignment == value) return;
    _rowCrossAxisAlignment = value;
    markNeedsLayout();
  }

  TextDirection get rowTextDirection => _rowTextDirection;
  TextDirection _rowTextDirection;

  set rowTextDirection(TextDirection value) {
    if (_rowTextDirection == value) return;
    _rowTextDirection = value;
    markNeedsLayout();
  }

  VerticalDirection get rowVerticalDirection => _rowVerticalDirection;
  VerticalDirection _rowVerticalDirection;

  set rowVerticalDirection(VerticalDirection value) {
    if (_rowVerticalDirection == value) return;
    _rowVerticalDirection = value;
    markNeedsLayout();
  }

  TextBaseline? get rowTextBaseline => _rowTextBaseline;
  TextBaseline? _rowTextBaseline;

  set rowTextBaseline(TextBaseline? value) {
    if (_rowTextBaseline == value) return;
    _rowTextBaseline = value;
    markNeedsLayout();
  }

  double get rowSpacing => _rowSpacing;
  double _rowSpacing;

  set rowSpacing(double value) {
    if (_rowSpacing == value) return;
    _rowSpacing = value;
    markNeedsLayout();
  }

  // – Column configuration.
  MainAxisAlignment get columnMainAxisAlignment => _columnMainAxisAlignment;
  MainAxisAlignment _columnMainAxisAlignment;

  set columnMainAxisAlignment(MainAxisAlignment value) {
    if (_columnMainAxisAlignment == value) return;
    _columnMainAxisAlignment = value;
    markNeedsLayout();
  }

  MainAxisSize get columnMainAxisSize => _columnMainAxisSize;
  MainAxisSize _columnMainAxisSize;

  set columnMainAxisSize(MainAxisSize value) {
    if (_columnMainAxisSize == value) return;
    _columnMainAxisSize = value;
    markNeedsLayout();
  }

  CrossAxisAlignment get columnCrossAxisAlignment => _columnCrossAxisAlignment;
  CrossAxisAlignment _columnCrossAxisAlignment;

  set columnCrossAxisAlignment(CrossAxisAlignment value) {
    if (_columnCrossAxisAlignment == value) return;
    _columnCrossAxisAlignment = value;
    markNeedsLayout();
  }

  TextDirection get columnTextDirection => _columnTextDirection;
  TextDirection _columnTextDirection;

  set columnTextDirection(TextDirection value) {
    if (_columnTextDirection == value) return;
    _columnTextDirection = value;
    markNeedsLayout();
  }

  VerticalDirection get columnVerticalDirection => _columnVerticalDirection;
  VerticalDirection _columnVerticalDirection;

  set columnVerticalDirection(VerticalDirection value) {
    if (_columnVerticalDirection == value) return;
    _columnVerticalDirection = value;
    markNeedsLayout();
  }

  TextBaseline? get columnTextBaseline => _columnTextBaseline;
  TextBaseline? _columnTextBaseline;

  set columnTextBaseline(TextBaseline? value) {
    if (_columnTextBaseline == value) return;
    _columnTextBaseline = value;
    markNeedsLayout();
  }

  double get columnSpacing => _columnSpacing;
  double _columnSpacing;

  set columnSpacing(double value) {
    if (_columnSpacing == value) return;
    _columnSpacing = value;
    markNeedsLayout();
  }

  // – Internal flag: if true the widget can use the preferred mode.
  // Otherwise, it must use the alternate mode.
  bool _usingPreferredMode = true;

  /// The effective layout direction: if using the preferred mode then this is
  /// [preferredDirection], else it is the alternate.
  Axis get _effectiveDirection {
    return _usingPreferredMode
        ? _preferredDirection
        : (_preferredDirection == Axis.horizontal
            ? Axis.vertical
            : Axis.horizontal);
  }

  @visibleForTesting
  Axis get effectiveDirection => _effectiveDirection;

  // We cache the last effective direction so that we can fire the callback when it changes.
  Axis? _lastEffectiveDirection;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! SingleAxisWrapParentData) {
      child.parentData = SingleAxisWrapParentData();
    }
  }

  // A helper to lay out a child with given constraints.
  void _layoutChild(RenderBox child, BoxConstraints childConstraints) {
    child.layout(childConstraints, parentUsesSize: true);
  }

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    // First, try laying out children in the preferred mode.
    final isPreferredHorizontal = _preferredDirection == Axis.horizontal;
    var usingPreferred = true;
    double totalMainSize = 0;
    double maxCrossSize = 0;
    var childIndex = 0;

    void layoutChildrenPreferred() {
      var child = firstChild;
      while (child != null) {
        BoxConstraints childConstraints;
        if (isPreferredHorizontal) {
          // In row mode, let the child be as wide as it wants; constrain its height.
          childConstraints = BoxConstraints(
            maxHeight: constraints.maxHeight,
          );
        } else {
          // In column mode, let the child be as tall as it wants; constrain its width.
          childConstraints = BoxConstraints(
            maxWidth: constraints.maxWidth,
          );
        }
        _layoutChild(child, childConstraints);
        final childSize = child.size;
        final childMainSize =
            isPreferredHorizontal ? childSize.width : childSize.height;
        final childCrossSize =
            isPreferredHorizontal ? childSize.height : childSize.width;
        totalMainSize += childMainSize;
        maxCrossSize = math.max(maxCrossSize, childCrossSize);
        if (childIndex > 0) {
          totalMainSize += (isPreferredHorizontal ? rowSpacing : columnSpacing);
        }
        childIndex++;
        final childParentData = child.parentData as SingleAxisWrapParentData?;
        child = childParentData?.nextSibling;
      }
    }

    layoutChildrenPreferred();

    // Check if the preferred mode fits.
    final maxMainAxisLimit =
        isPreferredHorizontal ? constraints.maxWidth : constraints.maxHeight;
    if (maxMainAxisLimit.isFinite && totalMainSize > maxMainAxisLimit) {
      // Preferred mode does not fit: switch to the alternate.
      usingPreferred = false;
      totalMainSize = 0.0;
      maxCrossSize = 0.0;
      childIndex = 0;
      var child = firstChild;
      while (child != null) {
        BoxConstraints childConstraints;
        if (isPreferredHorizontal) {
          // Alternate for a preferred horizontal is vertical.
          childConstraints = BoxConstraints(
            maxWidth: constraints.maxWidth,
          );
        } else {
          // Alternate for a preferred vertical is horizontal.
          childConstraints = BoxConstraints(
            maxHeight: constraints.maxHeight,
          );
        }
        _layoutChild(child, childConstraints);
        final childSize = child.size;
        // Now the main axis is the alternate axis.
        final childMainSize =
            isPreferredHorizontal ? childSize.height : childSize.width;
        final childCrossSize =
            isPreferredHorizontal ? childSize.width : childSize.height;
        totalMainSize += childMainSize;
        maxCrossSize = math.max(maxCrossSize, childCrossSize);
        if (childIndex > 0) {
          totalMainSize += (isPreferredHorizontal ? columnSpacing : rowSpacing);
        }
        childIndex++;
        final childParentData = child.parentData as SingleAxisWrapParentData?;
        child = childParentData?.nextSibling;
      }
    }

    _usingPreferredMode = usingPreferred;

    // Determine the effective layout direction.
    final effectiveDirection = _effectiveDirection;

    // Fire the callback if:
    //   - This is the very first layout and effectiveDirection != preferredDirection, or
    //   - The effective direction has changed since the last layout.
    if (_lastEffectiveDirection == null) {
      _lastEffectiveDirection = effectiveDirection;
      if (effectiveDirection != _preferredDirection) {
        onLayoutModeChanged?.call(effectiveDirection);
      }
    } else if (_lastEffectiveDirection != effectiveDirection) {
      _lastEffectiveDirection = effectiveDirection;
      onLayoutModeChanged?.call(effectiveDirection);
    }

    // Compute the content size.
    final contentSize = effectiveDirection == Axis.horizontal
        ? Size(totalMainSize, maxCrossSize)
        : Size(maxCrossSize, totalMainSize);
    size = constraints.constrain(contentSize);

    // Position the children.
    _positionChildren(effectiveDirection, totalMainSize, maxCrossSize);
  }

  void _positionChildren(
      Axis effectiveDirection, double totalMainSize, double maxCrossSize) {
    // Pick configuration based on the effective direction.
    MainAxisAlignment mainAxisAlignment;
    CrossAxisAlignment crossAxisAlignment;
    double spacing;
    if (effectiveDirection == Axis.horizontal) {
      // Use row configuration.
      mainAxisAlignment = rowMainAxisAlignment;
      crossAxisAlignment = rowCrossAxisAlignment;
      spacing = rowSpacing;
    } else {
      // Use column configuration.
      mainAxisAlignment = columnMainAxisAlignment;
      crossAxisAlignment = columnCrossAxisAlignment;
      spacing = columnSpacing;
    }

    final containerMainExtent =
        effectiveDirection == Axis.horizontal ? size.width : size.height;
    final childCount = this.childCount;
    final double remainingSpace =
        math.max(0, containerMainExtent - totalMainSize);
    double leadingSpace = 0;
    var betweenSpace = spacing;

    // Distribute extra space based on MainAxisAlignment.
    switch (mainAxisAlignment) {
      case MainAxisAlignment.start:
        leadingSpace = 0.0;
        break;
      case MainAxisAlignment.end:
        leadingSpace = remainingSpace;
        break;
      case MainAxisAlignment.center:
        leadingSpace = remainingSpace / 2.0;
        break;
      case MainAxisAlignment.spaceBetween:
        if (childCount > 1) {
          betweenSpace = spacing + remainingSpace / (childCount - 1);
        }
        break;
      case MainAxisAlignment.spaceAround:
        if (childCount > 0) {
          betweenSpace = spacing + remainingSpace / childCount;
          leadingSpace = betweenSpace / 2.0;
        }
        break;
      case MainAxisAlignment.spaceEvenly:
        if (childCount > 0) {
          betweenSpace = remainingSpace / (childCount + 1);
          leadingSpace = betweenSpace;
        }
        break;
    }

    var mainOffset = leadingSpace;
    var child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as SingleAxisWrapParentData?;
      final childSize = child.size;
      final childMainSize = effectiveDirection == Axis.horizontal
          ? childSize.width
          : childSize.height;
      final childCrossSize = effectiveDirection == Axis.horizontal
          ? childSize.height
          : childSize.width;
      final crossOffset =
          _computeCrossOffset(crossAxisAlignment, maxCrossSize, childCrossSize);
      final childOffset = effectiveDirection == Axis.horizontal
          ? Offset(mainOffset, crossOffset)
          : Offset(crossOffset, mainOffset);
      childParentData?.offset = childOffset;
      mainOffset += childMainSize + betweenSpace;
      child = childParentData?.nextSibling;
    }
  }

  double _computeCrossOffset(CrossAxisAlignment alignment,
      double containerCrossSize, double childCrossSize) {
    switch (alignment) {
      case CrossAxisAlignment.start:
      case CrossAxisAlignment.baseline:
        return 0;
      case CrossAxisAlignment.end:
        return containerCrossSize - childCrossSize;
      case CrossAxisAlignment.center:
        return (containerCrossSize - childCrossSize) / 2.0;
      case CrossAxisAlignment.stretch:
        return 0;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (clipBehavior != Clip.none) {
      context.pushClipRect(
          needsCompositing, offset, offset & size, defaultPaint,
          clipBehavior: clipBehavior);
    } else {
      defaultPaint(context, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<Axis>('preferredDirection', preferredDirection))
      ..add(EnumProperty<Axis>('effectiveDirection', _effectiveDirection))
      ..add(FlagProperty(
        'usingPreferredMode',
        value: _usingPreferredMode,
        ifTrue: 'preferred',
        ifFalse: 'alternate',
      ));
  }
}
