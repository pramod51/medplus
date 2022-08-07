import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/home_page_response.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';
import 'package:medplus/ui/home/home_page_controller.dart';

class MyAccountPageController extends AppPageController {
  final apiTupal = emptyTuple.obs;
  final service = Get.put(ApiService());
  final homePageController = Get.find<HomePageController>();

  @override
  void onReady() {
    super.onReady();
    print('MyACC onReady called');
    fetchFamily();
    // selectedBottomNav.value = BottomNavItems.myAccount;
  }

  void fetchFamily() async {
    apiTupal.value = loadingTuple;
    if (homePageController.homePageData != null) {
      apiTupal.value = successTuple;
      return;
    }
    final apiResponse = await service.fetchHomePageData();
    final responseData = HomePageResponse.fromMap(apiResponse.data);
    if (apiResponse.success && responseData.data != null) {
      homePageController.homePageData = responseData.data;
      apiTupal.value = successTuple;
      debugPrint('Family data Success${responseData.msg}');
    } else {
      apiTupal.value = errorTuple;
    }
  }
}
