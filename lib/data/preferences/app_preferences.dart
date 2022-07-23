import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences prefs;
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
}

class AppPreferencesKeys {
  AppPreferencesKeys._();

  static const String userId = 'userId';
  static const String name = 'name';
  static const String subCategory = 'subCategory';
}

class SharedConfig {
  static int? _userId;
  static String? _name;
  static List<String>? _subCategory;
  static int? get userId => _userId;
  static String? get name => _name;
  static List<String>? get subCategory => _subCategory;
  static void load(AppPreferences prefs) {
    _userId = prefs.getInt(AppPreferencesKeys.userId);
    _name = prefs.getString(AppPreferencesKeys.name);
    _subCategory = prefs.getStringList(AppPreferencesKeys.subCategory);
  }
}
