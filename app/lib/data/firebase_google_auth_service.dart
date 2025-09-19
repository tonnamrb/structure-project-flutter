import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart' show kIsWeb;

class GoogleAuthResult {
  GoogleAuthResult({required this.email, required this.user});
  final String email;
  final fb.User user;
}

class GoogleAuthFailed implements Exception {
  GoogleAuthFailed(this.message);
  final String message;
}

class GoogleAuthCanceled implements Exception {}

class MissingEmailPermission implements Exception {}

/// Handles Google Sign-In using Firebase Auth for web and mobile.
class FirebaseGoogleAuthService {
  FirebaseGoogleAuthService({fb.FirebaseAuth? auth})
    : _auth = auth ?? fb.FirebaseAuth.instance;

  final fb.FirebaseAuth _auth;

  Future<GoogleAuthResult> signInWithGoogle() async {
    try {
      fb.UserCredential credential;
      final provider = fb.GoogleAuthProvider();
      provider.addScope('email');
      provider.setCustomParameters({'prompt': 'select_account'});
      if (kIsWeb) {
        credential = await _auth.signInWithPopup(provider);
      } else {
        credential = await _auth.signInWithProvider(provider);
      }
      final user = credential.user;
      final email = user?.email;
      if (user == null) throw GoogleAuthFailed('No user returned');
      if (email == null || email.isEmpty) throw MissingEmailPermission();
      return GoogleAuthResult(email: email, user: user);
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == 'user-cancelled' ||
          e.code == 'web-context-canceled' ||
          e.code == 'canceled' ||
          e.code == 'popup-closed-by-user') {
        throw GoogleAuthCanceled();
      }
      throw GoogleAuthFailed(e.message ?? 'Auth failed');
    }
  }
}
