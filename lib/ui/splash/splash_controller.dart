import 'package:get/get.dart';
import 'package:medplus/data/models/country_code.dart';
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
    if (SharedConfig.userId == null) {
      final responseData = await Get.put(ApiService()).fetchCountryCode();
      final countyCode = CountryCode.fromMap(responseData.data).countryCode;
      final pref = Get.find<AppPreferences>();
      pref.saveString(AppPreferencesKeys.countryCode, countyCode);
      SharedConfig.load(pref);
      print(countyCode);
      LoginPage.start(
        countyCode,
      );
    } else {
      await Future.delayed(const Duration(seconds: 1));
      HomePage.start();
    }
  }
}
