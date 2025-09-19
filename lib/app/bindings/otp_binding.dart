import 'package:get/get.dart';

import '../controllers/otp_controller.dart';
import '../services/auth_service.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(
      () => OtpController(authService: Get.find<AuthService>()),
      fenix: true,
    );
  }
}
