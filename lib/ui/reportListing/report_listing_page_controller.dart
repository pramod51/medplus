import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/family_response.dart';
import 'package:medplus/data/models/home_page_response.dart';
import 'package:medplus/data/models/search_report.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';

enum SortFilter {
  latest,
  old,
  none,
}

class ReportListingPageController extends GetxController {
  final apiTupal = emptyTuple.obs;
  final reportApiTupal = emptyTuple.obs;
  final category = Get.find<AppPreferences>().categoryList;
  final sorting = SortFilter.none.obs;
  final allData = <ReportData>[];
  final data = <ReportData>[].obs;
  final familyList = <FamilyData>[].obs;
  final calcelToken = CancelToken();
  final service = Get.put(ApiService());
  final allCategory = <Category>[];
  int selectedIndex = 0;

  @override
  void onReady() {
    super.onReady();
    allCategory.assignAll(Get.find<AppPreferences>().categoryList);
    print('ReportList onReady called');
    fetchFamily();
  }

  void fetchFamily() async {
    apiTupal.value = loadingTuple;
    final apiResponse = await service.fetchFamily();
    if (apiResponse.success) {
      final responseData = FamilyResponse.fromMap(apiResponse.data);
      familyList.assignAll(responseData.data);
      if (familyList.isEmpty) {
        apiTupal.value = noDataTuple;
        return;
      }
      familyList[0].isSelected = true;
      fetchFamilyReport();
      debugPrint('Family data Success${responseData.data}+ ');
    } else {
      apiTupal.value = errorTuple;
    }
  }

  void fetchFamilyReport() async {
    reportApiTupal.value = loadingTuple;
    final apiResponse = await service.fetchFamilyReports(
        familyList[selectedIndex].id, calcelToken);
    if (apiResponse.success) {
      final responseData = SearchReportResponse.fromMap(apiResponse.data);
      data.assignAll(responseData.data);
      allData.assignAll(responseData.data);
      debugPrint('Family report data Success${responseData.msg}');
      apiTupal.value = successTuple;
      reportApiTupal.value = successTuple;
    } else {
      reportApiTupal.value = errorTuple;
    }
  }

  void onFamilySelected(int index) {
    selectedIndex = index;
    familyList[familyList.indexWhere((element) => element.isSelected)]
        .isSelected = false;
    familyList[index].isSelected = true;
    fetchFamilyReport();
  }

  void categoryFilter() {
    if (category.where((element) => element.isSelected.value).isEmpty) {
      data.assignAll(allData);
      sortFilter();
      return;
    }
    data.assignAll(
        allData.where((element) => isCategoryAvail(element.categoryName)));
    sortFilter();
  }

  void sortFilter() {
    switch (sorting.value) {
      case SortFilter.old:
        data.sort((a, b) {
          if (a.reportDateTime == null) return 1;
          if (b.reportDateTime == null) return -1;
          if (a.reportDateTime!.isAfter(b.reportDateTime!)) return 1;
          if (a.reportDateTime!.isBefore(b.reportDateTime!)) return -1;
          return 0;
        });
        break;
      case SortFilter.latest:
        data.sort((a, b) {
          if (a.reportDateTime == null) return 1;
          if (b.reportDateTime == null) return -1;
          if (a.reportDateTime!.isAfter(b.reportDateTime!)) return -1;
          if (a.reportDateTime!.isBefore(b.reportDateTime!)) return 1;
          return 0;
        });
        break;
      case SortFilter.none:
        break;
    }
    for (var element in data) {
      print(element.reportDateTime);
    }
    Get.back();
  }

  bool isCategoryAvail(String name) {
    for (var element in category) {
      if (name == element.name && element.isSelected.value) return true;
    }
    return false;
  }

  void onFilterRemoved() {
    sorting.value = SortFilter.none;
    for (var element in category) {
      element.isSelected.value = false;
    }
    data.assignAll(allData);
    Get.back();
  }

  void onSortChanges(SortFilter sortFilter) {
    sorting.value = sortFilter;
    print(sortFilter);
  }

  Future<void> onRefresh() async {
    print('object');
    fetchFamilyReport();
    return;
  }
}
