import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/ui/home/home_page.dart';
import 'package:medplus/widgets/app_snackbar.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPageController extends GetxController {
  final pinFieldAutoFillController = TextEditingController();
  var _otp = '';
  @override
  void onReady() {
    super.onReady();
    initSmsListener();
    _otp = Get.arguments ?? '';
    debugPrint(_otp);
    pinFieldAutoFillController.addListener(() {
      onSubmitClicked();
    });
  }

  void initSmsListener() async {
    await SmsAutoFill().listenForCode();
    AppSnackBar.onSuccess('capturing otp');
  }

  void onSubmitClicked() async {
    if (_otp == pinFieldAutoFillController.text) {
      await Future.delayed(const Duration(milliseconds: 100));
      HomePage.start();
    }
  }

  onCodeSubmitted(String p1) {}
}
