import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _fixedCarousel({
  required CarouselController controller,
  required double itemExtent,
  double width = 400,
  double height = 300,
  int itemCount = 10,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CarouselView(
            controller: controller,
            itemExtent: itemExtent,
            children: List<Widget>.generate(
              itemCount,
              (i) => Center(child: Text('Item $i')),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _weightedCarousel({
  required CarouselController controller,
  required List<int> flexWeights,
  double width = 400,
  double height = 300,
  int itemCount = 10,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CarouselView.weighted(
            controller: controller,
            flexWeights: flexWeights,
            children: List<Widget>.generate(
              itemCount,
              (i) => Center(child: Text('Item $i')),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('FHUCarouselControllerExtension', () {
    test('tryGet* returns null when unattached', () {
      final controller = CarouselController();

      expect(controller.tryGetCurrentIndex(itemExtent: 100), isNull);
      expect(controller.tryGetCurrentFractionalItem(itemExtent: 100), isNull);
      expect(
        controller.tryGetWeightedLeadingItemExtent(
          flexWeights: const [1, 2, 1],
        ),
        isNull,
      );
      expect(
        controller.tryGetCurrentIndexWeighted(flexWeights: const [1, 2, 1]),
        isNull,
      );
      expect(controller.canGoNext, isFalse);
      expect(controller.canGoPrevious, isFalse);
    });

    testWidgets('fixed extent - jumpToItem updates index and fractional item', (
      tester,
    ) async {
      final controller = CarouselController();
      const itemExtent = 200.0;

      await tester.pumpWidget(
        _fixedCarousel(controller: controller, itemExtent: itemExtent),
      );
      await tester.pump();

      controller.jumpToItem(2, itemExtent: itemExtent);
      await tester.pump();

      expect(controller.getCurrentIndex(itemExtent: itemExtent), 2);
      expect(
        controller.getCurrentFractionalItem(itemExtent: itemExtent),
        closeTo(2, 0.0001),
      );
    });

    testWidgets('weighted - helpers match Flutter offset units', (
      tester,
    ) async {
      final controller = CarouselController();
      const weights = <int>[1, 2, 1];
      const width = 400.0;

      await tester.pumpWidget(
        _weightedCarousel(
          controller: controller,
          flexWeights: weights,
          width: width,
        ),
      );
      await tester.pump();

      final extent = controller.getWeightedLeadingItemExtent(
        flexWeights: weights,
      );
      expect(extent, closeTo(width * (1 / 4), 0.0001));

      controller.jumpToItemWeighted(3, flexWeights: weights);
      await tester.pump();

      expect(controller.getCurrentIndexWeighted(flexWeights: weights), 3);
      expect(
        controller.getCurrentFractionalItemWeighted(flexWeights: weights),
        closeTo(3, 0.0001),
      );
    });

    testWidgets('roundingMode is respected', (tester) async {
      final controller = CarouselController();
      const itemExtent = 200.0;

      await tester.pumpWidget(
        _fixedCarousel(controller: controller, itemExtent: itemExtent),
      );
      await tester.pump();

      controller.jumpTo(itemExtent * 1.6);
      await tester.pump();

      expect(
        controller.getCurrentIndex(
          itemExtent: itemExtent,
          roundingMode: RoundingMode.floor,
        ),
        1,
      );
      expect(
        controller.getCurrentIndex(
          itemExtent: itemExtent,
          roundingMode: RoundingMode.round,
        ),
        2,
      );
      expect(
        controller.getCurrentIndex(
          itemExtent: itemExtent,
          roundingMode: RoundingMode.ceil,
        ),
        2,
      );
    });
  });
}
