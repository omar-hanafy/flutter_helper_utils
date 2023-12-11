import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

main() => runApp(MyCounter());

class MyCounter extends StatelessWidget {
  MyCounter({super.key});

  // this can also be initialized in another class (e.g. singleton class)
  // and change its value any where for more scaled state management
  final IntWatcher counter = 0.watch;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watch Counter',
      home: Scaffold(
        appBar: AppBar(title: const Text('Watch Counter')),
        body: Center(
          child: ValueWatcher(
            watcher: counter,
            builder: (context, value) {
              return Text('Counter: $value');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counter.increment(1),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
