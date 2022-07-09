import 'package:medplus/ui/base/app_page_controller.dart';

class ReportListingPageController extends AppPageController {
  @override
  void onReady() {
    super.onReady();
    print('ReportList onReady called');

    selectedBottomNav.value = BottomNavItems.home;
  }
}
