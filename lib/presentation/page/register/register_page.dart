import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/controllers/register_controller.dart';
import '../../../core/config/app_image.dart';
import '../../../core/enum/register_channel.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final headerBg = colors.primary.withValues(alpha: 0.1);

    return Scaffold(
      appBar: AppBar(
        title: Text('register.header'.tr),
        backgroundColor: headerBg,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Obx(
            () {
              final currentChannel = controller.selectedChannel.value;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildChannelToggle(theme, currentChannel),
                    const SizedBox(height: 24),
                    if (currentChannel == RegisterChannel.email)
                      _EmailForm(controller: controller)
                    else if (currentChannel == RegisterChannel.phone)
                      _PhoneForm(controller: controller),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.sendOtp,
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Text('register.sendOtp'.tr),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'register.or'.tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialButton(
                          asset: AppImage.googleIcon,
                          label: 'register.google'.tr,
                          onTap: controller.onGoogleAuth,
                        ),
                        const SizedBox(width: 16),
                        _SocialButton(
                          asset: AppImage.facebookIcon,
                          label: 'register.facebook'.tr,
                          onTap: controller.onFacebookAuth,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Image.asset(
                        AppImage.logoPrimary,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChannelToggle(ThemeData theme, RegisterChannel currentChannel) {
    final colors = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: colors.primary.withValues(alpha: 0.2), width: 2),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: RegisterChannel.values.take(2).map((channel) {
          final isSelected = channel == currentChannel;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.selectChannel(channel),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary : colors.surface,
                  borderRadius: BorderRadius.circular(28),
                ),
                alignment: Alignment.center,
                child: Text(
                  channel == RegisterChannel.email
                      ? 'register.email'.tr
                      : 'register.phone'.tr,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isSelected ? colors.onPrimary : colors.primary,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _EmailForm extends StatelessWidget {
  const _EmailForm({required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('register.email'.tr, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 12),
        TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'register.enterEmailHint'.tr,
          ),
        ),
      ],
    );
  }
}

class _PhoneForm extends StatelessWidget {
  const _PhoneForm({required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('register.phone'.tr, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 12),
        TextField(
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'register.enterPhoneHint'.tr,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.asset,
    required this.label,
    required this.onTap,
  });

  final String asset;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colors.primary, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(asset, width: 32, height: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}


