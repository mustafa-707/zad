import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/components/appbar/search.dart';
import 'package:zad_app/components/fields/search_field.dart';
import 'package:zad_app/providers/home.dart';
import 'package:zad_app/screens/content/article_widget.dart';
import 'package:zad_app/screens/home/components/article_inside.dart';
import 'package:zad_app/utils/hooks/editor_hook.dart';
import 'package:zad_app/utils/hooks/share_hook.dart';

class SearchScreen extends StatefulHookConsumerWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final articles = ref.watch(getUserListOfArticlesFutureProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(
        searchField: SearchField(
          onChange: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
      ),
      body: articles.when(
        data: (data) {
          final sortedData = data.where(
            (e) {
              final nodes = useEditorController(e.content);
              final text = useShareController(nodes.state.document.root.children);
              return e.title.toLowerCase().startsWith(
                        searchText.toLowerCase(),
                      ) ||
                  text.concatenateWithSeparator.toLowerCase().contains(searchText.toLowerCase());
            },
          ).toList();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: ListView.separated(
              itemCount: sortedData.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    if (index == 0) const SizedBox(height: 24),
                    ArticleWidget(
                      article: sortedData[index],
                      onPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ArticleInside(
                              content: sortedData[index].content,
                              title: sortedData[index].title,
                            ),
                          ),
                        );
                      },
                    ),
                    if (index == sortedData.length - 1) const SizedBox(height: 24),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          );
        },
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
