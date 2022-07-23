import 'dart:convert';

class FamilyResponse {
  final String status;
  final String msg;
  final List<Data> data;
  final Map<int, String> familyData;
  FamilyResponse({
    required this.status,
    required this.msg,
    required this.data,
    required this.familyData,
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
        ? <Data>[]
        : List<Data>.from((map['data']).map<Data>(
            (x) => Data.fromMap(x),
          ));
    Map<int, String> familyData = {};
    for (Data data in list) {
      familyData[data.id] = data.name;
    }
    return FamilyResponse(
      status: (map['status'] ?? ''),
      msg: (map['msg'] ?? ''),
      data: list,
      familyData: familyData,
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilyResponse.fromJson(String source) =>
      FamilyResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'FamilyResponse(status: $status, msg: $msg, data: $data)';
}

class Data {
  final int id;
  final int user_id;
  final String relation;
  final String name;
  final String phone;
  final String sex;
  final int age;
  final int status;
  final String created_at;
  final String updated_at;
  Data({
    required this.id,
    required this.user_id,
    required this.relation,
    required this.name,
    required this.phone,
    required this.sex,
    required this.age,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

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

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: (map['id'] ?? 0),
      user_id: (map['user_id'] ?? 0),
      relation: (map['relation'] ?? ''),
      name: (map['name'] ?? ''),
      phone: (map['phone'] ?? ''),
      sex: (map['sex'] ?? ''),
      age: (map['age'] ?? 0),
      status: (map['status'] ?? 0),
      created_at: (map['created_at'] ?? ''),
      updated_at: (map['updated_at'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(id: $id, user_id: $user_id, relation: $relation, name: $name, phone: $phone, sex: $sex, age: $age, status: $status, created_at: $created_at, updated_at: $updated_at)';
  }
}
