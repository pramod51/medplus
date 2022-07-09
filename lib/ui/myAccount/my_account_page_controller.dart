import 'package:medplus/ui/base/app_page_controller.dart';

class MyAccountPageController extends AppPageController {
  @override
  void onReady() {
    super.onReady();
    print('MyACC onReady called');

    selectedBottomNav.value = BottomNavItems.myAccount;
  }
}
