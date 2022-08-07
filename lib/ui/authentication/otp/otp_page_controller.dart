import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/ui/edit_profile/edit_profile.dart';
import 'package:medplus/ui/home/home_page.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPageController extends GetxController {
  final pinFieldAutoFillController = TextEditingController();
  var _otp = '';
  @override
  void onReady() {
    super.onReady();
    initSmsListener();
    _otp = Get.arguments[0] ?? '';
    debugPrint(_otp);
    pinFieldAutoFillController.addListener(() {
      onSubmitClicked();
    });
  }

  void initSmsListener() async {
    await SmsAutoFill().listenForCode();
  }

  void onSubmitClicked() async {
    if (_otp == pinFieldAutoFillController.text) {
      final appPref = Get.find<AppPreferences>();
      appPref.saveInt(AppPreferencesKeys.userId, Get.arguments[1]);
      SharedConfig.load(appPref);
      await Future.delayed(const Duration(milliseconds: 100));
      if (SharedConfig.email == null) {
        Get.offAllNamed(EditProfile.routeName);
      } else {
        HomePage.start();
      }
    }
  }

  onCodeSubmitted(String p1) {}
}
