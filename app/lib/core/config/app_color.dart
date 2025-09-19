import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Semantic color tokens
class AppTokens {
  // Surfaces
  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color divider;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  // Buttons
  final Color buttonBg;
  final Color onButton;
  final Color buttonBgAlt; // e.g., for dark mode alt button

  // TextFields
  final Color textFieldFill;
  final Color textFieldBorder;
  final Color onTextField;

  // Toast/Snackbar
  final Color toastBg;
  final Color onToast;

  // Overlays
  final Color overlayScrim;

  // States
  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  const AppTokens({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.buttonBg,
    required this.onButton,
    required this.buttonBgAlt,
    required this.textFieldFill,
    required this.textFieldBorder,
    required this.onTextField,
    required this.toastBg,
    required this.onToast,
    required this.overlayScrim,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });
}

class AppColors {
  static const AppTokens light = AppTokens(
    background: Colors.white,
    surface: Colors.white,
    surfaceAlt: Color(0xFFF5F5F5),
    divider: Color(0xFFE0E0E0),
    textPrimary: Colors.black,
    textSecondary: Color(0xFF424242),
    textMuted: Color(0xFF757575),
    buttonBg: Color(0xFF2196F3), // Blue
    onButton: Colors.white,
    buttonBgAlt: Color(0xFFE0E0E0),
    textFieldFill: Color(0xFFF2F2F2),
    textFieldBorder: Color(0xFFCCCCCC),
    onTextField: Colors.black,
    toastBg: Colors.black,
    onToast: Colors.white,
    overlayScrim: Color(0x99000000),
    success: Color(0xFF2E7D32),
    warning: Color(0xFFF9A825),
    error: Color(0xFFC62828),
    info: Color(0xFF1565C0),
  );

  static const AppTokens dark = AppTokens(
    background: Color(0xFF0B1020),
    surface: Color(0xFF121A2A),
    surfaceAlt: Color(0xFF0E1626),
    divider: Color(0xFF2A3550),
    textPrimary: Colors.white,
    textSecondary: Color(0xFFB0BEC5),
    textMuted: Color(0xFF90A4AE),
    buttonBg: Color(0xFF2196F3),
    onButton: Colors.white,
    buttonBgAlt: Color(0xFFE0E0E0),
    textFieldFill: Color(0xFF1C2740),
    textFieldBorder: Color(0xFF2E3B5A),
    onTextField: Colors.white,
    toastBg: Color(0xFF263238),
    onToast: Colors.white,
    overlayScrim: Color(0x99000000),
    success: Color(0xFF66BB6A),
    warning: Color(0xFFFFD54F),
    error: Color(0xFFEF5350),
    info: Color(0xFF42A5F5),
  );
}

class AppTheme {
  static TextTheme _kanitTextThemeOrDefault(Brightness brightness) {
    // If runtime fetching is disabled (like in tests), avoid GoogleFonts
    if (GoogleFonts.config.allowRuntimeFetching == false) {
      return ThemeData(brightness: brightness).textTheme;
    }
    try {
      if (brightness == Brightness.dark) {
        return GoogleFonts.kanitTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        );
      }
      return GoogleFonts.kanitTextTheme();
    } catch (_) {
      // In environments without bundled font, fall back gracefully
      return ThemeData(brightness: brightness).textTheme;
    }
  }

  static ThemeData light({String fontFamily = 'Kanit'}) {
    final t = AppColors.light;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: fontFamily,
      textTheme: _kanitTextThemeOrDefault(Brightness.light),
      scaffoldBackgroundColor: t.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: t.buttonBg,
        brightness: Brightness.light,
        primary: t.buttonBg,
        onPrimary: t.onButton,
        surface: t.surface,
        onSurface: t.textPrimary,
        error: t.error,
        onError: Colors.white,
      ),
      dividerColor: t.divider,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: t.textFieldFill,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: t.textFieldBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: t.textFieldBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: t.buttonBg),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: t.toastBg,
        contentTextStyle: TextStyle(color: t.onToast),
        behavior: SnackBarBehavior.floating,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: t.buttonBg),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: t.buttonBg,
          foregroundColor: t.onButton,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData dark({String fontFamily = 'Kanit'}) {
    final t = AppColors.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      textTheme: _kanitTextThemeOrDefault(Brightness.dark),
      scaffoldBackgroundColor: t.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: t.buttonBg,
        brightness: Brightness.dark,
        primary: t.buttonBg,
        onPrimary: t.onButton,
        surface: t.surface,
        onSurface: t.textPrimary,
        error: t.error,
        onError: Colors.white,
      ),
      dividerColor: t.divider,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: t.textFieldFill,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: t.textFieldBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: t.textFieldBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: t.buttonBg),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: t.toastBg,
        contentTextStyle: TextStyle(color: t.onToast),
        behavior: SnackBarBehavior.floating,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: t.buttonBg),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: t.buttonBg,
          foregroundColor: t.onButton,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

// Helper to get tokens for current theme
AppTokens tokensOf(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? AppColors.dark
    : AppColors.light;
