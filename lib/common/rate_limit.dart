
import 'dart:async';
import 'logger.dart';

class RateLimitManager {
  int _failureCount = 0;
  bool _circuitOpen = false;
  DateTime? _circuitResetTime;

  Future<T> execute<T>(Future<T> Function() action) async {
    if (_circuitOpen && _circuitResetTime != null) {
      if (DateTime.now().isBefore(_circuitResetTime!)) {
        Logger.log("[RATE LIMIT] Circuit open, rejecting request");
        throw Exception("Rate limit circuit breaker active");
      } else {
        _circuitOpen = false;
        _failureCount = 0;
      }
    }

    try {
      final result = await action();
      _failureCount = 0;
      return result;
    } catch (e) {
      _failureCount++;
      Logger.log("[RATE LIMIT] failure count = $_failureCount");

      if (_failureCount >= 3) {
        _circuitOpen = true;
        _circuitResetTime = DateTime.now().add(Duration(seconds: 30));
        Logger.log("[RATE LIMIT] Circuit opened for 30 seconds");
      }

      final delay = Duration(
        milliseconds: 300 * (1 << (_failureCount > 5 ? 5 : _failureCount))
      );
      Logger.log("[RATE LIMIT] Retrying in ${delay.inMilliseconds} ms");
      await Future.delayed(delay);

      return await action();
    }
  }
}
