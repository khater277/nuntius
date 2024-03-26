import 'dart:async';

class SelectNotificationStream {
  final _controller = StreamController<String?>.broadcast();

  Stream<String?> get stream => _controller.stream;

  void addToStream(String? data) {
    _controller.sink.add(data);
  }

  void dispose() {
    _controller.close();
  }
}
