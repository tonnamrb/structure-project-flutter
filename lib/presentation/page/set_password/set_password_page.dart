import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/controllers/set_password_controller.dart';
import '../../util/manifest_widget_renderer.dart';

class SetPasswordPage extends GetView<SetPasswordController> {
  const SetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('password.header'.tr),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('password.header'.tr, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.obscurePassword.value,
                  decoration: InputDecoration(
                    hintText: 'password.hint'.tr,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () => controller.obscurePassword.toggle(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: controller.obscureConfirmPassword.value,
                  decoration: InputDecoration(
                    hintText: 'password.confirmHint'.tr,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureConfirmPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () => controller.obscureConfirmPassword.toggle(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _PasswordRequirements(controller: controller),
              const SizedBox(height: 16),
              Obx(
                () => CheckboxListTile(
                  value: controller.isPdpaAccepted.value,
                  onChanged: (value) => controller.togglePdpa(value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  title: Text('password.acceptPolicy'.tr),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => ManifestWidgetRenderer.show(
                    'WG-08',
                    actionHandlers: {
                      'btn-accept': () => controller.togglePdpa(true),
                      'btn-decline': () => controller.togglePdpa(false),
                    },
                  ),
                  child: Text('password.viewPdpa'.tr),
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isSubmitting.value
                        ? null
                        : controller.submit,
                    child: controller.isSubmitting.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('password.submit'.tr),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordRequirements extends StatelessWidget {
  const _PasswordRequirements({required this.controller});

  final SetPasswordController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller.passwordController,
      builder: (context, value, _) {
        final password = value.text;
        final hasMinLength = password.length >= 8;
        final hasRequiredMix = _hasRequiredMix(password);

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.primary.withValues(alpha: 0.2), width: 1.5),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'password.conditions.title'.tr,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              _RequirementItem(
                met: hasMinLength,
                label: 'password.conditions.length'.tr,
              ),
              const SizedBox(height: 8),
              _RequirementItem(
                met: hasRequiredMix,
                label: 'password.conditions.mix'.tr,
              ),
            ],
          ),
        );
      },
    );
  }

  bool _hasRequiredMix(String password) {
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    final hasNumber = RegExp(r'\d').hasMatch(password);
    final hasSpecial = RegExp(r'[^A-Za-z\d]').hasMatch(password);
    return hasLetter && hasNumber && hasSpecial;
  }
}

class _RequirementItem extends StatelessWidget {
  const _RequirementItem({required this.met, required this.label});

  final bool met;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final metColor = colors.primary;
    final unmetColor = colors.onSurface.withValues(alpha: 0.6);

    return Row(
      children: [
        Icon(
          met ? Icons.check_circle : Icons.radio_button_unchecked,
          color: met ? metColor : unmetColor,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: met ? metColor : colors.onSurface,
              fontWeight: met ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
