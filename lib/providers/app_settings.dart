import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:zad_app/models/app_settings.dart';
import 'package:zad_app/models/content_langague.dart';
import 'package:zad_app/models/user.dart';
import 'package:zad_app/providers/shared_preferences.dart';
import 'package:zad_app/utils/conestants/firebase_collections.dart';
import 'package:zad_app/utils/lang/locale.dart';
import 'package:zad_app/utils/theme/app_theme.dart';

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
    final languageString = prefs.getString(PrefKeys.userContentLanguage);
    final selectedLanguage = ContentLanguage.fromString(languageString);

    final admin = FirebaseAuth.instance.currentUser;

    return AppSettings(
      locale: locale ?? LocaleService.getDefaultLocale(),
      theme: theme ?? ThemeService.getDefaultTheme(),
      selectedLanguage: selectedLanguage,
      user: admin != null
          ? UserData(
              user: admin,
              //TODO: load data from firestore not from auth user.
              info: UserProfile(
                name: admin.displayName ?? admin.email ?? "Admin User",
                type: UserType.admin,
                uid: admin.uid,
                language: selectedLanguage,
              ),
            )
          : null,
    );
  }

  Future<void> updateLocale(String locale) async {
    if (LocaleService.isSupportedLocale(locale)) {
      await sharedPreferences.setString(PrefKeys.appLocale, locale);
      HijriCalendar.setLocal(locale);

      state = state.copyWith(locale: locale);
    } else {
      throw Exception("Unsupported locale '$locale'");
    }
  }

  Future<void> updateTheme(String theme) async {
    if (LocaleService.isSupportedLocale(theme)) {
      await sharedPreferences.setString(PrefKeys.appTheme, theme);
      state = state.copyWith(theme: theme);
    } else {
      throw Exception("Unsupported locale '$theme'");
    }
  }

  Future<ContentLanguage?> getUserContentLanguage() async => state.selectedLanguage;

  Future<void> updateUserContentLanguage(ContentLanguage language) async {
    await sharedPreferences.setString(
      PrefKeys.userContentLanguage,
      jsonEncode(language.toJson()),
    );
    final userProfile = state.user!.info!.copyWith(language: language);
    if (FirebaseAuth.instance.currentUser != null) {
      return _updateLoginUser(userProfile);
    } else {
      return _updateOfflineUser(userProfile);
    }
  }

  Future<void> _updateUserData(UserProfile user) async {
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

  Future<UserData> offlineLogin() async {
    final jsonUser = sharedPreferences.getString(PrefKeys.offlineUserProfile);
    final UserData userData;
    if (jsonUser != null) {
      userData = UserData(info: UserProfile.fromJson(jsonDecode(jsonUser)));
    } else {
      userData = UserData(
          info: UserProfile(
        name: 'Guest User',
        type: UserType.normal,
        uid: const Uuid().v4(),
      ));
    }
    _saveOfflineUserProfile(userData.info!);
    state = state.copyWith(user: userData);
    return userData;
  }

  Future<Either<String, UserCredential>> adminLogin(String email, String password) async {
    try {
      final auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final profile = UserProfile(
        name: auth.user?.displayName ?? email,
        language: state.user?.info?.language ?? state.selectedLanguage,
        type: UserType.admin,
        uid: auth.user!.uid,
      );
      _updateUserData(profile);
      return Either.right(auth);
    } on FirebaseAuthException catch (e) {
      return Either.left(e.message!);
    } catch (e) {
      return Either.left('implementation error');
    }
  }

  Future<void> updateUserName(String name) async {
    if (name.trim().isEmpty) return;
    final userProfile = state.user!.info!.copyWith(name: name);
    if (FirebaseAuth.instance.currentUser != null) {
      return _updateLoginUser(userProfile);
    } else {
      return _updateOfflineUser(userProfile);
    }
  }

  Future<void> _saveOfflineUserProfile(UserProfile userProfile) {
    return sharedPreferences.setString(
        PrefKeys.offlineUserProfile, jsonEncode(userProfile.toJson()));
  }

  Future<void> _updateOfflineUser(UserProfile userProfile) async {
    state = state.copyWith(
      user: UserData(info: userProfile),
      selectedLanguage: userProfile.language,
    );
    return _saveOfflineUserProfile(userProfile);
  }

  Future<void> _updateLoginUser(UserProfile userProfile) async {
    try {
      final userData = FirebaseCollections.users.withConverter<UserProfile>(
        fromFirestore: (snapshot, _) => UserProfile.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
      final userAuth = FirebaseAuth.instance.currentUser;
      if (userAuth == null) throw Exception('User is null');

      final user = state.user?.copyWith(info: userProfile);
      state = state.copyWith(
        user: user,
      );
      await Future.wait([
        FirebaseAuth.instance.currentUser!.updateDisplayName(userProfile.name),
        userData.doc(userAuth.uid).set(state.user!.info!),
      ]);
    } catch (e) {
      throw Exception('Faild to update user  $e');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await offlineLogin();
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
