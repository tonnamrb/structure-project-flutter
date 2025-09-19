import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Firebase options loader using .env values.
///
/// Provide the following keys in your .env (per platform):
///
/// Common:
/// - FIREBASE_PROJECT_ID
/// - FIREBASE_STORAGE_BUCKET (optional)
/// - FIREBASE_MESSAGING_SENDER_ID
///
/// Web:
/// - FIREBASE_WEB_API_KEY
/// - FIREBASE_WEB_APP_ID
/// - FIREBASE_AUTH_DOMAIN (optional for web hosting)
/// - FIREBASE_MEASUREMENT_ID (optional)
///
/// Android:
/// - FIREBASE_ANDROID_API_KEY
/// - FIREBASE_ANDROID_APP_ID
///
/// iOS:
/// - FIREBASE_IOS_API_KEY
/// - FIREBASE_IOS_APP_ID
/// - FIREBASE_IOS_BUNDLE_ID
/// - FIREBASE_IOS_CLIENT_ID (optional)
/// - FIREBASE_IOS_APP_GROUP_ID (optional)
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        // Fallback to web-style config for desktop if provided, else Android.
        return _tryWebOr(android);
      default:
        return android;
    }
  }

  static FirebaseOptions _tryWebOr(FirebaseOptions fallback) {
    final apiKey = dotenv.env['FIREBASE_WEB_API_KEY'];
    final appId = dotenv.env['FIREBASE_WEB_APP_ID'];
    final projectId = dotenv.env['FIREBASE_PROJECT_ID'];
    final messagingSenderId = dotenv.env['FIREBASE_MESSAGING_SENDER_ID'];
    if ([
      apiKey,
      appId,
      projectId,
      messagingSenderId,
    ].every((e) => (e ?? '').isNotEmpty)) {
      return web;
    }
    return fallback;
  }

  static FirebaseOptions get web => FirebaseOptions(
    apiKey: _req('FIREBASE_WEB_API_KEY'),
    appId: _req('FIREBASE_WEB_APP_ID'),
    projectId: _req('FIREBASE_PROJECT_ID'),
    messagingSenderId: _req('FIREBASE_MESSAGING_SENDER_ID'),
    authDomain: _opt('FIREBASE_AUTH_DOMAIN'),
    storageBucket: _opt('FIREBASE_STORAGE_BUCKET'),
    measurementId: _opt('FIREBASE_MEASUREMENT_ID'),
  );

  static FirebaseOptions get android => FirebaseOptions(
    apiKey: _req('FIREBASE_ANDROID_API_KEY'),
    appId: _req('FIREBASE_ANDROID_APP_ID'),
    projectId: _req('FIREBASE_PROJECT_ID'),
    messagingSenderId: _req('FIREBASE_MESSAGING_SENDER_ID'),
    storageBucket: _opt('FIREBASE_STORAGE_BUCKET'),
  );

  static FirebaseOptions get ios => FirebaseOptions(
    apiKey: _req('FIREBASE_IOS_API_KEY'),
    appId: _req('FIREBASE_IOS_APP_ID'),
    projectId: _req('FIREBASE_PROJECT_ID'),
    messagingSenderId: _req('FIREBASE_MESSAGING_SENDER_ID'),
    storageBucket: _opt('FIREBASE_STORAGE_BUCKET'),
    iosBundleId: _opt('FIREBASE_IOS_BUNDLE_ID'),
    iosClientId: _opt('FIREBASE_IOS_CLIENT_ID'),
  );

  static String _req(String key) {
    final v = _clean(dotenv.env[key]);
    if (v == null || v.isEmpty) {
      throw StateError('Missing \'$key\' in .env for Firebase initialization');
    }
    return v;
  }

  static String? _opt(String key) => _clean(dotenv.env[key]);

  static String? _clean(String? v) {
    if (v == null) return null;
    var out = v.trim();
    if (out.length >= 2) {
      if ((out.startsWith('"') && out.endsWith('"')) ||
          (out.startsWith("'") && out.endsWith("'"))) {
        out = out.substring(1, out.length - 1).trim();
      }
    }
    return out;
  }
}
