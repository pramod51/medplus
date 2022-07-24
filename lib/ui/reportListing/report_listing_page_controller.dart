import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/family_response.dart';
import 'package:medplus/data/models/search_report.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';

class ReportListingPageController extends GetxController {
  final apiTupal = emptyTuple.obs;
  final reportApiTupal = emptyTuple.obs;

  final data = <ReportData>[].obs;
  final familyList = <FamilyData>[].obs;
  final calcelToken = CancelToken();
  final service = Get.put(ApiService());

  int selectedIndex = 0;

  @override
  void onReady() {
    super.onReady();
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
        apiTupal.value = successTuple;
        return;
      }
      familyList[0].isSelected = true;
      fetchFamilyReport();
      debugPrint('Family data Success${responseData.msg}');
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
}
