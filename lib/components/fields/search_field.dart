
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:zad_app/components/direction_aware.dart';
import 'package:zad_app/components/fields/primary_field.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

class SearchField extends StatefulHookWidget {
  const SearchField({
    super.key,
    required this.onChange,
  });
  static String tag = 'search';
  final void Function(String) onChange;

  @override
  State<StatefulWidget> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final searchTextController = useTextEditingController();
    final translate = AppLocalizations.of(context)!;

    return Center(
      child: Hero(
        tag: SearchField.tag,
        child: SizedBox(
          height: 54,
          child: Material(
            color: Colors.transparent,
            child: PrimaryTextField(
              controller: searchTextController,
              onChanged: (value) => widget.onChange(value),
              autofocus: true,
              suffixWidget: SizedBox(
                width: 52,
                height: 52,
                child: Center(
                  child: IconButton(
                    onPressed: () => searchTextController.text.isEmpty
                        ? Navigator.of(context).pop()
                        : setState(() => searchTextController.text = ''),
                    padding: EdgeInsets.zero,
                    icon: searchTextController.text.isEmpty
                        ? DirectionAware(
                            child: Icon(
                              FrinoIcons.f_arrow_left,
                              color: theme.colorScheme.onPrimary,
                            ),
                          )
                        : Icon(
                            Icons.close_rounded,
                            size: 18,
                            color: theme.colorScheme.onPrimary,
                          ),
                  ),
                ),
              ),
              prefixIcon: SizedBox(
                child: Center(
                  child: Icon(
                    FrinoIcons.f_search,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
              hintText: translate.search,
            ),
          ),
        ),
      ),
    );
  }
}
