import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _baseTheme(AppColors.light, Brightness.light);

  static ThemeData get darkTheme => _baseTheme(AppColors.dark, Brightness.dark);

  static ThemeData _baseTheme(AppColorTokens tokens, Brightness brightness) {
    final textTheme = TextTheme(
      headlineLarge: GoogleFonts.kanit(
        color: tokens.textHeading,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: GoogleFonts.kanit(
        color: tokens.textHeading,
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: GoogleFonts.kanit(
        color: tokens.textHeading,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.kanit(
        color: tokens.textBody,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.kanit(
        color: tokens.textBody,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: GoogleFonts.kanit(
        color: tokens.onPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.kanit(
        color: tokens.textBody,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );

    final baseScheme = ColorScheme.fromSeed(
      seedColor: tokens.primary,
      brightness: brightness,
      primary: tokens.primary,
      onPrimary: tokens.onPrimary,
      secondary: tokens.secondary,
      onSecondary: tokens.onSecondary,
      surface: tokens.surface,
      onSurface: tokens.textBody,
      error: tokens.error,
      onError: tokens.onPrimary,
    );

    final colorScheme = baseScheme.copyWith(
      primary: tokens.primary,
      secondary: tokens.secondary,
      surface: tokens.surface,
      onSurface: tokens.textBody,
      shadow: tokens.border,
    );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: tokens.surface,
      canvasColor: tokens.surface,
      textTheme: textTheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: tokens.surface,
        foregroundColor: tokens.textHeading,
        titleTextStyle: textTheme.titleLarge,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: tokens.primary,
          foregroundColor: tokens.onPrimary,
          textStyle: textTheme.labelLarge,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: tokens.primary,
          textStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: tokens.surface,
        hintStyle: textTheme.bodyMedium?.copyWith(color: tokens.textMuted),
        labelStyle: textTheme.bodyMedium,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(26)),
          borderSide: BorderSide(color: tokens.border, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(26)),
          borderSide: BorderSide(color: tokens.primary, width: 2.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(26)),
          borderSide: BorderSide(color: tokens.error, width: 2.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(26)),
          borderSide: BorderSide(color: tokens.warning, width: 2.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: tokens.surface,
        selectedItemColor: tokens.primary,
        unselectedItemColor: tokens.textMuted,
        selectedLabelStyle: textTheme.labelMedium,
        unselectedLabelStyle: textTheme.labelMedium,
        type: BottomNavigationBarType.fixed,
      ),
      dividerTheme: DividerThemeData(color: tokens.border, thickness: 1),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: tokens.toastBackground,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: tokens.toastText),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: tokens.surface,
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyLarge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
