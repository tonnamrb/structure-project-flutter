import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/shared_widgets.dart';
import 'oauth_consent_controller.dart';

// WG-01 Google Consent as popup overlay
class OauthConsentPage extends GetView<OauthConsentController> {
	const OauthConsentPage({super.key});

	@override
	Widget build(BuildContext context) {
		WidgetsBinding.instance.addPostFrameCallback((_) {
			showGoogleConsentPopup(
				onContinue: controller.continuePressed,
				onCancel: Get.back,
			);
		});
		return const Scaffold(backgroundColor: Colors.transparent);
	}
}
