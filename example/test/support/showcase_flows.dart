import 'package:example/main.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

final _homeScroll = find.byKey(const ValueKey('showcase-scroll'));
Finder get _homeScrollable =>
    find.descendant(of: _homeScroll, matching: find.byType(Scrollable)).first;

Future<void> _reveal(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(finder, 240, scrollable: _homeScrollable);
  await tester.pumpAndSettle();
  expect(finder.hitTestable(), findsOneWidget);
}

Future<void> _homeTop(WidgetTester tester) async {
  final scrollable = tester.state<ScrollableState>(_homeScrollable);
  scrollable.position.jumpTo(0);
  await tester.pumpAndSettle();
}

Future<void> _detailReveal(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    160,
    scrollable: find
        .descendant(
          of: find.byType(FeatureDetailsPage),
          matching: find.byType(Scrollable),
        )
        .first,
  );
  await tester.pumpAndSettle();
  expect(finder.hitTestable(), findsOneWidget);
}

/// Exercises the real example's Material, navigation, and utility interactions.
Future<void> runShowcaseJourney(WidgetTester tester) async {
  expect(find.byType(ShowcaseHomePage), findsOneWidget);
  final homeContext = tester.element(find.byType(ShowcaseHomePage));
  expect(homeContext.themeData, isA<ThemeData>());
  expect(
    homeContext.themeData.primary,
    homeContext.themeData.colorScheme.primary,
  );

  for (final mode in [ThemeMode.dark, ThemeMode.light, ThemeMode.system]) {
    final themeButton = find.widgetWithText(
      FilledButton,
      'Theme: ${tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode!.name}',
    );
    await _reveal(tester, themeButton);
    await tester.tap(themeButton);
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      mode,
    );
    if (mode != ThemeMode.system) {
      expect(
        homeContext.themeData.brightness,
        mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
      );
    }
  }

  final capsule = find.text('Tap this capsule three times');
  await _reveal(tester, capsule);
  await tester.tap(capsule);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.tap(capsule);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.tap(capsule);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.pumpAndSettle();
  expect(find.byKey(const ValueKey('secret')), findsOneWidget);
  expect(find.text('Hidden note unlocked.'), findsOneWidget);
  homeContext.hideCurrentSnackBar();
  await tester.pumpAndSettle();
  // A second sequence resets progress and toggles the state again.
  await tester.tap(capsule);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.tap(capsule);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.tap(capsule);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.pumpAndSettle();
  expect(find.byKey(const ValueKey('secret')), findsNothing);
  expect(find.text('Hidden note tucked away again.'), findsOneWidget);
  homeContext.hideCurrentSnackBar();
  await tester.pumpAndSettle();

  const featureTitles = [
    'Adaptive UI',
    'Color toolkit',
    'Typed sliver lists',
    'BuildContext sugar',
    'Scroll helpers',
  ];
  for (var index = 0; index < featureTitles.length; index++) {
    final row = find.byKey(ValueKey('feature-$index'));
    final rowTitle = find.descendant(
      of: row,
      matching: find.text('${index + 1}. ${featureTitles[index]}'),
    );
    await _reveal(tester, rowTitle);
    await tester.tap(rowTitle);
    await tester.pumpAndSettle();
    expect(find.byType(FeatureDetailsPage), findsOneWidget);
    final feature = tester
        .widget<FeatureDetailsPage>(find.byType(FeatureDetailsPage))
        .feature;
    expect(find.widgetWithText(AppBar, feature.title), findsOneWidget);
    for (final highlight in feature.highlights) {
      await _detailReveal(tester, find.text(highlight));
      expect(find.text(highlight), findsOneWidget);
    }

    final back = find.text('Back to showcase');
    await _detailReveal(tester, back);
    if (index == 0) {
      final guard = find.byType(SwitchListTile);
      await _detailReveal(tester, guard);
      await tester.tap(guard);
      await tester.pumpAndSettle();
      expect(tester.widget<SwitchListTile>(guard).value, isFalse);
      await _detailReveal(tester, back);
      await tester.tap(back);
      await tester.pumpAndSettle();
      expect(find.byType(FeatureDetailsPage), findsOneWidget);
      expect(find.text('Back blocked by PopScope.'), findsOneWidget);
      tester.element(find.byType(FeatureDetailsPage)).hideCurrentSnackBar();
      await tester.pumpAndSettle();
      final forceBack = find.text('Force back to showcase');
      await _detailReveal(tester, forceBack);
      await tester.tap(forceBack);
    } else {
      await tester.tap(back);
    }
    await tester.pumpAndSettle();
    expect(find.byType(FeatureDetailsPage), findsNothing);
    expect(find.byType(ShowcaseHomePage), findsOneWidget);
  }

  await _reveal(tester, find.text('Ink'));
  expect(find.text('#FF0F172A'), findsOneWidget);
  await _reveal(tester, find.text('platform env'));
  expect(find.text(PlatformEnv.operatingSystem), findsWidgets);

  final field = find.byKey(const ValueKey('focus-demo-field'));
  await _reveal(tester, field);
  await tester.enterText(field, 'Material migration verified');
  await tester.pumpAndSettle();
  expect(find.text('Material migration verified'), findsOneWidget);
  final dismiss = find.text('Dismiss keyboard');
  await tester.ensureVisible(dismiss);
  await tester.tap(dismiss);
  await tester.pumpAndSettle();
  expect(find.text('Focus dismissed.'), findsOneWidget);
  expect(
    tester
        .widget<EditableText>(
          find.descendant(of: field, matching: find.byType(EditableText)),
        )
        .focusNode
        .hasFocus,
    isFalse,
  );
  homeContext.hideCurrentSnackBar();
  await tester.pumpAndSettle();
  await tester.tap(find.text('Clear field'));
  await tester.pumpAndSettle();
  expect(tester.widget<TextField>(field).controller!.text, isEmpty);
  expect(find.text('Field cleared.'), findsOneWidget);
  homeContext.hideCurrentSnackBar();
  await tester.pumpAndSettle();

  await _homeTop(tester);
  await _reveal(tester, find.text('Middle'));
  final controller = tester.widget<CustomScrollView>(_homeScroll).controller!;
  // Sliver lists estimate unbuilt children. The helper targets the current
  // scroll metrics, which can change as more children are laid out.
  final middleTarget = controller.position.maxScrollExtent / 2;
  await tester.tap(find.text('Middle'));
  await tester.pumpAndSettle();
  expect(controller.offset, closeTo(middleTarget, 1));
  await _homeTop(tester);
  await _reveal(tester, find.text('Bottom'));
  await tester.tap(find.text('Bottom'));
  await tester.pumpAndSettle();
  expect(controller.offset, closeTo(controller.position.maxScrollExtent, 1));
  expect(
    find.textContaining('For migration specifics').hitTestable(),
    findsOneWidget,
  );
  await _homeTop(tester);
  await _reveal(tester, find.text('Top'));
  await tester.tap(find.text('Top'));
  await tester.pumpAndSettle();
  expect(controller.offset, 0);
  expect(tester.takeException(), isNull);
}
