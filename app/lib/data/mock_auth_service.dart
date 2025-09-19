import 'dart:async';

// Lightweight mock exceptions to simulate API edge cases
class AuthException implements Exception {
  final String message;
  AuthException([this.message = 'Auth error']);
}

class MissingEmailPermissionException extends AuthException {
  MissingEmailPermissionException() : super('Missing email permission');
}

class CsrfException extends AuthException {
  CsrfException() : super('CSRF validation failed');
}

class DuplicateDisplayNameException extends AuthException {
  DuplicateDisplayNameException() : super('Displayname taken');
}

class DuplicateEmailException extends AuthException {
  DuplicateEmailException() : super('Email already exists');
}

class MockAuthService {
  // Simulate exchanging an OAuth token for user info
  Future<Map<String, dynamic>> exchangeToken(String oauthToken) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // In a richer mock, different tokens could trigger errors.
    // Here we always succeed for simplicity.
    return {'email': 'user@example.com', 'provider_id': 'google-12345'};
  }

  // Simulate server-side account creation with simple duplicate checks
  Future<String> createAccount({
    required String email,
    required String displayName,
    required DateTime dob,
    required String gender,
    required bool consent,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Very simple duplicate checks for demo purposes
    const takenNames = {'Google888', 'admin', 'test'};
    if (takenNames.contains(displayName)) {
      throw DuplicateDisplayNameException();
    }
    if (email.toLowerCase() == 'existing@example.com') {
      throw DuplicateEmailException();
    }
    return 'user-id-abc';
  }
}
