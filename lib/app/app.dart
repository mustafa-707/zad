import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/app/app.router.dart';
import 'package:zad_app/components/behaviors/scroll.dart';
import 'package:zad_app/providers/app_settings.dart';
import 'package:zad_app/screens/splash_screen.dart';
import 'package:zad_app/utils/global_navigator.dart';
import 'package:zad_app/utils/lang/locale.dart';
import 'package:zad_app/utils/lang/locale.export.dart';
import 'package:zad_app/utils/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(currentLocaleProvider);
    final theme = ref.watch(currentThemeProvider);

    return MaterialApp(
      title: 'Zad Aldaia',
      navigatorKey: rootNavigator,
      themeMode: ThemeMode.values.firstWhere(
        (element) => element.name == theme,
      ),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: [
        for (var supportedLocale in LocaleService.supportedLocales) Locale(supportedLocale.code)
      ],
      locale: Locale(locale),
      initialRoute: SplashScreen.routeName,
      routes: appRoutes,
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaler: const TextScaler.linear(1.0)),
          child: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: child ?? const SizedBox(),
          ),
        );
      },
    );
  }
}
