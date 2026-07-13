
typedef LogListener = void Function(String level, String tag, String message);

class Logger {
  static final List<LogListener> _listeners = [];
  static bool enabled = true;
  static String minLevel = "DEBUG";

  static final _levels = {
    "DEBUG": 0,
    "INFO": 1,
    "WARN": 2,
    "ERROR": 3,
  };

  static void addListener(LogListener listener) {
    _listeners.add(listener);
  }

  static void removeListener(LogListener listener) {
    _listeners.remove(listener);
  }

  static void logDebug(String tag, String message) {
    _emit("DEBUG", tag, message);
  }

  static void logInfo(String tag, String message) {
    _emit("INFO", tag, message);
  }

  static void logWarn(String tag, String message) {
    _emit("WARN", tag, message);
  }

  static void logError(String tag, String message) {
    _emit("ERROR", tag, message);
  }

  static void log(String message, {String level = "INFO"}) {
    _emit(level, "AdsConnector", message);
  }

  static void _emit(String level, String tag, String message) {
    if (!enabled) return;
    if (_levels[level]! < _levels[minLevel]!) return;

    for (var listener in _listeners) {
      listener(level, tag, message);
    }
  }
}
