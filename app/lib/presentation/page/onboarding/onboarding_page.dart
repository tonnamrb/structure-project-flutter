import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_color.dart';
import '../../../core/config/app_layout.dart';
import '../../widget/shared_widgets.dart';
import 'onboarding_controller.dart';

// SC-01 Onboarding
class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Scaffold(
      body: SafeArea(
        child: PageContainer(
          maxWidth: AppLayout.pageMaxWidthNarrow,
          centerVertically: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              const Center(child: AppLogo(height: 56)),
              const SizedBox(height: 16),
              Text(
                'Replay the music. Relive the moment.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: t.textSecondary),
              ),
              const SizedBox(height: 48),
              SizedBox(
                height: AppLayout.controlHeight,
                child: ElevatedButton(
                  onPressed: controller.goSignup,
                  child: Text('sign_up'.tr),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: AppLayout.controlHeight,
                child: OutlinedButton(
                  onPressed: controller.goSignin,
                  child: Text('sign_in'.tr),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
