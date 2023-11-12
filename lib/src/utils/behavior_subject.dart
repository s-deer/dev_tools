import 'dart:async';

class BehaviorSubject<T> {
  late T _value;
  late final StreamController<T> _controller;

  BehaviorSubject(T initialValue) {
    _value = initialValue;
    _controller = StreamController<T>.broadcast(
      onListen: () {
        _controller.add(_value);
      },
    );
  }

  Stream<T> get stream => _controller.stream;

  void add(T event) {
    _value = event;
    _controller.add(event);
  }

  void close() {
    _controller.close();
  }
}
