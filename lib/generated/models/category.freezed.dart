// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../models/category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DawaCategory _$DawaCategoryFromJson(Map<String, dynamic> json) {
  return _DawaCategory.fromJson(json);
}

/// @nodoc
mixin _$DawaCategory {
  String get id => throw _privateConstructorUsedError;
  Set<String> get subCategories => throw _privateConstructorUsedError;
  Set<String>? get articles => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  ContentLanguage get language => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get archivedAt => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get editedAt => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;
  String? get authorImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DawaCategoryCopyWith<DawaCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DawaCategoryCopyWith<$Res> {
  factory $DawaCategoryCopyWith(
          DawaCategory value, $Res Function(DawaCategory) then) =
      _$DawaCategoryCopyWithImpl<$Res, DawaCategory>;
  @useResult
  $Res call(
      {String id,
      Set<String> subCategories,
      Set<String>? articles,
      String? parentId,
      ContentLanguage language,
      String title,
      String? image,
      String authorId,
      String authorName,
      @ServerTimestampConverter() DateTime? archivedAt,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? editedAt,
      bool isArchived,
      String? authorImage});

  $ContentLanguageCopyWith<$Res> get language;
}

/// @nodoc
class _$DawaCategoryCopyWithImpl<$Res, $Val extends DawaCategory>
    implements $DawaCategoryCopyWith<$Res> {
  _$DawaCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subCategories = null,
    Object? articles = freezed,
    Object? parentId = freezed,
    Object? language = null,
    Object? title = null,
    Object? image = freezed,
    Object? authorId = null,
    Object? authorName = null,
    Object? archivedAt = freezed,
    Object? createdAt = freezed,
    Object? editedAt = freezed,
    Object? isArchived = null,
    Object? authorImage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subCategories: null == subCategories
          ? _value.subCategories
          : subCategories // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      articles: freezed == articles
          ? _value.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as ContentLanguage,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      editedAt: freezed == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      authorImage: freezed == authorImage
          ? _value.authorImage
          : authorImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ContentLanguageCopyWith<$Res> get language {
    return $ContentLanguageCopyWith<$Res>(_value.language, (value) {
      return _then(_value.copyWith(language: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DawaCategoryImplCopyWith<$Res>
    implements $DawaCategoryCopyWith<$Res> {
  factory _$$DawaCategoryImplCopyWith(
          _$DawaCategoryImpl value, $Res Function(_$DawaCategoryImpl) then) =
      __$$DawaCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Set<String> subCategories,
      Set<String>? articles,
      String? parentId,
      ContentLanguage language,
      String title,
      String? image,
      String authorId,
      String authorName,
      @ServerTimestampConverter() DateTime? archivedAt,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? editedAt,
      bool isArchived,
      String? authorImage});

  @override
  $ContentLanguageCopyWith<$Res> get language;
}

/// @nodoc
class __$$DawaCategoryImplCopyWithImpl<$Res>
    extends _$DawaCategoryCopyWithImpl<$Res, _$DawaCategoryImpl>
    implements _$$DawaCategoryImplCopyWith<$Res> {
  __$$DawaCategoryImplCopyWithImpl(
      _$DawaCategoryImpl _value, $Res Function(_$DawaCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subCategories = null,
    Object? articles = freezed,
    Object? parentId = freezed,
    Object? language = null,
    Object? title = null,
    Object? image = freezed,
    Object? authorId = null,
    Object? authorName = null,
    Object? archivedAt = freezed,
    Object? createdAt = freezed,
    Object? editedAt = freezed,
    Object? isArchived = null,
    Object? authorImage = freezed,
  }) {
    return _then(_$DawaCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subCategories: null == subCategories
          ? _value._subCategories
          : subCategories // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      articles: freezed == articles
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as ContentLanguage,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      editedAt: freezed == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      authorImage: freezed == authorImage
          ? _value.authorImage
          : authorImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$DawaCategoryImpl implements _DawaCategory {
  const _$DawaCategoryImpl(
      {required this.id,
      final Set<String> subCategories = const {},
      final Set<String>? articles,
      this.parentId,
      required this.language,
      required this.title,
      this.image,
      required this.authorId,
      required this.authorName,
      @ServerTimestampConverter() this.archivedAt,
      @ServerTimestampConverter() this.createdAt,
      @ServerTimestampConverter() this.editedAt,
      this.isArchived = false,
      this.authorImage})
      : _subCategories = subCategories,
        _articles = articles;

  factory _$DawaCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DawaCategoryImplFromJson(json);

  @override
  final String id;
  final Set<String> _subCategories;
  @override
  @JsonKey()
  Set<String> get subCategories {
    if (_subCategories is EqualUnmodifiableSetView) return _subCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_subCategories);
  }

  final Set<String>? _articles;
  @override
  Set<String>? get articles {
    final value = _articles;
    if (value == null) return null;
    if (_articles is EqualUnmodifiableSetView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  @override
  final String? parentId;
  @override
  final ContentLanguage language;
  @override
  final String title;
  @override
  final String? image;
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  @ServerTimestampConverter()
  final DateTime? archivedAt;
  @override
  @ServerTimestampConverter()
  final DateTime? createdAt;
  @override
  @ServerTimestampConverter()
  final DateTime? editedAt;
  @override
  @JsonKey()
  final bool isArchived;
  @override
  final String? authorImage;

  @override
  String toString() {
    return 'DawaCategory(id: $id, subCategories: $subCategories, articles: $articles, parentId: $parentId, language: $language, title: $title, image: $image, authorId: $authorId, authorName: $authorName, archivedAt: $archivedAt, createdAt: $createdAt, editedAt: $editedAt, isArchived: $isArchived, authorImage: $authorImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DawaCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._subCategories, _subCategories) &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.archivedAt, archivedAt) ||
                other.archivedAt == archivedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.editedAt, editedAt) ||
                other.editedAt == editedAt) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.authorImage, authorImage) ||
                other.authorImage == authorImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_subCategories),
      const DeepCollectionEquality().hash(_articles),
      parentId,
      language,
      title,
      image,
      authorId,
      authorName,
      archivedAt,
      createdAt,
      editedAt,
      isArchived,
      authorImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DawaCategoryImplCopyWith<_$DawaCategoryImpl> get copyWith =>
      __$$DawaCategoryImplCopyWithImpl<_$DawaCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DawaCategoryImplToJson(
      this,
    );
  }
}

abstract class _DawaCategory implements DawaCategory {
  const factory _DawaCategory(
      {required final String id,
      final Set<String> subCategories,
      final Set<String>? articles,
      final String? parentId,
      required final ContentLanguage language,
      required final String title,
      final String? image,
      required final String authorId,
      required final String authorName,
      @ServerTimestampConverter() final DateTime? archivedAt,
      @ServerTimestampConverter() final DateTime? createdAt,
      @ServerTimestampConverter() final DateTime? editedAt,
      final bool isArchived,
      final String? authorImage}) = _$DawaCategoryImpl;

  factory _DawaCategory.fromJson(Map<String, dynamic> json) =
      _$DawaCategoryImpl.fromJson;

  @override
  String get id;
  @override
  Set<String> get subCategories;
  @override
  Set<String>? get articles;
  @override
  String? get parentId;
  @override
  ContentLanguage get language;
  @override
  String get title;
  @override
  String? get image;
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  @ServerTimestampConverter()
  DateTime? get archivedAt;
  @override
  @ServerTimestampConverter()
  DateTime? get createdAt;
  @override
  @ServerTimestampConverter()
  DateTime? get editedAt;
  @override
  bool get isArchived;
  @override
  String? get authorImage;
  @override
  @JsonKey(ignore: true)
  _$$DawaCategoryImplCopyWith<_$DawaCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
