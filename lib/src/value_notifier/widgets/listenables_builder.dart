import 'package:flutter/material.dart';

/// [ListenablesBuilder]
///
/// A widget that rebuilds itself when any of the provided [Listenable] objects notify their listeners.
/// This allows for responsive and dynamic UI updates based on changes in multiple [Listenable] sources.
///
/// The `ListenablesBuilder` widget is designed to listen to a collection of [Listenable] objects,
/// such as [ValueNotifier], [ChangeNotifier], or custom [Listenable] instances. When any of the
/// specified `listenables` notify their listeners of changes, the widget will trigger a rebuild,
/// ensuring that the UI reflects the latest state.
///
/// This widget offers flexibility in its configuration:
/// - You can provide a list of [Listenable] objects to listen to.
/// - You can define a custom `builder` function to specify the UI.
/// - You can optionally provide a `buildWhen` callback to control when the widget should rebuild,
///   optimizing performance by preventing unnecessary rebuilds.
/// - You can also specify a `threshold` duration to limit the frequency of rebuilds during rapid
///   state changes, helping to avoid performance issues and UI flickering.
/// **Example:**
/// ```dart
/// ListenablesBuilder(
///   listenables: [myValueNotifier1, myChangeNotifier],
///   builder: (context) => Text('Value 1: ${myValueNotifier1.value}, Value 2: ${myChangeNotifier.someProperty}'),
/// );
/// ```
class ListenablesBuilder extends StatefulWidget {
  const ListenablesBuilder({
    required this.listenables,
    required this.builder,
    this.buildWhen,
    this.threshold,
    super.key,
  });

  /// A list of [Listenable] objects that this widget listens to.
  /// The widget will rebuild when any of the `listenables` notify their listeners.
  final List<Listenable?> listenables;

  /// A function that returns the widget to be built.
  /// This function is called whenever the widget needs to rebuild.
  final Widget Function(BuildContext context) builder;

  /// An optional function that determines whether the widget should rebuild
  /// when any of the `listenables` notify their listeners.
  /// If it returns `true`, the [builder] function is called to rebuild the widget.
  /// If `false`, the widget is not rebuilt. If null, the widget rebuilds on every notification.
  final bool Function()? buildWhen;

  /// An optional [Duration] that sets a minimum interval between rebuilds
  /// to limit the frequency of rebuilds during rapid state changes.
  final Duration? threshold;

  @override
  State<ListenablesBuilder> createState() => _ListenablesBuilderState();
}

class _ListenablesBuilderState extends State<ListenablesBuilder> {
  DateTime? _lastBuildTime;
  final Set<Listenable> _activeListenables = {}; // Track active listeners

  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  void _addListeners() {
    for (final listenable in widget.listenables) {
      if (listenable != null && !_activeListenables.contains(listenable)) {
        listenable.addListener(_listener);
        _activeListenables.add(listenable);
      }
    }
  }

  void _removeListeners() {
    for (final listenable in _activeListenables) {
      listenable.removeListener(_listener);
    }
    _activeListenables.clear();
  }

  void _listener() {
    if (widget.buildWhen?.call() ?? true) {
      final now = DateTime.now();
      if (widget.threshold == null ||
          _lastBuildTime == null ||
          now.difference(_lastBuildTime!) > widget.threshold!) {
        setState(() {
          _lastBuildTime = now;
        });
      }
    }
  }

  @override
  void didUpdateWidget(ListenablesBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listenables != widget.listenables) {
      _removeListeners();
      _addListeners();
    }
  }

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}
