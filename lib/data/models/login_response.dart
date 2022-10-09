import 'dart:convert';

class LoginResponse {
  final String status;
  final String msg;
  final int otp;
  final int userId;
  final Data? data;
  LoginResponse({
    required this.status,
    required this.msg,
    required this.otp,
    required this.userId,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'msg': msg,
      'otp': otp,
      'user_id': userId,
      'data': data?.toMap(),
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      status: (map['status'] ?? ''),
      msg: (map['msg'] ?? 'Something went wrong'),
      otp: (map['otp'] ?? -1),
      userId: (map['user_id'] ?? -1),
      data: map['data'] == null ? null : Data.fromMap(map['data']),
    );
  }
  bool get isMobileAndEmailRegisted =>
      data != null && (data!.email.isNotEmpty && data!.phone.isNotEmpty);
  bool get isValidUser => otp != 0 && userId != 0;

  bool get isMobileLogin => otp != -1 && userId != -1;

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoginResponse(status: $status, msg: $msg, otp: $otp, user_id: $userId)';
  }
}

class Data {
  final String name;
  final String phone;
  final String email;
  final int status;
  final int id;
  final String profilePhotoUrl;
  Data({
    required this.name,
    required this.phone,
    required this.email,
    required this.status,
    required this.id,
    required this.profilePhotoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'status': status,
      'id': id,
      'profile_photo_url': profilePhotoUrl,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      name: (map['name'] ?? ''),
      phone: (map['phone']?.toString() ?? ''),
      email: (map['email'] ?? ''),
      status: (map['status'] ?? 0),
      id: (map['id'] ?? 0),
      profilePhotoUrl: (map['profile_photo_url'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(name: $name, country_code: , phone: $phone, email: $email, permissions_id: , status: $status, created_by: , updated_at: , created_at: , id: $id, profile_photo_url: $profilePhotoUrl)';
  }
}
