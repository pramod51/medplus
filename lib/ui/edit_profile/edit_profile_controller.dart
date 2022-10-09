import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/login_response.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';
import 'package:medplus/ui/home/home_page.dart';
import 'package:medplus/ui/home/home_page_controller.dart';
import 'package:medplus/utils/app_utils.dart';
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
    final ccc = SharedConfig.callingCountryCode ?? '';
    phoneTextEditingController.addListener(() {
      if (phoneTextEditingController.text.length < ccc.length) {
        phoneTextEditingController.text = ccc;
        phoneTextEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: phoneTextEditingController.text.length));
      }
    });
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
      emailTextEditingController.text.trim(),
    );
    if (apiResponse.success) {
      final responseData = LoginResponse.fromMap(apiResponse.data);
      print(responseData.data);
      if (responseData.data == null) {
        hideProgress();
        AppSnackBar.onError(responseData.msg);
        return;
      }
      SharedConfig.saveEmail(responseData.data!.email);
      SharedConfig.savePhone(responseData.data!.phone);
      if (SharedConfig.name.isNotNullOrEmpty) {
        AppUtils.updateFileName(SharedConfig.name!.replaceAll(' ', '_'),
            nameTextEditingController.text.trim().replaceAll(' ', '_'));
      }
      SharedConfig.saveString(
          AppPreferencesKeys.name, nameTextEditingController.text.trim());
      hideProgress();
      if (Get.isRegistered<HomePageController>()) {
        Get.back();
      } else {
        HomePage.start();
      }
    } else {
      hideProgress();
      AppSnackBar.onError(apiResponse.message);
    }
  }

  void onGenderChanged() {
    isMale.value = !isMale.value;
  }
}
