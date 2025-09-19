import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import '../../../core/config/app_color.dart';
import '../../../core/config/app_layout.dart';
import '../../widget/shared_widgets.dart';
import 'signup_profile_controller.dart';

// SC-04 Sign up with Google - Step 2
class SignupProfilePage extends GetView<SignupProfileController> {
  const SignupProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Scaffold(
      appBar: AppBar(title: Text('sign_up'.tr)),
      body: PageContainer(
        maxWidth: AppLayout.pageMaxWidthNarrow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'sign_up'.tr,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: controller.displayNameCtrl,
                    decoration: InputDecoration(
                      labelText: 'display_name'.tr,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    validator: (_) => controller.validateDisplayName(
                      controller.displayNameCtrl.text,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => InkWell(
                      onTap: () async {
                        final now = DateTime.now();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(now.year - 18),
                          firstDate: DateTime(1900),
                          lastDate: now,
                        );
                        if (picked != null) controller.dob.value = picked;
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'dob'.tr,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        child: Text(
                          controller.dob.value == null
                              ? '--'
                              : '${controller.dob.value!.year}-${controller.dob.value!.month.toString().padLeft(2, '0')}-${controller.dob.value!.day.toString().padLeft(2, '0')}',
                          style: TextStyle(color: t.textPrimary),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.dobError.value.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              controller.dobError.value,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      initialValue: controller.gender.value.isEmpty
                          ? null
                          : controller.gender.value,
                      items: [
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('female'.tr),
                        ),
                        DropdownMenuItem(value: 'Male', child: Text('male'.tr)),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text('other'.tr),
                        ),
                      ],
                      onChanged: (v) => controller.gender.value = v ?? '',
                      decoration: InputDecoration(
                        labelText: 'gender'.tr,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2,
                        ),
                      ),
                      validator: (_) =>
                          controller.validateGender(controller.gender.value),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: controller.acceptTerms.value,
                      onChanged: (v) =>
                          controller.acceptTerms.value = v ?? false,
                      title: RichText(
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: t.textPrimary),
                          children: [
                            TextSpan(text: 'agree_prefix'.tr),
                            TextSpan(
                              text: 'terms_of_service'.tr,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => showOkPopup(
                                      title: 'terms_of_service'.tr,
                                      message: 'terms_mock'.tr,
                                    ),
                            ),
                            TextSpan(text: 'and_connector'.tr),
                            TextSpan(
                              text: 'privacy_policy'.tr,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => showOkPopup(
                                      title: 'privacy_policy'.tr,
                                      message: 'privacy_mock'.tr,
                                    ),
                            ),
                            TextSpan(text: 'agree_suffix'.tr),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.acceptTermsError.value.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              controller.acceptTermsError.value,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 18),
                  Obx(
                    () => SizedBox(
                      height: AppLayout.controlHeight,
                      child: ElevatedButton(
                        onPressed: controller.isSubmitting.value
                            ? null
                            : controller.submit,
                        child: Text('continue'.tr),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('already_have_account'.tr),
                      const SizedBox(width: 6),
                      TextButton(
                        onPressed: Get.back,
                        child: Text('sign_in'.tr),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
