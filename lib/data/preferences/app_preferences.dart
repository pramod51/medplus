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

  void clearAll() async {
    prefs.remove(AppPreferencesKeys.userId);
    prefs.remove(AppPreferencesKeys.email);
    prefs.remove(AppPreferencesKeys.phone);
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
  static const String email = 'email';
  static const String phone = 'phone';
  static const String locale = 'locale';

  static const String subCategory = 'subCategory';
  static const String callingCountryCode = 'callingCountryCode';
  static const String languageCode = 'languageCode';
  static const String countryCode = 'countryCode';
}

class SharedConfig {
  static int? _userId;
  static String? _name;
  static String? _email;
  static String? _phone;
  static List<String>? _subCategory;
  static String? _callingCountryCode;
  static final List<String> _locale = ["en", "US"];
  static TextDirection? _textDirection;
  static String? _countryCode;
  static String? _languageCode;

  static int? get userId => _userId;
  static String? get name => _name;
  static String? get email => _email;
  static String? get phone => _phone;
  static String? get callingCountryCode => _callingCountryCode;
  static String? get countryCode => _countryCode;
  static String? get languageCode => _languageCode;

  static List<String>? get subCategory => _subCategory;
  static List<String> get locale => _locale;
  static TextDirection? get textDirection => _textDirection;
  static void updateLocal(String languageCode, String countryCode) {
    final prefs = Get.find<AppPreferences>();
    prefs
        .saveStringList(AppPreferencesKeys.locale, [languageCode, countryCode]);
    load(prefs);
  }

  static void saveEmail(String email) {
    final prefs = Get.find<AppPreferences>();
    prefs.saveString(AppPreferencesKeys.email, email);
    load(prefs);
  }

  static void savePhone(String phone) {
    final prefs = Get.find<AppPreferences>();
    prefs.saveString(AppPreferencesKeys.phone, phone);
    load(prefs);
  }

  static void saveString(String key, String value) {
    final prefs = Get.find<AppPreferences>();
    prefs.saveString(key, value);
    load(prefs);
  }

  static void saveUserId(int userId) {
    final prefs = Get.find<AppPreferences>();
    prefs.saveInt(AppPreferencesKeys.userId, userId);
    load(prefs);
  }

  static void load(AppPreferences prefs) {
    _userId = prefs.getInt(AppPreferencesKeys.userId);
    _name = prefs.getString(AppPreferencesKeys.name);
    _email = prefs.getString(AppPreferencesKeys.email);
    _phone = prefs.getString(AppPreferencesKeys.phone);
    _subCategory = prefs.getStringList(AppPreferencesKeys.subCategory);
    _callingCountryCode =
        prefs.getString(AppPreferencesKeys.callingCountryCode);
    _countryCode = prefs.getString(AppPreferencesKeys.countryCode);
    final list = prefs.getStringList(AppPreferencesKeys.locale);
    if (list.isNotEmpty) {
      _locale.assignAll(list);
      _textDirection =
          (list.first == 'ar') ? TextDirection.rtl : TextDirection.ltr;
    }
  }
}
