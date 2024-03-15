import 'dart:developer';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:quran/quran.dart';
import 'package:zad_app/components/app_dropdown.dart';
import 'package:zad_app/utils/lang/locale.export.dart';
import 'package:zad_app/utils/theme/images.dart';

final quranMobileToolbarItem = MobileToolbarItem.withMenu(
  itemMenuBuilder: (_, editor, __) {
    return _AyaPicker(
      editor.selection!,
      editor,
    );
  },
  itemIconBuilder: (_, __, ___) {
    return Image.asset(
      Images.quranIcon,
    );
  },
);

class _AyaPicker extends StatefulWidget {
  const _AyaPicker(
    this.selection,
    this.editorState,
  );

  final Selection selection;
  final EditorState editorState;

  @override
  State<_AyaPicker> createState() => _AyaPickerState();
}

enum SupportedLanguages {
  en,
  ar,
  fr,
  es,
}

class _AyaPickerState extends State<_AyaPicker> {
  int surahNumberDropdownvalue = -1;
  int ayaNumberDropdownvalue = 0;
  SupportedLanguages local = SupportedLanguages.en;
  @override
  Widget build(BuildContext context) {
    final style = MobileToolbarTheme.of(context);
    final size = MediaQuery.sizeOf(context);
    final translate = AppLocalizations.of(context)!;

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: size.width),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      // 3 buttons in a row
                      width: (size.width - 4 * style.buttonSpacing) / 2,
                    ),
                    child: AppDropdown(
                      hintText: translate.surahName,
                      itemList: List.generate(
                        totalSurahCount,
                        (index) {
                          return getSurahName(index);
                        },
                      ),
                      onTap: (int val) {
                        setState(() {
                          surahNumberDropdownvalue = val;
                        });
                      },
                      onOpenTrailingIcon: FrinoIcons.f_arrow_up,
                      onCloseTrailingIcon: FrinoIcons.f_arrow_down,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      // 3 buttons in a row
                      width: (size.width - 4 * style.buttonSpacing) / 2,
                    ),
                    child: surahNumberDropdownvalue == -1
                        ? Text(translate.chooseSurah)
                        : AppDropdown(
                            hintText: translate.ayahNo,
                            itemList: List.generate(
                              getVerseCount(surahNumberDropdownvalue),
                              (index) {
                                return index + 1;
                              },
                            ),
                            onTap: (int val) {
                              setState(() {
                                ayaNumberDropdownvalue = val + 1;
                              });
                            },
                            onOpenTrailingIcon: FrinoIcons.f_arrow_up,
                            onCloseTrailingIcon: FrinoIcons.f_arrow_down,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  // 3 buttons in a row
                  width: (size.width - 4 * style.buttonSpacing) / 2,
                ),
                child: AppDropdown(
                  hintText: translate.localeName,
                  itemList: List.generate(
                    SupportedLanguages.values.length,
                    (index) {
                      return SupportedLanguages.values[index].name;
                    },
                  ),
                  onTap: (int val) {
                    setState(() {
                      local = SupportedLanguages.values[val];
                    });
                  },
                  onOpenTrailingIcon: FrinoIcons.f_arrow_up,
                  onCloseTrailingIcon: FrinoIcons.f_arrow_down,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              final selectedAya = getVerseTranslation(
                local.name,
                surahNumberDropdownvalue + 1,
                ayaNumberDropdownvalue,
                verseEndSymbol: true,
              );
              log(selectedAya);
              widget.editorState.formatNode(
                widget.selection,
                (node) => paragraphNode(
                  text: selectedAya,
                  textDirection: blockComponentTextDirectionRTL,
                ),
              );
            },
            child: Text(translate.insertAya),
          ),
        ],
      ),
    );
  }
}
