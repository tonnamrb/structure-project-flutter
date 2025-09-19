import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../nav/app_routes.dart';
import '../../../data/mock_auth_service.dart';
import '../../../data/analytics_service.dart';
import '../../widget/shared_widgets.dart';

class SignupProfileController extends GetxController {
  SignupProfileController(this._auth, this._analytics);

  final MockAuthService _auth;
  final AnalyticsService _analytics;
  final displayNameCtrl = TextEditingController();
  final dob = Rxn<DateTime>();
  final gender = ''.obs; // 'Female' | 'Male' | 'Other'
  final acceptTerms = false.obs;
  final acceptTermsError = ''.obs; // WG-06 inline
  final isSubmitting = false.obs;
  String? _email; // from OAuth step
  final dobError = ''.obs; // WG-06 inline for DOB

  final formKey = GlobalKey<FormState>();

  // Mock existing display names
  final takenNames = {'Google888', 'admin', 'test'}.obs;

  bool _isValidDisplayName(String name) {
    final sanitized = name.replaceAll(RegExp(r"[^A-Za-z0-9 _.-]"), '');
    return sanitized.length == name.length;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      final maybeEmail = args['email'];
      if (maybeEmail is String && maybeEmail.isNotEmpty) {
        _email = maybeEmail;
      }
    }
  }

  String? validateDisplayName(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'please_fill_required'.tr;
    if (v.length > 30) {
      // Auto-trim to 30 without message per spec TC01-8
      displayNameCtrl.text = v.substring(0, 30);
      displayNameCtrl.selection = TextSelection.fromPosition(
        TextPosition(offset: 30),
      );
    }
    if (!_isValidDisplayName(v)) return 'displayname_invalid'.tr;
    if (takenNames.contains(v)) return 'displayname_taken'.tr; // WG-07
    return null;
  }

  String? validateDob(DateTime? date) {
    if (date == null) return 'please_fill_required'.tr;
    final now = DateTime.now();
    if (!date.isBefore(DateTime(now.year, now.month, now.day))) {
      return 'dob_future'.tr;
    }
    return null;
  }

  String? validateGender(String? value) {
    if ((value ?? '').isEmpty) return 'please_fill_required'.tr;
    return null;
  }

  Future<void> submit() async {
    final email = _email;
    if (email == null || email.isEmpty) {
      // WG-05 popup
      await showPopupTryAgainCancel(
        title: 'Error',
        message: 'cannot_without_email'.tr,
        cancelText: 'cancel'.tr,
        confirmText: 'try_again'.tr,
      );
      return;
    }
    final nameError = validateDisplayName(displayNameCtrl.text);
    final dobErr = validateDob(dob.value);
    final genderError = validateGender(gender.value);
    // Update inline errors
    dobError.value = dobErr ?? '';
    acceptTermsError.value = acceptTerms.value ? '' : 'please_accept_terms'.tr;

    // Trigger built-in Form validators for text/dropdown fields
    formKey.currentState?.validate();

    if (nameError != null ||
        dobErr != null ||
        genderError != null ||
        !acceptTerms.value) {
      // Strict inline-only: do not show toast
      return;
    }

    isSubmitting.value = true;
    // Event: Submit โปรไฟล์สมัคร (SC-04.btn-continue)
    _analytics.logEvent('Submit โปรไฟล์สมัคร', params: {
      'displayname': displayNameCtrl.text.trim(),
      'DOB': dob.value?.toIso8601String(),
      'gender': gender.value,
      'consent': acceptTerms.value,
    });
    // WG-08 processing modal
    showProcessingModal('processing'.tr);
    try {
      final userId = await _auth.createAccount(
        email: email,
        displayName: displayNameCtrl.text.trim(),
        dob: dob.value!,
        gender: gender.value,
        consent: acceptTerms.value,
      );
      isSubmitting.value = false;
      hideDialogIfAny();
      // Event: สมัครสำเร็จ (SC-06.toast-success)
      _analytics.logEvent('สมัครสำเร็จ', params: {
        'user_id': userId,
        'provider_id': 'google',
        'session_id': 'mock-session',
      });
      Get.offAllNamed(AppRoutes.main);
      // WG-02 success toast
      showSuccessToast('signed_up'.tr);
    } on DuplicateDisplayNameException {
      isSubmitting.value = false;
      hideDialogIfAny();
      // WG-07 inline: mark as taken and trigger validator
      takenNames.add(displayNameCtrl.text.trim());
      formKey.currentState?.validate();
    } on DuplicateEmailException {
      // Redirect to home silently if email already exists per spec
      isSubmitting.value = false;
      hideDialogIfAny();
      Get.offAllNamed(AppRoutes.main);
    } catch (_) {
      isSubmitting.value = false;
      hideDialogIfAny();
      // WG-04 toast with Retry button (right)
      showAuthFailedToastWithRetry('auth_failed'.tr);
    }
  }
}
