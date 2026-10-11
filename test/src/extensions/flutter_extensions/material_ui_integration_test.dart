import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

class _BrandTheme extends ThemeExtension<_BrandTheme> {
  const _BrandTheme(this.color);

  final Color color;

  @override
  _BrandTheme copyWith({Color? color}) => _BrandTheme(color ?? this.color);

  @override
  _BrandTheme lerp(_BrandTheme? other, double t) =>
      _BrandTheme(Color.lerp(color, other?.color, t)!);
}

void main() {
  testWidgets('theme helpers resolve material_ui themes and extensions', (
    tester,
  ) async {
    const brand = _BrandTheme(Colors.orange);
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      platform: TargetPlatform.iOS,
      extensions: const [brand],
      textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 21)),
    );
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Builder(
            builder: (value) {
              context = value;
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    expect(context.themeData, isA<ThemeData>());
    expect(context.colorScheme, theme.colorScheme);
    expect(context.textTheme.bodyLarge?.fontSize, 21);
    expect(context.appBarTheme, theme.appBarTheme);
    expect(context.carouselViewTheme, theme.carouselViewTheme);
    expect(context.themeExtension<_BrandTheme>(), brand);
    final (activeTheme, activeBrand) = context
        .themeWithExtension<_BrandTheme>();
    expect(activeTheme.colorScheme, theme.colorScheme);
    expect(activeBrand, brand);
    expect(context.targetPlatform, TargetPlatform.iOS);
    expect(context.materialLocalizations, isA<MaterialLocalizations>());
    expect(context.scaffold, isA<ScaffoldState>());
    expect(context.scaffoldOrNull, context.scaffold);
  });

  testWidgets(
    'scaffold messenger helpers show and remove material_ui content',
    (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (value) {
                context = value;
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(context.maybeScaffoldMessenger, context.scaffoldMessenger);
      final snackBar = context.showSnackBar(
        const SnackBar(content: Text('saved')),
        snackBarAnimationStyle: AnimationStyle.noAnimation,
      );
      await tester.pump();
      expect(find.text('saved'), findsOneWidget);
      context.removeCurrentSnackBar();
      await tester.pump();
      expect(find.text('saved'), findsNothing);
      await expectLater(
        snackBar.closed,
        completion(SnackBarClosedReason.remove),
      );

      final banner = context.showMaterialBanner(
        const MaterialBanner(
          content: Text('offline'),
          actions: [TextButton(onPressed: null, child: Text('retry'))],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('offline'), findsOneWidget);
      context.removeCurrentMaterialBanner();
      await tester.pumpAndSettle();
      expect(find.text('offline'), findsNothing);
      await expectLater(
        banner.closed,
        completion(MaterialBannerClosedReason.remove),
      );
    },
  );

  testWidgets('page helpers push a material_ui route and return its result', (
    tester,
  ) async {
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (value) {
              context = value;
              return const Text('home');
            },
          ),
        ),
      ),
    );

    final result = context.pushPage<String>(
      const Scaffold(body: Text('details')),
      settings: const RouteSettings(name: '/details'),
    );
    await tester.pumpAndSettle();
    final details = tester.element(find.text('details'));
    expect(ModalRoute.of(details), isA<MaterialPageRoute<String>>());
    expect(ModalRoute.of(details)?.settings.name, '/details');
    expect(await details.popPage('done'), isTrue);
    await tester.pumpAndSettle();
    expect(find.text('home'), findsOneWidget);
    await expectLater(result, completion('done'));
  });
}
