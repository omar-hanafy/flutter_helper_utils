// ignore_for_file: avoid_redundant_argument_values
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SingleAxisWrap -', () {
    // Helper function to create test widgets
    Widget buildTestWidget({
      required List<Widget> children,
      required double width,
      double? height,
      Axis preferredDirection = Axis.horizontal,
      OnLayoutDirectionChanged? onLayoutModeChanged,
      double rowSpacing = 0,
      double columnSpacing = 0,
      MainAxisAlignment rowMainAxisAlignment = MainAxisAlignment.start,
      MainAxisAlignment columnMainAxisAlignment = MainAxisAlignment.start,
      CrossAxisAlignment rowCrossAxisAlignment = CrossAxisAlignment.center,
      CrossAxisAlignment columnCrossAxisAlignment = CrossAxisAlignment.center,
    }) {
      return MaterialApp(
        home: Center(
          child: SizedBox(
            width: width,
            height: height ?? 500,
            child: SingleAxisWrap(
              preferredDirection: preferredDirection,
              onLayoutModeChanged: onLayoutModeChanged,
              rowSpacing: rowSpacing,
              columnSpacing: columnSpacing,
              rowMainAxisAlignment: rowMainAxisAlignment,
              columnMainAxisAlignment: columnMainAxisAlignment,
              rowCrossAxisAlignment: rowCrossAxisAlignment,
              columnCrossAxisAlignment: columnCrossAxisAlignment,
              children: children,
            ),
          ),
        ),
      );
    }

    testWidgets('Horizontal Layout - Children fit within constraints',
        (WidgetTester tester) async {
      var layoutChanged = false;

      await tester.pumpWidget(
        buildTestWidget(
          width: 500,
          onLayoutModeChanged: (axis) => layoutChanged = true,
          rowSpacing: 10,
          children: [
            Container(width: 50, height: 50, color: Colors.red),
            Container(width: 50, height: 50, color: Colors.green),
            Container(width: 50, height: 50, color: Colors.blue),
          ],
        ),
      );

      final renderObject = tester
          .renderObject<RenderSingleAxisWrap>(find.byType(SingleAxisWrap));

      expect(renderObject.effectiveDirection, equals(Axis.horizontal));
      expect(layoutChanged, isFalse);

      // Verify horizontal positioning
      final redTopLeft = tester.getTopLeft(
        find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.red,
        ),
      );
      final greenTopLeft = tester.getTopLeft(
        find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.green,
        ),
      );
      final blueTopLeft = tester.getTopLeft(
        find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.blue,
        ),
      );

      expect(greenTopLeft.dx, equals(redTopLeft.dx + 60)); // 50 + 10 spacing
      expect(blueTopLeft.dx, equals(greenTopLeft.dx + 60));
      expect(greenTopLeft.dy, equals(redTopLeft.dy)); // Same vertical alignment
    });

    testWidgets('Vertical Layout - Children exceed horizontal constraints',
        (WidgetTester tester) async {
      var layoutChanged = false;
      Axis? layoutDirection;

      await tester.pumpWidget(
        buildTestWidget(
          width: 100,
          onLayoutModeChanged: (axis) {
            layoutChanged = true;
            layoutDirection = axis;
          },
          rowSpacing: 10,
          columnSpacing: 8,
          children: [
            Container(width: 70, height: 50, color: Colors.red),
            Container(width: 70, height: 50, color: Colors.green),
            Container(width: 70, height: 50, color: Colors.blue),
          ],
        ),
      );

      final renderObject = tester
          .renderObject<RenderSingleAxisWrap>(find.byType(SingleAxisWrap));

      expect(renderObject.effectiveDirection, equals(Axis.vertical));
      expect(layoutChanged, isTrue);
      expect(layoutDirection, equals(Axis.vertical));

      // Verify vertical positioning with column spacing
      final redTopLeft = tester.getTopLeft(find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.red));
      final greenTopLeft = tester.getTopLeft(find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.green));
      final blueTopLeft = tester.getTopLeft(find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.blue));

      expect(greenTopLeft.dy, equals(redTopLeft.dy + 58)); // 50 + 8 spacing
      expect(blueTopLeft.dy, equals(greenTopLeft.dy + 58));
      expect(
          greenTopLeft.dx, equals(redTopLeft.dx)); // Same horizontal alignment
    });

    testWidgets('Alignment - SpaceBetween in horizontal mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          width: 300,
          height: 100,
          rowSpacing: 20,
          rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: 50, height: 50, color: Colors.red),
            Container(width: 50, height: 50, color: Colors.green),
            Container(width: 50, height: 50, color: Colors.blue),
          ],
        ),
      );

      final renderObject = tester
          .renderObject<RenderSingleAxisWrap>(find.byType(SingleAxisWrap));
      final childRects = <Rect>[];

      var child = renderObject.firstChild;
      while (child != null) {
        final childData = child.parentData as SingleAxisWrapParentData?;
        expect(childData, isNotNull);
        childRects.add(childData!.offset & child.size);
        child = childData.nextSibling;
      }

      final minLeft = childRects.map((r) => r.left).reduce(math.min);
      final maxRight = childRects.map((r) => r.right).reduce(math.max);

      expect(minLeft, closeTo(0.0, 2.0));
      expect(maxRight, closeTo(300.0, 2.0));
    });

    testWidgets('CrossAxisAlignment - Stretch in vertical mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          width: 100,
          // Keep narrow width to force vertical mode
          height: 300,
          preferredDirection: Axis.horizontal,
          // This will switch to vertical due to width
          columnCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                width: 200,
                height: 50,
                color: Colors.red), // Width > 100 forces vertical mode
            Container(
                width: 200,
                height: 50,
                color: Colors.green), // Width > 100 forces vertical mode
            Container(
                width: 200,
                height: 50,
                color: Colors.blue), // Width > 100 forces vertical mode
          ],
        ),
      );

      // First verify we're in vertical mode
      final renderObject = tester
          .renderObject<RenderSingleAxisWrap>(find.byType(SingleAxisWrap));
      expect(renderObject.effectiveDirection, equals(Axis.vertical));

      // Now check stretching
      final redRect = tester.getRect(find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.red));
      final greenRect = tester.getRect(find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.green));
      final blueRect = tester.getRect(find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == Colors.blue));

      expect(redRect.width, equals(100.0));
      expect(greenRect.width, equals(100.0));
      expect(blueRect.width, equals(100.0));
    });

    testWidgets('Empty children list handling', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          width: 300,
          height: 100,
          children: [],
        ),
      );

      final renderObject = tester
          .renderObject<RenderSingleAxisWrap>(find.byType(SingleAxisWrap));
      expect(renderObject.size.width, equals(300.0));
      expect(renderObject.size.height, equals(100.0));
    });

    testWidgets('Clip behavior test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: SingleAxisWrap(
                clipBehavior: Clip.hardEdge,
                children: [
                  Container(width: 120, height: 120, color: Colors.red),
                ],
              ),
            ),
          ),
        ),
      );

      final renderObject = tester
          .renderObject<RenderSingleAxisWrap>(find.byType(SingleAxisWrap));
      expect(renderObject.clipBehavior, equals(Clip.hardEdge));
    });
  });
}
