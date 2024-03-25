import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zad_app/models/content_langague.dart';
import 'package:zad_app/models/user.dart';
import 'package:zad_app/utils/lang/locale.dart';
import 'package:zad_app/utils/theme/app_theme.dart';

part '../generated/models/app_settings.freezed.dart';

@freezed
class AppSettings with _$AppSettings {
  const AppSettings._();

  const factory AppSettings({
    required String locale,
    required String theme,
    ContentLanguage? selectedLanguage,
    UserData? user,
  }) = _AppSettings;

  static const default_ = AppSettings(
    locale: LocaleService.defaultLocale,
    theme: ThemeService.defaultTheme,
    selectedLanguage: null,
  );

  String get userName => user?.info?.name ?? 'Guest User';

  UserType get userType => user?.info?.type ?? UserType.normal;
}
