import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/family_response.dart';
import 'package:medplus/data/models/search_report.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';

class SearchPageController extends GetxController {
  final apiTupal = emptyTuple.obs;
  final data = <ReportData>[].obs;
  final textEditingController = TextEditingController();
  final calcelToken = CancelToken();
  final service = Get.put(ApiService());
  final familyNameMap = <int, String>{};
  @override
  void onReady() {
    super.onReady();
    print('Search onReady called');
  }

  @override
  void onInit() {
    super.onInit();
    getSearchPageData();
    textEditingController.addListener(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      calcelToken.cancel();
      apiTupal.value = loadingTuple;
      final isSucess = await search();
      if (isSucess) {
        apiTupal.value = successTuple;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    print('Search onClose called');
  }

  void getSearchPageData() async {
    final response = await Future.wait([
      search(),
      fetchFamily(),
    ]);
    if (response.first && response.last) {
      apiTupal.value = successTuple;
    } else {
      apiTupal.value = errorTuple;
    }
  }

  Future<bool> search() async {
    final apiResponse =
        await service.searchReport(textEditingController.text, calcelToken);
    if (apiResponse.success) {
      final responseData = SearchReportResponse.fromMap(apiResponse.data);

      data.assignAll(responseData.data);
      debugPrint('Serach Success${responseData.msg}');

      return true;
    } else {}
    return false;
  }

  Future<bool> fetchFamily() async {
    final apiResponse = await service.fetchFamily();
    if (apiResponse.success) {
      final responseData = FamilyResponse.fromMap(apiResponse.data);
      for (FamilyData f in responseData.data) {
        familyNameMap[f.id!] = f.name;
      }
      debugPrint('Family data Success${responseData.msg}');
      return true;
    } else {}
    return false;
  }
}
