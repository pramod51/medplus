import 'package:get/get.dart';
import 'package:medplus/data/models/country_code.dart';
import 'package:medplus/data/models/home_page_response.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/authentication/login/login_page.dart';
import 'package:medplus/ui/home/home_page.dart';

class SplashController extends GetxController {
  final String prt = 'khdjdf';

  @override
  void onReady() {
    super.onReady();
    navigate();
  }

  void navigate() async {
    final pref = Get.find<AppPreferences>();
    // print(SharedConfig.locale?.countryCode);
    // return
    // pref.saveInt(AppPreferencesKeys.userId, 11);

    // SharedConfig.load(pref);
    if (SharedConfig.userId == null) {
      final apiResponse = await Get.put(ApiService()).fetchCountryCode();
      final responseData = CountryCode.fromMap(apiResponse.data);
      pref.saveString(
          AppPreferencesKeys.languageCode, Get.locale?.languageCode ?? 'en');
      pref.saveString(AppPreferencesKeys.callingCountryCode, responseData.ccc);
      SharedConfig.load(pref);
      print(responseData.cc);
      LoginPage.start(
        responseData.ccc,
      );
    } else {
      final apiResponse = await Get.put(ApiService()).fetchCategories();
      if (apiResponse.success) {
        final responseData = CategoryResponse.fromMap(apiResponse.data);
        pref.assigneCategory(responseData.data);
        HomePage.start();
      }
    }
  }
}
