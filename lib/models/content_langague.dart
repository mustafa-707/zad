import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/content_langague.freezed.dart';
part '../generated/models/content_langague.g.dart';

@freezed
class ContentLanguage with _$ContentLanguage {
  const factory ContentLanguage({
    required String flag,
    required String name,
  }) = _ContentLanguage;

  static ContentLanguage? fromString(String? string) {
    if (string == null) return null;
    try {
      return ContentLanguage.fromJson(jsonDecode(string));
    } catch (e) {
      final languageFormatted = string.split(":");
      return ContentLanguage(
        flag: languageFormatted.first,
        name: languageFormatted.last,
      );
    }
  }

  factory ContentLanguage.fromJson(Map<String, dynamic> json) =>
      _$ContentLanguageFromJson(json);
}
