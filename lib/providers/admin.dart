import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/models/articles.dart';
import 'package:zad_app/models/category.dart';
import 'package:zad_app/models/content_langague.dart';
import 'package:zad_app/utils/conestants/firebase_collections.dart';

class CategoryOptions {
  final ContentLanguage language;
  final Set<String>? subCategoriesIds;

  CategoryOptions({
    required this.language,
    this.subCategoriesIds,
  });
}

final _getRootCategoriesFutureProvider = FutureProvider.family((
  ref,
  ContentLanguage language,
) async {
  try {
    final categoryQuery = FirebaseCollections.categories
        .withConverter<DawaCategory>(
          fromFirestore: (snapshot, _) => DawaCategory.fromJson(snapshot.data()!),
          toFirestore: (category, _) => category.toJson(),
        )
        .where(
          'language',
          isEqualTo: language.toJson(),
        )
        .where(
          'parentId',
          isNull: true,
        );
    final categories = await categoryQuery.get();
    return categories.docs.map((e) => e.data()).toList();
  } catch (e) {
    throw Exception('Faild to get categories $e');
  }
});

final getListOfCategoriesByIdsFutureProvider = FutureProvider.family((ref, Set<String> list) async {
  try {
    final categoryQuery = FirebaseCollections.categories
        .withConverter<DawaCategory>(
          fromFirestore: (snapshot, _) => DawaCategory.fromJson(snapshot.data()!),
          toFirestore: (category, _) => category.toJson(),
        )
        .where(
          FieldPath.documentId,
          whereIn: list,
        );

    final categories = await categoryQuery.get();
    return categories.docs.map((e) => e.data()).toList();
  } catch (e) {
    throw Exception('Faild to get categories $e');
  }
});

final categoriesManagerProvider = StateNotifierProvider.family<CategoriesStateController,
    AsyncValue<List<DawaCategory>>, CategoryOptions>((ref, options) {
  return CategoriesStateController(options.language, ref, options.subCategoriesIds);
});

class CategoriesStateController extends StateNotifier<AsyncValue<List<DawaCategory>>> {
  final ContentLanguage language;
  final Ref ref;
  final Set<String>? subCategoriesIds;
  CategoriesStateController(this.language, this.ref, [this.subCategoriesIds])
      : super(_initCategories(ref, language, subCategoriesIds));

  static AsyncValue<List<DawaCategory>> _initCategories(Ref ref, ContentLanguage language,
      [Set<String>? subCategoriesIds]) {
    try {
      if (subCategoriesIds == null) {
        ref.invalidate(_getRootCategoriesFutureProvider(language));
        return ref.watch(_getRootCategoriesFutureProvider(language));
      } else {
        ref.invalidate(getListOfCategoriesByIdsFutureProvider(subCategoriesIds));
        return ref.watch(getListOfCategoriesByIdsFutureProvider(subCategoriesIds));
      }
    } catch (e) {
      throw Exception('Faild to get categories $e');
    }
  }

  void _refresh() {
    state = state.copyWithPrevious(_initCategories(
      ref,
      language,
    ));
  }

  Future<void> create(DawaCategory newCategory) async {
    try {
      final categoryQuery = FirebaseCollections.categories.withConverter<DawaCategory>(
        fromFirestore: (snapshot, _) => DawaCategory.fromJson(snapshot.data()!),
        toFirestore: (category, _) => category.toJson(),
      );

      await categoryQuery.doc(newCategory.id).set(newCategory);
      _refresh();
    } catch (e) {
      throw Exception('Faild to create category $e');
    }
  }

  Future<void> createSubCategory(DawaCategory parent, DawaCategory child) async {
    try {
      final categoryQuery = FirebaseCollections.categories.withConverter<DawaCategory>(
        fromFirestore: (snapshot, _) => DawaCategory.fromJson(snapshot.data()!),
        toFirestore: (category, _) => category.toJson(),
      );
      final updatedParent = updateSubCategoryParent(parent, child.id);
      await update(updatedParent, false);
      await categoryQuery.doc(child.id).set(child);
    } catch (e) {
      throw Exception('Faild to createSubCategory $e');
    }
  }

  DawaCategory updateSubCategoryParent(DawaCategory parent, String childId) {
    final subCategories = List<String>.from(parent.subCategories);

    subCategories.add(childId);

    return parent.copyWith(subCategories: subCategories.toSet());
  }

  Future<void> update(DawaCategory newCategory, [bool refresh = true]) async {
    try {
      final categoryQuery = FirebaseCollections.categories.withConverter<DawaCategory>(
        fromFirestore: (snapshot, _) => DawaCategory.fromJson(snapshot.data()!),
        toFirestore: (category, _) => category.toJson(),
      );

      await categoryQuery.doc(newCategory.id).update(
            newCategory.toJson(),
          );
      if (refresh) _refresh();
    } catch (e) {
      throw Exception('Faild to update category $e');
    }
  }
}

final getArticleFutureProvider = FutureProvider.family((ref, String id) async {
  try {
    final articleQuery = FirebaseCollections.articles.withConverter<DawaArticle>(
      fromFirestore: (snapshot, _) => DawaArticle.fromJson(snapshot.data()!),
      toFirestore: (article, _) => article.toJson(),
    );

    final articles = await articleQuery.doc(id).get();
    if (articles.data() == null) throw Exception('Article not found');
    return articles.data();
  } catch (e) {
    throw Exception('Faild to get categories $e');
  }
});

final getListOfArticlesByIdsFutureProvider = FutureProvider.family((ref, Set<String> list) async {
  try {
    if (list.isEmpty) return <DawaArticle>[];
    final articleQuery = FirebaseCollections.articles
        .withConverter<DawaArticle>(
          fromFirestore: (snapshot, _) => DawaArticle.fromJson(snapshot.data()!),
          toFirestore: (article, _) => article.toJson(),
        )
        .where(
          FieldPath.documentId,
          whereIn: list,
        );

    final articles = await articleQuery.get();
    return articles.docs.map((e) => e.data()).toList();
  } catch (e) {
    throw Exception('Faild to get articles $e');
  }
});

class ContentManagerService {
  static Future<void> createArticle(DawaArticle newArticle) async {
    try {
      final articleQuery = FirebaseCollections.articles.withConverter<DawaArticle>(
        fromFirestore: (snapshot, _) => DawaArticle.fromJson(snapshot.data()!),
        toFirestore: (article, _) => article.toJson(),
      );

      await articleQuery.doc(newArticle.id).set(newArticle);
    } catch (e) {
      throw Exception('Faild to create article $e');
    }
  }

  static Future<void> updateArticle(DawaArticle newArticle) async {
    try {
      final articleQuery = FirebaseCollections.articles.withConverter<DawaArticle>(
        fromFirestore: (snapshot, _) => DawaArticle.fromJson(snapshot.data()!),
        toFirestore: (article, _) => article.toJson(),
      );

      await articleQuery.doc(newArticle.id).update(newArticle.toJson());
    } catch (e) {
      throw Exception('Faild to create article $e');
    }
  }
}
