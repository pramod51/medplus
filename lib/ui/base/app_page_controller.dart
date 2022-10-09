import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/api_response.dart';
import 'package:medplus/ui/authentication/login/login_page.dart';
import 'package:medplus/ui/base/add_member_dilog.dart';
import 'package:medplus/ui/edit_profile/edit_profile.dart';
import 'package:medplus/ui/home/home_page.dart';
import 'package:medplus/ui/myAccount/my_account_page.dart';
import 'package:medplus/ui/reportListing/report_listing.dart';
import 'package:medplus/ui/search/search_page.dart';
import 'package:medplus/ui/splash/splash_page.dart';
import 'package:share_plus/share_plus.dart';

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

  void onMyAccountClicked() {
    Get.toNamed(EditProfile.routeName);
  }

  void onAllReportsClicked() {
    onTap(2);
  }

  @override
  void onInit() {
    super.onInit();
    SharedConfig.load(Get.find<AppPreferences>());
  }

  void onAddMemberClicked({
    String familyId = '',
    String name = '',
    String relation = '',
    bool isMale = true,
  }) {
    showDialog(
      context: Get.context!,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: double.maxFinite,
          child: AddMemberDialog(
            familyId: familyId,
            name: name,
            relation: relation,
            isMale: isMale,
          ),
        ),
      ),
    );
  }

  void onMyMemberClicked() {
    onTap(3);
  }

  void onLanguageClicked() async {
    if (SharedConfig.locale.first == 'en') {
      SharedConfig.updateLocal('ar', 'UAE');
      await Get.updateLocale(const Locale('ar', 'UAE'));
    } else {
      SharedConfig.updateLocal('en', 'US');
      await Get.updateLocale(const Locale('en', 'US'));
    }
    Get.back();
    Get.deleteAll();
    Get.offAndToNamed(SplashPage.routeName);
    Phoenix.rebirth(Get.context!);
  }

  void onRefAFrdClicked() {
    Share.share(
      Platform.isAndroid
          ? 'Download the Medplus App\nhttps://play.google.com/store/apps/details?id=com.peoplestrong.alt.organise'
          : 'Download the Medplus App\nhttps://apps.apple.com/in/app/alt-worklife/id1166495470',
    );
  }

  void onSignOutClicked() async {
    Get.find<AppPreferences>().clearAll();
    await Get.deleteAll();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    await FacebookAuth.instance.logOut();
    LoginPage.start();
  }

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

  void showProgress([Widget? child]) {
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
          child: child ??
              const CircularProgressIndicator(
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  void hideProgress() {
    Get.back();
  }
}

Tupal<ApiStatus, String> get emptyTuple => Tupal(ApiStatus.EMPTY, "");
Tupal<ApiStatus, String> get loadingTuple => Tupal(ApiStatus.LOADING, "");
Tupal<ApiStatus, String> get cancelledTuple => Tupal(ApiStatus.CANCELED, "");

Tupal<ApiStatus, String> get noDataTuple =>
    Tupal(ApiStatus.NO_DATA, "No Data Found");

Tupal<ApiStatus, String> get successTuple => Tupal(ApiStatus.SUCCESS, "");
Tupal<ApiStatus, String> get errorTuple =>
    Tupal(ApiStatus.SERVER_ERROR, "Something went wrong, try again");

class Tupal<T, V> {
  T item1;
  V item2;

  Tupal(this.item1, this.item2);
}
