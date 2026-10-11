import 'dart:async';

import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

class _PaginationHarness extends StatefulWidget {
  const _PaginationHarness();

  @override
  State<_PaginationHarness> createState() => _PaginationHarnessState();
}

class _PaginationHarnessState extends State<_PaginationHarness> {
  final outer = ScrollController();
  final inner = ScrollController();
  Completer<void>? pending;
  int requests = 0;
  int rebuilds = 0;

  Future<void> _loadPage() {
    pending = Completer<void>();
    setState(() => requests++);
    return pending!.future;
  }

  void _finishPage() {
    pending!.complete();
    setState(() => pending = null);
  }

  @override
  void dispose() {
    outer.dispose();
    inner.dispose();
    pending?.complete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Pagination harness')),
      body: Column(
        children: [
          Text('Page requests: $requests'),
          Text('Parent rebuilds: $rebuilds'),
          Wrap(
            children: [
              TextButton(
                onPressed: () => setState(() => rebuilds++),
                child: const Text('Rebuild parent'),
              ),
              TextButton(
                onPressed: pending == null ? null : _finishPage,
                child: const Text('Finish page'),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: TypedListView<int>(
                  key: const ValueKey('paged-outer-list'),
                  controller: outer,
                  items: List.generate(20, (index) => index),
                  itemExtent: 60,
                  onEndReached: _loadPage,
                  itemBuilder: (context, index, item) => index == 0
                      ? ListView(
                          key: const ValueKey('paged-inner-list'),
                          controller: inner,
                          scrollDirection: Axis.horizontal,
                          children: const [
                            SizedBox(
                              width: 1200,
                              child: Center(
                                child: Text('Nested horizontal row'),
                              ),
                            ),
                          ],
                        )
                      : Center(child: Text('Item $item')),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Verifies nested-scroll isolation and a pending page across parent rebuilds.
Future<void> runPaginationJourney(WidgetTester tester) async {
  await tester.pumpWidget(const _PaginationHarness());
  await tester.pumpAndSettle();
  final harness = tester.state<_PaginationHarnessState>(
    find.byType(_PaginationHarness),
  );
  final inner = find.byKey(const ValueKey('paged-inner-list'));
  final outer = find.byKey(const ValueKey('paged-outer-list'));
  await tester.drag(inner, const Offset(-1000, 0));
  await tester.pumpAndSettle();
  expect(harness.inner.offset, greaterThan(0));
  expect(harness.outer.position.extentAfter, greaterThan(200));
  expect(find.text('Page requests: 0'), findsOneWidget);

  await tester.drag(outer, const Offset(0, -1000));
  await tester.pumpAndSettle();
  expect(find.text('Page requests: 1'), findsOneWidget);
  await tester.tap(find.text('Rebuild parent'));
  await tester.pumpAndSettle();
  expect(find.text('Parent rebuilds: 1'), findsOneWidget);
  await tester.drag(outer, const Offset(0, 20));
  await tester.pumpAndSettle();
  expect(find.text('Page requests: 1'), findsOneWidget);

  await tester.tap(find.text('Finish page'));
  await tester.pumpAndSettle();
  await tester.drag(outer, const Offset(0, -80));
  await tester.pumpAndSettle();
  expect(find.text('Page requests: 2'), findsOneWidget);
  // Completing an outstanding load after disposal must remain safe.
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull);
}
