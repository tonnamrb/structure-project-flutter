import 'package:flutter_test/flutter_test.dart';
import 'package:app/presentation/page/signup_profile/signup_profile_controller.dart';
import 'package:app/data/mock_auth_service.dart';
import 'package:app/data/analytics_service.dart';

void main() {
  group('SignupProfileController validation', () {
    final c = SignupProfileController(MockAuthService(), AnalyticsService());

    test('rejects special characters in display name', () {
      expect(c.validateDisplayName('abc@'), isNotNull);
    });

    test('rejects duplicate display name', () {
      expect(c.validateDisplayName('admin'), isNotNull);
    });

    test('accepts valid display name', () {
      expect(c.validateDisplayName('GoodName'), isNull);
    });

    test('dob must be in the past', () {
      final future = DateTime.now().add(const Duration(days: 1));
      expect(c.validateDob(future), isNotNull);
    });
  });
}
