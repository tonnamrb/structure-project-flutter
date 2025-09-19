import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/controllers/otp_controller.dart';
import '../../../core/config/app_config.dart';

class OtpPage extends GetView<OtpController> {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('otp.header'.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                'otp.subHeader'.tr,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Obx(
                () => Text(
                  controller.targetValue.value,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 32),
              _OtpInput(controller: controller),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isVerifying.value
                        ? null
                        : controller.verifyOtp,
                    child: controller.isVerifying.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('otp.confirm'.tr),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () {
                  final seconds = controller.resendCountdown.value;
                  return Column(
                    children: [
                      Text(
                        '${'otp.timerPrefix'.tr} ${seconds}s',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: seconds == 0 ? controller.resendOtp : null,
                        child: Text('otp.resend'.tr),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Get.back<void>(),
                child: Text('otp.changeChannel'.tr),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpInput extends StatelessWidget {
  const _OtpInput({required this.controller});

  final OtpController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: theme.colorScheme.primary, width: 2),
      ),
      child: TextField(
        controller: controller.otpController,
        maxLength: AppConfig.otpLength,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: theme.textTheme.headlineMedium,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintText: '0' * AppConfig.otpLength,
        ),
      ),
    );
  }
}
