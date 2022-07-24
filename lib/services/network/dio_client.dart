import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:medplus/services/api_response.dart';

const int _defaultConnectTimeout = 30 * 1000; // 30 sec
const int _defaultReceiveTimeout = 60 * 1000; // 60 sec

class DioClient {
  late Dio _dio;
  static final DioClient _instance = DioClient._internal();

  static Set<String> ignoreApiSessionExpired = {
    //  "/XmppJinie/favList/",
  };

  factory DioClient.getInstance() {
    return _instance;
  }

  DioClient._internal() {
    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: _defaultConnectTimeout,
      receiveTimeout: _defaultReceiveTimeout,
    );
    _dio = Dio(options);
  }

  Future<ApiResponse> post(
    String url,
    dynamic data, {
    Options? options,
    CancelToken? cancelToken,
  }) async {
    debugPrint(url + "\n" + data.toString());
    try {
      final response = await _dio.post<dynamic>(
        url,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(
        data: response.data,
        httpStatusCode: response.statusCode ?? 200,
      );
    } catch (error) {
      debugPrint("DioClient, post() -> catch");
      debugPrint(error.toString());
      return ApiResponse.error(status: ApiStatus.SERVER_ERROR);
    } // end of catch block
  }

  Future<ApiResponse> get(
    String url,
    dynamic data, {
    Options? options,
  }) async {
    debugPrint(url + "\n" + data.toString());
    try {
      final response = await _dio.get<dynamic>(
        url,
        queryParameters: data,
        options: options,
      );
      return ApiResponse.success(
        data: response.data,
        httpStatusCode: response.statusCode ?? 200,
      );
    } catch (error) {
      debugPrint("DioClient, get() -> catch");
      debugPrint(error.toString());
      return ApiResponse.error(status: ApiStatus.SERVER_ERROR);
    } // end of catch block
  }

  Future<ApiResponse> upload(
    String url,
    FormData formData,
    Function(int percentage)? onUploadProgress, {
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: formData,
        onSendProgress: (count, total) {
          if (onUploadProgress != null) {
            var value = int.parse((count / total * 100).toStringAsFixed(0));
            if (value > 0) {
              onUploadProgress(value);
            }
          }
        },
        options: options,
        cancelToken: cancelToken,
      );

      return ApiResponse.success(
        httpStatusCode: response.statusCode!,
        data: response.data,
      );
    } catch (error) {
      debugPrint("DioClient, download() -> catch");
      debugPrint(error.toString());
      return ApiResponse.error(status: ApiStatus.SERVER_ERROR);
    }
  }

  Future<void> download(
    String url,
    String savePath, {
    Function(int received, int total)? onReceiveProgress,
  }) async {
    //   if (total != -1) {
    //  print((received / total * 100).toStringAsFixed(0) + "%");
    // }
    try {
      final response = await _dio.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
      );
      // File file = File(savePath);
      // var raf = file.openSync(mode: FileMode.write);
      // raf.writeFromSync(response.data);
      // await raf.close();

    } catch (e) {
      print(e.toString());
    }
  }
}
