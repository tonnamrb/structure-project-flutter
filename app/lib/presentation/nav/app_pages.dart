import 'package:get/get.dart';
import '../page/onboarding/onboarding_binding.dart';
import '../page/onboarding/onboarding_page.dart';
import '../page/signup_method/signup_method_binding.dart';
import '../page/signup_method/signup_method_page.dart';
import '../page/signup_profile/signup_profile_binding.dart';
import '../page/signup_profile/signup_profile_page.dart';
import '../page/main_shell/main_shell_binding.dart';
import '../page/main_shell/main_shell_page.dart';
// WG-01 overlay is invoked directly; oauth_consent route removed
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.signupMethod,
      page: () => const SignupMethodPage(),
      binding: SignupMethodBinding(),
    ),
    GetPage(
      name: AppRoutes.signupProfile,
      page: () => const SignupProfilePage(),
      binding: SignupProfileBinding(),
    ),
    // WG-01 consent is now shown as an overlay (Get.generalDialog) from SignupMethodPage.
    // Keep route removed to prevent full-screen navigation that hides background.
    GetPage(
      name: AppRoutes.main,
      page: () => const MainShellPage(),
      binding: MainShellBinding(),
    ),
  ];
}
