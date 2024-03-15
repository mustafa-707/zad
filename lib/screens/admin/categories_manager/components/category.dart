import 'package:deep_menu/deep_menu.dart';
import 'package:flutter/material.dart';
import 'package:zad_app/models/category.dart';
import 'package:zad_app/screens/admin/articles_manager/articles_manager.dart';
import 'package:zad_app/screens/admin/categories_manager/categories_manager.dart';
import 'package:zad_app/screens/admin/categories_manager/components/category_deepmenu.dart';
import 'package:zad_app/screens/content/category_widget.dart';

class CategoryAdminWidget extends StatelessWidget {
  final DawaCategory data;

  const CategoryAdminWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return DeepMenu(
        bodyMenu: ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            CategoryDeepMenu(
              data: data,
            ),
          ],
        ),
        child: CategoryWidget(
          onTap: () {
            if (data.subCategories.isEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticlesManager(
                    title: data.title,
                    ids: data.articles ?? {},
                    selectedLanguage: data.language,
                    parentCategory: data,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesManager(
                    title: data.title,
                    selectedLanguage: data.language,
                    subCategoriesIds: data.subCategories,
                  ),
                ),
              );
            }
          },
          category: data,
        ));
  }
}
