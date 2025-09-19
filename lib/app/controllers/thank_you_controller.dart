import 'package:get/get.dart';

import '../routes/app_routes.dart';

class ThankYouController extends GetxController {
  void goToDashboard() {
    Get.offAllNamed(AppRoutes.dashboard);
  }
}
