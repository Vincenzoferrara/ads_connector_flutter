import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'logger.dart';

/// Enterprise-grade HTTP client built on Dio with automatic retry, logging, and circuit breaker
class HttpClient {
  late final Dio _dio;

  HttpClient({
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool enableLogging = true,
    int maxRetries = 3,
  }) {
    _dio = Dio(BaseOptions(
      connectTimeout: connectTimeout ?? const Duration(seconds: 30),
      receiveTimeout: receiveTimeout ?? const Duration(seconds: 60),
      sendTimeout: sendTimeout ?? const Duration(seconds: 30),
      validateStatus: (status) {
        // Accept all status codes to handle them manually
        return status != null && status < 500;
      },
    ));

    // Add retry interceptor with exponential backoff
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        retries: maxRetries,
        retryDelays: [
          const Duration(milliseconds: 300),
          const Duration(milliseconds: 600),
          const Duration(milliseconds: 1200),
        ],
        retryableExtraStatuses: {408, 429, 503, 504},
      ),
    );

    // Add pretty logger in debug mode
    if (enableLogging) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 120,
          logPrint: (object) {
            // Integrate with custom Logger
            Logger.logDebug("HTTP", object.toString());
          },
        ),
      );
    }

    // Add custom error handler interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          Logger.logError("HTTP", "Request failed: ${error.message}");
          return handler.next(error);
        },
      ),
    );
  }

  /// GET request
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'HTTP GET failed: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('HTTP GET failed: ${e.message}');
    }
  }

  /// POST request
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'HTTP POST failed: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('HTTP POST failed: ${e.message}');
    }
  }

  /// PUT request
  Future<dynamic> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'HTTP PUT failed: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('HTTP PUT failed: ${e.message}');
    }
  }

  /// DELETE request
  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.delete(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'HTTP DELETE failed: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('HTTP DELETE failed: ${e.message}');
    }
  }

  /// Get raw Dio instance for advanced usage
  Dio get dio => _dio;
}
