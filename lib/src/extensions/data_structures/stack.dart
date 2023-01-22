import 'dart:collection';

class StackX<T> {
  final _list = ListQueue<T>();

  bool get isEmpty => _list.isEmpty;

  bool get isNotEmpty => _list.isNotEmpty;

  void push(T element) => _list.addLast(element);

  T pop() {
    final element = _list.last;
    _list.removeLast();
    return element;
  }

  void top() => _list.last;

  List<T> addAll(Iterable<T> elements) {
    _list.addAll(elements);
    return _list.toList();
  }
}
