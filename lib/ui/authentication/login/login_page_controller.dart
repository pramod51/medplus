import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medplus/data/models/login_response.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/authentication/otp/otp_page.dart';
import 'package:medplus/ui/edit_profile/edit_profile.dart';
import 'package:medplus/ui/home/home_page.dart';
import 'package:medplus/widgets/app_snackbar.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginPageController extends GetxController {
  final focusNode = FocusNode();
  final phoneTextEditingController = TextEditingController();
  final googleSignIn = GoogleSignIn();
  final service = Get.put(ApiService());

  @override
  void onInit() async {
    super.onInit();
    final ccc = SharedConfig.callingCountryCode ?? '';
    phoneTextEditingController.text = SharedConfig.callingCountryCode ?? '';
    phoneTextEditingController.addListener(() {
      if (phoneTextEditingController.text.length < ccc.length) {
        phoneTextEditingController.text = ccc;
        phoneTextEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: phoneTextEditingController.text.length));
      }
    });
  }

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

    final apiResponse = await service.doLogin(phoneTextEditingController.text
        .replaceAll((SharedConfig.callingCountryCode ?? ''), '')
        .trim());
    if (apiResponse.success) {
      final responseData = LoginResponse.fromMap(apiResponse.data);
      print(Get.arguments);
      print(responseData.data);
      if (responseData.data == null) {
        AppSnackBar.onError(responseData.msg);
        return;
      }
      if (responseData.isMobileLogin) {
        hideProgress();
        SharedConfig.savePhone(responseData.data!.phone);
        if (responseData.data!.email.isNotEmpty) {
          SharedConfig.saveEmail(responseData.data!.email);
        }
        OtpPage.start([
          responseData.otp.toString(),
          responseData.userId,
        ]);
      } else if (responseData.isMobileAndEmailRegisted) {
        hideProgress();
        HomePage.start();
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
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        content: Container(
            color: Colors.transparent,
            height: 100,
            width: 100,
            alignment: Alignment.center,
            child: const CircularProgressIndicator()
            // valueColor: Animation(),

            ),
      ),
    );
  }

  void hideProgress() {
    Get.back();
  }

  void onGoogleSIgneInClicked() async {
    final user = FirebaseAuth.instance.currentUser;
    print(user);
    // await FirebaseAuth.instance.signOut();
    // await googleSignIn.signOut();
    // return;

    // if (user != null) {

    // }
    print('-------------------------------');
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final user1 =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser == null) return;
      loginEmail(user1.additionalUserInfo?.profile!['email']);
      print(
          '##########################${user1.additionalUserInfo?.profile!['email']}');
      print(user1.additionalUserInfo?.username);
    } catch (e) {
      print(e);
      print('object');
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    }
  }

  void loginWithFacebook() async {
    // await FacebookAuth.instance.logOut();
    // await FirebaseAuth.instance.signOut();
    // return;

    try {
      final facebookLoginResult = await FacebookAuth.instance.login(
        loginBehavior: LoginBehavior.webOnly,
      );
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      loginEmail(userData['email']);
      print(userData);
    } catch (e) {
      print(e.toString());
    }
  }

  void loginEmail(String email) async {
    showProgress();
    final apiResponse = await service.doLoginWithSocialMedia(email);
    if (apiResponse.success) {
      final responseData = LoginResponse.fromMap(apiResponse.data);
      print(responseData);
      if (responseData.data == null) {
        AppSnackBar.onError(responseData.msg);
        return;
      }
      print(responseData.data);
      debugPrint(responseData.isMobileAndEmailRegisted.toString());
      if (responseData.data!.email.isNotEmpty) {
        SharedConfig.savePhone(responseData.data!.phone);
      }
      if (responseData.data!.email.isNotEmpty) {
        SharedConfig.saveEmail(responseData.data!.email);
      }
      SharedConfig.saveUserId(responseData.userId);
      if (responseData.isMobileAndEmailRegisted) {
        hideProgress();
        HomePage.start();
      } else {
        hideProgress();
        Get.offAllNamed(EditProfile.routeName);
        debugPrint(responseData.msg);
      }
      debugPrint('login Success${responseData.msg}');
    } else {
      hideProgress();
      debugPrint('login failed');
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    }
  }
}
