import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('settings'.tr, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text('theme'.tr),
          Obx(
            () => SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
                ButtonSegment(value: ThemeMode.system, label: Text('System')),
              ],
              selected: {controller.themeMode.value},
              onSelectionChanged: (s) => controller.setTheme(s.first),
            ),
          ),
          const SizedBox(height: 24),
          Text('language'.tr),
          Obx(
            () => SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'en', label: Text('EN')),
                ButtonSegment(value: 'th', label: Text('TH')),
              ],
              selected: {controller.locale.value.languageCode},
              onSelectionChanged: (s) => controller.setLanguage(
                s.first == 'th'
                    ? const Locale('th', 'TH')
                    : const Locale('en', 'US'),
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
            label: Text('logout'.tr),
          ),
        ],
      ),
    );
  }
}
