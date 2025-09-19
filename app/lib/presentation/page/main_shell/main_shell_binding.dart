import 'package:get/get.dart';
import 'main_shell_controller.dart';
import '../home/home_controller.dart';
import '../profile/profile_controller.dart';
import '../search/search_controller.dart';
import '../favorites/favorites_controller.dart';

class MainShellBinding extends Bindings {
  @override
  void dependencies() {
    // Shell controller
    Get.put(MainShellController());
    // Tab controllers for SC-06 Home and others
    Get.put(HomeController());
    Get.put(ProfileController());
    Get.put(SearchPageController());
    Get.put(FavoritesController());
  }
}
