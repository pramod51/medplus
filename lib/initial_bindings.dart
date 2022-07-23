import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/preferences/app_preferences.dart';

class InitialBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    try {
      final appPreferences = AppPreferences(
        prefs: await SharedPreferences.getInstance(),
      );
      Get.put<AppPreferences>(appPreferences, permanent: true);
      SharedConfig.load(appPreferences);
    } catch (e) {
      debugPrint("During app initialization$e");
    }
  }
}
