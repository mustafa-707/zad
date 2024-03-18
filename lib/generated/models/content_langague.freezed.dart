// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../models/content_langague.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContentLanguage _$ContentLanguageFromJson(Map<String, dynamic> json) {
  return _ContentLanguage.fromJson(json);
}

/// @nodoc
mixin _$ContentLanguage {
  String get flag => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContentLanguageCopyWith<ContentLanguage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentLanguageCopyWith<$Res> {
  factory $ContentLanguageCopyWith(
          ContentLanguage value, $Res Function(ContentLanguage) then) =
      _$ContentLanguageCopyWithImpl<$Res, ContentLanguage>;
  @useResult
  $Res call({String flag, String name});
}

/// @nodoc
class _$ContentLanguageCopyWithImpl<$Res, $Val extends ContentLanguage>
    implements $ContentLanguageCopyWith<$Res> {
  _$ContentLanguageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flag = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentLanguageImplCopyWith<$Res>
    implements $ContentLanguageCopyWith<$Res> {
  factory _$$ContentLanguageImplCopyWith(_$ContentLanguageImpl value,
          $Res Function(_$ContentLanguageImpl) then) =
      __$$ContentLanguageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String flag, String name});
}

/// @nodoc
class __$$ContentLanguageImplCopyWithImpl<$Res>
    extends _$ContentLanguageCopyWithImpl<$Res, _$ContentLanguageImpl>
    implements _$$ContentLanguageImplCopyWith<$Res> {
  __$$ContentLanguageImplCopyWithImpl(
      _$ContentLanguageImpl _value, $Res Function(_$ContentLanguageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flag = null,
    Object? name = null,
  }) {
    return _then(_$ContentLanguageImpl(
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentLanguageImpl implements _ContentLanguage {
  const _$ContentLanguageImpl({required this.flag, required this.name});

  factory _$ContentLanguageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentLanguageImplFromJson(json);

  @override
  final String flag;
  @override
  final String name;

  @override
  String toString() {
    return 'ContentLanguage(flag: $flag, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentLanguageImpl &&
            (identical(other.flag, flag) || other.flag == flag) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, flag, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentLanguageImplCopyWith<_$ContentLanguageImpl> get copyWith =>
      __$$ContentLanguageImplCopyWithImpl<_$ContentLanguageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentLanguageImplToJson(
      this,
    );
  }
}

abstract class _ContentLanguage implements ContentLanguage {
  const factory _ContentLanguage(
      {required final String flag,
      required final String name}) = _$ContentLanguageImpl;

  factory _ContentLanguage.fromJson(Map<String, dynamic> json) =
      _$ContentLanguageImpl.fromJson;

  @override
  String get flag;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ContentLanguageImplCopyWith<_$ContentLanguageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
