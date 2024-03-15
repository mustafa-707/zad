import 'package:flutter/material.dart';
import 'package:zad_app/models/articles.dart';
import 'package:zad_app/screens/content/article_widget.dart';
import 'package:zad_app/screens/home/components/article_inside.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

class ArticlesSection extends StatelessWidget {
  final List<DawaArticle> articles;
  const ArticlesSection({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
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
                translate.latestArticles,
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: (articles.length * 150) + 250,
          child: ListView.separated(
            itemCount: articles.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  if (index == 0) const SizedBox(height: 16),
                  ArticleWidget(
                    article: articles[index],
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ArticleInside(
                            content: articles[index].content,
                            title: articles[index].title,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 28,
            ),
          ),
        )
      ],
    );
  }
}
