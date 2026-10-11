import 'dart:async';

import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Widget buildList({
    required ScrollController controller,
    required Future<void> Function() onEndReached,
    bool isLoadingMore = false,
    bool showScrollbar = false,
    Future<void> Function()? onRefresh,
    Widget? firstItem,
  }) => Directionality(
    textDirection: TextDirection.ltr,
    child: Center(
      child: SizedBox(
        height: 300,
        width: 300,
        child: TypedListView<int>(
          items: List.generate(20, (index) => index),
          controller: controller,
          onEndReached: onEndReached,
          isLoadingMore: isLoadingMore,
          showScrollbar: showScrollbar,
          onRefresh: onRefresh,
          itemBuilder: (context, index, item) => SizedBox(
            height: 60,
            child: index == 0 && firstItem != null ? firstItem : Text('$item'),
          ),
        ),
      ),
    ),
  );

  testWidgets('nested scrolling cannot request another outer page', (
    tester,
  ) async {
    final outer = ScrollController();
    final inner = ScrollController();
    addTearDown(outer.dispose);
    addTearDown(inner.dispose);
    var requests = 0;
    await tester.pumpWidget(
      buildList(
        controller: outer,
        onEndReached: () async {
          requests++;
        },
        firstItem: ListView(
          controller: inner,
          scrollDirection: Axis.horizontal,
          children: const [SizedBox(width: 1200)],
        ),
      ),
    );
    inner.jumpTo(inner.position.maxScrollExtent);
    await tester.pump();
    expect(outer.position.extentAfter, greaterThan(200));
    expect(requests, 0);
  });

  testWidgets(
    'one pending request survives scroll events and parent rebuilds',
    (tester) async {
      final controller = ScrollController();
      addTearDown(controller.dispose);
      var pending = Completer<void>();
      var requests = 0;
      Future<void> load() {
        requests++;
        return pending.future;
      }

      await tester.pumpWidget(
        buildList(controller: controller, onEndReached: load),
      );
      controller.jumpTo(controller.position.maxScrollExtent);
      await tester.pump();
      expect(requests, 1);

      await tester.pumpWidget(
        buildList(controller: controller, onEndReached: load),
      );
      controller.jumpTo(controller.position.maxScrollExtent - 10);
      await tester.pump();
      expect(requests, 1);

      pending.complete();
      await tester.pump();
      pending = Completer<void>();
      controller.jumpTo(controller.position.maxScrollExtent);
      await tester.pump();
      expect(requests, 2);
      pending.complete();
      await tester.pump();
    },
  );

  testWidgets('external loading blocks requests until it clears', (
    tester,
  ) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    var requests = 0;
    final pending = Completer<void>();
    Future<void> load() {
      requests++;
      return pending.future;
    }

    await tester.pumpWidget(
      buildList(
        controller: controller,
        onEndReached: load,
        isLoadingMore: true,
      ),
    );
    controller.jumpTo(controller.position.maxScrollExtent);
    await tester.pump();
    expect(requests, 0);

    await tester.pumpWidget(
      buildList(controller: controller, onEndReached: load),
    );
    controller.jumpTo(controller.position.maxScrollExtent - 10);
    await tester.pump();
    expect(requests, 1);
    await tester.pumpWidget(const SizedBox.shrink());
    pending.complete();
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('optional Material wrappers retain the pending request', (
    tester,
  ) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    final pending = Completer<void>();
    var requests = 0;
    Future<void> load() {
      requests++;
      return pending.future;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: buildList(controller: controller, onEndReached: load),
      ),
    );
    controller.jumpTo(controller.position.maxScrollExtent);
    await tester.pump();
    expect(requests, 1);

    await tester.pumpWidget(
      MaterialApp(
        home: buildList(
          controller: controller,
          onEndReached: load,
          showScrollbar: true,
          onRefresh: () async {},
        ),
      ),
    );
    controller.jumpTo(controller.position.maxScrollExtent - 10);
    await tester.pump();
    expect(requests, 1);
    pending.complete();
    await tester.pumpAndSettle();
  });
}
