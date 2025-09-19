import 'package:get/get.dart';
import 'signup_method_controller.dart';
import '../../../data/analytics_service.dart';
import '../../../data/firebase_google_auth_service.dart';
import '../oauth_consent/oauth_consent_controller.dart';

class SignupMethodBinding extends Bindings {
  @override
  void dependencies() {
    // Provide services needed for WG-01 flow executed from this page
    Get.put(AnalyticsService());
    Get.put(FirebaseGoogleAuthService());
    Get.put(OauthConsentController(
      Get.find<FirebaseGoogleAuthService>(),
      Get.find<AnalyticsService>(),
    ));
    Get.put(SignupMethodController(
      Get.find<AnalyticsService>(),
    ));
  }
}
