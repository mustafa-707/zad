import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/components/progress_index.dart';
import 'package:zad_app/providers/admin.dart';
import 'package:zad_app/screens/content/category_widget.dart';
import 'package:zad_app/screens/home/components/articles_list.dart';
import 'package:zad_app/utils/theme/images.dart';

class CategoriesList extends ConsumerWidget {
  final String title;
  final Set<String> ids;

  const CategoriesList({
    super.key,
    required this.title,
    required this.ids,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesProvider = ref.watch(getListOfCategoriesByIdsFutureProvider(ids));
    final media = MediaQuery.of(context);

    return Scaffold(
      appBar: SubScreenAppbar(title: title),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: categoriesProvider.when(
          data: (categories) => categories.isEmpty
              ? Images.notFound
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GridView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryWidget(
                        category: categories[index],
                        onTap: () {
                          if (categories[index].subCategories.isEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticleList(
                                  title: categories[index].title,
                                  ids: categories[index].articles ?? {},
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesList(
                                  title: categories[index].title,
                                  ids: categories[index].subCategories,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 174,
                    ),
                  ),
                ),
          error: (error, stackTrace) => Center(
            child: Images.error,
          ),
          loading: () => SizedBox(
            // 200 is estimated of the center without appbar and other stuff,
            height: media.size.height - 200,
            child: const Center(
              child: AppProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
