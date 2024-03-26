import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:zad_app/models/category.dart';
import 'package:zad_app/utils/lang/locale.dart';
import 'package:zad_app/utils/lang/locale.export.dart';
import 'package:zad_app/utils/theme/images.dart';
import 'package:zad_app/utils/theme/painters/category_shape.dart';

class CategoryWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final DawaCategory category;

  const CategoryWidget({
    super.key,
    required this.onTap,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translate = AppLocalizations.of(context)!;

    return SizedBox(
      width: 164,
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: category.isArchived
                          ? theme.colorScheme.shadow.withOpacity(.2)
                          : theme.colorScheme.onPrimary,
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: CustomPaint(
                      painter: CurvedPainter(
                        isHaveSubCategory:
                            category.subCategories.isNotEmpty || category.articles.isNotEmpty,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            category.title,
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    start: 10,
                    top: 10,
                    child: Visibility(
                      visible: category.isArchived,
                      child: Icon(
                        FrinoIcons.f_lock,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Images.avatar,
                const SizedBox(width: 4),
                SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.authorName,
                        maxLines: 1,
                        style: theme.textTheme.bodySmall,
                      ),
                      if (category.createdAt != null)
                        Text(
                          LocaleService.timeAgoTranslated(
                            category.editedAt ?? category.createdAt!,
                            translate,
                          ),
                          maxLines: 1,
                          style: theme.textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
