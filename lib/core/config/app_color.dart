import 'package:flutter/material.dart';

class AppColorTokens {
  const AppColorTokens({
    required this.background,
    required this.surface,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.textHeading,
    required this.textBody,
    required this.textMuted,
    required this.border,
    required this.toastBackground,
    required this.toastText,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.overlay,
  });

  final Color background;
  final Color surface;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color textHeading;
  final Color textBody;
  final Color textMuted;
  final Color border;
  final Color toastBackground;
  final Color toastText;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color overlay;
}

class AppColors {
  AppColors._();

  static const AppColorTokens light = AppColorTokens(
    background: Color(0xFFF7F9FC),
    surface: Color(0xFFFFFFFF),
    primary: Color(0xFF008CFF),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF4DA5FF),
    onSecondary: Color(0xFFFFFFFF),
    textHeading: Color(0xFF003366),
    textBody: Color(0xFF064B8F),
    textMuted: Color(0xFF6B8AA6),
    border: Color(0xFFB5D2F3),
    toastBackground: Color(0xFF1A91F0),
    toastText: Color(0xFFFFFFFF),
    success: Color(0xFF2EB875),
    warning: Color(0xFFF7B733),
    error: Color(0xFFD9534F),
    info: Color(0xFF5BC0EB),
    overlay: Color(0xB300335A),
  );

  static const AppColorTokens dark = AppColorTokens(
    background: Color(0xFF0F1A2B),
    surface: Color(0xFF182841),
    primary: Color(0xFF1A91F0),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF345678),
    onSecondary: Color(0xFFE0F0FF),
    textHeading: Color(0xFFE4F1FF),
    textBody: Color(0xFFC3D9F2),
    textMuted: Color(0xFF9BB6D6),
    border: Color(0xFF2D3E5A),
    toastBackground: Color(0xFF1A91F0),
    toastText: Color(0xFFE2F3FF),
    success: Color(0xFF2EB875),
    warning: Color(0xFFF7B733),
    error: Color(0xFFE57373),
    info: Color(0xFF81D4FA),
    overlay: Color(0xCC0F1A2B),
  );
}
