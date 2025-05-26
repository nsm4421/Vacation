import 'dart:async';

mixin DebounceMixin {
  Timer? _debounceTimer;
  bool _isExecuting = false;

  // 여러 번 호출되면 delay 시간 내에 마지막 호출만 실제로 실행됨.
  debounce(
    Future<void> Function() action, {
    Duration delay = const Duration(milliseconds: 300),
  }) {
    if (_isExecuting) return;
    try {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(delay, () async {
        await action();
      });
    } finally {
      _isExecuting = false;
    }
  }
}
