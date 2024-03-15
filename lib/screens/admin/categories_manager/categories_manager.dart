import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/components/appbar/sub_screen_appbar.dart';
import 'package:zad_app/components/buttons/floating_btn.dart';
import 'package:zad_app/components/dialogs.dart';
import 'package:zad_app/components/progress_index.dart';
import 'package:zad_app/models/category.dart';
import 'package:zad_app/models/content_langague.dart';
import 'package:zad_app/providers/admin.dart';
import 'package:zad_app/providers/app_settings.dart';
import 'package:zad_app/screens/admin/categories_manager/components/list_of_categories.dart';
import 'package:zad_app/utils/theme/images.dart';
import 'package:uuid/uuid.dart';

class CategoriesManager extends StatefulHookConsumerWidget {
  final String title;
  final ContentLanguage selectedLanguage;
  final Set<String>? subCategoriesIds;
  final DawaCategory? parent;

  const CategoriesManager({
    super.key,
    required this.title,
    required this.selectedLanguage,
    this.subCategoriesIds,
    this.parent,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoriesManagerState();
}

class _CategoriesManagerState extends ConsumerState<CategoriesManager> {
  Future<void> onProcess = Future.value();

  @override
  Widget build(BuildContext context) {
    final createTitleController = useTextEditingController();

    final categories = ref.watch(
      categoriesManagerProvider(CategoryOptions(
        language: widget.selectedLanguage,
        subCategoriesIds: widget.subCategoriesIds,
      )),
    );
    final user = ref.watch(appSettingsProvider).user;
    final isLoading = useFuture(onProcess).connectionState == ConnectionState.waiting;

    return Scaffold(
      appBar: SubScreenAppbar(title: widget.title),
      floatingActionButton: AppFloatingActionButton(
        onPressed: () {
          addCategoryTitleDialog(
            context,
            createTitleController,
            true,
            title: 'Create new category',
            hint: 'Enter category name',
            actionText: 'Create',
            onTap: () async {
              if (isLoading) return;
              final uuid = const Uuid().v1();
              final provider = ref.read(
                categoriesManagerProvider(
                  CategoryOptions(
                    language: widget.selectedLanguage,
                    subCategoriesIds: widget.subCategoriesIds,
                  ),
                ).notifier,
              );
              final newCategory = DawaCategory(
                id: uuid,
                parentId: widget.parent?.id,
                title: createTitleController.text.trim(),
                authorName: user?.info?.name ?? "Someone",
                authorId: user!.user!.uid,
                language: widget.selectedLanguage,
                createdAt: DateTime.now(),
                authorImage: user.info?.image ?? 'assets/images/avatar.svg',
              );
              setState(() {
                onProcess = Future.microtask(() async {
                  if (widget.parent != null) {
                    await provider.createSubCategory(widget.parent!, newCategory);
                  } else {
                    await provider.create(newCategory);
                  }
                });
              });
            },
          );
        },
        icon: FrinoIcons.f_plus,
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          Expanded(
            child: categories.when(
              data: (data) => ListOfCategories(
                data: data,
              ),
              loading: () => const Center(child: AppProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Images.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
