import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:app/core/config/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  test('AppTheme.light uses light tokens', () {
    final theme = AppTheme.light();
    expect(theme.brightness, Brightness.light);
    expect(theme.colorScheme.primary, AppColors.light.buttonBg);
  });

  test('AppTheme.dark uses dark tokens', () {
    final theme = AppTheme.dark();
    expect(theme.brightness, Brightness.dark);
    expect(theme.colorScheme.primary, AppColors.dark.buttonBg);
  });
}
