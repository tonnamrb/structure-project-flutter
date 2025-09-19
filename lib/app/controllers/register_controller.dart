import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/config/app_config.dart';
import '../../core/enum/register_channel.dart';
import '../../presentation/util/manifest_widget_renderer.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class RegisterController extends GetxController {
  RegisterController({required this.authService});

  final AuthService authService;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final isLoading = false.obs;
  final selectedChannel = RegisterChannel.email.obs;

  Timer? _otpCountdownTimer;
  final otpRemaining = AppConfig.otpResendSeconds.obs;

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    _otpCountdownTimer?.cancel();
    super.onClose();
  }


  void selectChannel(RegisterChannel channel) {
    selectedChannel.value = channel;
  }

  Future<void> sendOtp() async {
    final channel = selectedChannel.value;

    final value = channel == RegisterChannel.email
        ? emailController.text.trim()
        : phoneController.text.trim();

    if (!_validateInput(channel, value)) {
      return;
    }

    isLoading.value = true;
    try {
      await authService.sendOtp(channel: channel.name, value: value);
      _startCountdown();
      Get.toNamed(
        AppRoutes.otp,
        arguments: {'channel': channel.name, 'value': value},
      );
    } catch (error) {
      ManifestWidgetRenderer.show('WG-04');
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInput(RegisterChannel channel, String value) {
    if (channel == RegisterChannel.email) {
      if (value.isEmpty) {
        ManifestWidgetRenderer.show('WG-01');
        return false;
      }
      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
      if (!emailRegex.hasMatch(value)) {
        ManifestWidgetRenderer.show('WG-02');
        return false;
      }
      if (value.toLowerCase() == 'duplicate@example.com') {
        ManifestWidgetRenderer.show('WG-03');
        return false;
      }
    } else if (channel == RegisterChannel.phone) {
      if (value.isEmpty) {
        ManifestWidgetRenderer.show('WG-06');
        return false;
      }
      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
        ManifestWidgetRenderer.show('WG-07');
        return false;
      }
      if (value == '0999999999') {
        ManifestWidgetRenderer.show('WG-03');
        return false;
      }
    }
    return true;
  }

  void onGoogleAuth() {
    _showSocialModal('register.googleAuthMessage'.tr);
  }

  void onFacebookAuth() {
    _showSocialModal('register.facebookAuthMessage'.tr);
  }

  void _startCountdown() {
    otpRemaining.value = AppConfig.otpResendSeconds;
    _otpCountdownTimer?.cancel();
    _otpCountdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpRemaining.value <= 0) {
        timer.cancel();
      } else {
        otpRemaining.value--;
      }
    });
  }

  void _showSocialModal(String message) {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back<void>(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Get.textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
