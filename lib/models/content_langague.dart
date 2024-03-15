import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/content_langague.freezed.dart';
part '../generated/models/content_langague.g.dart';

@freezed
class ContentLanguage with _$ContentLanguage {
  const factory ContentLanguage({
    required String flag,
    required String name,
  }) = _ContentLanguage;

  factory ContentLanguage.fromJson(Map<String, dynamic> json) => _$ContentLanguageFromJson(json);
}
