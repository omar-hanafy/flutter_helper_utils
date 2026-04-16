import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

/// Launches the v9 example showcase.
void main() {
  runApp(const PlatformTypeProvider(child: ShowcaseApp()));
}

/// Root app widget for the `flutter_helper_utils` example.
class ShowcaseApp extends StatefulWidget {
  /// Creates the example app shell.
  const ShowcaseApp({super.key});

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = switch (_themeMode) {
        ThemeMode.system => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.light,
        ThemeMode.light => ThemeMode.system,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_helper_utils v9',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF97316),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F4EC),
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: const Color(0xFF171717),
          displayColor: const Color(0xFF171717),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF97316),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF111111),
      ),
      home: ShowcaseHomePage(
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

/// Home screen that presents the main v9 showcase sections.
class ShowcaseHomePage extends StatefulWidget {
  /// Creates the showcase home screen.
  const ShowcaseHomePage({
    required this.themeMode,
    required this.onToggleTheme,
    super.key,
  });

  /// The currently active theme mode in the example app.
  final ThemeMode themeMode;

  /// Toggles the example app between light, dark, and system modes.
  final VoidCallback onToggleTheme;

  @override
  State<ShowcaseHomePage> createState() => _ShowcaseHomePageState();
}

class _ShowcaseHomePageState extends State<ShowcaseHomePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _focusDemoController = TextEditingController();
  bool _secretUnlocked = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _focusDemoController.dispose();
    super.dispose();
  }

  Future<void> _scrollToTop() => _scrollController.animateToStart();

  Future<void> _scrollToMiddle() => _scrollController.scrollToPercentage(0.5);

  Future<void> _scrollToBottom() => _scrollController.animateToEnd();

  void _unlockSecret() {
    setState(() {
      _secretUnlocked = !_secretUnlocked;
    });

    context.showSnackBar(
      SnackBar(
        content: Text(
          _secretUnlocked
              ? 'Hidden note unlocked.'
              : 'Hidden note tucked away again.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    final breakpoint = context.watchBreakpoint;
    final isWide = breakpoint.isTablet || breakpoint.isDesktop;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: _HeroSection(
              isWide: isWide,
              secretUnlocked: _secretUnlocked,
              themeMode: widget.themeMode,
              onToggleTheme: widget.onToggleTheme,
              onUnlockSecret: _unlockSecret,
              onScrollToTop: _scrollToTop,
              onScrollToMiddle: _scrollToMiddle,
              onScrollToBottom: _scrollToBottom,
            ),
          ),
          _features.buildSliverList(
            sliverHeader: const SliverToBoxAdapter(
              child: _SectionShell(
                title: 'Capability index',
                subtitle:
                    'A sliver-powered feature list that opens focused detail screens with the v9 navigation helpers.',
                child: SizedBox.shrink(),
              ),
            ),
            itemBuilder: (context, index, feature) =>
                _FeatureRow(feature: feature, index: index),
            spacing: 12,
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          ),
          SliverToBoxAdapter(
            child: _SectionShell(
              title: 'Parsed palette',
              subtitle:
                  'These swatches come from CSS-like color strings parsed by `tryToColor` and displayed with contrast-aware labels.',
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _palette
                    .map(
                      (entry) => _PaletteSwatch(
                        entry: entry,
                        color: tryToColor(entry.spec) ?? theme.primary,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _SectionShell(
              title: 'Context report',
              subtitle:
                  'Adaptive layout, platform reporting, and theme shortcuts all in one place.',
              child: PlatformInfoLayoutBuilder(
                builder: (context, info) => _ContextBoard(info: info),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _SectionShell(
              title: 'Tiny interaction lab',
              subtitle:
                  'A focused text field and a keyboard dismiss action using the current focus helper naming.',
              child: ThemeWithoutEffects(
                noHoverColor: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _focusDemoController,
                      decoration: InputDecoration(
                        labelText: 'Type something, then dismiss focus',
                        hintText: 'This is just here to exercise the focus API',
                        filled: true,
                        fillColor: theme.surfaceContainerHighest.setOpacity(
                          theme.isDark ? 0.2 : 0.65,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: 18.allCircular,
                        ),
                      ),
                    ),
                    16.heightBox(),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        FilledButton.icon(
                          onPressed: () {
                            context
                              ..unfocus()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text('Focus dismissed.'),
                                ),
                              );
                          },
                          icon: const Icon(Icons.keyboard_hide_rounded),
                          label: const Text('Dismiss keyboard'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            _focusDemoController.clear();
                            context.showSnackBar(
                              const SnackBar(content: Text('Field cleared.')),
                            );
                          },
                          icon: const Icon(Icons.backspace_rounded),
                          label: const Text('Clear field'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
              child: Text(
                'For migration specifics, read migration_guides.md. '
                'For everything else, this example is the current v9 reference.',
                style: theme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.isWide,
    required this.secretUnlocked,
    required this.themeMode,
    required this.onToggleTheme,
    required this.onUnlockSecret,
    required this.onScrollToTop,
    required this.onScrollToMiddle,
    required this.onScrollToBottom,
  });

  final bool isWide;
  final bool secretUnlocked;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final VoidCallback onUnlockSecret;
  final Future<void> Function() onScrollToTop;
  final Future<void> Function() onScrollToMiddle;
  final Future<void> Function() onScrollToBottom;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    final panelColor = theme.surfaceContainerHigh.setOpacity(
      theme.isDark ? 0.28 : 0.72,
    );
    final body = isWide
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _HeroCopy(
                  secretUnlocked: secretUnlocked,
                  themeMode: themeMode,
                  onToggleTheme: onToggleTheme,
                  onUnlockSecret: onUnlockSecret,
                  onScrollToTop: onScrollToTop,
                  onScrollToMiddle: onScrollToMiddle,
                  onScrollToBottom: onScrollToBottom,
                ),
              ),
              24.widthBox(),
              const Expanded(flex: 2, child: _HeroContextPanel()),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeroCopy(
                secretUnlocked: secretUnlocked,
                themeMode: themeMode,
                onToggleTheme: onToggleTheme,
                onUnlockSecret: onUnlockSecret,
                onScrollToTop: onScrollToTop,
                onScrollToMiddle: onScrollToMiddle,
                onScrollToBottom: onScrollToBottom,
              ),
              24.heightBox(),
              const _HeroContextPanel(),
            ],
          );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFF6EDE0), theme.colorScheme.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: panelColor,
            borderRadius: 32.allCircular,
            border: Border.all(color: theme.outlineVariant.setOpacity(0.35)),
          ),
          child: Padding(padding: const EdgeInsets.all(24), child: body),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.secretUnlocked,
    required this.themeMode,
    required this.onToggleTheme,
    required this.onUnlockSecret,
    required this.onScrollToTop,
    required this.onScrollToMiddle,
    required this.onScrollToBottom,
  });

  final bool secretUnlocked;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final VoidCallback onUnlockSecret;
  final Future<void> Function() onScrollToTop;
  final Future<void> Function() onScrollToMiddle;
  final Future<void> Function() onScrollToBottom;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    final titleStyle = (theme.displaySmall ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.w800,
      height: 0.95,
      color: Colors.white,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'flutter_helper_utils v9',
          style: theme.labelLarge?.copyWith(
            letterSpacing: 1.4,
            color: theme.primary,
          ),
        ),
        12.heightBox(),
        GradientWidget(
          gradient: const LinearGradient(
            colors: [Color(0xFFF97316), Color(0xFF0EA5E9)],
          ),
          child: Text(
            'Less clutter.\nStill useful.\nActually shippable.',
            style: titleStyle,
          ),
        ),
        16.heightBox(),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'This example is a clean v9 showcase: adaptive layout, parsed colors, '
            'typed sliver lists, focused BuildContext helpers, and a small opt-in '
            'sugar layer when you actually want it.',
            style: theme.titleMedium?.copyWith(height: 1.45),
          ),
        ),
        20.heightBox(),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.setOpacity(
              theme.isDark ? 0.16 : 0.74,
            ),
            borderRadius: 20.allCircular,
            border: Border.all(color: theme.outlineVariant.setOpacity(0.25)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SelectableText(
              "import 'package:flutter_helper_utils/flutter_helper_utils.dart';\n"
              "import 'package:flutter_helper_utils/sugar.dart';",
              style: theme.bodyMedium?.copyWith(
                fontFamily: 'monospace',
                height: 1.5,
              ),
            ),
          ),
        ),
        20.heightBox(),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: onToggleTheme,
              icon: Icon(switch (themeMode) {
                ThemeMode.system => Icons.motion_photos_auto_rounded,
                ThemeMode.dark => Icons.dark_mode_rounded,
                ThemeMode.light => Icons.light_mode_rounded,
              }),
              label: Text('Theme: ${themeMode.name}'),
            ),
            OutlinedButton(onPressed: onScrollToTop, child: const Text('Top')),
            OutlinedButton(
              onPressed: onScrollToMiddle,
              child: const Text('Middle'),
            ),
            OutlinedButton(
              onPressed: onScrollToBottom,
              child: const Text('Bottom'),
            ),
          ],
        ),
        16.heightBox(),
        MultiTapDetector(
          tapCount: 3,
          onTap: onUnlockSecret,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.setOpacity(
                theme.isDark ? 0.16 : 0.82,
              ),
              borderRadius: 999.allCircular,
              border: Border.all(color: theme.outlineVariant.setOpacity(0.3)),
            ),
            child: Text(
              'Tap this capsule three times',
              style: theme.bodyMedium,
            ),
          ),
        ),
        12.heightBox(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: secretUnlocked
              ? Text(
                  'Unlocked note: v9 is trying to feel smaller on purpose.',
                  key: const ValueKey('secret'),
                  style: theme.bodyMedium?.copyWith(
                    color: theme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const SizedBox.shrink(key: ValueKey('empty')),
        ),
      ],
    );
  }
}

class _HeroContextPanel extends StatelessWidget {
  const _HeroContextPanel();

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    final breakpoint = context.watchBreakpoint;
    final facts = <(String, String)>[
      ('breakpoint', breakpoint.name),
      ('platform', PlatformEnv.targetPlatform.name),
      ('os', PlatformEnv.operatingSystem),
      ('locale', PlatformEnv.localeName),
      ('viewport', '${context.widthPx.toInt()} x ${context.heightPx.toInt()}'),
      ('cores', PlatformEnv.numberOfProcessors.toString()),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.setOpacity(theme.isDark ? 0.18 : 0.9),
        borderRadius: 28.allCircular,
        border: Border.all(color: theme.outlineVariant.setOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Live context', style: theme.titleLarge),
          12.heightBox(),
          ...facts.map(
            (fact) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 88,
                    child: Text(
                      fact.$1,
                      style: theme.labelMedium?.copyWith(color: theme.primary),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      fact.$2,
                      style: theme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.headlineSmall),
          8.heightBox(),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(subtitle, style: theme.bodyLarge),
          ),
          20.heightBox(),
          child,
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.feature, required this.index});

  final DemoFeature feature;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    final accent = tryToColor(feature.accentSpec) ?? theme.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: 28.allCircular,
        onTap: () => context.pushPage(FeatureDetailsPage(feature: feature)),
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: theme.surfaceContainerHigh.setOpacity(
              theme.isDark ? 0.22 : 1,
            ),
            borderRadius: 28.allCircular,
            border: Border.all(color: theme.outlineVariant.setOpacity(0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: accent.setOpacity(0.14),
                  borderRadius: 18.allCircular,
                ),
                child: Icon(feature.icon, color: accent),
              ),
              16.widthBox(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}. ${feature.title}',
                      style: theme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    6.heightBox(),
                    Text(feature.summary, style: theme.bodyLarge),
                    10.heightBox(),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: feature.highlights
                          .map(
                            (highlight) => DecoratedBox(
                              decoration: BoxDecoration(
                                color: accent.setOpacity(0.12),
                                borderRadius: 999.allCircular,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                child: Text(
                                  highlight,
                                  style: theme.labelMedium,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              16.widthBox(),
              Icon(Icons.arrow_forward_rounded, color: accent),
            ],
          ),
        ),
      ),
    );
  }
}

/// Detail page used to inspect a single showcased package capability.
class FeatureDetailsPage extends StatelessWidget {
  /// Creates the feature detail page.
  const FeatureDetailsPage({required this.feature, super.key});

  /// The feature being presented on the page.
  final DemoFeature feature;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    final accent = tryToColor(feature.accentSpec) ?? theme.primary;

    return Scaffold(
      appBar: AppBar(title: Text(feature.title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: accent.setOpacity(0.14),
                borderRadius: 24.allCircular,
              ),
              child: Icon(feature.icon, color: accent, size: 36),
            ),
            20.heightBox(),
            Text(
              feature.title,
              style: theme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            12.heightBox(),
            Text(feature.summary, style: theme.titleMedium),
            20.heightBox(),
            ...feature.highlights.map(
              (highlight) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle_rounded, color: accent, size: 20),
                    10.widthBox(),
                    Expanded(child: Text(highlight, style: theme.bodyLarge)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => context.popPage(),
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Back to showcase'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaletteSwatch extends StatelessWidget {
  const _PaletteSwatch({required this.entry, required this.color});

  final PaletteEntry entry;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    final labelColor = color.contrastColor();

    return Container(
      width: 176,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: 24.allCircular,
        border: Border.all(color: theme.outlineVariant.setOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.label,
            style: theme.titleMedium?.copyWith(
              color: labelColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          24.heightBox(),
          Text(
            entry.spec,
            style: theme.bodyMedium?.copyWith(color: labelColor),
          ),
          6.heightBox(),
          Text(
            color.toHex(includeAlpha: true, uppercase: true),
            style: theme.labelMedium?.copyWith(color: labelColor),
          ),
        ],
      ),
    );
  }
}

class _ContextBoard extends StatelessWidget {
  const _ContextBoard({required this.info});

  final PlatformSizeInfo info;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    final cards = <(String, String)>[
      ('orientation', info.orientation.name),
      ('breakpoint width', info.breakpoint.width.toStringAsFixed(0)),
      ('theme brightness', theme.brightness.name),
      ('primary color', theme.primary.toHex()),
      ('surface high', theme.surfaceContainerHigh.toHex(uppercase: true)),
      ('platform env', PlatformEnv.operatingSystem),
    ];

    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: cards
          .map(
            (card) => Container(
              width: 220,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.surfaceContainerHigh.setOpacity(
                  theme.isDark ? 0.22 : 0.92,
                ),
                borderRadius: 22.allCircular,
                border: Border.all(
                  color: theme.outlineVariant.setOpacity(0.28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.$1,
                    style: theme.labelMedium?.copyWith(color: theme.primary),
                  ),
                  8.heightBox(),
                  Text(
                    card.$2,
                    style: theme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

/// Metadata for a single showcased package capability.
class DemoFeature {
  /// Creates one feature entry for the example app.
  const DemoFeature({
    required this.title,
    required this.summary,
    required this.icon,
    required this.accentSpec,
    required this.highlights,
  });

  /// Display title used in the list and detail view.
  final String title;

  /// Short explanation of what the feature does.
  final String summary;

  /// Leading icon for the feature row.
  final IconData icon;

  /// CSS-like color string used to derive the accent color.
  final String accentSpec;

  /// Supporting bullet points rendered in the list and detail screens.
  final List<String> highlights;
}

/// A named color string used by the parsed palette section.
class PaletteEntry {
  /// Creates one palette swatch entry.
  const PaletteEntry({required this.label, required this.spec});

  /// Human-readable label shown on the swatch.
  final String label;

  /// Color source string parsed with `tryToColor`.
  final String spec;
}

const List<DemoFeature> _features = [
  DemoFeature(
    title: 'Adaptive UI',
    summary:
        'Breakpoints, platform info, and layout builders that work high in the tree.',
    icon: Icons.devices_rounded,
    accentSpec: '#F97316',
    highlights: [
      'PlatformTypeProvider',
      'Breakpoint helpers',
      'PlatformInfoLayoutBuilder',
    ],
  ),
  DemoFeature(
    title: 'Color toolkit',
    summary:
        'Parse, inspect, transform, and audit colors with one coherent surface.',
    icon: Icons.palette_outlined,
    accentSpec: 'rgb(14 165 233)',
    highlights: ['tryToColor', 'toHex', 'contrastColor', 'WCAG utilities'],
  ),
  DemoFeature(
    title: 'Typed sliver lists',
    summary:
        'Typed builders for sliver-heavy screens without giving up layout control.',
    icon: Icons.view_stream_rounded,
    accentSpec: 'hsl(142 72% 40%)',
    highlights: [
      'TypedListView',
      'TypedSliverList',
      'Headers, spacing, pagination',
    ],
  ),
  DemoFeature(
    title: 'BuildContext sugar',
    summary:
        'Focused helpers for navigation, focus, theme access, and snackbars.',
    icon: Icons.touch_app_rounded,
    accentSpec: '#7C3AED',
    highlights: ['pushPage', 'showSnackBar', 'unfocus', 'themeData'],
  ),
  DemoFeature(
    title: 'Scroll helpers',
    summary:
        'Readable scroll actions that help demos and product screens stay ergonomic.',
    icon: Icons.swipe_vertical_rounded,
    accentSpec: '#0F766E',
    highlights: ['animateToStart', 'scrollToPercentage', 'animateToEnd'],
  ),
];

const List<PaletteEntry> _palette = [
  PaletteEntry(label: 'Ink', spec: '#0F172A'),
  PaletteEntry(label: 'Signal', spec: '#F97316'),
  PaletteEntry(label: 'Lake', spec: 'rgb(14 165 233)'),
  PaletteEntry(label: 'Field', spec: 'hsl(142 72% 40%)'),
  PaletteEntry(label: 'Fog', spec: 'aliceblue'),
];
