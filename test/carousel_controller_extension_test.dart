import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FHUCarouselControllerExtension.jumpToItem', () {
    testWidgets('infers fixed itemExtent and jumps', (tester) async {
      final controller = CarouselController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              height: 200,
              child: CarouselView(
                controller: controller,
                itemExtent: 100,
                children: List<Widget>.generate(
                  10,
                  (_) => const ColoredBox(color: Colors.red),
                ),
              ),
            ),
          ),
        ),
      );

      expect(controller.hasClients, isTrue);

      controller.jumpToItem(2);
      await tester.pump();
      expect(controller.offset, moreOrLessEquals(200));

      controller.jumpToItem(999);
      await tester.pumpAndSettle();
      expect(controller.offset, controller.position.maxScrollExtent);
    });

    testWidgets(
      'infers weighted flexWeights and jumps (consumeMaxWeight true)',
      (tester) async {
        final controller = CarouselController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 300,
                height: 200,
                child: CarouselView.weighted(
                  controller: controller,
                  flexWeights: const <int>[1, 2, 1],
                  children: List<Widget>.generate(
                    10,
                    (_) => const ColoredBox(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ),
        );

        expect(controller.hasClients, isTrue);

        controller.jumpToItem(2);
        await tester.pump();
        expect(controller.offset, moreOrLessEquals(150));
      },
    );

    testWidgets(
      'infers weighted flexWeights and jumps (consumeMaxWeight false)',
      (tester) async {
        final controller = CarouselController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 300,
                height: 200,
                child: CarouselView.weighted(
                  controller: controller,
                  consumeMaxWeight: false,
                  flexWeights: const <int>[1, 2, 1],
                  children: List<Widget>.generate(
                    10,
                    (_) => const ColoredBox(color: Colors.green),
                  ),
                ),
              ),
            ),
          ),
        );

        expect(controller.hasClients, isTrue);

        // maxWeightIndex is 1 for [1, 2, 1], so leadingIndex is index - 1.
        controller.jumpToItem(3);
        await tester.pump();
        expect(controller.offset, moreOrLessEquals(150));

        controller.jumpToItem(0);
        await tester.pump();
        expect(controller.offset, moreOrLessEquals(0));
      },
    );
  });
}
