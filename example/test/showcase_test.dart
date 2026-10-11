import 'package:example/main.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'support/multi_tap_flows.dart';
import 'support/pagination_flows.dart';
import 'support/showcase_flows.dart';

void main() {
  testWidgets('cold narrow showcase reaches the actual bottom in one action', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(320, 568)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const PlatformTypeProvider(child: ShowcaseApp()));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Bottom'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bottom'));
    await tester.pumpAndSettle();
    final controller = tester
        .widget<CustomScrollView>(find.byKey(const ValueKey('showcase-scroll')))
        .controller!;
    expect(controller.offset, closeTo(controller.position.maxScrollExtent, 1));
    expect(
      find.textContaining('For migration specifics').hitTestable(),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('showcase utility journey uses official Material types', (
    tester,
  ) async {
    await tester.pumpWidget(const PlatformTypeProvider(child: ShowcaseApp()));
    await tester.pumpAndSettle();
    await runShowcaseJourney(tester);
  });

  for (final (size, breakpoint) in [
    (const Size(320, 568), 'mobile'),
    (const Size(1024, 768), 'tablet'),
    (const Size(1440, 900), 'desktop'),
  ]) {
    testWidgets('all sections remain usable at $size with large text', (
      tester,
    ) async {
      tester.view
        ..physicalSize = size
        ..devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      tester.platformDispatcher.textScaleFactorTestValue = 1.5;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(const PlatformTypeProvider(child: ShowcaseApp()));
      await tester.pumpAndSettle();
      expect(
        tester.element(find.byType(ShowcaseHomePage)).readBreakpoint.name,
        breakpoint,
      );
      await runShowcaseJourney(tester);
    });
  }

  testWidgets('custom multi-tap timing, scroll cancellation, and disposal', (
    tester,
  ) async {
    await runCustomMultiTapJourney(tester);
  });

  testWidgets('pagination isolates nested scrolling and pending loads', (
    tester,
  ) async {
    await runPaginationJourney(tester);
  });
}
