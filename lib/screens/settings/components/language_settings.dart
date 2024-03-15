import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/components/direction_aware.dart';
import 'package:zad_app/components/line_widget.dart';
import 'package:zad_app/providers/app_settings.dart';
import 'package:zad_app/utils/lang/locale.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

class LanguageSettings extends ConsumerWidget {
  static const routeName = '/languages';

  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(currentLocaleProvider);
    const languages = LocaleService.supportedLocales;
    final translate = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: SubScreenAppbar(
        title: translate.languageSettings,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: List.generate(
            languages.length,
            (i) => Column(
              children: [
                InkWell(
                  onTap: () {
                    ref.read(appSettingsProvider.notifier).updateLocale(
                          languages[i].code,
                        );
                  },
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 16, top: 16, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6, right: 16, left: 16),
                          child: Text(
                            languages[i].name,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 100),
                          crossFadeState: languages[i].code == selectedLocale
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          secondChild: const Icon(
                            FrinoIcons.f_check_circle,
                          ),
                          firstChild: const DirectionAware(
                            child: Icon(
                              FrinoIcons.f_arrow_left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (i != languages.length - 1) const LineWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
