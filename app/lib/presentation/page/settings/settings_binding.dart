import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<SettingsController>()) {
      // In main() we already put it, but keep safety here in case of hot restarts
      SharedPreferences.getInstance().then((prefs) {
        if (!Get.isRegistered<SettingsController>()) {
          Get.put(SettingsController(prefs));
        }
      });
    }
  }
}
