import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zad_app/models/content_langague.dart';
import 'package:zad_app/models/convertors.dart';

part '../generated/models/category.freezed.dart';
part '../generated/models/category.g.dart';

@freezed
class DawaCategory with _$DawaCategory {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory DawaCategory({
    required String id,
    @Default({}) Set<String> subCategories,
    @Default({}) Set<String> articles,
    String? parentId,
    required ContentLanguage language,
    required String title,
    String? image,
    required String authorId,
    required String authorName,
    @ServerTimestampConverter() DateTime? archivedAt,
    @ServerTimestampConverter() DateTime? createdAt,
    @ServerTimestampConverter() DateTime? editedAt,
    @Default(false) bool isArchived,
    String? authorImage,
  }) = _DawaCategory;

  factory DawaCategory.fromJson(Map<String, dynamic> json) => _$DawaCategoryFromJson(json);
}
