import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProvider = StateProvider<SharedPreferences?>((ref) => null);

class PrefKeys {
  static const appLocale = "app_locale";
  static const appTheme = "app_theme";
  static const userContentLanguage = "user_content_language";
  static const offlineUserProfile = "offline_user_profile";
}
