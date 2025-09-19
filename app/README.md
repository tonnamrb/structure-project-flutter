# Re:Play (UC-01 Mock)

This is a minimal Flutter app scaffold implementing UC-01 (Sign up with Google) flow with GetX, mocked OAuth and API.

## Run

PowerShell (Windows):

```
cd app
flutter pub get
flutter run -d chrome
```

## Firebase Google Sign-In setup

This app uses Firebase Auth for Google Sign-In.

1) In Firebase Console, add Web/Android/iOS apps.
2) Copy credentials into `.env` at project root:

```
# Common
FIREBASE_PROJECT_ID=
FIREBASE_MESSAGING_SENDER_ID=
FIREBASE_STORAGE_BUCKET=

# Web
FIREBASE_WEB_API_KEY=
FIREBASE_WEB_APP_ID=
FIREBASE_AUTH_DOMAIN=
FIREBASE_MEASUREMENT_ID=

# Android
FIREBASE_ANDROID_API_KEY=
FIREBASE_ANDROID_APP_ID=

# iOS
FIREBASE_IOS_API_KEY=
FIREBASE_IOS_APP_ID=
FIREBASE_IOS_BUNDLE_ID=
FIREBASE_IOS_CLIENT_ID=
```

3) Ensure your Web OAuth redirect domain is authorized in Firebase (e.g. localhost ports during dev). On web, Flutter uses popup flow.

4) Run the app:

```
flutter run -d chrome
```

If initialization fails, verify `.env` keys and that `lib/firebase_options.dart` is configured per above.

## Structure

- Clean-ish layers under `lib/` with `presentation`, `data`, `core/config`.
- Theming via semantic tokens in `core/config/app_color.dart`. No hardcoded colors in widgets.
- GetX routing/bindings and state management.
- Settings page includes theme/language persistence using SharedPreferences.

## UC-01 Screens

- SC-01: `OnboardingPage`
- SC-02: `SignupMethodPage`
- WG-01: `OauthMockPage` (select outcome, then Continue/Cancel)
- SC-04: `SignupProfilePage` (validations per spec)
- SC-06: `MainShellPage` w/ bottom navigation

Toasts (WG-02..WG-09) are implemented via Get.snackbar messages.
