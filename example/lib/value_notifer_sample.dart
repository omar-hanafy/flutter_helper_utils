import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';

main() => runApp(MyCounter());

class MyCounter extends StatelessWidget {
  MyCounter({super.key});

  final counter = 0.notifier;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      home: Scaffold(
        appBar: AppBar(title: const Text('Counter')),
        body: Center(
          child: counter.listenableBuilder(
            (value) {
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
