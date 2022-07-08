import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/ui/base/search_dialog.dart';

class AppPageController extends GetxController {
  void onMyAccountClicked() {}

  void onAllReportsClicked() {}

  void onAddMemberClicked() {}

  void onMyMemberClicked() {}

  void onLanguageClicked() {}

  void onRefAFrdClicked() {}

  void onSignOutClicked() {}

  void onSearchedClicked() {
    showDialog(
      context: Get.context!,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: double.maxFinite,
          child: SearchDialog(),
        ),
      ),
    );
  }

  void onSeachDilogClosesd() {
    Get.back();
  }
}
