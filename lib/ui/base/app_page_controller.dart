import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/main.dart';
import 'package:medplus/services/api_response.dart';
import 'package:medplus/ui/authentication/login/login_page.dart';
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
          child: AddMemberDilog(
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
    final pref = Get.find<AppPreferences>();
    if (SharedConfig.locale?.languageCode == 'en') {
      pref.saveString(AppPreferencesKeys.languageCode, 'ar');
      pref.saveString(AppPreferencesKeys.countryCode, 'UAE');
      await Get.updateLocale(const Locale('ar', 'UAE'));
    } else {
      pref.saveString(AppPreferencesKeys.languageCode, 'en');
      pref.saveString(AppPreferencesKeys.countryCode, 'US');
      await Get.updateLocale(const Locale('en', 'US'));
    }
    SharedConfig.load(pref);
    Get.back();
    runApp(const RestartWidget());
  }

  void onRefAFrdClicked() {}

  void onSignOutClicked() async {
    final code = SharedConfig.callingCountryCode;
    await Get.find<AppPreferences>().clearAll();
    await Get.deleteAll();
    LoginPage.start(code);
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
Tupal<ApiStatus, String> get successTuple => Tupal(ApiStatus.SUCCESS, "");
Tupal<ApiStatus, String> get errorTuple =>
    Tupal(ApiStatus.SERVER_ERROR, "Something went wrong, try again");

class Tupal<T, V> {
  T item1;
  V item2;

  Tupal(this.item1, this.item2);
}
