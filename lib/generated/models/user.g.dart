// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      name: json['name'] as String,
      type: $enumDecode(_$UserTypeEnumMap, json['type']),
      uid: json['uid'] as String,
      language: json['language'] == null
          ? null
          : ContentLanguage.fromJson(json['language'] as Map<String, dynamic>),
      deviceId: json['deviceId'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$UserTypeEnumMap[instance.type]!,
      'uid': instance.uid,
      'language': instance.language?.toJson(),
      'deviceId': instance.deviceId,
      'image': instance.image,
    };

const _$UserTypeEnumMap = {
  UserType.normal: 'normal',
  UserType.admin: 'admin',
};
