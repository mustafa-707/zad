import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShareController {
  final List<Map<String, String>> list;
  final String concatenateWithSeparator;

  ShareController(this.list, {required this.concatenateWithSeparator});
}

ShareController useShareController(List<Node> nodes) {
  return use(_ShareControllerControllerHook(nodes));
}

class _ShareControllerControllerHook extends Hook<ShareController> {
  final List<Node> nodes;
  const _ShareControllerControllerHook(this.nodes);

  @override
  _ShareControllerControllerHookState createState() => _ShareControllerControllerHookState();
}

class _ShareControllerControllerHookState
    extends HookState<ShareController, _ShareControllerControllerHook> {
  late List<Map<String, String>> listOfArticleDividerText;

  String get concatenateWithSeparator {
    if (listOfArticleDividerText.isEmpty) return '';

    final textBuffer = StringBuffer();

    textBuffer.write(listOfArticleDividerText[0]);

    for (int i = 1; i < listOfArticleDividerText.length; i++) {
      textBuffer.write('\n════════════════════════════════════\n');
      textBuffer.write(listOfArticleDividerText[i].values.first);
    }

    return textBuffer.toString();
  }

  @override
  void initHook() {
    super.initHook();
    listOfArticleDividerText = <Map<String, String>>[];

    final textBuffer = StringBuffer();
    final notesBuffer = StringBuffer();

    bool hasTextBeforeDivider = false;

    for (final node in hook.nodes) {
      final delta = node.delta;
      if (delta != null) {
        final text = delta.toPlainText().trim().split("||");
        if (text.isNotEmpty) {
          if (text.length == 1) {
            textBuffer.write(text.first);
          } else {
            notesBuffer.write(text.first);
            textBuffer.write(text.last);
          }

          hasTextBeforeDivider = true;
        }
      } else {
        if (node.type == DividerBlockKeys.type) {
          if (hasTextBeforeDivider) {
            listOfArticleDividerText.add({notesBuffer.toString(): textBuffer.toString()});
            textBuffer.clear();
            hasTextBeforeDivider = false;
          }
        }
      }
    }

    // Add the last text segment to the list if it exists
    if (textBuffer.isNotEmpty) {
      listOfArticleDividerText.add({notesBuffer.toString(): textBuffer.toString()});
    }
  }

  @override
  ShareController build(BuildContext context) {
    return ShareController(
      listOfArticleDividerText,
      concatenateWithSeparator: concatenateWithSeparator,
    );
  }

  @override
  void dispose() {
    listOfArticleDividerText.clear();
    super.dispose();
  }
}
