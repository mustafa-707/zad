import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/components/editor_field.dart';
import 'package:zad_app/screens/home/components/share_screen.dart';
import 'package:zad_app/utils/hooks/editor_hook.dart';

class ArticleInside extends StatefulHookConsumerWidget {
  final Map<String, dynamic> content;
  final String title;

  const ArticleInside({
    super.key,
    required this.content,
    required this.title,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticleInsideState();
}

class _ArticleInsideState extends ConsumerState<ArticleInside> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final controller = useEditorController(widget.content);

    return Scaffold(
      appBar: SubScreenAppbar(
        title: widget.title,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ShareScreen(
                    nodes: controller.state.document.root.children,
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: Icon(
              Platform.isIOS ? Icons.ios_share : Icons.share,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary,
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(.1),
                  ),
                ),
                child: EditorField(
                  controller: controller.scrollController,
                  editorState: controller.state,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
