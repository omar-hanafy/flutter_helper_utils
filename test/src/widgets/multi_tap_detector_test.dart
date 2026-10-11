import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';

const _target = Key('tap target');

Widget _detector({
  required VoidCallback onTap,
  required List<int> progress,
  Duration duration = const Duration(milliseconds: 500),
  int tapCount = 3,
}) => Directionality(
  textDirection: TextDirection.ltr,
  child: Center(
    child: MultiTapDetector(
      tapCount: tapCount,
      duration: duration,
      onTap: onTap,
      onTapProgress: progress.add,
      child: const SizedBox(
        key: _target,
        width: 100,
        height: 100,
        child: ColoredBox(color: Color(0xFFFFFFFF)),
      ),
    ),
  ),
);

void main() {
  testWidgets('starts a fresh sequence immediately after completion', (
    tester,
  ) async {
    var completions = 0;
    final progress = <int>[];
    await tester.pumpWidget(
      _detector(onTap: () => completions++, progress: progress),
    );

    for (var i = 0; i < 6; i++) {
      await tester.tap(find.byKey(_target));
      await tester.pump(const Duration(milliseconds: 50));
    }

    expect(completions, 2);
    expect(progress, [1, 2, 3, 0, 1, 2, 3, 0]);
  });

  testWidgets(
    'custom duration allows gaps longer than SDK serial tap timeout',
    (tester) async {
      var completions = 0;
      final progress = <int>[];
      await tester.pumpWidget(
        _detector(onTap: () => completions++, progress: progress),
      );

      await tester.tap(find.byKey(_target));
      await tester.pump(const Duration(milliseconds: 400));
      await tester.tap(find.byKey(_target));
      await tester.pump(const Duration(milliseconds: 400));
      await tester.tap(find.byKey(_target));

      expect(completions, 1);
      expect(progress, [1, 2, 3, 0]);
    },
  );

  testWidgets(
    'custom timeout resets count even within SDK serial tap timeout',
    (tester) async {
      var completions = 0;
      final progress = <int>[];
      await tester.pumpWidget(
        _detector(
          onTap: () => completions++,
          progress: progress,
          duration: const Duration(milliseconds: 100),
        ),
      );

      await tester.tap(find.byKey(_target));
      await tester.pump(const Duration(milliseconds: 150));
      await tester.tap(find.byKey(_target));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(find.byKey(_target));

      expect(completions, 0);
      expect(progress, [1, 0, 1, 2]);
      await tester.pump(const Duration(milliseconds: 100));
      expect(progress.last, 0);
    },
  );

  testWidgets('gesture cancellation resets the whole sequence', (tester) async {
    var completions = 0;
    final progress = <int>[];
    await tester.pumpWidget(
      _detector(onTap: () => completions++, progress: progress),
    );

    await tester.tap(find.byKey(_target));
    await tester.pump(const Duration(milliseconds: 50));
    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(_target)),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await gesture.moveBy(const Offset(100, 0));
    await gesture.up();
    await tester.tap(find.byKey(_target));

    expect(completions, 0);
    expect(progress, [1, 2, 0, 1]);
    await tester.pump(const Duration(milliseconds: 500));
    expect(progress.last, 0);
  });

  testWidgets('disposal cancels pending progress callbacks', (tester) async {
    final progress = <int>[];
    await tester.pumpWidget(_detector(onTap: () {}, progress: progress));
    await tester.tap(find.byKey(_target));
    expect(progress, [1]);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));

    expect(progress, [1]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('changed sequence settings start a fresh count', (tester) async {
    var completions = 0;
    final progress = <int>[];
    await tester.pumpWidget(
      _detector(onTap: () => completions++, progress: progress),
    );
    await tester.tap(find.byKey(_target));

    await tester.pumpWidget(
      _detector(onTap: () => completions++, progress: progress, tapCount: 2),
    );
    await tester.tap(find.byKey(_target));
    expect(completions, 0);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.byKey(_target));

    expect(completions, 1);
    expect(progress, [1, 1, 2, 0]);
  });

  testWidgets('a competing scroll gesture cancels the tap sequence', (
    tester,
  ) async {
    var completions = 0;
    final progress = <int>[];
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(),
          child: ListView(
            controller: controller,
            children: [
              MultiTapDetector(
                onTap: () => completions++,
                onTapProgress: progress.add,
                child: const SizedBox(
                  key: _target,
                  height: 200,
                  child: ColoredBox(color: Color(0xFFFFFFFF)),
                ),
              ),
              const SizedBox(height: 1500),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(_target));
    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(_target)),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await gesture.moveBy(const Offset(0, -60));
    await gesture.moveBy(const Offset(0, -60));
    await gesture.up();
    expect(progress.last, 0);
    await tester.pumpAndSettle();

    expect(controller.offset, greaterThan(0));
    expect(completions, 0);
    expect(progress.last, 0);
  });

  testWidgets('an immediate drag cancels prior progress before tap deadline', (
    tester,
  ) async {
    var completions = 0;
    final progress = <int>[];
    await tester.pumpWidget(
      _detector(onTap: () => completions++, progress: progress),
    );
    await tester.tap(find.byKey(_target));
    await tester.pump(const Duration(milliseconds: 50));
    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(_target)),
    );
    await gesture.moveBy(const Offset(100, 0));
    await gesture.up();

    expect(progress, [1, 2, 0]);
    await tester.tap(find.byKey(_target));
    expect(progress.last, 1);
    expect(completions, 0);
    await tester.pump(const Duration(milliseconds: 500));
  });

  testWidgets('the final tap can stay down longer than the gap duration', (
    tester,
  ) async {
    var completions = 0;
    final progress = <int>[];
    await tester.pumpWidget(
      _detector(onTap: () => completions++, progress: progress, tapCount: 2),
    );
    await tester.tap(find.byKey(_target));
    await tester.pump(const Duration(milliseconds: 50));
    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(_target)),
    );
    await tester.pump(const Duration(milliseconds: 600));
    expect(progress, [1, 2]);
    await gesture.up();

    expect(completions, 1);
    expect(progress, [1, 2, 0]);
  });

  testWidgets('child tap recognizers retain serial-tap arena behavior', (
    tester,
  ) async {
    var completions = 0;
    var childTaps = 0;
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: MultiTapDetector(
            tapCount: 2,
            onTap: () => completions++,
            child: GestureDetector(
              onTap: () => childTaps++,
              child: const SizedBox(
                key: _target,
                width: 100,
                height: 100,
                child: ColoredBox(color: Color(0xFFFFFFFF)),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byKey(_target));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.byKey(_target));

    expect(completions, 1);
    expect(childTaps, 0);
  });

  testWidgets('distant taps start a new sequence within the same widget', (
    tester,
  ) async {
    var completions = 0;
    final progress = <int>[];
    await tester.pumpWidget(
      _detector(onTap: () => completions++, progress: progress, tapCount: 2),
    );
    final center = tester.getCenter(find.byKey(_target));
    await tester.tapAt(center + const Offset(-40, -40));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tapAt(center + const Offset(40, 40));

    expect(completions, 0);
    expect(progress, [1, 1]);
    await tester.pump(const Duration(milliseconds: 500));
  });

  testWidgets(
    'matching secondary buttons form a sequence after a button change',
    (tester) async {
      var completions = 0;
      final progress = <int>[];
      await tester.pumpWidget(
        _detector(onTap: () => completions++, progress: progress, tapCount: 2),
      );
      final center = tester.getCenter(find.byKey(_target));
      await tester.tapAt(center, kind: PointerDeviceKind.mouse);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tapAt(
        center,
        kind: PointerDeviceKind.mouse,
        buttons: kSecondaryMouseButton,
      );
      expect(completions, 0);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tapAt(
        center,
        kind: PointerDeviceKind.mouse,
        buttons: kSecondaryMouseButton,
      );

      expect(completions, 1);
      expect(progress, [1, 1, 2, 0]);
    },
  );

  testWidgets('interleaving pointers cancel the pending tap and start fresh', (
    tester,
  ) async {
    var completions = 0;
    final progress = <int>[];
    await tester.pumpWidget(
      _detector(onTap: () => completions++, progress: progress, tapCount: 2),
    );
    final center = tester.getCenter(find.byKey(_target));
    final first = await tester.startGesture(center, pointer: 1);
    final second = await tester.startGesture(center, pointer: 2);
    await first.up();
    await second.up();
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tapAt(center);

    expect(completions, 1);
    expect(progress, [1, 0, 1, 2, 0]);
  });
}
