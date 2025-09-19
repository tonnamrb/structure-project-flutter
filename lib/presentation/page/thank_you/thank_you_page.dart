import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/controllers/thank_you_controller.dart';

class ThankYouPage extends GetView<ThankYouController> {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('thankYou.header'.tr, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 16),
                Text(
                  'thankYou.body'.tr,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: controller.goToDashboard,
                  child: Text('thankYou.goHome'.tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
