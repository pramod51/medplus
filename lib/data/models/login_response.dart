import 'dart:convert';

class LoginResponse {
  final String status;
  final String msg;
  final int otp;
  final int userId;
  LoginResponse({
    required this.status,
    required this.msg,
    required this.otp,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'msg': msg,
      'otp': otp,
      'user_id': userId,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      status: (map['status'] ?? ''),
      msg: (map['msg'] ?? ''),
      otp: (map['otp'] ?? 0),
      userId: (map['user_id'] ?? 0),
    );
  }

  bool get isValidUser => otp != 0 && userId != 0;

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponse(status: $status, msg: $msg, otp: $otp, user_id: $userId)';
  }
}
