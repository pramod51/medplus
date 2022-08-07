import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/login_response.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';
import 'package:medplus/ui/home/home_page.dart';
import 'package:medplus/widgets/app_snackbar.dart';

class EditProfileController extends AppPageController {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  final isMale = true.obs;
  @override
  void onReady() {
    super.onReady();
    nameTextEditingController.text = SharedConfig.name ?? '';
    emailTextEditingController.text = SharedConfig.email ?? '';
    phoneTextEditingController.text = (SharedConfig.callingCountryCode ?? "") +
        ' ' +
        (SharedConfig.phone ?? '');
  }

  void updateDeatils() async {
    if (nameTextEditingController.text.isEmpty) {
      AppSnackBar.onError('Enter name');
      return;
    }
    if (emailTextEditingController.text.isEmpty) {
      AppSnackBar.onError('Enter email');
      return;
    }
    if (!emailTextEditingController.text.isEmail) {
      AppSnackBar.onError('Enter valid email');
      return;
    }
    if (phoneTextEditingController.text.isEmpty) {
      AppSnackBar.onError('Enter phone number');
      return;
    }
    if (!phoneTextEditingController.text.isPhoneNumber) {
      AppSnackBar.onError('Enter valid number');
      return;
    }
    showProgress();
    final service = Get.put(ApiService());
    final apiResponse = await service.updateUserDetails(
      nameTextEditingController.text,
      phoneTextEditingController.text
          .replaceAll(SharedConfig.callingCountryCode ?? " ", '')
          .trim(),
      emailTextEditingController.text,
    );
    if (apiResponse.success) {
      final responseData = LoginResponse.fromMap(apiResponse.data);
      print(responseData);
      if (responseData.data == null) {
        hideProgress();
        AppSnackBar.onError(responseData.msg);
        return;
      }
      hideProgress();
      HomePage.start();
    } else {
      hideProgress();
      AppSnackBar.onError(apiResponse.message);
    }
  }

  void onGenderChanged() {
    isMale.value = !isMale.value;
  }
}
