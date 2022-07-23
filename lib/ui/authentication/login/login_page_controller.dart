import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/login_response.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/authentication/otp/otp_page.dart';
import 'package:medplus/widgets/app_snackbar.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginPageController extends GetxController {
  final phoneTextEditingController = TextEditingController();

  void onLoginClicked() async {
    // AppSnackBar.onSuccess('Sending OTP to your device Please wait');
    final signature = await SmsAutoFill().getAppSignature;
    debugPrint(signature);
    if (phoneTextEditingController.text.isEmpty ||
        !phoneTextEditingController.text.isPhoneNumber) {
      AppSnackBar.onError('enter correct phone number');
      return;
    }
    showProgress();
    final service = Get.put(ApiService());
    final apiResponse = await service.doLogin(phoneTextEditingController.text);
    if (apiResponse.success) {
      final responseData = LoginResponse.fromMap(apiResponse.data);
      if (responseData.isValidUser) {
        Get.find<AppPreferences>()
            .saveInt(AppPreferencesKeys.userId, responseData.userId);
        hideProgress();
        OtpPage.start(responseData.otp.toString());
      } else {
        hideProgress();
        debugPrint(responseData.msg);
      }
      debugPrint('login Success${responseData.msg}');
    } else {
      hideProgress();
      debugPrint('login failed');
    }
  }

  void showProgress() {
    showDialog(
      context: Get.context!,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        content: Container(
          color: Colors.transparent,
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: const CircularProgressIndicator.adaptive(
              // valueColor: Animation(),
              ),
        ),
      ),
    );
  }

  void hideProgress() {
    Get.back();
  }
}
