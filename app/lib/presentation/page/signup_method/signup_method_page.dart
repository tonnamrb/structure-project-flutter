import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_color.dart';
import '../../../core/config/app_layout.dart';
import '../../widget/shared_widgets.dart';
import 'signup_method_controller.dart';

// SC-02 Sign Up methods
class SignupMethodPage extends GetView<SignupMethodController> {
  const SignupMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Scaffold(
      appBar: AppBar(title: Text('sign_up'.tr)),
      body: SafeArea(
        child: PageContainer(
          maxWidth: AppLayout.pageMaxWidthNarrow,
          centerVertically: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'sign_up'.tr,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: AppLayout.controlHeight,
                child: GoogleAuthButton(
                  text: 'sign_up_with_google'.tr,
                  onPressed: controller.signUpWithGoogle,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'already_have_account'.tr,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: t.textMuted),
                    ),
                  ),
                  TextButton(
                    onPressed: Get.back,
                    child: Text(
                      'sign_in'.tr,
                      style: TextStyle(color: t.textMuted),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
