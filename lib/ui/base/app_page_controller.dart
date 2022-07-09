import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/ui/base/add_member_dilog.dart';
import 'package:medplus/ui/home/home_page.dart';
import 'package:medplus/ui/myAccount/my_account_page.dart';
import 'package:medplus/ui/reportListing/report_listing.dart';
import 'package:medplus/ui/search/search_page.dart';

enum BottomNavItems {
  home,
  search,
  reports,
  myAccount,
}

class AppPageController extends GetxController {
  final bottomNav = [
    BottomNavItems.home,
    BottomNavItems.search,
    BottomNavItems.reports,
    BottomNavItems.myAccount
  ];
  final selectedBottomNav = BottomNavItems.home.obs;

  void onMyAccountClicked() {}

  void onAllReportsClicked() {}

  void onAddMemberClicked() {
    showDialog(
      context: Get.context!,
      builder: (_) => const AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 24),
        content: SizedBox(
          width: double.maxFinite,
          child: AddMemberDilog(),
        ),
      ),
    );
  }

  void onMyMemberClicked() {}

  void onLanguageClicked() {}

  void onRefAFrdClicked() {}

  void onSignOutClicked() {}

  void onTap(int index) {
    final prevNav = selectedBottomNav.value;
    selectedBottomNav.value = bottomNav[index];
    switch (selectedBottomNav.value) {
      case BottomNavItems.home:
        Get.offAllNamed(
          HomePage.routeName,
        );
        break;
      case BottomNavItems.search:
        if (prevNav == BottomNavItems.home) {
          Get.toNamed(
            SearchPage.routeName,
          );
        } else {
          Get.offNamed(
            SearchPage.routeName,
          );
        }

        break;
      case BottomNavItems.reports:
        if (prevNav == BottomNavItems.home) {
          Get.toNamed(
            ReportListing.routeName,
          );
        } else {
          Get.offNamed(
            ReportListing.routeName,
          );
        }

        break;
      case BottomNavItems.myAccount:
        if (prevNav == BottomNavItems.home) {
          Get.toNamed(
            MyAccountPage.routeName,
          );
        } else {
          Get.offNamed(
            MyAccountPage.routeName,
          );
        }
    }
  }

  void onSeachDilogClosesd() {
    Get.back();
  }

  void searchBottomNav() {
    selectedBottomNav.value = BottomNavItems.search;
  }

  void onBackButtonClicked() {
    selectedBottomNav.value = BottomNavItems.home;
    Get.offNamed(
      HomePage.routeName,
    );
  }
}
