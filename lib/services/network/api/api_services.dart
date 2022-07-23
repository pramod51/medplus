import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/api_response.dart';
import 'package:medplus/services/network/dio_client.dart';
import 'package:medplus/utils/app_utils.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  final DioClient client = DioClient.getInstance();
  final String baseUrl = 'https://medical.techmeguru.com';
  Map<String, dynamic> makePalyload([
    Map<String, dynamic>? data,
  ]) {
    return {
      'api_key': 402784613679330,
      ...?data,
    };
  }

  Future<ApiResponse> doLogin(String phone) {
    return client.post(
      '$baseUrl/api/v1/get_challenge',
      makePalyload({
        "phone": int.parse(phone),
      }),
    );
  }

  Future<ApiResponse> fetchHomePageData() {
    return client.post(
      '$baseUrl/api/v1/my_dashboard',
      makePalyload({
        "user_id": SharedConfig.userId,
      }),
    );
  }

  Future<ApiResponse> uploadReport(
      {required MultipartFile data,
      required int categoryId,
      required String subCategory,
      required String reportDate,
      required String nextCheckupDate,
      required Function(int) onUploadProgress}) {
    FormData formData = FormData.fromMap(makePalyload({
      "user_id": SharedConfig.userId,
      'category_id': categoryId,
      'sub_category_key': subCategory,
      'report_date': AppUtils.getFormattedDate(reportDate),
      'next_checkup_date': AppUtils.getFormattedDate(nextCheckupDate),
      'reports[]': data,
    }));
    print(formData.fields);
    return client.upload(
      '$baseUrl/api/v1/add_my_documents',
      formData,
      onUploadProgress,
    );
  }

  void onProgress(int progress) {
    print(progress);
  }

  Future<File?> downloadReport(String url, String name, int id) async {
    final dir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final savePath = Platform.isAndroid
        ? '/storage/emulated/0/Medplus/$name Report $id.pdf'
        : ('${dir?.path}/$name Report $id.pdf');

    print(savePath);
    await client.download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
        }
      },
    );
    return File(savePath);
  }

  Future<ApiResponse> searchReport(String query, CancelToken cancelToken) {
    return client.post(
      '$baseUrl/api/v1/get_my_documents',
      makePalyload({
        "user_id": SharedConfig.userId,
        'search_key': query,
      }),
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse> fetchFamily() {
    return client.post(
      '$baseUrl/api/v1/get_family',
      makePalyload({
        "user_id": SharedConfig.userId,
      }),
    );
  }
}
