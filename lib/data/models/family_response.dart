import 'dart:convert';

import 'package:get/get.dart';

class FamilyResponse {
  final String status;
  final String msg;
  final List<FamilyData> data;
  FamilyResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'msg': msg,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory FamilyResponse.fromMap(Map<String, dynamic> map) {
    final list = map['data'] == null
        ? <FamilyData>[].obs
        : List<FamilyData>.from((map['data']).map<FamilyData>(
            (x) => FamilyData.fromMap(x),
          )).obs;

    return FamilyResponse(
      status: (map['status'] ?? ''),
      msg: (map['msg'] ?? ''),
      data: list,
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilyResponse.fromJson(String source) =>
      FamilyResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'FamilyResponse(status: $status, msg: $msg, data: $data)';
}

class FamilyData {
  final int? id;
  final int user_id;
  String relation;
  String name;
  final String phone;
  String sex;
  final int age;
  final int status;
  final String created_at;
  final String updated_at;
  bool isSelected;
  FamilyData(
      {required this.id,
      required this.user_id,
      required this.relation,
      required this.name,
      required this.phone,
      required this.sex,
      required this.age,
      required this.status,
      required this.created_at,
      required this.updated_at,
      required this.isSelected});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'relation': relation,
      'name': name,
      'phone': phone,
      'sex': sex,
      'age': age,
      'status': status,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory FamilyData.fromMap(Map<String, dynamic> map) {
    return FamilyData(
      id: map['id'],
      user_id: (map['user_id'] ?? 0),
      relation: (map['relation'] ?? ''),
      name: (map['name'] ?? ''),
      phone: (map['phone'] ?? ''),
      sex: (map['sex'] ?? ''),
      age: (map['age'] ?? 0),
      status: (map['status'] ?? 0),
      created_at: (map['created_at'] ?? ''),
      updated_at: (map['updated_at'] ?? ''),
      isSelected: false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilyData.fromJson(String source) =>
      FamilyData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(id: $id, user_id: $user_id, relation: $relation, name: $name, phone: $phone, sex: $sex, age: $age, status: $status, created_at: $created_at, updated_at: $updated_at)';
  }
}

class AddFamily {
  final String status;
  final String msg;
  final FamilyData data;
  AddFamily({
    required this.status,
    required this.msg,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'msg': msg,
      'data': data.toMap(),
    };
  }

  factory AddFamily.fromMap(Map<String, dynamic> map) {
    return AddFamily(
      status: (map['status'] ?? ''),
      msg: (map['msg'] ?? ''),
      data: map['data'] == null
          ? FamilyData.fromMap({})
          : FamilyData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddFamily.fromJson(String source) =>
      AddFamily.fromMap(json.decode(source));

  @override
  String toString() => 'AddFamily(status: $status, msg: $msg, data: $data)';
}
