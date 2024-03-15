import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/components/buttons/floating_btn.dart';
import 'package:zad_app/components/progress_index.dart';
import 'package:zad_app/models/articles.dart';
import 'package:zad_app/models/category.dart';
import 'package:zad_app/models/content_langague.dart';
import 'package:zad_app/providers/admin.dart';
import 'package:zad_app/providers/app_settings.dart';
import 'package:zad_app/screens/admin/articles_manager/components/list_of_articles.dart';
import 'package:zad_app/screens/admin/editor/editor.dart';
import 'package:zad_app/utils/theme/images.dart';

class ArticlesManager extends ConsumerWidget {
  final String title;
  final Set<String> ids;
  final DawaCategory parentCategory;
  final ContentLanguage selectedLanguage;

  const ArticlesManager({
    super.key,
    required this.ids,
    required this.title,
    required this.parentCategory,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(getListOfArticlesByIdsFutureProvider(ids));
    final user = ref.watch(appSettingsProvider).user;

    return Scaffold(
      appBar: SubScreenAppbar(title: title),
      floatingActionButton: AppFloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorWidget(
                onSave: (title, content) async {
                  final uuid = const Uuid().v1();

                  final newArticle = DawaArticle(
                    id: uuid,
                    categoryId: parentCategory.id,
                    title: title,
                    content: content,
                    language: selectedLanguage,
                    authorName: user?.info?.name ?? "Someone",
                    authorId: user!.user!.uid,
                    createdAt: DateTime.now(),
                    authorImage: user.info?.image ?? 'assets/images/avatar.svg',
                    image: "",
                  );
                  await ContentManagerService.createArticle(newArticle);
                  await Future.delayed(const Duration(seconds: 2));
                  await updateLists(ref, newArticle.id);
                },
              ),
            ),
          );
        },
        icon: FrinoIcons.f_plus,
      ),
      body: Column(
        children: [
          Expanded(
            child: articles.when(
              data: (data) => ListOfArticles(
                data: data,
                categoryId: parentCategory.id,
                onRefresh: (String id) async {
                  final _ = ref.invalidate(getListOfArticlesByIdsFutureProvider(ids));
                },
              ),
              loading: () => const Center(child: AppProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Images.error,
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> updateLists(WidgetRef ref, articleId) async {
    final newArticles = List<String>.from(
      parentCategory.articles ?? {},
    );

    newArticles.add(articleId);

    final updatedCategory = parentCategory.copyWith(
      articles: newArticles.toSet(),
    );

    await ref
        .read(
          categoriesManagerProvider(CategoryOptions(
            language: parentCategory.language,
            subCategoriesIds: parentCategory.subCategories,
          )).notifier,
        )
        .update(
          updatedCategory,
        );
    final _ = ref.invalidate(getListOfArticlesByIdsFutureProvider(ids));
  }
}
