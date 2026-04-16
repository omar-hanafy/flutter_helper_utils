import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

void main() {
  testWidgets(
    'PlatformTypeProvider works when it wraps MaterialApp at the root',
    (tester) async {
      tester.view
        ..physicalSize = const Size(800, 600)
        ..devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        PlatformTypeProvider(
          child: MaterialApp(
            home: Builder(
              builder: (context) => Text(context.watchBreakpoint.name),
            ),
          ),
        ),
      );

      expect(find.text('tablet'), findsOneWidget);
    },
  );
}
