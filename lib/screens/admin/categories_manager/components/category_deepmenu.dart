import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:zad_app/components/dialogs.dart';
import 'package:zad_app/components/progress_index.dart';
import 'package:zad_app/models/category.dart';
import 'package:zad_app/providers/admin.dart';
import 'package:zad_app/providers/app_settings.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

class CategoryDeepMenu extends StatefulHookConsumerWidget {
  final DawaCategory data;

  const CategoryDeepMenu({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryDeepMenuState();
}

class _CategoryDeepMenuState extends ConsumerState<CategoryDeepMenu> {
  Future<void> onProcess = Future.value();

  @override
  Widget build(BuildContext context) {
    final editTitleController = useTextEditingController();
    final translate = AppLocalizations.of(context)!;

    final theme = Theme.of(context);
    final provider = ref.watch(
      categoriesManagerProvider(
        CategoryOptions(
          language: widget.data.language,
          subCategoriesIds: widget.data.subCategories.isEmpty ? null : widget.data.subCategories,
        ),
      ).notifier,
    );

    final isLoading = useFuture(onProcess).connectionState == ConnectionState.waiting;

    return Stack(
      children: [
        Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        addCategoryTitleDialog(
                          context,
                          editTitleController,
                          mounted,
                          title: translate.editCategory,
                          hint: translate.enterCategoryName,
                          actionText: translate.edit,
                          onTap: () async {
                            if (isLoading) return;
                            final editedCategory = widget.data;
                            setState(() {
                              onProcess = Future.microtask(() async {
                                if (mounted) Navigator.pop(context);
                                await provider.update(
                                  editedCategory.copyWith(
                                    title: editTitleController.text.trim(),
                                    editedAt: DateTime.now(),
                                  ),
                                );
                              });
                            });
                          },
                        );
                      },
                      child: AnimatedContainer(
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99.0),
                          color: theme.colorScheme.background,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          FrinoIcons.f_edit,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    Text(translate.edit)
                  ],
                ),
                const SizedBox(width: 52),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final editedCategory = widget.data;
                        warningDialog(
                          context,
                          title: editedCategory.isArchived
                              ? translate.activateCategory
                              : translate.deleteCategory,
                          subtitle: editedCategory.isArchived
                              ? translate.activeCategoryTitle
                              : translate.archiveCategoryTitle,
                          actionText:
                              editedCategory.isArchived ? translate.active : translate.archive,
                          onTap: () async {
                            if (isLoading) return;
                            setState(() {
                              onProcess = Future.microtask(() async {
                                if (mounted) Navigator.pop(context);
                                await provider.update(
                                  editedCategory.copyWith(
                                    archivedAt: DateTime.now(),
                                    isArchived: !editedCategory.isArchived,
                                  ),
                                );
                              });
                            });
                          },
                        );
                      },
                      child: AnimatedContainer(
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99.0),
                          color: theme.colorScheme.background,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          widget.data.isArchived ? FrinoIcons.f_check : FrinoIcons.f_delete,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    Text(widget.data.isArchived ? translate.active : translate.archive)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    addCategoryTitleDialog(
                      context,
                      editTitleController,
                      true,
                      title: translate.addSubCategory,
                      hint: translate.enterCategoryName,
                      actionText: translate.add,
                      onTap: () async {
                        if (isLoading) return;
                        final uuid = const Uuid().v1();
                        final user = ref.read(appSettingsProvider).user;
                        setState(
                          () {
                            onProcess = Future.microtask(
                              () async {
                                if (mounted) Navigator.pop(context);
                                if (widget.data.articles.isNotEmpty) {
                                  warningDialog(
                                    context,
                                    title: translate.cannotCreateSubCategory,
                                    subtitle: translate.hasArticles,
                                    actionText: translate.ok,
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                  );
                                  return;
                                }
                                await provider.createSubCategory(
                                  widget.data,
                                  DawaCategory(
                                    id: uuid,
                                    parentId: widget.data.id,
                                    title: editTitleController.text,
                                    authorName: user?.info?.name ?? "Someone",
                                    authorId: user!.user!.uid,
                                    language: widget.data.language,
                                    createdAt: DateTime.now(),
                                    authorImage: user.info?.image ?? 'assets/images/avatar.svg',
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99.0),
                      color: theme.colorScheme.background,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      FrinoIcons.f_rename,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                Text(translate.addSubCategory)
              ],
            ),
          ],
        ),
        Positioned.fill(
          child: Visibility(
            visible: isLoading,
            child: const Center(
              child: AppProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}
