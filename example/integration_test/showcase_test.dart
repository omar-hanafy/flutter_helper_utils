import 'package:example/main.dart' as app;
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';

import '../test/support/multi_tap_flows.dart';
import '../test/support/pagination_flows.dart';
import '../test/support/showcase_flows.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('native entry point exercises Material and utility flows', (
    tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    expect(PlatformEnv.isWeb, isFalse);
    await runShowcaseJourney(tester);
  });

  testWidgets('native app stays usable in a narrow constrained window', (
    tester,
  ) async {
    await binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => binding.setSurfaceSize(null));
    app.main();
    await tester.pumpAndSettle();
    expect(
      tester.element(find.byType(app.ShowcaseHomePage)).readBreakpoint.name,
      'mobile',
    );
    await runShowcaseJourney(tester);
  });

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
