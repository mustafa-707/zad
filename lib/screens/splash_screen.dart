import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zad_app/components/progress_index.dart';
import 'package:zad_app/providers/app_settings.dart';
import 'package:zad_app/providers/shared_preferences.dart';
import 'package:zad_app/screens/main_screen.dart';
import 'package:zad_app/screens/content/language_picker/content_langauge_picker.dart';
import 'package:zad_app/screens/settings/settings_screen.dart';
import 'package:zad_app/utils/lang/locale.export.dart';
import 'package:zad_app/utils/theme/images.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Future<void> _initializeApp() async {
    final prefs = await SharedPreferences.getInstance();

    ref.read(sharedPrefsProvider.notifier).state = prefs;

    final user = ref.read(appSettingsProvider).user;

    if (user?.user != null) {
      // make sure context is still viable as we are in async function
      if (!mounted) return;
      log("user loggedIn successfully : type : ${user!.user!.isAnonymous ? "anonymous" : "admin"} -- id : ${user.user!.uid} -- ${user.info?.language}");

      if (user.info?.language != null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          MainScreen.routeName,
          (_) => false,
        );
        if (!user.user!.isAnonymous) {
          Navigator.of(context).pushNamed(
            SettingsScreen.routeName,
          );
        }
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ContentLanguagePickerScreen.onBoarding()),
          (_) => false,
        );
      }
    } else {
      await ref.read(appSettingsProvider.notifier).anonymouslyLogin();
      _initializeApp();
    }
  }

  @override
  void initState() {
    _initializeApp().then((value) {
      ref.read(appReadyProvider.notifier).state = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translate = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                top: 120,
                child: Column(
                  children: [
                    Container(
                      height: 278,
                      width: 328,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            Images.appLogo,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: Text(
                        translate.intro,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.background.withOpacity(.9),
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      theme.colorScheme.primary.withOpacity(.1),
                      theme.colorScheme.onPrimary.withOpacity(.5),
                    ],
                    stops: const [1.0, 0.4],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 88,
                      ),
                      Column(
                        children: [
                          const AppProgressIndicator(),
                          const SizedBox(
                            height: 61,
                          ),
                          Text(
                            "© ${DateTime.now().year} ${translate.appName}",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.background,
                            ),
                          ),
                          const SizedBox(
                            height: 64,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
