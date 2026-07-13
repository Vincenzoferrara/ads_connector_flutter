
import 'dart:async';
import 'logger.dart';

typedef RefreshCallback = Future<void> Function();

class Scheduler {
  Timer? _timer;
  Duration? _interval;
  RefreshCallback? _callback;

  bool get isRunning => _timer != null;

  void start({required Duration interval, required RefreshCallback onRefresh}) {
    stop();
    _interval = interval;
    _callback = onRefresh;

    Logger.logInfo("SCHEDULER", "Starting scheduler: every ${interval.inSeconds}s");

    _timer = Timer.periodic(interval, (_) async {
      Logger.logDebug("SCHEDULER", "Executing scheduled task...");
      try {
        if (_callback != null) {
          await _callback!.call();
        }
      } catch (e) {
        Logger.logError("SCHEDULER", "Error in scheduled task: $e");
      }
    });
  }

  void stop() {
    if (_timer != null) {
      Logger.logInfo("SCHEDULER", "Stopping scheduler");
      _timer!.cancel();
      _timer = null;
    }
  }

  void restart() {
    if (_interval != null && _callback != null) {
      start(interval: _interval!, onRefresh: _callback!);
    }
  }
}
