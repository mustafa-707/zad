import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/components/buttons/normal_btn.dart';
import 'package:zad_app/models/content_langague.dart';
import 'package:zad_app/providers/app_settings.dart';
import 'package:zad_app/providers/content.dart';
import 'package:zad_app/providers/home.dart';
import 'package:zad_app/screens/content/language_picker/components/language_item.dart';
import 'package:zad_app/screens/main_screen.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

enum PickerRouter {
  onBoarding,
  subPage,
  editor,
}

class ContentLanguagePickerScreen extends ConsumerWidget {
  final PickerRouter router;
  final void Function(ContentLanguage)? onSelectLanguage;
  const ContentLanguagePickerScreen.onBoarding({
    super.key,
  })  : onSelectLanguage = null,
        router = PickerRouter.onBoarding;
  const ContentLanguagePickerScreen.subPage({
    super.key,
  })  : onSelectLanguage = null,
        router = PickerRouter.subPage;

  const ContentLanguagePickerScreen.editor({
    super.key,
    required this.onSelectLanguage,
  }) : router = PickerRouter.editor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final translate = AppLocalizations.of(context)!;
    final languages = ref.watch(contentLanguagesProvider);
    final settingsFn = ref.watch(appSettingsProvider.notifier);
    final settings = ref.watch(appSettingsProvider);

    if (router != PickerRouter.editor) {
      settingsFn.getUserContentLanguage();
    }

    return SafeArea(
      child: Scaffold(
        appBar: !Navigator.canPop(context) ? null : const SubScreenAppbar(title: ''),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: media.viewPadding.top,
                ),
                Text(
                  translate.selectLanguage,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 62.0),
                  child: Text(
                    translate.selectLanguageSubtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary.withOpacity(.4),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                languages.when(
                  data: (data) {
                    return Column(
                      children: [
                        ...data.map(
                          (c) => Padding(
                            padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
                            child: LanguageItemWidget(
                              onSelectLanguage: (selectedLanguage) {
                                if (router == PickerRouter.editor) {
                                  onSelectLanguage?.call(selectedLanguage);
                                  return;
                                }
                                settingsFn.updateUserContentLanguage(selectedLanguage);
                              },
                              isSelected: PickerRouter.editor != router &&
                                  settings.selectedLanguage == c.data(),
                              language: c.data(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => const SizedBox(),
                  loading: () => const SizedBox(),
                ),
                const SizedBox(
                  height: 84,
                ),
                Visibility(
                  visible: router != PickerRouter.editor,
                  child: NormalButton(
                    text: translate.continueText,
                    onPressed: () {
                      switch (router) {
                        case PickerRouter.onBoarding:
                          if (settings.selectedLanguage == null) {
                            return;
                          }
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            MainScreen.routeName,
                            (_) => false,
                          );
                          break;
                        case PickerRouter.subPage:
                          ref.invalidate(homeStateProvider);
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                          break;
                        default:
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 84,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
