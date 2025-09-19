import 'package:get/get.dart';

import '../controllers/register_controller.dart';
import '../services/auth_service.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(authService: Get.find<AuthService>()),
      fenix: true,
    );
  }
}
