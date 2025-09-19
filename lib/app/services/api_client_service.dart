import 'package:dio/dio.dart';

import 'app_config_service.dart';
import 'logger_service.dart';

class ApiClientService {
  ApiClientService({required this.config, required this.logger});

  final AppConfigService config;
  final LoggerService logger;

  Dio? _dio;

  Dio get client => _dio ?? _createDio();

  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl,
        connectTimeout: config.requestTimeout,
        receiveTimeout: config.requestTimeout,
        sendTimeout: config.requestTimeout,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.log('API request ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onError: (error, handler) {
          logger.log('API error', error: error, stackTrace: error.stackTrace);
          return handler.next(error);
        },
      ),
    );
    _dio = dio;
    return dio;
  }
}
