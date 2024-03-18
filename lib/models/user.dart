import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zad_app/models/content_langague.dart';

part '../generated/models/user.freezed.dart';
part '../generated/models/user.g.dart';

enum UserType {
  normal("Normal User"),
  admin("Admin");

  final String name;

  const UserType(this.name);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String name,
    required UserType type,
    required String uid,
    ContentLanguage? language,
    String? deviceId,
    String? image,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
class UserData with _$UserData {
  const factory UserData({
    User? user,
    UserProfile? info,
  }) = _UserData;
}
