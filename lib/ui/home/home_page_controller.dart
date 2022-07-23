import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/home_page_response.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';
import 'package:medplus/ui/uploadReport/upload_report.dart';

class HomePageController extends AppPageController {
  final apiTupal = emptyTuple.obs;
  HomePageData? homePageData;
  String name = '';

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onReady() {
    super.onReady();

    selectedBottomNav.value = BottomNavItems.home;
  }

  void fetchData() async {
    apiTupal.value = loadingTuple;
    final service = Get.put(ApiService());
    final apiResponse = await service.fetchHomePageData();
    if (apiResponse.success) {
      final responseData = HomePageResponse.fromMap(apiResponse.data);
      if (responseData.data == null) {
        return;
      }
      homePageData = responseData.data!;
      name = homePageData!.user.name;
      debugPrint('Homepage Success${responseData.msg}');
      apiTupal.value = successTuple;
      saveSubCategory();
    } else {}
  }

  void onCategoryClicked(Category category) {
    UploadReport.start([
      name,
      category,
    ]);
  }

  void onTabClicked(String tabName) {
    name = tabName;
  }

  void saveSubCategory() {
    if (homePageData == null) return;
    final catList = <String>[];
    for (Category cat in homePageData!.category) {
      catList.addAll(cat.subCategory.split(','));
    }

    Get.find<AppPreferences>()
        .saveStringList(AppPreferencesKeys.subCategory, catList);
  }
}
