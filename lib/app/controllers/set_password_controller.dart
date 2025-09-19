import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation/util/manifest_widget_renderer.dart';
import '../routes/app_routes.dart';

class SetPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isSubmitting = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final isPdpaAccepted = false.obs;

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePdpa(bool value) {
    isPdpaAccepted.value = value;
  }

  Future<void> submit() async {
    final password = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (!isPdpaAccepted.value) {
      ManifestWidgetRenderer.show('WG-09');
      return;
    }

    if (!_validate(password, confirm)) {
      return;
    }

    isSubmitting.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 400));
    isSubmitting.value = false;
    Get.toNamed(AppRoutes.profile);
  }

  bool _validate(String password, String confirm) {
    if (!_isStrongPassword(password)) {
      ManifestWidgetRenderer.show('WG-10');
      return false;
    }
    if (password != confirm) {
      ManifestWidgetRenderer.show('WG-11');
      return false;
    }
    return true;
  }

  bool _isStrongPassword(String password) {
    // Require at least 8 characters with a letter, number, and special character.
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$');
    return regex.hasMatch(password);
  }
}
