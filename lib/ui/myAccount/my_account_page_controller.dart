import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/family_response.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';
import 'package:medplus/ui/home/home_page_controller.dart';

class MyAccountPageController extends AppPageController {
  final apiTupal = emptyTuple.obs;
  final service = Get.put(ApiService());
  final familyList = <FamilyData>[];

  @override
  void onReady() {
    super.onReady();
    print('MyACC onReady called');
    fetchFamily();
    // selectedBottomNav.value = BottomNavItems.myAccount;
  }

  void fetchFamily() async {
    apiTupal.value = loadingTuple;
    final homeData = Get.find<HomePageController>().homePageData;
    if (homeData != null && homeData.myFamily.isNotEmpty) {
      familyList.assignAll(homeData.myFamily);
      apiTupal.value = successTuple;
      return;
    }
    final apiResponse = await service.fetchFamily();
    if (apiResponse.success) {
      final responseData = FamilyResponse.fromMap(apiResponse.data);
      if (responseData.data.isEmpty) {
        return;
      }
      familyList.assignAll(responseData.data);
      apiTupal.value = successTuple;
      debugPrint('Family data Success${responseData.msg}');
    } else {
      apiTupal.value = errorTuple;
    }
  }
}
