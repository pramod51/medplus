import 'package:get/get.dart';
import 'package:medplus/ui/authentication/login/login_page.dart';
import 'package:medplus/ui/authentication/login/login_page_controller.dart';
import 'package:medplus/ui/authentication/otp/otp_page.dart';
import 'package:medplus/ui/authentication/otp/otp_page_controller.dart';
import 'package:medplus/ui/home/home_page.dart';
import 'package:medplus/ui/myAccount/my_account_page.dart';
import 'package:medplus/ui/myAccount/my_account_page_controller.dart';
import 'package:medplus/ui/reportListing/report_listing.dart';
import 'package:medplus/ui/search/search_page.dart';
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
        page: () => LoginPage(),
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
            // Get.create(() => HomePageController());
          },
        ),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: OtpPage.routeName,
        page: () => OtpPage(),
        binding: BindingsBuilder(
          () {
            Get.create(() => OtpPageController());
          },
        ),
      ),
      GetPage(
        name: ReportListing.routeName,
        page: () => ReportListing(),
        binding: BindingsBuilder(
          () {
            // Get.create(() => ReportListingPageController());
          },
        ),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: UploadReport.routeName,
        page: () => UploadReport(),
        binding: BindingsBuilder(
          () {
            // Get.create(() => UploadReportPageController());
          },
        ),
      ),
      GetPage(
        name: SearchPage.routeName,
        page: () => SearchPage(),
        binding: BindingsBuilder(
          () {
            // Get.create(() => SearchPageController());
          },
        ),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: MyAccountPage.routeName,
        page: () => MyAccountPage(),
        binding: BindingsBuilder(
          () {
            Get.create(() => MyAccountPageController());
          },
        ),
        transition: Transition.noTransition,
      ),
    ];
  }
}
