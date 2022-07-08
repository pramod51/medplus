import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'res/en_translation.dart';

class AppTranslations extends Translations {
  final _translations = <String, String>{};
  AppTranslations._internal() {
    _translations.addAll(enUS);
  }

  static final _instance = AppTranslations._internal();

  factory AppTranslations.get() => _instance;

  @override
  Map<String, Map<String, String>> get keys {
    return {
      "en_US": _translations,
      "hi_IN": _translations,
      "th_TH": _translations,
    };
  }

  Locale? getLocale(LanguageBundle bundle) {
    switch (bundle.name) {
      case "EN":
        return const Locale('en', 'US');
      case "HI":
        return const Locale('hi', 'IN');
      case "TH":
        return const Locale('th', 'TH');
    }
    return null;
  }

  void updateLocale(LanguageBundle bundle, Map<String, String> map) {
    final locale = getLocale(bundle);
    if (locale == null) return;
    var tempTranslations = Map<String, String>.from(enUS);
    tempTranslations.addAll(map);
    _translations.addAll(tempTranslations);
    Get.updateLocale(locale);
  }
}

/// This below class is as per server response
class LanguageBundle {
  final int bundleID;
  final String name;
  final String language;
  final String value;
  final String country;
  bool selected = false;

  LanguageBundle({
    required this.bundleID,
    required this.name,
    required this.language,
    required this.value,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'bundleID': bundleID,
      'name': name,
      'language': language,
      'value': value,
      'country': country,
    };
  }

  factory LanguageBundle.fromMap(Map<String, dynamic> map) {
    return LanguageBundle(
      bundleID: map['bundleID']?.toInt() ?? 0,
      name: map['name'] ?? '',
      language: map['language'] ?? '',
      value: map['value'] ?? '',
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageBundle.fromJson(String source) =>
      LanguageBundle.fromMap(json.decode(source));

  static LanguageBundle get defaultLanguageBundle => LanguageBundle(
        bundleID: 1,
        name: "EN",
        language: "English",
        value: 'English',
        country: "IN",
      );

  @override
  String toString() {
    return 'Bundle(bundleID: $bundleID, name: $name, language: $language, value: $value, country: $country)';
  }
}
