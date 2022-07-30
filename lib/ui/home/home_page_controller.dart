import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/family_response.dart';
import 'package:medplus/data/models/home_page_response.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';
import 'package:medplus/ui/uploadReport/upload_report.dart';

// SHA1: 73:D6:34:D4:C1:BF:CB:72:F1:7E:5A:32:D0:15:8A:09:2B:E9:17:95
//  SHA256: F9:C8:4B:B2:33:2D:7E:48:1F:5A:89:CD:6F:98:55:AE:A4:65:05:0C:50:F5:43:2C:96:AE:B6:65:11:B0:E0:CE
class HomePageController extends AppPageController {
  final apiTupal = emptyTuple.obs;
  HomePageData? homePageData;
  String name = '';
  int selectedTabIndex = 0;
  int? familyId;
  TabController? tabController;

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
        apiTupal.value = errorTuple;
        return;
      }
      homePageData = responseData.data!;
      name = homePageData!.user.name;
      debugPrint('Homepage Success${responseData.msg}');
      apiTupal.value = successTuple;
      saveSubCategory();
    } else {
      apiTupal.value = errorTuple;
    }
  }

  void onCategoryClicked(Category category) async {
    await Future.delayed(const Duration(milliseconds: 100));
    UploadReport.start([name, category, familyId]);
  }

  void onTabClicked(FamilyData famData) {
    name = famData.name;
    familyId = famData.id;
  }

  void saveSubCategory() {
    if (homePageData == null) return;

    final pref = Get.find<AppPreferences>();
    pref.saveString(AppPreferencesKeys.name, homePageData!.user.name);
    pref.saveInt(AppPreferencesKeys.userId, homePageData!.user.id);
    final catList = <String>[];
    for (Category cat in homePageData!.category) {
      catList.addAll(cat.subCategory.split(','));
    }
    pref.saveStringList(AppPreferencesKeys.subCategory, catList);
    SharedConfig.load(Get.find<AppPreferences>());
  }
}
