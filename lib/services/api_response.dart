// ignore: constant_identifier_names
enum ApiStatus {
  EMPTY,
  NO_DATA,
  LOADING,
  SUCCESS,
  NETWORK_ERROR,
  SERVER_ERROR,
  CLIENT_ERROR,
  CANCELED,
}

extension ApiStatusExtension on ApiStatus {
  bool get isError {
    // ignore: missing_enum_constant_in_switch
    switch (this) {
      case ApiStatus.NETWORK_ERROR:
      case ApiStatus.SERVER_ERROR:
      case ApiStatus.CLIENT_ERROR:
        return true;
    }
    return false;
  }

  bool get isSuccess {
    return this == ApiStatus.SUCCESS;
  }

  bool get isLoading {
    return this == ApiStatus.LOADING;
  }
}

class ApiResponse<T> {
  int httpStatusCode = -1;
  ApiStatus status;
  String message = "Invalid Response";
  dynamic data;

  ApiResponse.empty() : status = ApiStatus.EMPTY;

  ApiResponse.loading() : status = ApiStatus.LOADING;

  ApiResponse.success({
    required this.httpStatusCode,
    this.message = "OK",
    this.data,
  }) : status = ApiStatus.SUCCESS;

  ApiResponse.error({
    this.httpStatusCode = -1,
    required this.status,
    this.message = "Something went wrong, try again",
    this.data,
  });

  bool get success => status == ApiStatus.SUCCESS;
}
