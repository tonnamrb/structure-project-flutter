import 'package:get/get.dart';
import '../../nav/app_routes.dart';

class OnboardingController extends GetxController {
  void goSignup() => Get.toNamed(AppRoutes.signupMethod);
  void goSignin() {
    // Not in scope; navigate to signup method for now
    Get.toNamed(AppRoutes.signupMethod);
  }
}
