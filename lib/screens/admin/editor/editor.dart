import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/components/editor_field.dart';
import 'package:zad_app/components/progress_index.dart';
import 'package:zad_app/screens/admin/editor/quran_ayat_toolbar_item.dart';
import 'package:zad_app/screens/admin/editor/title_text_field.dart';
import 'package:zad_app/utils/hooks/editor_hook.dart';

class EditorWidget extends StatefulHookConsumerWidget {
  final Future<void>? Function(String title, Map<String, dynamic> content) onSave;
  final String? title;
  final Map<String, dynamic>? content;

  const EditorWidget({
    super.key,
    required this.onSave,
    this.title,
    this.content,
  });

  @override
  ConsumerState<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends ConsumerState<EditorWidget> {
  final Map<String, dynamic> json = {
    "document": {
      "type": "page",
      "children": [
        {
          "type": "heading",
          "data": {
            "level": 2,
            "delta": [
              {"insert": "👋 "},
              {
                "insert": "Welcome to",
                "attributes": {"bold": true}
              },
              {"insert": " "},
              {
                "insert": "ZAD ALDAIA Editor",
                "attributes": {"italic": false, "bold": true}
              },
              {"insert": " "},
              {
                "insert": "Article Content HERE ->",
                "attributes": {"italic": false, "bold": true}
              },
            ],
            "align": "center"
          }
        }
      ]
    }
  };
  Future<void> onProcess = Future.value();

  @override
  Widget build(BuildContext context) {
    final controller = useEditorController(widget.content ?? json);
    final theme = Theme.of(context);
    final titleTextFieldController = useTextEditingController(text: widget.title);
    final isLoading = useFuture(onProcess).connectionState == ConnectionState.waiting;

    return Scaffold(
      appBar: SubScreenAppbar(
        title: 'editor',
        actions: [
          GestureDetector(
            onTap: () {
              if (isLoading) return;
              if (titleTextFieldController.text.trim().isEmpty) return; //todo : please enter title
              final content = controller.state.document.toJson();
              if (content.isEmpty) return;
              setState(() {
                onProcess = Future.microtask(() async {
                  await widget.onSave(
                    titleTextFieldController.text.trim(),
                    content,
                  );
                });
              });
              Navigator.pop(context);
            },
            child: isLoading
                ? const AppProgressIndicator()
                : Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 12.0,
                      top: 4.0,
                    ),
                    child: Column(
                      children: [
                        const Icon(FrinoIcons.f_plus),
                        Text(
                          'Save',
                          style: theme.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      body: Column(
        children: [
          MobileToolbar(
            editorState: controller.state,
            toolbarItems: [
              redo,
              undo,
              textDecorationMobileToolbarItem,
              buildTextAndBackgroundColorMobileToolbarItem(),
              headingMobileToolbarItem,
              todoListMobileToolbarItem,
              listMobileToolbarItem,
              linkMobileToolbarItem,
              quoteMobileToolbarItem,
              dividerMobileToolbarItem,
              codeMobileToolbarItem,
              quranMobileToolbarItem
            ],
          ),
          ExpansionTile(
            title: Text(
              titleTextFieldController.text.isEmpty
                  ? "title here.."
                  : titleTextFieldController.text,
            ),
            children: [
              ArticleTitleTextField(
                controller: titleTextFieldController,
              ),
            ],
          ),
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
                  isEditable: true,
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

final undo = MobileToolbarItem.action(
  itemIconBuilder: (context, __, ___) => Icon(
    FrinoIcons.f_forward,
    color: MobileToolbarTheme.of(context).iconColor,
  ),
  actionHandler: (_, editorState) {
    undoCommand.execute(editorState);
  },
);

final redo = MobileToolbarItem.action(
  itemIconBuilder: (context, __, ___) => Icon(
    FrinoIcons.f_reply,
    color: MobileToolbarTheme.of(context).iconColor,
  ),
  actionHandler: (_, editorState) {
    redoCommand.execute(editorState);
  },
);
