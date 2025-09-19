import 'package:get/get.dart';
import 'signup_profile_controller.dart';
import '../../../data/mock_auth_service.dart';
import '../../../data/analytics_service.dart';

class SignupProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MockAuthService());
    Get.put(AnalyticsService());
    Get.put(SignupProfileController(
      Get.find<MockAuthService>(),
      Get.find<AnalyticsService>(),
    ));
  }
}
