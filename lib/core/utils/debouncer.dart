import 'dart:async';

/// Simple debouncer for auto-save (300-500ms).
class Debouncer {
  Debouncer({required this.delay});
  final Duration delay;
  Timer? _timer;

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() => _timer?.cancel();
}
