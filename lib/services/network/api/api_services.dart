import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medplus/data/preferences/app_preferences.dart';
import 'package:medplus/services/api_response.dart';
import 'package:medplus/services/network/dio_client.dart';
import 'package:medplus/utils/app_utils.dart';

class ApiService {
  final DioClient client = DioClient.getInstance();
  final String baseUrl = 'https://medical.techmeguru.com';
  Map<String, dynamic> makePayload([
    Map<String, dynamic>? data,
  ]) {
    return {
      'api_key': 402784613679330,
      ...?data,
    };
  }

  Future<ApiResponse> fetchCountryCode() {
    return client.get('http://ip-api.com/json', null);
  }

  Future<ApiResponse> doLogin(String phone) {
    return client.post(
      '$baseUrl/api/v1/get_challenge',
      makePayload({
        "phone": phone,
        'ccc': SharedConfig.callingCountryCode,
        'cc': SharedConfig.countryCode,
      }),
    );
  }

  Future<ApiResponse> doLoginWithSocialMedia(String email) {
    return client.post(
      '$baseUrl/api/v1/get_challenge',
      makePayload({
        "email": email,
      }),
    );
  }

  Future<ApiResponse> updateUserDetails(
    String name,
    String? phone,
    String? email,
  ) {
    return client.post(
      '$baseUrl/api/v1/update_user',
      makePayload({
        "user_id": SharedConfig.userId,
        "name": name,
        if (SharedConfig.email.isNullOrEmpty) "email": email,
        if (SharedConfig.phone.isNullOrEmpty) "phone": phone,
        if (SharedConfig.phone.isNullOrEmpty) "cc": SharedConfig.countryCode,
        if (SharedConfig.phone.isNullOrEmpty)
          "ccc": SharedConfig.callingCountryCode,
      }),
    );
  }

  Future<ApiResponse> fetchHomePageData() {
    return client.post(
      '$baseUrl/api/v1/my_dashboard',
      makePayload({
        "user_id": SharedConfig.userId,
      }),
    );
  }

  Future<ApiResponse> fetchCategories() {
    return client.post(
      '$baseUrl/api/v1/get_category',
      makePayload(),
    );
  }

  Future<ApiResponse> uploadReport(
      {required MultipartFile data,
      int? familyId,
      required int categoryId,
      required String subCategory,
      required String reportDate,
      required String nextCheckupDate,
      required Function(int) onUploadProgress}) {
    FormData formData = FormData.fromMap(makePayload({
      "user_id": SharedConfig.userId,
      "family_id": familyId,
      'category_id': categoryId,
      'sub_category_key': subCategory,
      'report_date': AppUtils.getFormattedDate(reportDate),
      'next_checkup_date': AppUtils.getFormattedDate(nextCheckupDate),
      'reports[]': data,
    }));
    print(formData.fields);
    return client.upload(
      '$baseUrl/api/v1/add_my_family_documents',
      formData,
      onUploadProgress,
    );
  }

  void onProgress(int progress) {
    print(progress);
  }

  Future<File?> downloadReport(String url, String savePath) async {
    try {
      final responseData = await client.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      );
      return responseData;
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse> searchReport(String query, CancelToken? cancelToken) {
    return client.post(
      '$baseUrl/api/v1/search_documents',
      makePayload({
        "user_id": SharedConfig.userId,
        'key': query,
      }),
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse> fetchFamily() {
    return client.post(
      '$baseUrl/api/v1/get_family',
      makePayload({
        "user_id": SharedConfig.userId,
      }),
    );
  }

  Future<ApiResponse> fetchFamilyReports(int? id, CancelToken cancelToken) {
    return client.post(
        '$baseUrl/api/v1/get_my_family_documents',
        makePayload({
          "user_id": SharedConfig.userId,
          'family_id': id ?? 0,
        }),
        cancelToken: cancelToken);
  }

  Future<ApiResponse> addFamily({
    required String name,
    required String relation,
    required String gender,
  }) {
    return client.post(
      '$baseUrl/api/v1/add_family',
      makePayload({
        "user_id": SharedConfig.userId,
        "name": name,
        "relation": relation,
        "sex": gender.toLowerCase()
      }),
    );
  }

  Future<ApiResponse> updateFamily({
    required String id,
    required String name,
    required String relation,
    required String gender,
  }) {
    return client.post(
      '$baseUrl/api/v1/update_family',
      makePayload({
        'family_id': id,
        "user_id": SharedConfig.userId,
        "name": name,
        "relation": relation,
        "sex": gender.toLowerCase()
      }),
    );
  }
}
