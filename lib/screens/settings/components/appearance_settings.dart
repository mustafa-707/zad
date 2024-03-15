import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/screens/settings/components/appearance_tab.dart';
import 'package:zad_app/screens/settings/components/language_settings.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

class AppearanceSettings extends StatelessWidget {
  static const routeName = '/appearance';

  const AppearanceSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: SubScreenAppbar(
        title: translate.appSettings,
      ),
      body: Column(
        children: [
          AppearanceTab(
            title: translate.language,
            icon: FrinoIcons.f_translate,
            route: LanguageSettings.routeName,
          ),
          AppearanceTab(
            title: translate.theme,
            icon: FrinoIcons.f_colour_palette,
          ),
        ],
      ),
    );
  }
}
