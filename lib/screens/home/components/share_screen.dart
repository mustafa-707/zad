import 'dart:io';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/utils/hooks/share_hook.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

String appWaterMark(BuildContext ctx) {
  final translate = AppLocalizations.of(ctx)!;

  return """

      ────────────
      ${translate.shareText} ${translate.shareLink}
      ────────────
      """;
}

class ShareScreen extends HookConsumerWidget {
  final List<Node> nodes;
  const ShareScreen({
    super.key,
    required this.nodes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shareTexts = useShareController(nodes);
    final translate = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: SubScreenAppbar(
        title: translate.shareScreen,
        actions: [
          IconButton(
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(
                  text: shareTexts.concatenateWithSeparator +
                      appWaterMark(context),
                ),
              ).then((value) {
                var snackBar = SnackBar(content: Text(translate.copied));

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            },
            icon: const Icon(
              FrinoIcons.f_copy,
            ),
          ),
          IconButton(
            onPressed: () {
              Share.share(
                shareTexts.concatenateWithSeparator + appWaterMark(context),
              );
            },
            icon: Icon(
              Platform.isIOS ? FrinoIcons.f_upload_square : FrinoIcons.f_share,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(
              shareTexts.list.length,
              (index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${translate.text}#${index + 1}"),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(
                                  text: shareTexts.concatenateWithSeparator +
                                      appWaterMark(context),
                                ),
                              ).then((value) {
                                var snackBar =
                                    SnackBar(content: Text(translate.copied));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            },
                            icon: const Icon(
                              FrinoIcons.f_copy,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Share.share(
                                shareTexts.list[index].values.first +
                                    appWaterMark(context),
                              );
                            },
                            icon: Icon(
                              Platform.isIOS
                                  ? FrinoIcons.f_upload_square
                                  : FrinoIcons.f_share,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (shareTexts.list[index].keys.first.isEmpty) return;
                      var snackBar = SnackBar(
                          content: Text(shareTexts.list[index].keys.first));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey.shade100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableText(
                          shareTexts.list[index].values.first,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
