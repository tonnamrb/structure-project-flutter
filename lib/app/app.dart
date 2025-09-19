import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/initial_binding.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import '../core/config/app_theme.dart';
import '../core/config/app_translation.dart';

class StructureProjectApp extends StatelessWidget {
  const StructureProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Alumni Management System',
      debugShowCheckedModeBanner: false,
      translations: AppTranslation(),
      locale: const Locale('th', 'TH'),
      fallbackLocale: const Locale('en', 'US'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.fade,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.welcome,
      getPages: AppPages.routes,
    );
  }
}
