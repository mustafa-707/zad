import 'package:flutter/material.dart';
import 'package:zad_app/components/flag_icon.dart';
import 'package:zad_app/models/content_langague.dart';

class LanguageItemWidget extends StatelessWidget {
  final void Function(ContentLanguage) onSelectLanguage;
  final bool isSelected;
  final ContentLanguage language;

  const LanguageItemWidget({
    super.key,
    required this.onSelectLanguage,
    this.isSelected = false,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 35),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        child: Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onPrimary,
          child: InkWell(
            onTap: () {
              onSelectLanguage(language);
            },
            child: Container(
              height: 88,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.shadow.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4), // changes position of shadow
                        ),
                      ]
                    : null,
                border: isSelected
                    ? null
                    : Border.all(
                        color: theme.colorScheme.shadow.withOpacity(0.1),
                      ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 24),
                  FlagIcon(
                    countryCode: language.flag,
                  ),
                  const SizedBox(width: 24),
                  Text(
                    language.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
