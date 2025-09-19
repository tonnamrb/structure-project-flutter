import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_shell_controller.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../search/search_page.dart';
import '../favorites/favorites_page.dart';
import '../settings/settings_page.dart';

// SC-06 Home + Bottom Nav
class MainShellPage extends GetView<MainShellController> {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = const [
      HomePage(),
      ProfilePage(),
      SearchPage(),
      FavoritesPage(),
      SettingsPage(),
    ];

    final labels = [
      'home'.tr,
      'profile'.tr,
      'search'.tr,
      'favorites'.tr,
      'settings'.tr,
    ];
    final icons = const [
      Icons.home_outlined,
      Icons.person_outline,
      Icons.search,
      Icons.favorite_border,
      Icons.settings,
    ];

    return Obx(
      () => Scaffold(
        body: SafeArea(child: pages[controller.currentIndex.value]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.onTab,
          destinations: List.generate(
            5,
            (i) =>
                NavigationDestination(icon: Icon(icons[i]), label: labels[i]),
          ),
        ),
      ),
    );
  }
}
