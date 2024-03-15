import 'dart:async';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zad_app/models/app_settings.dart';
import 'package:zad_app/models/content_langague.dart';
import 'package:zad_app/models/user.dart';
import 'package:zad_app/providers/shared_preferences.dart';
import 'package:zad_app/utils/conestants/firebase_collections.dart';
import 'package:zad_app/utils/lang/locale.dart';
import 'package:zad_app/utils/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

final appReadyProvider = StateProvider<bool>((ref) => false);

final appSettingsProvider = StateNotifierProvider<AppSettingsController, AppSettings>((ref) {
  final sharedPrefs = ref.watch(sharedPrefsProvider);
  assert(
    sharedPrefs != null,
    "App settings must not be used before SharedPreferences are initialized!",
  );

  return AppSettingsController(sharedPrefs!);
});

class AppSettingsController extends StateNotifier<AppSettings> {
  final SharedPreferences sharedPreferences;

  AppSettingsController(
    this.sharedPreferences,
  ) : super(_settingsFromPrefs(sharedPreferences));

  static AppSettings _settingsFromPrefs(SharedPreferences prefs) {
    final locale = prefs.getString(PrefKeys.appLocale);
    final theme = prefs.getString(PrefKeys.appTheme);
    final userLangauge = prefs.getString(PrefKeys.userContentLanguage);

    final langaugeFormated = userLangauge?.split(":");
    final selectedLanguage = langaugeFormated == null
        ? null
        : ContentLanguage(
            flag: langaugeFormated.first,
            name: langaugeFormated.last,
          );
    final user = FirebaseAuth.instance.currentUser;

    return AppSettings(
      locale: locale ?? LocaleService.getDefaultLocale(),
      theme: theme ?? ThemeService.getDefaultTheme(),
      selectedLanguage: selectedLanguage,
      user: UserData(
        user: user,
        info: UserProfile(
          name: user?.email ?? user?.displayName ?? "Guest User",
          type: (user?.isAnonymous ?? false) ? "normal" : "Admin",
          uid: user?.uid ?? "",
          language: selectedLanguage,
        ),
      ),
    );
  }

  Future<void> updateLocale(String locale) async {
    if (LocaleService.isSupportedLocale(locale)) {
      await sharedPreferences.setString(PrefKeys.appLocale, locale);
      HijriCalendar.setLocal(locale);

      state = _settingsFromPrefs(sharedPreferences);
    } else {
      throw Exception("Unsupported locale '$locale'");
    }
  }

  Future<void> updateTheme(String theme) async {
    if (LocaleService.isSupportedLocale(theme)) {
      await sharedPreferences.setString(PrefKeys.appTheme, theme);
      state = _settingsFromPrefs(sharedPreferences);
    } else {
      throw Exception("Unsupported locale '$theme'");
    }
  }

  Future<ContentLanguage?> getUserContentLanguage() async {
    try {
      final userData = FirebaseCollections.users.withConverter<UserProfile>(
        fromFirestore: (snapshot, _) => UserProfile.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

      final userLanguage = await userData
          .doc(
            FirebaseAuth.instance.currentUser!.uid,
          )
          .get()
          .then(
            (value) => value.data()?.language,
          );

      return userLanguage;
    } catch (e) {
      log('Faild to fetch user language');
      return null;
    }
  }

  Future<void> updateUserContentLanguage(ContentLanguage language) async {
    try {
      final userData = FirebaseCollections.users.withConverter<UserProfile>(
        fromFirestore: (snapshot, _) => UserProfile.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
      final decodedLanguage = '${language.flag}:${language.name}';
      final userAuth = FirebaseAuth.instance.currentUser;
      if (userAuth == null) throw Exception('User is null');
      await userData
          .doc(
        userAuth.uid,
      )
          .update(
        {
          "language": language.toJson(),
        },
      );

      await sharedPreferences.setString(
        PrefKeys.userContentLanguage,
        decodedLanguage,
      );

      state = state.copyWith(
        selectedLanguage: language,
      );
    } catch (e) {
      throw Exception('Faild to update user language $e');
    }
  }

  Future<void> updateUserData(UserProfile user) async {
    try {
      final userData = FirebaseCollections.users.withConverter<UserProfile>(
        fromFirestore: (snapshot, _) => UserProfile.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
      final userAuth = FirebaseAuth.instance.currentUser;
      if (userAuth == null) throw Exception('User is null');
      state = state.copyWith(
          user: UserData(
        user: userAuth,
        info: user,
      ));

      await userData.doc(userAuth.uid).set(user);
    } catch (e) {
      throw Exception('Faild to update user  $e');
    }
  }

  Future<Either<String, UserCredential>> anonymouslyLogin() async {
    try {
      final auth = await FirebaseAuth.instance.signInAnonymously();
      final profile = UserProfile(
        name: 'Guest User',
        type: 'normal',
        uid: auth.user!.uid,
      );
      updateUserData(profile);
      return Either.right(auth);
    } on FirebaseAuthException catch (e) {
      return Either.left(e.message!);
    } catch (e) {
      return Either.left('implementation error');
    }
  }

  Future<Either<String, UserCredential>> adminLogin(String email, String password) async {
    try {
      final auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final profile = UserProfile(
        name: auth.user?.displayName ?? email,
        language: state.user?.info?.language,
        type: 'Admin',
        uid: auth.user!.uid,
      );
      updateUserData(profile);
      return Either.right(auth);
    } on FirebaseAuthException catch (e) {
      return Either.left(e.message!);
    } catch (e) {
      return Either.left('implementation error');
    }
  }

  Future<void> saveNewUserName(String name) async {
    try {
      if (name.isEmpty) return;
      final userData = FirebaseCollections.users.withConverter<UserProfile>(
        fromFirestore: (snapshot, _) => UserProfile.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
      final userAuth = FirebaseAuth.instance.currentUser;
      if (userAuth == null) throw Exception('User is null');
      final user = state.user?.copyWith(
        info: state.user?.info?.copyWith(
          name: name,
        ),
      );
      state = state.copyWith(
        user: user,
      );
      await userData.doc(userAuth.uid).set(state.user!.info!);
    } catch (e) {
      throw Exception('Faild to update user  $e');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await anonymouslyLogin();
    state = state.copyWith(user: null);
  }
}

final currentLocaleProvider = Provider<String>((ref) {
  final isAppReady = ref.watch(appReadyProvider);

  return isAppReady
      ? ref.watch(appSettingsProvider.select((settings) => settings.locale))
      : LocaleService.getDefaultLocale();
});

final currentThemeProvider = Provider<String>((ref) {
  final isAppReady = ref.watch(appReadyProvider);

  return isAppReady
      ? ref.watch(appSettingsProvider.select((settings) => settings.theme))
      : ThemeService.getDefaultTheme();
});
