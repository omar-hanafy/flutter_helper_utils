import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FHUNavigatorExtension pop helpers', () {
    testWidgets(
      'popPage returns false when the first route bubbles the request',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: Text('home'))),
        );

        final handled = await tester.element(find.text('home')).popPage<void>();

        expect(handled, isFalse);
        expect(find.text('home'), findsOneWidget);
      },
    );

    testWidgets('popPage respects PopScope guards', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => const PopScope<void>(
                        canPop: false,
                        child: Scaffold(body: Text('guarded')),
                      ),
                    ),
                  );
                },
                child: const Text('push'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('push'));
      await tester.pumpAndSettle();

      final handled = await tester
          .element(find.text('guarded'))
          .popPage<void>();
      await tester.pumpAndSettle();

      expect(handled, isTrue);
      expect(find.text('guarded'), findsOneWidget);
    });

    testWidgets('forcePopPage removes the route and returns its result', (
      tester,
    ) async {
      Future<String?>? routeResult;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  routeResult = Navigator.of(context).push<String>(
                    MaterialPageRoute<String>(
                      builder: (_) => const PopScope<String>(
                        canPop: false,
                        child: Scaffold(body: Text('details')),
                      ),
                    ),
                  );
                },
                child: const Text('push'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('push'));
      await tester.pumpAndSettle();

      tester.element(find.text('details')).forcePopPage<String>('done');
      await tester.pumpAndSettle();

      expect(find.text('details'), findsNothing);
      await expectLater(routeResult!, completion('done'));
    });
  });
}
