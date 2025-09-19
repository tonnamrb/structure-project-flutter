import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../nav/app_routes.dart';

class SettingsController extends GetxController {
  final SharedPreferences prefs;
  SettingsController(this.prefs);

  final themeMode = ThemeMode.system.obs;
  final locale = const Locale('en', 'US').obs;

  final fallbackLocale = const Locale('en', 'US');

  // Simple translations holder here; could be refactored out
  final translations = _AppTranslations();

  static const _keyTheme = 'themeMode';
  static const _keyLang = 'langCode';

  @override
  void onInit() {
    super.onInit();
    final theme = prefs.getString(_keyTheme);
    switch (theme) {
      case 'light':
        themeMode.value = ThemeMode.light;
        break;
      case 'dark':
        themeMode.value = ThemeMode.dark;
        break;
      default:
        themeMode.value = ThemeMode.system;
    }
    final lang = prefs.getString(_keyLang) ?? 'en_US';
    if (lang == 'th_TH') {
      locale.value = const Locale('th', 'TH');
    } else {
      locale.value = const Locale('en', 'US');
    }
  }

  void setTheme(ThemeMode mode) {
    themeMode.value = mode;
    prefs.setString(_keyTheme, mode.name);
    update();
  }

  void setLanguage(Locale l) {
    locale.value = l;
    prefs.setString(_keyLang, l.languageCode == 'th' ? 'th_TH' : 'en_US');
    Get.updateLocale(l);
  }

  Future<void> logout() async {
    try {
      // Sign out from Firebase
      await fb.FirebaseAuth.instance.signOut();
    } catch (_) {
      // Best-effort logout; continue navigation
    }
    // Navigate back to SC-01 (Onboarding) and clear history
    Get.offAllNamed(AppRoutes.onboarding);
  }
}

class _AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'app_title': 'Re:Play',
      'sign_up': 'Sign Up',
      'sign_in': 'Sign In',
      'sign_up_with_google': 'Sign up with Google',
      'already_have_account': 'Already have an account?',
      'continue': 'Continue',
      'cancel': 'Cancel',
      'try_again': 'Try again',
      'ok': 'OK',
      'retry': 'Retry',
      'display_name': 'Displayname',
      'dob': 'Date of birth',
      'gender': 'Gender',
      'female': 'Female',
      'male': 'Male',
      'other': 'Other',
      'accept_terms':
          'I agree that I have read and accepted Re:Play\'s Terms of Service and Privacy Policy.',
    // Split phrases for underlined links
    'agree_prefix': 'I agree that I have read and accepted Re:Play\'s ',
    'terms_of_service': 'Terms of Service',
    'and_connector': ' and ',
    'privacy_policy': 'Privacy Policy',
    'agree_suffix': '.',
    // Mock popup texts
    'terms_mock': 'Mock Terms of Service content goes here for demo purposes.',
    'privacy_mock': 'Mock Privacy Policy content goes here for demo purposes.',
      'please_fill_required': 'Please fill in all required fields.',
      'displayname_taken': 'Displayname already taken.',
      'displayname_invalid':
          'Displayname cannot contain special characters or emoji.',
      'dob_future': 'Date of birth must be in the past.',
      'please_accept_terms':
          'Please accept Terms of Service and Privacy Policy before continuing.',
      'processing': 'Processing… Please wait.',
      'security_failed': 'Security check failed. Please try again.',
      'auth_failed': 'Authentication failed. Please try again.',
      'cannot_without_email': 'Cannot sign up without email permission.',
      'signed_up': 'Signed up!',
      'sign_up_canceled': 'Sign up canceled.',
      'home': 'Home',
      'profile': 'Profile',
      'search': 'Search',
      'favorites': 'Favorites',
      'settings': 'Settings',
      'theme': 'Theme',
      'language': 'Language',
      'logout': 'Logout',
    },
    'th_TH': {
      'app_title': 'Re:Play',
      'sign_up': 'สมัครสมาชิก',
      'sign_in': 'เข้าสู่ระบบ',
      'sign_up_with_google': 'สมัครด้วย Google',
      'already_have_account': 'มีบัญชีอยู่แล้ว?',
      'continue': 'ดำเนินการต่อ',
      'cancel': 'ยกเลิก',
      'try_again': 'ลองอีกครั้ง',
      'ok': 'ตกลง',
      'retry': 'ลองใหม่',
      'display_name': 'ชื่อที่แสดง',
      'dob': 'วันเกิด',
      'gender': 'เพศ',
      'female': 'หญิง',
      'male': 'ชาย',
      'other': 'อื่นๆ',
      'accept_terms':
          'ฉันยอมรับเงื่อนไขการให้บริการและนโยบายความเป็นส่วนตัวของ Re:Play',
    // Split phrases for underlined links
    'agree_prefix': 'ฉันยอมรับ',
    'terms_of_service': 'เงื่อนไขการให้บริการ',
    'and_connector': ' และ ',
    'privacy_policy': 'นโยบายความเป็นส่วนตัว',
    'agree_suffix': ' ของ Re:Play',
    // Mock popup texts
    'terms_mock': 'ตัวอย่างเนื้อหาเงื่อนไขการให้บริการ (Mock) สำหรับการทดสอบ',
    'privacy_mock': 'ตัวอย่างเนื้อหานโยบายความเป็นส่วนตัว (Mock) สำหรับการทดสอบ',
      'please_fill_required': 'กรุณากรอกข้อมูลให้ครบถ้วน',
      'displayname_taken': 'ชื่อที่แสดงถูกใช้แล้ว',
      'displayname_invalid': 'ชื่อที่แสดงต้องไม่มีอักขระพิเศษหรืออีโมจิ',
      'dob_future': 'วันเกิดต้องเป็นอดีต',
      'please_accept_terms': 'กรุณายอมรับเงื่อนไขก่อนดำเนินการต่อ',
      'processing': 'กำลังประมวลผล…',
      'security_failed': 'การตรวจสอบความปลอดภัยล้มเหลว กรุณาลองใหม่',
      'auth_failed': 'ยืนยันตัวตนล้มเหลว กรุณาลองใหม่',
      'cannot_without_email': 'ไม่สามารถสมัครได้หากไม่ได้ให้สิทธิ์อีเมล',
      'signed_up': 'สมัครสำเร็จ!',
      'sign_up_canceled': 'ยกเลิกการสมัคร',
      'home': 'หน้าหลัก',
      'profile': 'โปรไฟล์',
      'search': 'ค้นหา',
      'favorites': 'รายการโปรด',
      'settings': 'ตั้งค่า',
      'theme': 'ธีม',
      'language': 'ภาษา',
      'logout': 'ออกจากระบบ',
    },
  };
}
