import 'package:get/get.dart';

import '../bindings/dashboard_binding.dart';
import '../bindings/otp_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/register_binding.dart';
import '../bindings/set_password_binding.dart';
import '../bindings/thank_you_binding.dart';
import '../bindings/welcome_binding.dart';
import '../../presentation/page/dashboard/dashboard_page.dart';
import '../../presentation/page/otp/otp_page.dart';
import '../../presentation/page/profile/profile_page.dart';
import '../../presentation/page/register/register_page.dart';
import '../../presentation/page/set_password/set_password_page.dart';
import '../../presentation/page/thank_you/thank_you_page.dart';
import '../../presentation/page/welcome/welcome_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpPage(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppRoutes.setPassword,
      page: () => const SetPasswordPage(),
      binding: SetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.thankYou,
      page: () => const ThankYouPage(),
      binding: ThankYouBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
  ];
}
