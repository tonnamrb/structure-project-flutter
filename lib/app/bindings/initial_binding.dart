import 'package:get/get.dart';

import '../services/api_client_service.dart';
import '../services/app_config_service.dart';
import '../services/auth_service.dart';
import '../services/logger_service.dart';
import '../services/secure_storage_service.dart';

class InitialBinding extends Bindings {
  static bool _initialized = false;

  static Future<void> ensureInitialized() async {
    if (_initialized) {
      return;
    }
    final appConfig = AppConfigService();
    await appConfig.init();

    final logger = LoggerService();
    final secureStorage = SecureStorageService();
    await secureStorage.init();

    final apiClient = ApiClientService(config: appConfig, logger: logger);
    final authService = AuthService(
      apiClient: apiClient,
      storage: secureStorage,
      logger: logger,
    );

    Get.put<AppConfigService>(appConfig, permanent: true);
    Get.put<LoggerService>(logger, permanent: true);
    Get.put<SecureStorageService>(secureStorage, permanent: true);
    Get.put<ApiClientService>(apiClient, permanent: true);
    Get.put<AuthService>(authService, permanent: true);

    _initialized = true;
  }

  @override
  void dependencies() {
    if (!_initialized) {
      ensureInitialized();
    }
  }
}
