import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfigService {
  late final String apiBaseUrl;
  late final Duration requestTimeout;

  Future<void> init() async {
    if (!dotenv.isInitialized) {
      try {
        await dotenv.load(fileName: '.env');
      } on Object {
        dotenv.testLoad(fileInput: '');
      }
    }
    apiBaseUrl = dotenv.env['API_BASE_URL'] ?? 'https://api.example.com';
    requestTimeout = Duration(
      seconds: int.tryParse(dotenv.env['API_TIMEOUT_SECONDS'] ?? '30') ?? 30,
    );
  }
}
