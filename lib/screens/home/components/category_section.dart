import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/models/category.dart';
import 'package:zad_app/screens/content/category_widget.dart';
import 'package:zad_app/screens/home/components/articles_list.dart';
import 'package:zad_app/screens/home/components/categories_list.dart';
import 'package:zad_app/screens/home/components/more_categories.dart';
import 'package:zad_app/utils/lang/locale.export.dart';
import 'package:zad_app/utils/theme/colors.dart';

class CategorySection extends ConsumerWidget {
  final List<DawaCategory> categories;

  const CategorySection({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final translate = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate.latestCategories,
                style: theme.textTheme.titleLarge,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RootCategoriesList(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    translate.more,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.ancor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 150,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  if (index == 0) const SizedBox(width: 16),
                  CategoryWidget(
                    category: categories[index],
                    onTap: () {
                      if (categories[index].subCategories.isEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleList(
                              title: categories[index].title,
                              ids: categories[index].articles,
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
                  ),
                  if (index + 1 == categories.length) const SizedBox(width: 16),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 16),
          ),
        )
      ],
    );
  }
}
