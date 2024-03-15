import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/components/progress_index.dart';
import 'package:zad_app/providers/home.dart';
import 'package:zad_app/screens/content/article_widget.dart';
import 'package:zad_app/screens/home/components/article_inside.dart';
import 'package:zad_app/utils/theme/images.dart';

class ArticleList extends ConsumerWidget {
  final String title;
  final Set<String> ids;

  const ArticleList({
    super.key,
    required this.title,
    required this.ids,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(getUserListOfArticlesByIdsFutureProvider(ids));
    final media = MediaQuery.of(context);

    return Scaffold(
      appBar: SubScreenAppbar(title: title),
      body: articles.when(
        data: (data) => data.isEmpty
            ? Images.notFound
            : ListView.separated(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 16.0 : .0),
                    child: ArticleWidget(
                      article: data[index],
                      onPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ArticleInside(
                              content: data[index].content,
                              title: data[index].title,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 22,
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
    );
  }
}
