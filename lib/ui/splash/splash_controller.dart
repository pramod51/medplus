import 'package:get/get.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
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
    await Future.delayed(const Duration(seconds: 1));
    if (SharedConfig.userId == null) {
      LoginPage.start();
    } else {
      HomePage.start();
    }
  }
}
