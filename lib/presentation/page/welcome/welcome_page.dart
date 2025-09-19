import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/controllers/welcome_controller.dart';
import '../../../core/config/app_image.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(48),
                  border: Border.all(color: colors.primary, width: 3),
                ),
                padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppImage.logoPrimary,
                      width: 240,
                      height: 240,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'ALUMNI\nMANAGEMENT\nSYSTEM',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(height: 1.2),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'CONNECT. COLLABORATE. CONTINUE.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.onLoginTap,
                  child: Text('welcome.login'.tr),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.onRegisterTap,
                  child: Text('welcome.register'.tr),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
