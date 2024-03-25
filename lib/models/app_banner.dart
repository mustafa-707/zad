import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/app_banner.freezed.dart';
part '../generated/models/app_banner.g.dart';

@freezed
class AppBanner with _$AppBanner {
  factory AppBanner({required String image, required String url}) = _AppBanner;

  factory AppBanner.fromJson(Map<String, dynamic> json) =>
      _$AppBannerFromJson(json);
}
