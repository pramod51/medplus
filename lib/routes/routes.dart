import 'package:get/get.dart';
import 'package:medplus/ui/authentication/login/login_page.dart';
import 'package:medplus/ui/authentication/login/login_page_controller.dart';
import 'package:medplus/ui/authentication/otp/otp_page.dart';
import 'package:medplus/ui/home/home_page.dart';
import 'package:medplus/ui/reportListing/report_listing.dart';
import 'package:medplus/ui/splash/splash_controller.dart';
import 'package:medplus/ui/splash/splash_page.dart';
import 'package:medplus/ui/uploadReport/upload_report.dart';

class Routes {
  Routes._();
  static String initialRoute = SplashPage.routeName;
  static List<GetPage> get() {
    return [
      GetPage(
        name: SplashPage.routeName,
        page: () => SplashPage(),
        binding: BindingsBuilder(
          () {
            Get.create(() => SplashController());
          },
        ),
      ),
      GetPage(
        name: LoginPage.routeName,
        page: () => const LoginPage(),
        binding: BindingsBuilder(
          () {
            Get.create(() => LoginPageController());
          },
        ),
      ),
      GetPage(
        name: HomePage.routeName,
        page: () => HomePage(),
        binding: BindingsBuilder(
          () {
            //Get.create(() => HomePageController());
          },
        ),
      ),
      GetPage(
        name: OtpPage.routeName,
        page: () => const OtpPage(),
        binding: BindingsBuilder(
          () {
            //Get.create(() => HomePageController());
          },
        ),
      ),
      GetPage(
        name: ReportListing.routeName,
        page: () => ReportListing(),
        binding: BindingsBuilder(
          () {
            //Get.create(() => HomePageController());
          },
        ),
      ),
      GetPage(
        name: UploadReport.routeName,
        page: () => UploadReport(),
        binding: BindingsBuilder(
          () {
            //Get.create(() => HomePageController());
          },
        ),
      ),
    ];
  }
}
