import 'package:get/get.dart';

import 'res/ar_translation.dart';
import 'res/en_translation.dart';

class AppTranslations extends Translations {
  final _translations = <String, String>{};
  final _translationsAr = <String, String>{};

  AppTranslations._internal() {
    _translations.addAll(enUS);
    _translationsAr.addAll(arUAE);
  }

  static final _instance = AppTranslations._internal();

  factory AppTranslations.get() => _instance;

  @override
  Map<String, Map<String, String>> get keys {
    return {
      "en_US": _translations,
      'ar_UAE': _translationsAr,
    };
  }

  // void updateLocale(Locale? locale, Map<String, String> map) {
  //   if (locale == null) return;
  //   var tempTranslations = Map<String, String>.from(enUS);
  //   tempTranslations.addAll(map);
  //   _translations.addAll(tempTranslations);
  //   Get.updateLocale(locale);
  // }
}
