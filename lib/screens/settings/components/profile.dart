import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zad_app/components/buttons/normal_btn.dart';
import 'package:zad_app/models/user.dart';
import 'package:zad_app/providers/app_settings.dart';
import 'package:zad_app/utils/helpers/extensions.dart';
import 'package:zad_app/utils/lang/locale.export.dart';
import 'package:zad_app/utils/theme/images.dart';

class ProfileTab extends StatefulHookConsumerWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final theme = Theme.of(context);
    final appSettings = ref.watch(appSettingsProvider);
    final translate = AppLocalizations.of(context)!;
    log(appSettings.toString(), name: "appSettings");
    // padding (24*2) + space between buttons (12) = 60
    final buttonWidth = (context.width - 60) / 2;
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 32.0, end: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Images.avatar,
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isEditing
                          ? SizedBox(
                              height: 34,
                              child: TextField(
                                controller: nameController,
                                style: theme.textTheme.titleLarge,
                                decoration: InputDecoration(
                                  hintText: appSettings.user?.info?.name ??
                                      'Anonymous User',
                                  contentPadding: EdgeInsets.zero,
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              appSettings.userName,
                              style: theme.textTheme.titleLarge,
                            ),
                      const SizedBox(height: 4),
                      Text(
                        appSettings.userType.name,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary.withOpacity(.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                    if (!isEditing) {
                      ref.read(appSettingsProvider.notifier).updateUserName(
                            nameController.text,
                          );
                    }
                  });
                },
                icon: Icon(
                  isEditing ? FrinoIcons.f_check_circle : FrinoIcons.f_edit,
                ),
              ),
            ],
          ),
          Visibility(
            visible: appSettings.user?.info?.type == UserType.admin,
            child: Column(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  opacity: isEditing ? 1 : 0,
                  child: Visibility(
                    visible: isEditing,
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NormalButton(
                              text: translate.deleteAccout,
                              width: buttonWidth,
                              onPressed: () {
                                _launchUrl(
                                    'https://forms.gle/vzyHP18jJQyTdE2g8');
                              },
                            ),
                            NormalButton(
                              text: translate.logout,
                              width: buttonWidth,
                              onPressed: () async {
                                await ref
                                    .read(appSettingsProvider.notifier)
                                    .logout();
                              },
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
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
