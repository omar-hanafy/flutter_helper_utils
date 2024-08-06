import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

extension CustomBreakpoint on Breakpoint {
  bool get isWatch => match('watch');
}

void main() {
  runApp(
    PlatformTypeProvider(
      breakpoints: [
        Breakpoint(size: Size(200, 200), name: 'Watch'),
        ...Breakpoint.defaults,
      ],
      child: MyApp(),
    ),
  );
}

final themeModeNotifier = ThemeMode.light.notifier;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return themeModeNotifier.builder(
      (themeMode) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          // Use the value from the ValueNotifier
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Mode Switcher"),
        actions: [
          Switch(
            value: theme.isDark,
            onChanged: (value) => value
                ? themeModeNotifier.setDart()
                : themeModeNotifier.setLight(),
          ),
        ],
      ),
      body: PlatformInfoLayoutBuilder(
        builder: (context, platformInfo) {
          return Padding(
            padding: 8.paddingAll,
            child: Center(
              child: Text(
                "Theme Mode is: ${theme.brightness.name}",
                style: platformInfo.breakpoint.isDesktop
                    ? theme.displayLarge
                    : theme.displayMedium,
              ),
            ),
          );
        },
      ),
    );
  }
}
