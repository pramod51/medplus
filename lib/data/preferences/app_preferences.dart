import 'package:get/get.dart';
import 'package:medplus/data/models/home_page_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppPreferences {
  final SharedPreferences prefs;
  final _categories = <Category>[];
  AppPreferences({
    required this.prefs,
  });

  void saveString(String key, String val) {
    prefs.setString(key, val);
  }

  void saveInt(String key, int val) {
    prefs.setInt(key, val);
  }

  void saveDouble(String key, double val) {
    prefs.setDouble(key, val);
  }

  void saveStringList(String key, List<String> val) {
    prefs.setStringList(key, val);
  }

  String getString(String key) {
    return prefs.getString(key) ?? '';
  }

  int? getInt(String key) {
    return prefs.getInt(key);
  }

  double getDouble(String key) {
    return prefs.getDouble(key) ?? 0.0;
  }

  List<String> getStringList(String key) {
    return prefs.getStringList(key) ?? <String>[];
  }

  Future<bool> clearAll() async {
    await prefs.clear();
    return true;
  }

  void assigneCategory(List<Category> data) {
    _categories.assignAll(data);
  }

  List<Category> get categoryList => _categories;
}

class AppPreferencesKeys {
  AppPreferencesKeys._();

  static const String userId = 'userId';
  static const String name = 'name';
  static const String subCategory = 'subCategory';
  static const String callingCountryCode = 'callingCountryCode';
  static const String languageCode = 'languageCode';
  static const String countryCode = 'countryCode';
}

class SharedConfig {
  static int? _userId;
  static String? _name;
  static List<String>? _subCategory;
  static String? _callingCountryCode;
  static Locale? _locale;
  static TextDirection? _textDirection;

  static int? get userId => _userId;
  static String? get name => _name;
  static String? get callingCountryCode => _callingCountryCode;
  static List<String>? get subCategory => _subCategory;
  static Locale? get locale => _locale;
  static TextDirection? get textDirection => _textDirection;
  static void updateLocal(Locale? locale) {
    _locale = locale;
    _textDirection = _locale?.languageCode == 'ar' ? TextDirection.rtl : null;
  }

  static void load(AppPreferences prefs) {
    _userId = prefs.getInt(AppPreferencesKeys.userId);
    _name = prefs.getString(AppPreferencesKeys.name);
    _subCategory = prefs.getStringList(AppPreferencesKeys.subCategory);
    _callingCountryCode =
        prefs.getString(AppPreferencesKeys.callingCountryCode);
    _locale = prefs.getString(AppPreferencesKeys.languageCode).isEmpty
        ? Get.deviceLocale
        : Locale(prefs.getString(AppPreferencesKeys.languageCode),
            prefs.getString(AppPreferencesKeys.countryCode));
    _textDirection =
        _locale?.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;
  }
}
