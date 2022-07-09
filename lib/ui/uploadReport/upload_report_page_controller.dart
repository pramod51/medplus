import 'package:medplus/ui/base/app_page_controller.dart';

class UploadReportPageController extends AppPageController {
  @override
  void onReady() {
    super.onReady();
    selectedBottomNav.value = BottomNavItems.home;
  }
}
