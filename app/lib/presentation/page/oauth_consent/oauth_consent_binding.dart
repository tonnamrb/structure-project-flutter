import 'package:get/get.dart';
import 'oauth_consent_controller.dart';
import '../../../data/firebase_google_auth_service.dart';
import '../../../data/analytics_service.dart';

class OauthConsentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseGoogleAuthService());
    Get.put(AnalyticsService());
    Get.put(OauthConsentController(
      Get.find<FirebaseGoogleAuthService>(),
      Get.find<AnalyticsService>(),
    ));
  }
}
