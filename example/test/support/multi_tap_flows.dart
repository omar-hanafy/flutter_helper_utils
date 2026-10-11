import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

class _TapHarness extends StatefulWidget {
  const _TapHarness({required this.duration, super.key});

  final Duration duration;

  @override
  State<_TapHarness> createState() => _TapHarnessState();
}

class _TapHarnessState extends State<_TapHarness> {
  int completed = 0;

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      body: ListView(
        children: [
          MultiTapDetector(
            duration: widget.duration,
            onTap: () => setState(() => completed++),
            child: Container(
              key: const ValueKey('custom-multi-tap-target'),
              height: 180,
              color: Colors.orange,
              alignment: Alignment.center,
              child: Text('Completed sequences: $completed'),
            ),
          ),
          const SizedBox(height: 1200),
        ],
      ),
    ),
  );
}

/// Verifies timing, gesture arbitration, and disposal in a real render tree.
Future<void> runCustomMultiTapJourney(WidgetTester tester) async {
  final target = find.byKey(const ValueKey('custom-multi-tap-target'));
  await tester.pumpWidget(
    const _TapHarness(duration: Duration(milliseconds: 500)),
  );
  await tester.pumpAndSettle();
  // Consecutive sequences reset immediately after each completion. Each gap
  // exceeds the serial recognizer's 40ms minimum inter-tap interval.
  for (var i = 0; i < 6; i++) {
    await tester.tap(target);
    await tester.pump(const Duration(milliseconds: 50));
  }
  await tester.pump();
  expect(find.text('Completed sequences: 2'), findsOneWidget);

  // The configured rolling gap is 500ms, even though the sequence lasts 800ms.
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 400));
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 400));
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.pump();
  expect(find.text('Completed sequences: 3'), findsOneWidget);

  await tester.pumpWidget(
    const _TapHarness(
      key: ValueKey('short-duration-harness'),
      duration: Duration(milliseconds: 100),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 150));
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.pump();
  expect(find.text('Completed sequences: 0'), findsOneWidget);
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.pump();
  expect(find.text('Completed sequences: 1'), findsOneWidget);

  await tester.pumpWidget(
    const _TapHarness(
      key: ValueKey('scroll-arena-harness'),
      duration: Duration(milliseconds: 500),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 50));
  // A scroll drag cancels the serial tap sequence while the pointer is held.
  await tester.drag(target, const Offset(0, -80));
  await tester.pumpAndSettle();
  await tester.ensureVisible(target);
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.pump();
  expect(find.text('Completed sequences: 0'), findsOneWidget);
  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.pump();
  expect(find.text('Completed sequences: 1'), findsOneWidget);

  await tester.tap(target);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 600));
  expect(tester.takeException(), isNull);
}
