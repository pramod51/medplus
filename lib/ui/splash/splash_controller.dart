import 'package:get/get.dart';
import 'package:medplus/ui/authentication/login/login_page.dart';

class SplashController extends GetxController {
  final String prt = 'khdjdf';
  @override
  void onReady() {
    super.onReady();
    // print(Get.locale?.countryCode);
    // final Locale? deviceLocale = CountryCodes.getDeviceLocale();
    // print(deviceLocale?.languageCode); // Displays en
    // print(deviceLocale?.countryCode); // Displays US

    // final CountryDetails details = CountryCodes.detailsForLocale();
    // print(details.alpha2Code); // Displays alpha2Code, for example US.
    // print(details.dialCode); // Displays the dial code, for example +1.
    // print(
    //     details.name); // Displays the extended name, for example United States.
    // print(details.localizedName);
    navigate();
  }

  void navigate() async {
    await Future.delayed(const Duration(seconds: 1));
    LoginPage.start();
  }
}
