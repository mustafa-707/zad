import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/components/progress_index.dart';
import 'package:zad_app/providers/home.dart';
import 'package:zad_app/screens/home/components/articles_section.dart';
import 'package:zad_app/screens/home/components/category_section.dart';
import 'package:zad_app/screens/home/components/search_field.dart';
import 'package:zad_app/utils/theme/images.dart';

import 'components/banners_slider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final homeState = ref.watch(homeStateProvider);

    return SingleChildScrollView(
      child: homeState.when(
        data: (data) => Column(
          children: [
            const SizedBox(height: 32),
            const SearchWidget(),
            const SizedBox(height: 16),
            BannersSlider(banners: data.banners),
            const SizedBox(height: 16),
            Column(
              children: [
                CategorySection(
                  categories: data.categories,
                ),
                const SizedBox(height: 32),
              ],
            ),
            ArticlesSection(articles: data.articles),
          ],
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
