import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/controllers/dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  static const _pages = [
    _DashboardPlaceholder(titleKey: 'dashboard.home'),
    _DashboardPlaceholder(titleKey: 'dashboard.profile'),
    _DashboardPlaceholder(titleKey: 'dashboard.search'),
    _DashboardPlaceholder(titleKey: 'dashboard.favorites'),
    _DashboardPlaceholder(titleKey: 'dashboard.settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => _pages[controller.currentIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'dashboard.home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'dashboard.profile'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: 'dashboard.search'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: 'dashboard.favorites'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: 'dashboard.settings'.tr,
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardPlaceholder extends StatelessWidget {
  const _DashboardPlaceholder({required this.titleKey});

  final String titleKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(titleKey.tr, style: theme.textTheme.headlineSmall),
    );
  }
}
