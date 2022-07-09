import 'package:get/get_state_manager/get_state_manager.dart';

class SearchPageController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    print('Search onReady called');
  }

  @override
  void dispose() {
    super.dispose();
    print('Search onClose called');
  }
}
