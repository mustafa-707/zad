// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/articles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DawaArticleImpl _$$DawaArticleImplFromJson(Map<String, dynamic> json) =>
    _$DawaArticleImpl(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      title: json['title'] as String,
      content: json['content'] as Map<String, dynamic>,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      language:
          ContentLanguage.fromJson(json['language'] as Map<String, dynamic>),
      authorImage: json['authorImage'] as String?,
      image: json['image'] as String?,
      archivedAt: const ServerTimestampConverter().fromJson(json['archivedAt']),
      createdAt: const ServerTimestampConverter().fromJson(json['createdAt']),
      editedAt: const ServerTimestampConverter().fromJson(json['editedAt']),
      isArchived: json['isArchived'] as bool? ?? false,
    );

Map<String, dynamic> _$$DawaArticleImplToJson(_$DawaArticleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'title': instance.title,
      'content': instance.content,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'language': instance.language.toJson(),
      'authorImage': instance.authorImage,
      'image': instance.image,
      'archivedAt':
          const ServerTimestampConverter().toJson(instance.archivedAt),
      'createdAt': const ServerTimestampConverter().toJson(instance.createdAt),
      'editedAt': const ServerTimestampConverter().toJson(instance.editedAt),
      'isArchived': instance.isArchived,
    };
