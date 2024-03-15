import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:zad_app/components/flag_icon.dart';
import 'package:zad_app/utils/lang/locale.export.dart';

class Language {
  final String code;
  final String name;
  final Widget icon;

  const Language({
    required this.code,
    required this.name,
    required this.icon,
  });
}

class LocaleService {
  static const List<Language> supportedLocales = [
    Language(
      code: 'ar',
      name: 'العربية',
      icon: FlagIcon(countryCode: 'SA'),
    ),
    Language(
      code: 'en',
      name: 'English',
      icon: FlagIcon(countryCode: 'GB'),
    ),
  ];

  /// default language code
  static const String defaultLocale = 'en';

  /// System locale
  static Locale _getPlatformLocale() {
    final currentLocale = Platform.localeName;

    if (currentLocale.length == 2) {
      return Locale.fromSubtags(languageCode: currentLocale);
    } else {
      final parts = currentLocale.split('_');
      if (parts.isNotEmpty) {
        return Locale.fromSubtags(languageCode: parts[0]);
      } else {
        return const Locale('en');
      }
    }
  }

  static Language getInfo(String code) {
    return supportedLocales.firstWhere((element) => element.code == code);
  }

  static bool isSupportedLocale(String locale) {
    return supportedLocales.map((l) => l.code).contains(locale);
  }

  /// Returns system locale if supported, otherwise default locale (english)
  static String getDefaultLocale() {
    final platformLocale = _getPlatformLocale().languageCode;
    if (isSupportedLocale(platformLocale)) {
      return platformLocale;
    } else {
      return defaultLocale;
    }
  }

  static String timeAgoTranslated(DateTime date, AppLocalizations tr) {
    Duration diff = DateTime.now().difference(date);
    if (diff.inSeconds <= 5) {
      return tr.now;
    } else if (diff.inSeconds < 60) {
      return tr.lessOneMin;
    } else if (diff.inSeconds < 120) {
      return '${tr.within} ${tr.oneMinLater}';
    } else if (diff.inSeconds < 180) {
      return '${tr.within} ${tr.twoMinLater}';
    } else if (diff.inMinutes < 11) {
      return '${tr.within} ${diff.inMinutes} ${tr.oneMinLater}';
    } else if (diff.inMinutes < 60) {
      return '${tr.within} ${diff.inMinutes} ${tr.mins}';
    } else if (diff.inMinutes < 120) {
      return '${tr.within} ${tr.oneHourLater}';
    } else if (diff.inMinutes < 180) {
      return '${tr.within} ${tr.twoHoursLater}';
    } else if (diff.inHours < 11) {
      return '${tr.within} ${diff.inHours} ${tr.hours}';
    } else if (diff.inHours < 24) {
      return '${tr.within} ${diff.inHours} ${tr.oneHourLater}';
    } else if (diff.inDays < 2) {
      return '${tr.within} ${tr.oneDayLater}';
    } else if (diff.inDays < 3) {
      return '${tr.within} ${tr.twoDaysLater}';
    } else {
      final dateFormat = DateFormat('dd-MM-yyyy');
      return dateFormat.format(date);
    }
  }
}

String toTitleCase(String text) {
  return text.replaceAllMapped(RegExp(r'(\w)(\w*)'), (Match m) {
    return (m.group(1)?.toUpperCase() ?? '') + (m.group(2) ?? '');
  });
}
