// ignore_for_file: omit_local_variable_types, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

Future<void> main() async {
// Examples for Dart Extensions (some of flutter extensions are provided in the above UI example):

// DATETIME:
  final now = DateTime.now();
  DateTime tomorrow = now.addDays(1); // Adds 1 day to current date.
  DateTime afterOneHour = now.addHours(1); // Adds 1 hour to current date.
  String fullMonthName = now.month.toFullMonthName; // e.g March
  String fullSmallName = now.month.toSmallMonthName; // e.g Mar
  bool isToday = now.isToday; // true

// DURATION:
  const duration = Duration(seconds: 1, milliseconds: 30);
  // Adds the Duration to the current DateTime and returns a DateTime in the future.
  DateTime futureDate = duration.fromNow;
  // Subtracts the Duration from the current DateTime and returns a DateTime in the past
  DateTime pastDate = duration.ago;
  await duration.delayed<void>(); // run async delay

// NUMBERS:
  const int number = 1000;
  String greeks = number.asGreeks(0); // 1k
  Duration seconds = number.asSeconds; //  Duration(seconds: 1000)
  int numberOfDigits = number.numberOfDigits; // 4
  int doubled = number.doubled; // 2000

// TEXT:
  const text = 'hello there!';

  // wrap string at the specified word
  String wrappedString = text.wrapString(wordCount: 2);

  String capitalized = text.capitalizeFirstLetter; // 'Hello there!'
  String pascalCase = text.toPascalCase; // 'HelloThere!'.
  String camelCase = text.toCamelCase; // 'helloThere!'.
  String titleCase = text.toTitleCase; // 'Hello There!'.
  bool isAlphanumeric = text.isAlphanumeric; // false
  // tryToInt, tryToDateTime are also available
  double? tryToDouble = text.tryToDouble;
  // limit the string from the start. limitFromEnd also available
  String? limitFromStart = text.limitFromStart(3);
  // check if the string is a valid username. 'isValidPhoneNumber', isValidEmail, isValidHTML, and more are also available
  bool isValidUsername = text.isValidUsername;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Helper Utils',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();
  static final GlobalKey<TooltipState> tooltipKey2 = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    final theme = context.themeData;
    final txtTheme = theme.textTheme;

    print(233.percentage(430));
    bool? toToggleNull;
    bool toToggle = true;
    print(toToggle.toggled);
    print(toToggleNull.toggled);
    print('google.com/[]()[]()');
    print(
      'google.com/[]()[]()'.isValidUrl ? 'Url Is Valid' : 'Url Is not Valid',
    );

    const color = Colors.red;
    final hexColor = color.toHex();

    print(color.toHex());

    print('2'.isValidPhoneNumber);
    print(01111.isValidPhoneNumber);
    final ValueNotifier<int?> nullableCounter = ValueNotifier(null);
    nullableCounter.value = 2;
    print(nullableCounter.value);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Utils Samples',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: color,
            height: 20,
          ),
          Container(
            color: hexColor.toColor,
            height: 20,
          ),
          Text(
            'Hex Code to Flutter Color:',
            style: txtTheme.headlineSmall,
          ),
          const ColorConverter(),
          Row(
            children: [
              Flexible(
                child: Text(
                  'Numbers as Greeks',
                  style: txtTheme.headlineSmall,
                ),
              ),
              Tooltip(
                key: tooltipKey,
                waitDuration: 1.asSeconds,
                showDuration: 6.asSeconds,
                triggerMode: TooltipTriggerMode.manual,
                message: '''
1K = 1,000 or One thousand
10K = 10,000 or Ten thousand
100K = 100,000 or Hundred thousand
1M = 1 Million or 10,00,000
  K comes from the Greek word kilo which means a thousand.
  The Greeks would likewise show million as M, short for Mega.                
                ''',
                child: GestureDetector(
                  onTap: () => tooltipKey.currentState?.ensureTooltipVisible(),
                  child: Icon(
                    Icons.info,
                    color: theme.primaryColor,
                  ).paddingOnly(left: 10),
                ),
              ),
            ],
          ),
          const ToGreekNumbers(),
        ],
      ).paddingAll(20),
    );
  }
}

class ColorConverter extends StatefulWidget {
  const ColorConverter({super.key});

  @override
  State<ColorConverter> createState() => _ColorConverterState();
}

class _ColorConverterState extends State<ColorConverter> {
  Color? color;

  @override
  Widget build(BuildContext context) {
    final txtTheme = context.txtTheme;
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.grey,
            child: const Icon(Icons.favorite),
          ).alignAtBottomRight(),
          Expanded(
            flex: 2,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter any Hex color to show it',
              ),
              onChanged: (value) {
                setState(() {
                  color = value.toColor;
                });
              },
            ),
          ),
          if (color != null)
            SizedBox(
              height: 60,
              width: 80,
              child: Card(
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ).paddingOnly(left: 20),
            )
          else
            Flexible(
              child: Text(
                'Please Enter A valid Hex Color',
                style: txtTheme.headlineSmall,
              ).paddingOnly(left: 20),
            ),
        ],
      ),
    );
  }
}

class ToGreekNumbers extends StatefulWidget {
  const ToGreekNumbers({super.key});

  @override
  State<ToGreekNumbers> createState() => _ToGreekNumbersState();
}

class _ToGreekNumbersState extends State<ToGreekNumbers> {
  String? greekNumber;

  @override
  Widget build(BuildContext context) {
    final txtTheme = context.txtTheme;
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter any number to convert it'),
              onChanged: (value) {
                setState(() {
                  greekNumber = value.tryToInt?.asGreeks(0);
                });
              },
            ),
          ),
          Flexible(
            child: Text(
              greekNumber != null
                  ? greekNumber!
                  : 'Please Enter A valid Number',
              style: txtTheme.headlineSmall,
            ).paddingOnly(left: 20),
          ),
        ],
      ),
    );
  }
}
