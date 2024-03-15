import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zad_app/models/content_langague.dart';
import 'package:zad_app/models/convertors.dart';

part '../generated/models/articles.freezed.dart';
part '../generated/models/articles.g.dart';

@freezed
class DawaArticle with _$DawaArticle {
  const factory DawaArticle({
    required String id,
    required String categoryId,
    required String title,
    required Map<String, dynamic> content,
    required String authorId,
    required String authorName,
    required ContentLanguage language,
    String? authorImage,
    String? image,
    @ServerTimestampConverter() DateTime? archivedAt,
    @ServerTimestampConverter() DateTime? createdAt,
    @ServerTimestampConverter() DateTime? editedAt,
    @Default(false) bool isArchived,
  }) = _DawaArticle;

  factory DawaArticle.fromJson(Map<String, dynamic> json) => _$DawaArticleFromJson(json);
}
