import 'package:get/get.dart';
import 'package:medplus/data/models/country_code.dart';
import 'package:medplus/data/models/home_page_response.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/authentication/login/login_page.dart';
import 'package:medplus/ui/downloads/download.dart';
import 'package:medplus/ui/home/home_page.dart';
import 'package:medplus/utils/app_utils.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    navigate();
  }

  void navigate() async {
    final pref = Get.find<AppPreferences>();
    if (SharedConfig.languageCode.isNullOrEmpty) {
      SharedConfig.saveString(AppPreferencesKeys.languageCode, 'en');
    }
    if (SharedConfig.userId == null) {
      final apiResponse = await Get.put(ApiService()).fetchCountryCode();
      if (!apiResponse.success) return;
      final responseData = CountryCode.fromMap(apiResponse.data);

      pref.saveString(
          AppPreferencesKeys.languageCode, Get.locale?.languageCode ?? 'en');
      pref.saveString(AppPreferencesKeys.callingCountryCode, responseData.ccc);
      pref.saveString(AppPreferencesKeys.countryCode, responseData.cc);
      SharedConfig.load(pref);
      print(responseData.cc);
      LoginPage.start();
    }
    // else if (SharedConfig.email.isNullOrEmpty ||
    //     SharedConfig.phone.isNotNullOrEmpty) {
    //   Get.toNamed(EditProfile.routeName);
    // }
  }

  void fetchCategories() async {
    final pref = Get.find<AppPreferences>();
    try {
      final apiResponse = await Get.put(ApiService()).fetchCategories();
      print(apiResponse.httpStatusCode.toString() + '#############');

      if (apiResponse.httpStatusCode == -1 && SharedConfig.userId != null) {
        Get.offAndToNamed(Downloads.routeName);
        return;
      }
      if (apiResponse.success) {
        final responseData = CategoryResponse.fromMap(apiResponse.data);
        pref.assigneCategory(responseData.data);
        HomePage.start();
      }
    } catch (e) {
      print(e);
    }
  }
}
