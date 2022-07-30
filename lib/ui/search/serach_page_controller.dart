import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medplus/data/models/family_response.dart';
import 'package:medplus/data/models/search_report.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/network/api/api_services.dart';
import 'package:medplus/ui/base/app_page_controller.dart';

class SearchPageController extends GetxController {
  final apiTupal = emptyTuple.obs;
  final data = <ReportData>[].obs;
  final textEditingController = TextEditingController();
  CancelToken? cancelToken;
  List<String> suggestions = [];
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
    fetchFamily();
    textEditingController.addListener(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      // calcelToken.cancel();

      final isSucess = await search();
      if (isSucess) {
        apiTupal.value = successTuple;
      } else {
        apiTupal.value = errorTuple;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    print('Search onClose called');
  }

  Future<bool> search() async {
    apiTupal.value = loadingTuple;
    if (familyNameMap.isEmpty) {
      await fetchFamily();
    }
    cancelToken?.cancel("fetching contacts");
    cancelToken = CancelToken();
    final apiResponse =
        await service.searchReport(textEditingController.text, cancelToken);
    if (apiResponse.success) {
      final responseData = SearchReportResponse.fromMap(apiResponse.data);
      apiTupal.value = successTuple;
      data.assignAll(responseData.data);
      debugPrint('Serach Success${responseData.msg}');
      return true;
    } else {
      apiTupal.value = errorTuple;
    }
    return false;
  }

  Future<bool> fetchFamily() async {
    final apiResponse = await service.fetchFamily();
    if (apiResponse.success) {
      final responseData = FamilyResponse.fromMap(apiResponse.data);
      for (FamilyData f in responseData.data) {
        familyNameMap[f.id!] = f.name;
        print('${f.id} ${SharedConfig.name}');
      }
      if (familyNameMap.isEmpty) {
        familyNameMap[-1] = '';
      }
      search();
      debugPrint('Family data Success${responseData.msg}');
      return true;
    } else {}
    return false;
  }
}
