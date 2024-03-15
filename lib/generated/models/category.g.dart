// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DawaCategoryImpl _$$DawaCategoryImplFromJson(Map<String, dynamic> json) =>
    _$DawaCategoryImpl(
      id: json['id'] as String,
      subCategories: (json['subCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      articles:
          (json['articles'] as List<dynamic>?)?.map((e) => e as String).toSet(),
      parentId: json['parentId'] as String?,
      language:
          ContentLanguage.fromJson(json['language'] as Map<String, dynamic>),
      title: json['title'] as String,
      image: json['image'] as String?,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      archivedAt: const ServerTimestampConverter().fromJson(json['archivedAt']),
      createdAt: const ServerTimestampConverter().fromJson(json['createdAt']),
      editedAt: const ServerTimestampConverter().fromJson(json['editedAt']),
      isArchived: json['isArchived'] as bool? ?? false,
      authorImage: json['authorImage'] as String?,
    );

Map<String, dynamic> _$$DawaCategoryImplToJson(_$DawaCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subCategories': instance.subCategories.toList(),
      'articles': instance.articles?.toList(),
      'parentId': instance.parentId,
      'language': instance.language.toJson(),
      'title': instance.title,
      'image': instance.image,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'archivedAt':
          const ServerTimestampConverter().toJson(instance.archivedAt),
      'createdAt': const ServerTimestampConverter().toJson(instance.createdAt),
      'editedAt': const ServerTimestampConverter().toJson(instance.editedAt),
      'isArchived': instance.isArchived,
      'authorImage': instance.authorImage,
    };
