import 'package:flutter/material.dart';
import 'package:zad_app/screens/admin/auth/login.dart';
import 'package:zad_app/screens/main_screen.dart';
import 'package:zad_app/screens/settings/components/appearance_settings.dart';
import 'package:zad_app/screens/settings/components/language_settings.dart';
import 'package:zad_app/screens/settings/settings_screen.dart';
import 'package:zad_app/screens/splash_screen.dart';

final appRoutes = <String, WidgetBuilder>{
  SplashScreen.routeName: (context) => const SplashScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
  SettingsScreen.routeName: (context) => const SettingsScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  AppearanceSettings.routeName: (context) => const AppearanceSettings(),
  LanguageSettings.routeName: (context) => const LanguageSettings(),
};
