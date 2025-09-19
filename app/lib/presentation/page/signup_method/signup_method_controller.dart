import 'package:get/get.dart';
import '../../../data/analytics_service.dart';
import '../../widget/shared_widgets.dart';
import '../oauth_consent/oauth_consent_controller.dart';

class SignupMethodController extends GetxController {
  SignupMethodController(this._analytics);

  final AnalyticsService _analytics;
  final isLoading = false.obs;

  Future<void> signUpWithGoogle() async {
    if (isLoading.value) return;
    isLoading.value = true;
    // Event: เริ่มสมัคร (SC-02.btn-google)
    _analytics.logEvent('เริ่มสมัคร', params: {'trigger': 'SC-02.btn-google'});
    // Per requirement: show WG-01 as overlay (background visible); OAuth runs on Continue
    final oauth = Get.find<OauthConsentController>();
    await showGoogleConsentPopup(
      onContinue: oauth.continuePressed,
      onCancel: () {},
    );
    isLoading.value = false;
  }

  // no-op helpers removed; masking handled in OAuth controller after result
}
