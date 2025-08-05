import 'package:example/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

extension CustomBreakpoint on Breakpoint {
  bool get isWatch => match('watch');
}

void main() {
  runApp(
    const PlatformTypeProvider(
      breakpoints: [
        Breakpoint(width: 200, name: 'Watch'),
        ...Breakpoint.defaults,
      ],
      child: MyApp(),
    ),
  );
}

final ThemeModeNotifier themeModeNotifier = ThemeMode.system.notifier;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return themeModeNotifier.builder(
      (themeMode) {
        return MaterialApp(
          title: 'Flutter Helper Utils Enhanced Demo',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              headlineMedium: TextStyle(color: Colors.blue),
              bodyMedium: TextStyle(color: Colors.black87),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
            textTheme: const TextTheme(
              headlineMedium: TextStyle(color: Colors.deepPurpleAccent),
              bodyMedium: TextStyle(color: Colors.white70),
            ),
          ),
          themeMode: themeMode,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    final platformInfo = context.platformSizeInfo;
    final screenSize = context.sizePx;

    return Scaffold(
      appBar: AppBar(
        title: Text('Platform: ${platformInfo.platform.name}'),
        actions: [
          IconButton(
            icon: Icon(theme.isDark ? Icons.nightlight_round : Icons.wb_sunny),
            onPressed: () {
              theme.isDark
                  ? themeModeNotifier.setLight()
                  : themeModeNotifier.setDark();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: 16.edgeInsetsAll, // Using EdgeInsets utility
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Current Theme Mode: ${theme.brightness.name}',
              style: platformInfo.breakpoint.isDesktop
                  ? theme.headlineMedium
                  : theme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Platform: ${platformInfo.platform.name}',
              style: platformInfo.breakpoint.isDesktop
                  ? theme.headlineMedium
                  : theme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Screen Size: ${screenSize.width.toInt()} x ${screenSize.height.toInt()}',
              style: platformInfo.breakpoint.isDesktop
                  ? theme.headlineMedium
                  : theme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildResponsiveButtons(context, platformInfo, screenSize),
            const SizedBox(height: 40),
            Text(
              'Try switching the theme mode or resizing the window to see changes!',
              style: theme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (platformInfo.breakpoint.isDesktop)
              Text(
                'Additional Desktop Information: Multi-window support enabled.',
                style: theme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Using focus utility
                context
                  ..unFocus()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Focus removed and button clicked!'),
                    ),
                  );
              },
              child: const Text('Unfocused & Click'),
            ),
            const SizedBox(height: 20),
            _buildAdditionalUtilities(context),
            const Countries(),
          ],
        ),
      ),
      drawer: platformInfo.breakpoint.isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: const Text('Item 1'),
                    onTap: () {
                      context.showSnackBar(
                        const SnackBar(
                          content: Text('Item 1 selected'),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: () {
                      context.showSnackBar(
                        const SnackBar(
                          content: Text('Item 2 selected'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildResponsiveButtons(
      BuildContext context, PlatformSizeInfo platformInfo, Size screenSize) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        if (platformInfo.breakpoint.isMobile)
          ElevatedButton.icon(
            onPressed: () {
              context.showSnackBar(
                const SnackBar(
                  content: Text('Action triggered on Mobile!'),
                ),
              ); // Using context.showSnackBar utility
            },
            icon: const Icon(Icons.phone_android),
            label: const Text('Mobile Action'),
          ),
        if (platformInfo.breakpoint.isTablet)
          ElevatedButton.icon(
            onPressed: () {
              context.showSnackBar(
                const SnackBar(
                  content: Text('Action triggered on Tablet!'),
                ),
              );
            },
            icon: const Icon(Icons.tablet),
            label: const Text('Tablet Action'),
          ),
        if (platformInfo.breakpoint.isDesktop)
          ElevatedButton.icon(
            onPressed: () {
              context.showSnackBar(
                const SnackBar(
                  content: Text('Action triggered on Desktop!'),
                ),
              );
            },
            icon: const Icon(Icons.desktop_windows),
            label: const Text('Desktop Action'),
          ),
      ],
    );
  }

  Widget _buildAdditionalUtilities(BuildContext context) {
    return Column(
      children: [
        // Demonstrating DateTime utilities
        Text(
          'Formatted Date: ${DateTime.now().format('yyyy/MM/dd')}',
          style: context.themeData.bodyMedium,
        ),
        const SizedBox(height: 20),
        // Demonstrating String utilities
        Text(
          'Is the string "Helper" blank? ${"Helper".isBlank}',
          style: context.themeData.bodyMedium,
        ),
        const SizedBox(height: 20),
        // Demonstrating Focus utility
        ElevatedButton(
          onPressed: () {
            context
              ..unFocus()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Focus removed and action triggered!'),
                ),
              );
          },
          child: const Text('Unfocus & Show SnackBar'),
        ),
      ],
    );
  }
}
