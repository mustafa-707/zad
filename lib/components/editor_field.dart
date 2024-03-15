import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class EditorField extends StatefulWidget {
  final EditorState editorState;
  final EditorScrollController controller;
  final bool isEditable;
  const EditorField({
    super.key,
    this.isEditable = false,
    required this.editorState,
    required this.controller,
  });

  @override
  State<EditorField> createState() => _EditorFieldState();
}

class _EditorFieldState extends State<EditorField> {
  late EditorStyle editorStyle;
  late Map<String, BlockComponentBuilder> blockComponentBuilders;

  @override
  void initState() {
    super.initState();
    editorStyle = _buildMobileEditorStyle();
    blockComponentBuilders = _buildBlockComponentBuilders();
  }

  @override
  void reassemble() {
    super.reassemble();

    editorStyle = _buildMobileEditorStyle();
    blockComponentBuilders = _buildBlockComponentBuilders();
  }

  @override
  Widget build(BuildContext context) {
    widget.editorState.logConfiguration
      ..handler = debugPrint
      ..level = LogLevel.off;

    return Column(
      children: [
        Expanded(
          child: MobileFloatingToolbar(
            editorState: widget.editorState,
            editorScrollController: widget.controller,
            toolbarBuilder: (_, anchor, __) {
              return widget.isEditable
                  ? AdaptiveTextSelectionToolbar.editable(
                      clipboardStatus: ClipboardStatus.pasteable,
                      onCopy: () => copyCommand.execute(widget.editorState),
                      onCut: () => cutCommand.execute(widget.editorState),
                      onPaste: () => pasteCommand.execute(widget.editorState),
                      onSelectAll: () => selectAllCommand.execute(widget.editorState),
                      anchors: TextSelectionToolbarAnchors(
                        primaryAnchor: anchor,
                      ),
                      onLiveTextInput: () {},
                      onLookUp: () {},
                      onSearchWeb: () {},
                      onShare: () {},
                    )
                  : AdaptiveTextSelectionToolbar.selectable(
                      onCopy: () => copyCommand.execute(widget.editorState),
                      onSelectAll: () => selectAllCommand.execute(widget.editorState),
                      selectionGeometry: const SelectionGeometry(
                        status: SelectionStatus.uncollapsed,
                        hasContent: true,
                      ),
                      anchors: TextSelectionToolbarAnchors(
                        primaryAnchor: anchor,
                      ),
                    );
            },
            child: AppFlowyEditor(
              editorStyle: editorStyle,
              editable: widget.isEditable,
              editorState: widget.editorState,
              editorScrollController: widget.controller,
              blockComponentBuilders: blockComponentBuilders,
              header: const SizedBox(height: 12),
              footer: const SizedBox(height: 12),
            ),
          ),
        ),
      ],
    );
  }

  EditorStyle _buildMobileEditorStyle() {
    return EditorStyle.mobile(
      cursorColor: const Color.fromARGB(255, 134, 46, 247),
      selectionColor: const Color.fromARGB(50, 134, 46, 247),
      textStyleConfiguration: TextStyleConfiguration(
        text: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black,
        ),
        code: GoogleFonts.sourceCodePro(
          backgroundColor: Colors.grey.shade200,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
    );
  }

  Map<String, BlockComponentBuilder> _buildBlockComponentBuilders() {
    final map = {
      ...standardBlockComponentBuilderMap,
    };
    // customize the heading block component
    final levelToFontSize = [
      24.0,
      22.0,
      20.0,
      18.0,
      16.0,
      14.0,
    ];
    map[HeadingBlockKeys.type] = HeadingBlockComponentBuilder(
      textStyleBuilder: (level) => GoogleFonts.poppins(
        fontSize: levelToFontSize.elementAtOrNull(level - 1) ?? 14.0,
        fontWeight: FontWeight.w600,
      ),
    );
    map[ParagraphBlockKeys.type] = ParagraphBlockComponentBuilder(
      configuration: BlockComponentConfiguration(
        placeholderText: (node) => 'Type something...',
      ),
    );
    return map;
  }
}
