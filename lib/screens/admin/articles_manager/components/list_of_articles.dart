import 'package:flutter/material.dart';
import 'package:zad_app/models/articles.dart';
import 'package:zad_app/screens/admin/articles_manager/components/article_widget.dart';
import 'package:zad_app/utils/theme/images.dart';

class ListOfArticles extends StatelessWidget {
  final List<DawaArticle> data;
  final String categoryId;
  final Function(String) onRefresh;

  const ListOfArticles({
    super.key,
    required this.data,
    required this.categoryId,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? Images.notFound
        : ListView.separated(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 16.0 : .0),
                child: ArticleAdminWidget(
                  article: data[index],
                  categoryId: categoryId,
                  onRefresh: onRefresh,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 22,
            ),
          );
  }
}
