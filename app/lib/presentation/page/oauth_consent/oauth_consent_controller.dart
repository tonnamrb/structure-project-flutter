import 'package:get/get.dart';
import '../../nav/app_routes.dart';
import '../../../data/firebase_google_auth_service.dart';
import '../../../data/analytics_service.dart';
import '../../widget/shared_widgets.dart';

class OauthConsentController extends GetxController {
  OauthConsentController(this._googleAuth, this._analytics);
  final FirebaseGoogleAuthService _googleAuth;
  final AnalyticsService _analytics;

  Future<void> continuePressed() async {
    try {
      showProcessingModal('processing'.tr);
      final res = await _googleAuth.signInWithGoogle();
      final masked = _maskEmail(res.email);
      _analytics.logEvent('OAuth ตอบกลับ', params: {
        'email': masked,
        'result': 'success',
      });
      hideDialogIfAny();
      Get.offNamed(
        AppRoutes.signupProfile,
        arguments: {'token': res.user.uid, 'email': res.email},
      );
    } on GoogleAuthCanceled {
      _analytics.logEvent('OAuth ตอบกลับ', params: {
        'email': null,
        'result': 'canceled',
      });
      hideDialogIfAny();
      showToast('sign_up_canceled'.tr);
    } on MissingEmailPermission {
      _analytics.logEvent('OAuth ตอบกลับ', params: {
        'email': null,
        'result': 'missing_email_permission',
      });
      hideDialogIfAny();
      await showPopupTryAgainCancel(
        title: 'Error',
        message: 'cannot_without_email'.tr,
        cancelText: 'cancel'.tr,
        confirmText: 'try_again'.tr,
      );
    } catch (_) {
      _analytics.logEvent('OAuth ตอบกลับ', params: {
        'email': null,
        'result': 'failed',
      });
      hideDialogIfAny();
      showAuthFailedToastWithRetry('auth_failed'.tr);
    }
  }

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return '***';
    final name = parts[0];
    final domain = parts[1];
    if (name.isEmpty) return '***@$domain';
    final head = name[0];
    return '$head***@$domain';
  }
}
