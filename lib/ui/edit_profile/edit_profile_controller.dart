import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/ui/base/app_page_controller.dart';

class EditProfileController extends AppPageController {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  final isMale = true.obs;

  void updateDeatils() {}

  void onGenderChanged() {
    isMale.value = !isMale.value;
  }
}
