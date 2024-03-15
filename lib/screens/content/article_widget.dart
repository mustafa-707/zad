import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:zad_app/models/articles.dart';
import 'package:zad_app/utils/lang/locale.dart';
import 'package:zad_app/utils/lang/locale.export.dart';
import 'package:zad_app/utils/theme/images.dart';

class ArticleWidget extends StatelessWidget {
  final GestureTapCallback onPress;
  final DawaArticle article;
  const ArticleWidget({
    super.key,
    required this.onPress,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Stack(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            margin: const EdgeInsetsDirectional.symmetric(
              horizontal: 40.0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [-0.5, 0.5],
                colors: [
                  theme.colorScheme.onPrimary,
                  theme.colorScheme.background,
                ],
              ),
              border: Border.all(
                color: const Color(0xffFDF8FD),
                width: .8,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff344054).withOpacity(.2),
                  spreadRadius: 4,
                  blurRadius: 30,
                  offset: const Offset(16, 14),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16.0,
                end: 16.0,
                top: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        LocaleService.timeAgoTranslated(
                          article.editedAt ?? article.createdAt!,
                          translate,
                        ),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.shadow.withOpacity(.2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.secondary,
                      height: 1.2,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Images.avatar,
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 100,
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          article.authorName,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: theme.colorScheme.shadow,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Positioned.fill(
            right: 0,
            bottom: 0,
            child: Visibility(
              visible: article.isArchived,
              child: Container(
                height: 150,
                width: double.infinity,
                margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: 40.0,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.shadow.withOpacity(.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 56.0,
            bottom: 16,
            child: Visibility(
              visible: article.isArchived,
              child: Icon(
                FrinoIcons.f_lock,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
