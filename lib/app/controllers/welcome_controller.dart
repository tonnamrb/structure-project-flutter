import 'package:get/get.dart';

import '../routes/app_routes.dart';

class WelcomeController extends GetxController {
  void onLoginTap() {
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void onRegisterTap() {
    Get.offNamed(AppRoutes.register);
  }
}
