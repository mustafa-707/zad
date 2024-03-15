// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../models/articles.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DawaArticle _$DawaArticleFromJson(Map<String, dynamic> json) {
  return _DawaArticle.fromJson(json);
}

/// @nodoc
mixin _$DawaArticle {
  String get id => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  Map<String, dynamic> get content => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  ContentLanguage get language => throw _privateConstructorUsedError;
  String? get authorImage => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get archivedAt => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get editedAt => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DawaArticleCopyWith<DawaArticle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DawaArticleCopyWith<$Res> {
  factory $DawaArticleCopyWith(
          DawaArticle value, $Res Function(DawaArticle) then) =
      _$DawaArticleCopyWithImpl<$Res, DawaArticle>;
  @useResult
  $Res call(
      {String id,
      String categoryId,
      String title,
      Map<String, dynamic> content,
      String authorId,
      String authorName,
      ContentLanguage language,
      String? authorImage,
      String? image,
      @ServerTimestampConverter() DateTime? archivedAt,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? editedAt,
      bool isArchived});

  $ContentLanguageCopyWith<$Res> get language;
}

/// @nodoc
class _$DawaArticleCopyWithImpl<$Res, $Val extends DawaArticle>
    implements $DawaArticleCopyWith<$Res> {
  _$DawaArticleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = null,
    Object? title = null,
    Object? content = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? language = null,
    Object? authorImage = freezed,
    Object? image = freezed,
    Object? archivedAt = freezed,
    Object? createdAt = freezed,
    Object? editedAt = freezed,
    Object? isArchived = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as ContentLanguage,
      authorImage: freezed == authorImage
          ? _value.authorImage
          : authorImage // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$DawaArticleImplCopyWith<$Res>
    implements $DawaArticleCopyWith<$Res> {
  factory _$$DawaArticleImplCopyWith(
          _$DawaArticleImpl value, $Res Function(_$DawaArticleImpl) then) =
      __$$DawaArticleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String categoryId,
      String title,
      Map<String, dynamic> content,
      String authorId,
      String authorName,
      ContentLanguage language,
      String? authorImage,
      String? image,
      @ServerTimestampConverter() DateTime? archivedAt,
      @ServerTimestampConverter() DateTime? createdAt,
      @ServerTimestampConverter() DateTime? editedAt,
      bool isArchived});

  @override
  $ContentLanguageCopyWith<$Res> get language;
}

/// @nodoc
class __$$DawaArticleImplCopyWithImpl<$Res>
    extends _$DawaArticleCopyWithImpl<$Res, _$DawaArticleImpl>
    implements _$$DawaArticleImplCopyWith<$Res> {
  __$$DawaArticleImplCopyWithImpl(
      _$DawaArticleImpl _value, $Res Function(_$DawaArticleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = null,
    Object? title = null,
    Object? content = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? language = null,
    Object? authorImage = freezed,
    Object? image = freezed,
    Object? archivedAt = freezed,
    Object? createdAt = freezed,
    Object? editedAt = freezed,
    Object? isArchived = null,
  }) {
    return _then(_$DawaArticleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as ContentLanguage,
      authorImage: freezed == authorImage
          ? _value.authorImage
          : authorImage // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DawaArticleImpl implements _DawaArticle {
  const _$DawaArticleImpl(
      {required this.id,
      required this.categoryId,
      required this.title,
      required final Map<String, dynamic> content,
      required this.authorId,
      required this.authorName,
      required this.language,
      this.authorImage,
      this.image,
      @ServerTimestampConverter() this.archivedAt,
      @ServerTimestampConverter() this.createdAt,
      @ServerTimestampConverter() this.editedAt,
      this.isArchived = false})
      : _content = content;

  factory _$DawaArticleImpl.fromJson(Map<String, dynamic> json) =>
      _$$DawaArticleImplFromJson(json);

  @override
  final String id;
  @override
  final String categoryId;
  @override
  final String title;
  final Map<String, dynamic> _content;
  @override
  Map<String, dynamic> get content {
    if (_content is EqualUnmodifiableMapView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_content);
  }

  @override
  final String authorId;
  @override
  final String authorName;
  @override
  final ContentLanguage language;
  @override
  final String? authorImage;
  @override
  final String? image;
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
  String toString() {
    return 'DawaArticle(id: $id, categoryId: $categoryId, title: $title, content: $content, authorId: $authorId, authorName: $authorName, language: $language, authorImage: $authorImage, image: $image, archivedAt: $archivedAt, createdAt: $createdAt, editedAt: $editedAt, isArchived: $isArchived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DawaArticleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.authorImage, authorImage) ||
                other.authorImage == authorImage) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.archivedAt, archivedAt) ||
                other.archivedAt == archivedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.editedAt, editedAt) ||
                other.editedAt == editedAt) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      categoryId,
      title,
      const DeepCollectionEquality().hash(_content),
      authorId,
      authorName,
      language,
      authorImage,
      image,
      archivedAt,
      createdAt,
      editedAt,
      isArchived);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DawaArticleImplCopyWith<_$DawaArticleImpl> get copyWith =>
      __$$DawaArticleImplCopyWithImpl<_$DawaArticleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DawaArticleImplToJson(
      this,
    );
  }
}

abstract class _DawaArticle implements DawaArticle {
  const factory _DawaArticle(
      {required final String id,
      required final String categoryId,
      required final String title,
      required final Map<String, dynamic> content,
      required final String authorId,
      required final String authorName,
      required final ContentLanguage language,
      final String? authorImage,
      final String? image,
      @ServerTimestampConverter() final DateTime? archivedAt,
      @ServerTimestampConverter() final DateTime? createdAt,
      @ServerTimestampConverter() final DateTime? editedAt,
      final bool isArchived}) = _$DawaArticleImpl;

  factory _DawaArticle.fromJson(Map<String, dynamic> json) =
      _$DawaArticleImpl.fromJson;

  @override
  String get id;
  @override
  String get categoryId;
  @override
  String get title;
  @override
  Map<String, dynamic> get content;
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  ContentLanguage get language;
  @override
  String? get authorImage;
  @override
  String? get image;
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
  @JsonKey(ignore: true)
  _$$DawaArticleImplCopyWith<_$DawaArticleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
