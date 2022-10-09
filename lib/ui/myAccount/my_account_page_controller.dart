import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/home_page_response.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';
import 'package:medplus/ui/home/home_page_controller.dart';

class MyAccountPageController extends AppPageController {
  final apiTuple = emptyTuple.obs;
  final service = Get.put(ApiService());
  final familyList = Get.find<HomePageController>().familyList;

  @override
  void onReady() {
    super.onReady();
    print('MyACC onReady called');
    fetchFamily();
    // selectedBottomNav.value = BottomNavItems.myAccount;
  }

  void fetchFamily() async {
    apiTuple.value = loadingTuple;
    if (familyList.isNotEmpty) {
      apiTuple.value = successTuple;
      return;
    }

    final apiResponse = await service.fetchHomePageData();
    if (apiResponse.success && apiResponse.data != null) {
      final responseData = HomePageResponse.fromMap(apiResponse.data);
      familyList.assignAll(responseData.data!.myFamily);
      apiTuple.value = successTuple;
      debugPrint('Family data Success${responseData.msg}');
    } else {
      apiTuple.value = errorTuple;
    }
  }
}
