import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zad_app/models/app_banner.dart';
import 'package:zad_app/models/articles.dart';
import 'package:zad_app/models/category.dart';
import 'package:zad_app/providers/app_settings.dart';
import 'package:zad_app/utils/conestants/firebase_collections.dart';

part '../generated/providers/home.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(<DawaArticle>[]) List<DawaArticle> articles,
    @Default(<DawaCategory>[]) List<DawaCategory> categories,
    @Default(<AppBanner>[]) List<AppBanner> banners,
  }) = _HomeState;
}

final getRootCategoriesFutureProvider = FutureProvider((ref) async {
  try {
    final language = ref.watch(appSettingsProvider).selectedLanguage;

    final categoryQuery = FirebaseCollections.categories
        .withConverter<DawaCategory>(
          fromFirestore: (snapshot, _) =>
              DawaCategory.fromJson(snapshot.data()!),
          toFirestore: (category, _) => category.toJson(),
        )
        .where(
          'language',
          isEqualTo: language!.toJson(),
        )
        .where(
          'parentCategory',
          isEqualTo: null,
        )
        .where(
          'isArchived',
          isEqualTo: false,
        )
        .where(
          'articles',
          isNotEqualTo: null,
        )
        .orderBy(
          'createdAt',
          descending: true,
        )
        .orderBy(
          'editedAt',
          descending: true,
        );
    final categories = await categoryQuery.get();
    return categories.docs.map((e) => e.data()).toList();
  } catch (e) {
    throw Exception('Failed to get categories: $e');
  }
});

final _getLastTenArticlesFutureProvider =
    Provider<Future<List<DawaArticle>>>((ref) async {
  try {
    final language = ref.watch(appSettingsProvider).selectedLanguage;

    final articleQuery = FirebaseCollections.articles
        .withConverter<DawaArticle>(
          fromFirestore: (snapshot, _) =>
              DawaArticle.fromJson(snapshot.data()!),
          toFirestore: (article, _) => article.toJson(),
        )
        .where(
          'language',
          isEqualTo: language!.toJson(),
        )
        .where(
          'isArchived',
          isEqualTo: false,
        )
        .orderBy('createdAt', descending: true)
        .orderBy('editedAt', descending: true)
        .limit(10);
    final articles = await articleQuery.get();
    return articles.docs.map((e) => e.data()).toList();
  } catch (e) {
    throw Exception('Failed to get articles: $e');
  }
});

final getUserListOfArticlesByIdsFutureProvider =
    FutureProvider.family((ref, Set<String> list) async {
  try {
    if (list.isEmpty) return <DawaArticle>[];
    final language = ref.watch(appSettingsProvider).selectedLanguage;

    final articleQuery = FirebaseCollections.articles
        .withConverter<DawaArticle>(
          fromFirestore: (snapshot, _) =>
              DawaArticle.fromJson(snapshot.data()!),
          toFirestore: (article, _) => article.toJson(),
        )
        .where(
          FieldPath.documentId,
          whereIn: list,
        )
        .where(
          'language',
          isEqualTo: language!.toJson(),
        )
        .where(
          'isArchived',
          isEqualTo: false,
        );

    final articles = await articleQuery.get();
    return articles.docs.map((e) => e.data()).toList();
  } catch (e) {
    throw Exception('Faild to get articles $e');
  }
});

final getUserListOfArticlesFutureProvider = FutureProvider((ref) async {
  try {
    final language = ref.watch(appSettingsProvider).selectedLanguage;

    final articleQuery = FirebaseCollections.articles
        .withConverter<DawaArticle>(
          fromFirestore: (snapshot, _) =>
              DawaArticle.fromJson(snapshot.data()!),
          toFirestore: (article, _) => article.toJson(),
        )
        .where(
          'language',
          isEqualTo: language!.toJson(),
        )
        .where(
          'isArchived',
          isEqualTo: false,
        );

    final articles = await articleQuery.get();
    return articles.docs.map((e) => e.data()).toList();
  } catch (e) {
    throw Exception('Faild to get articles $e');
  }
});
final _getLastTenCategoriesFutureProvider =
    Provider<Future<List<DawaCategory>>>((ref) async {
  try {
    final language = ref.watch(appSettingsProvider).selectedLanguage;

    final articleQuery = FirebaseCollections.categories
        .withConverter<DawaCategory>(
          fromFirestore: (snapshot, _) =>
              DawaCategory.fromJson(snapshot.data()!),
          toFirestore: (category, _) => category.toJson(),
        )
        .where(
          'language',
          isEqualTo: language!.toJson(),
        )
        .where(
          'articles',
          isNotEqualTo: null,
        )
        .where(
          'isArchived',
          isEqualTo: false,
        )
        .orderBy('createdAt', descending: true)
        .orderBy('editedAt', descending: true)
        .limit(10);
    final categories = await articleQuery.get();
    return categories.docs.map((e) => e.data()).toList();
  } catch (e) {
    throw Exception('Failed to get categories: $e');
  }
});

final _getBannersFutureProvider =
    Provider<Future<List<AppBanner>>>((ref) async {
  try {
    final bannersQuery = FirebaseCollections.banners.withConverter<AppBanner>(
      fromFirestore: (snapshot, _) => AppBanner.fromJson(snapshot.data()!),
      toFirestore: (banner, _) => banner.toJson(),
    );
    final banners = await bannersQuery.get();
    return banners.docs.map((e) => e.data()).toList();
  } catch (e, st) {
    log("$e", stackTrace: st, name: "_getBannersFutureProvider");
    throw Exception('Failed to get banners: $e');
  }
});

final homeStateProvider =
    StateNotifierProvider<HomeStateController, AsyncValue<HomeState>>((ref) {
  return HomeStateController(ref: ref);
});

class HomeStateController extends StateNotifier<AsyncValue<HomeState>> {
  final Ref ref;

  HomeStateController({
    required this.ref,
  }) : super(const AsyncValue.loading()) {
    _fetch();
  }

  Future<void> _fetch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        final futures = await Future.wait([
          ref.read(_getLastTenArticlesFutureProvider),
          ref.read(_getLastTenCategoriesFutureProvider),
          ref.read(_getBannersFutureProvider),
        ]);
        final articles = futures[0] as List<DawaArticle>;
        final categories = futures[1] as List<DawaCategory>;
        final banners = futures[2] as List<AppBanner>;
        return Future<HomeState>(
          () => HomeState(
            articles: articles,
            categories: categories,
            banners: banners,
          ),
        );
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    });
  }
}
