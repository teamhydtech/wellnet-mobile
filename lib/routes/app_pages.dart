import 'package:get/get.dart';
import 'package:wellnet/target_settings/target-setting_screen.dart';
import '../assesments/self-assesments_screen.dart';
import '../auth/parental-email-verification_screen.dart';
import '../auth/parental-success-email_screen.dart';
import '../auth/personal-email-verification_screen.dart';
import '../auth/personal-success-email_screen.dart';
import '../auth/sign-in_screen.dart';
import '../auth/sign-up_screen.dart';
import '../welcome_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.welcome, page: () => const WelcomeScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignUpScreen()),
    GetPage(name: AppRoutes.signin, page: () => const SignInScreen()),
    GetPage(name: AppRoutes.parentalVerification, page: () => const parentalVerificationScreen()),
    GetPage(name: AppRoutes.successParentalVerification, page: () => const successParentalVerificationScreen()),
    GetPage(name: AppRoutes.personalVerification, page: () => const personalVerificationScreen()),
    GetPage(name: AppRoutes.successPersonalVerification, page: () => const successPersonalVerificationScreen()),
    GetPage(name: AppRoutes.selfAssesment, page: () => const SelfAssessmentScreen()),
    GetPage(name: AppRoutes.targetSettings, page: () => const TargetSettingsPage()),
  ];
}
