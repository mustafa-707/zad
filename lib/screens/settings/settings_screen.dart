import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:gleap_sdk/gleap_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/models/user.dart';
import 'package:zad_app/providers/app_settings.dart';
import 'package:zad_app/screens/admin/auth/login.dart';
import 'package:zad_app/screens/admin/categories_manager/categories_manager.dart';
import 'package:zad_app/screens/content/language_picker/content_langauge_picker.dart';
import 'package:zad_app/screens/settings/components/appearance_settings.dart';
import 'package:zad_app/screens/settings/components/profile.dart';
import 'package:zad_app/screens/settings/components/tab.dart';
import 'package:zad_app/utils/lang/locale.export.dart';
import 'package:zad_app/utils/theme/images.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translate = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final auth = ref.watch(appSettingsProvider);
    final now = DateTime.now();
    return Scaffold(
      appBar: SubScreenAppbar(title: translate.settings),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const ProfileTab(),
            const SizedBox(height: 24),
            auth.user?.info?.type == UserType.admin
                ? SettingsTab(
                    icon: FrinoIcons.f_pen,
                    title: translate.joinEditor,
                    subtitle: translate.joinEditorSubtitle,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ContentLanguagePickerScreen.editor(
                            onSelectLanguage: (selectedLanguage) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoriesManager(
                                    title:
                                        "${translate.categoryOf} ${selectedLanguage.name}",
                                    selectedLanguage: selectedLanguage,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  )
                : SettingsTab(
                    icon: FrinoIcons.f_user_circle,
                    title: translate.loginToApp,
                    subtitle: translate.loginToAppSubtitle,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        LoginScreen.routeName,
                      );
                    },
                  ),
            SettingsTab(
              icon: FrinoIcons.f_colour_palette,
              title: translate.themeSettingsTitle,
              subtitle: translate.themeSettingsSubtitle,
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppearanceSettings.routeName,
                );
              },
            ),
            if (!Platform.isWindows)
              SettingsTab(
                icon: FrinoIcons.f_headset_mic,
                title: translate.helpSettingsTitle,
                subtitle: translate.helpSettingsSubtitle,
                onTap: () {
                  Gleap.open();
                },
              ),
            SettingsTab(
              icon: FrinoIcons.f_send,
              title: translate.invateApp,
              onTap: () {
                // TODO : add link
                Share.share(
                  '${translate.shareText} ${translate.shareLink}',
                );
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  Container(
                    height: 124,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Image.asset(
                      Images.appLogoLight,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "${translate.appName} © ${now.year}",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snap) {
                        return Text(
                          'v${snap.data?.version ?? "0.0.0"}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        );
                      }),
                ],
              ),
            ),
            const SizedBox(height: 52),
          ],
        ),
      ),
    );
  }
}
