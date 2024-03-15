import 'package:flutter/material.dart';
import 'package:zad_app/utils/global_navigator.dart';
import 'package:zad_app/utils/theme/colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      background: AppColors.background,
      onBackground: AppColors.onBackground,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontWeight: FontWeight.bold,
        height: 1.4,
        fontSize: 14,
        color: AppColors.onSurface,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        height: 1.4,
        fontSize: 24,
        color: AppColors.onSurface,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        height: 1.4,
        fontSize: 16,
        color: AppColors.onSurface,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.normal,
        height: 1.4,
        fontSize: 14,
        color: AppColors.onSurface,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.normal,
        height: 1.4,
        fontSize: 16,
        color: AppColors.onSurface,
      ),
    ),
  );

  static final darkTheme = lightTheme.copyWith(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryDark,
      onPrimary: AppColors.onPrimaryDark,
      secondary: AppColors.secondaryDark,
      onSecondary: AppColors.onSecondaryDark,
      error: AppColors.errorDark,
      onError: AppColors.onErrorDark,
      background: AppColors.backgroundDark,
      onBackground: AppColors.onBackgroundDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.onSurfaceDark,
    ),
    textTheme: lightTheme.textTheme.merge(
      TextTheme(
        titleSmall: TextStyle(
          fontWeight: FontWeight.bold,
          height: 1.4,
          fontSize: 14,
          color: AppColors.onSurfaceDark,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.bold,
          height: 1.4,
          fontSize: 16,
          color: AppColors.onSurfaceDark,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.normal,
          height: 1.4,
          fontSize: 14,
          color: AppColors.onSurfaceDark,
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.normal,
          height: 1.4,
          fontSize: 16,
          color: AppColors.onSurfaceDark,
        ),
      ),
    ),
  );
}

class ThemeService {
  static const defaultTheme = 'light';

  static String getDefaultTheme() {
    final context = rootNavigator.currentContext;
    if (context != null) {
      bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
      return isDarkMode ? 'dark' : 'light';
    } else {
      return ThemeMode.system.name;
    }
  }
}
