import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/config/app_config.dart';
import '../../core/enum/register_channel.dart';
import '../../presentation/util/manifest_widget_renderer.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class OtpController extends GetxController {
  OtpController({required this.authService});

  final AuthService authService;

  final otpController = TextEditingController();
  final isVerifying = false.obs;
  final resendCountdown = AppConfig.otpResendSeconds.obs;
  RegisterChannel channel = RegisterChannel.email;
  final RxString targetValue = ''.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? const {};
    final channelName = args['channel'] as String? ?? RegisterChannel.email.name;
    channel = RegisterChannel.values.firstWhere(
      (item) => item.name == channelName,
      orElse: () => RegisterChannel.email,
    );
    targetValue.value = args['value'] as String? ?? '';
    _startTimer();
  }

  @override
  void onClose() {
    otpController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  Future<void> verifyOtp() async {
    final code = otpController.text.trim();
    if (code.length != AppConfig.otpLength) {
      ManifestWidgetRenderer.show('WG-05');
      return;
    }

    isVerifying.value = true;
    try {
      final success = await authService.verifyOtp(code);
      if (!success) {
        ManifestWidgetRenderer.show('WG-05');
        return;
      }
      Get.toNamed(AppRoutes.setPassword);
    } catch (error) {
      ManifestWidgetRenderer.show('WG-04');
    } finally {
      isVerifying.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (resendCountdown.value > 0) {
      return;
    }
    try {
      await authService.sendOtp(channel: channel.name, value: targetValue.value);
      _startTimer();
      if (channel == RegisterChannel.email) {
        ManifestWidgetRenderer.show('WG-18');
      } else {
        ManifestWidgetRenderer.show('WG-14');
      }
    } catch (error) {
      ManifestWidgetRenderer.show('WG-04');
    }
  }

  void _startTimer() {
    resendCountdown.value = AppConfig.otpResendSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value <= 0) {
        timer.cancel();
      } else {
        resendCountdown.value--;
      }
    });
  }
}
