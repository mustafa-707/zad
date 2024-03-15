import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EditorController {
  final EditorScrollController scrollController;
  final EditorState state;
  EditorController(this.scrollController, this.state);
}

EditorController useEditorController(Map<String, dynamic> json) {
  return use(_EditorControllerControllerHook(json));
}

class _EditorControllerControllerHook extends Hook<EditorController> {
  final Map<String, dynamic> json;
  const _EditorControllerControllerHook(this.json);

  @override
  _EditorControllerControllerHookState createState() => _EditorControllerControllerHookState();
}

class _EditorControllerControllerHookState
    extends HookState<EditorController, _EditorControllerControllerHook> {
  late EditorScrollController controller;
  EditorState? state;

  @override
  void initHook() {
    super.initHook();
    state = EditorState(
      document: Document.fromJson(hook.json),
    );
    state!.logConfiguration
      ..handler = debugPrint
      ..level = LogLevel.off;
    controller = EditorScrollController(editorState: state!);
  }

  @override
  EditorController build(BuildContext context) {
    return EditorController(
      controller,
      state!,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    state = null;
    super.dispose();
  }
}
