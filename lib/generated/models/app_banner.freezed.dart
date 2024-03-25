// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../models/app_banner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppBanner _$AppBannerFromJson(Map<String, dynamic> json) {
  return _AppBanner.fromJson(json);
}

/// @nodoc
mixin _$AppBanner {
  String get image => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppBannerCopyWith<AppBanner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppBannerCopyWith<$Res> {
  factory $AppBannerCopyWith(AppBanner value, $Res Function(AppBanner) then) =
      _$AppBannerCopyWithImpl<$Res, AppBanner>;
  @useResult
  $Res call({String image, String url});
}

/// @nodoc
class _$AppBannerCopyWithImpl<$Res, $Val extends AppBanner>
    implements $AppBannerCopyWith<$Res> {
  _$AppBannerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppBannerImplCopyWith<$Res>
    implements $AppBannerCopyWith<$Res> {
  factory _$$AppBannerImplCopyWith(
          _$AppBannerImpl value, $Res Function(_$AppBannerImpl) then) =
      __$$AppBannerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String image, String url});
}

/// @nodoc
class __$$AppBannerImplCopyWithImpl<$Res>
    extends _$AppBannerCopyWithImpl<$Res, _$AppBannerImpl>
    implements _$$AppBannerImplCopyWith<$Res> {
  __$$AppBannerImplCopyWithImpl(
      _$AppBannerImpl _value, $Res Function(_$AppBannerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? url = null,
  }) {
    return _then(_$AppBannerImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppBannerImpl implements _AppBanner {
  _$AppBannerImpl({required this.image, required this.url});

  factory _$AppBannerImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppBannerImplFromJson(json);

  @override
  final String image;
  @override
  final String url;

  @override
  String toString() {
    return 'AppBanner(image: $image, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppBannerImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, image, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppBannerImplCopyWith<_$AppBannerImpl> get copyWith =>
      __$$AppBannerImplCopyWithImpl<_$AppBannerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppBannerImplToJson(
      this,
    );
  }
}

abstract class _AppBanner implements AppBanner {
  factory _AppBanner({required final String image, required final String url}) =
      _$AppBannerImpl;

  factory _AppBanner.fromJson(Map<String, dynamic> json) =
      _$AppBannerImpl.fromJson;

  @override
  String get image;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$AppBannerImplCopyWith<_$AppBannerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
