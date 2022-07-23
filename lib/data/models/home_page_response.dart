import 'dart:convert';
import 'package:medplus/data/models/search_report.dart';

class HomePageResponse {
  final String status;
  final String msg;
  final HomePageData? data;
  HomePageResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'msg': msg,
      'data': data?.toMap(),
    };
  }

  factory HomePageResponse.fromMap(Map<String, dynamic> map) {
    return HomePageResponse(
      status: (map['status'] ?? ''),
      msg: (map['msg'] ?? ''),
      data: map['data'] == null ? null : HomePageData.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePageResponse.fromJson(String source) =>
      HomePageResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'HomePageResponse(status: $status, msg: $msg, data: $data)';
}

class HomePageData {
  final User user;
  final List<MyFamily> myFamily;
  final List<String> familyNames;
  final List<Category> category;
  final List<ReportData> yourReport;
  HomePageData({
    required this.user,
    required this.myFamily,
    required this.category,
    required this.yourReport,
    required this.familyNames,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'myFamily': myFamily.map((x) => x.toMap()).toList(),
      'category': category.map((x) => x.toMap()).toList(),
      'yourReport': yourReport.map((x) => x.toMap()).toList(),
    };
  }

  factory HomePageData.fromMap(Map<String, dynamic> map) {
    final nameList = <String>[];
    final list = map['myFamily'] == null
        ? <MyFamily>[]
        : List<MyFamily>.from(
            (map['myFamily']).map<MyFamily>(
              (x) => MyFamily.fromMap(x),
            ),
          );
    for (MyFamily f in list) {
      print(f.name);
      nameList.add(f.name);
    }
    return HomePageData(
      user: map['user'] == null ? User.fromMap({}) : User.fromMap(map['user']),
      myFamily: list,
      category: List<Category>.from(
        (map['category']).map<Category>(
          (x) => Category.fromMap(x),
        ),
      ),
      yourReport: List<ReportData>.from(
        (map['yourReport']).map<ReportData>(
          (x) => ReportData.fromMap(x),
        ),
      ),
      familyNames: nameList,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePageData.fromJson(String source) =>
      HomePageData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(user: $user, myFamily: $myFamily, category: $category, yourReport: $yourReport)';
  }
}

class User {
  final int id;
  final String name;
  final String phone;
  final String sex;
  final String photoBaseUrl;
  final String profilePhotoUrl;
  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.sex,
    required this.photoBaseUrl,
    required this.profilePhotoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'sex': sex,
      'photo_base_url': photoBaseUrl,
      'profile_photo_url': profilePhotoUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: (map['id'].toInt() ?? 0),
      name: (map['name'] ?? ''),
      phone: (map['phone'] ?? ''),
      sex: map['sex'] ?? '',
      photoBaseUrl: (map['photo_base_url'] ?? ''),
      profilePhotoUrl: (map['profile_photo_url'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

class MyFamily {
  final int id;
  final int userId;
  final String relation;
  final String name;
  final String phone;
  final String sex;
  final int status;
  MyFamily({
    required this.id,
    required this.userId,
    required this.relation,
    required this.name,
    required this.phone,
    required this.sex,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'relation': relation,
      'name': name,
      'phone': phone,
      'sex': sex,
      'status': status,
    };
  }

  factory MyFamily.fromMap(Map<String, dynamic> map) {
    return MyFamily(
      id: (map['id'] ?? 0),
      userId: (map['user_id'].toInt() ?? 0),
      relation: (map['relation'] ?? ''),
      name: (map['name'] ?? ''),
      phone: (map['phone'] ?? ''),
      sex: (map['sex'] ?? ''),
      status: (map['status'].toInt() ?? 0),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyFamily.fromJson(String source) =>
      MyFamily.fromMap(json.decode(source));
}

class Category {
  final int id;
  final String name;
  final String name_ar;
  final String subCategory;
  final String sub_category_ar;
  final int status;
  final String created_at;
  final String updated_at;
  Category({
    required this.id,
    required this.name,
    required this.name_ar,
    required this.subCategory,
    required this.sub_category_ar,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name_en': name,
      'name_ar': name_ar,
      'sub_category_en': subCategory,
      'sub_category_ar': sub_category_ar,
      'status': status,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: (map['id'] ?? 0),
      name: (map['name_en'] ?? ''),
      name_ar: (map['name_ar'] ?? ''),
      subCategory: (map['sub_category_en'] ?? ''),
      sub_category_ar: (map['sub_category_ar'] ?? ''),
      status: (map['status'] ?? 0),
      created_at: (map['created_at'] ?? ''),
      updated_at: (map['updated_at'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(id: $id, name_en: $name, name_ar: $name_ar, sub_category_en: $subCategory, sub_category_ar: $sub_category_ar, status: $status, created_at: $created_at, updated_at: $updated_at)';
  }
}
