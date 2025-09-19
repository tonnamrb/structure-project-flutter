import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/app_color.dart';
import 'firebase_options.dart';

import 'presentation/nav/app_routes.dart';
import 'presentation/nav/app_pages.dart';
import 'presentation/page/settings/settings_binding.dart';
import 'presentation/page/settings/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, st) {
    // If Firebase init fails (likely missing .env keys), show a friendly page.
    debugPrint('Firebase init failed: $e\n$st');
    runApp(StartupErrorApp(error: e.toString()));
    return;
  }
  // Preload SharedPreferences for settings
  final prefs = await SharedPreferences.getInstance();
  // Inject SettingsController early for theme/lang persistence
  Get.put(SettingsController(prefs));
  runApp(const MainApp());
}

class MainApp extends GetView<SettingsController> {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'app_title'.tr,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: controller.themeMode.value,
        initialRoute: AppRoutes.onboarding,
        getPages: AppPages.pages,
        initialBinding: SettingsBinding(),
        translations: controller.translations,
        locale: controller.locale.value,
        fallbackLocale: controller.fallbackLocale,
      ),
    );
  }
}

class StartupErrorApp extends StatelessWidget {
  const StartupErrorApp({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Startup Error')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Firebase initialization failed. Please check your .env configuration.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(error),
              const SizedBox(height: 16),
              const Text('Required keys:'),
              const SizedBox(height: 8),
              const Text(
                '- FIREBASE_PROJECT_ID\n- FIREBASE_MESSAGING_SENDER_ID\n- FIREBASE_STORAGE_BUCKET (optional)\n\nWeb:\n- FIREBASE_WEB_API_KEY\n- FIREBASE_WEB_APP_ID\n- FIREBASE_AUTH_DOMAIN (optional)\n- FIREBASE_MEASUREMENT_ID (optional)\n\nAndroid:\n- FIREBASE_ANDROID_API_KEY\n- FIREBASE_ANDROID_APP_ID\n\niOS:\n- FIREBASE_IOS_API_KEY\n- FIREBASE_IOS_APP_ID\n- FIREBASE_IOS_BUNDLE_ID\n- FIREBASE_IOS_CLIENT_ID (optional)',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
