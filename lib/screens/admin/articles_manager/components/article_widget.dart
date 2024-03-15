import 'package:deep_menu/deep_menu.dart';
import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/components/dialogs.dart';
import 'package:zad_app/models/articles.dart';
import 'package:zad_app/providers/admin.dart';
import 'package:zad_app/screens/admin/editor/editor.dart';
import 'package:zad_app/screens/content/article_widget.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

class ArticleAdminWidget extends ConsumerWidget {
  final DawaArticle article;
  final String categoryId;
  final Function(String) onRefresh;

  const ArticleAdminWidget({
    super.key,
    required this.categoryId,
    required this.article,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final translate = AppLocalizations.of(context)!;

    return DeepMenu(
      bodyMenu: Column(
        children: [
          GestureDetector(
            onTap: () {
              warningDialog(
                context,
                title: translate.deleteArticle,
                subtitle: article.isArchived
                    ? translate.activeArticleTitle
                    : translate.archiveArticleTitle,
                actionText: article.isArchived ? translate.active : translate.archive,
                onTap: () async {
                  Navigator.pop(context);
                  final newArticle = article.copyWith(
                    archivedAt: DateTime.now(),
                    isArchived: !article.isArchived,
                  );
                  await ContentManagerService.updateArticle(newArticle);
                  onRefresh(article.id);
                },
              );
            },
            child: AnimatedContainer(
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99.0),
                color: theme.colorScheme.background,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                article.isArchived ? FrinoIcons.f_check : FrinoIcons.f_delete,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          Text(article.isArchived ? translate.active : translate.archive)
        ],
      ),
      child: ArticleWidget(
        article: article,
        onPress: () {
          //edit
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorWidget(
                title: article.title,
                content: article.content,
                onSave: (title, content) async {
                  final newArticle = article.copyWith(
                    editedAt: DateTime.now(),
                    title: title,
                    content: content,
                  );
                  await ContentManagerService.updateArticle(newArticle);
                  onRefresh(article.id);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
