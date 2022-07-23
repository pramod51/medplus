import 'dart:convert';

import 'package:medplus/utils/app_utils.dart';

class SearchReportResponse {
  final String status;
  final String msg;
  final List<ReportData> data;
  SearchReportResponse({
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

  factory SearchReportResponse.fromMap(Map<String, dynamic> map) {
    return SearchReportResponse(
      status: (map['status'] ?? ''),
      msg: (map['msg'] ?? ''),
      data: map['data'] == null
          ? <ReportData>[]
          : List<ReportData>.from(
              (map['data']).map<ReportData>(
                (x) => ReportData.fromMap(x),
              ),
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchReportResponse.fromJson(String source) =>
      SearchReportResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SearchReportResponse(status: $status, msg: $msg, data: $data)';
}

class ReportData {
  final int id;
  final int userId;
  final int familyId;
  final int categoryId;
  final String subCategoryKey;
  final String reports;
  final String reportDate;
  final String next_checkup_date;
  final int status;
  final String created_at;
  final String updated_at;
  final String reportBaseUrl;
  final String categoryName;
  ReportData({
    required this.id,
    required this.userId,
    required this.familyId,
    required this.categoryId,
    required this.subCategoryKey,
    required this.reports,
    required this.reportDate,
    required this.next_checkup_date,
    required this.status,
    required this.created_at,
    required this.updated_at,
    required this.reportBaseUrl,
    required this.categoryName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'family_id': familyId,
      'category_id': categoryId,
      'sub_category_key': subCategoryKey,
      'reports': reports,
      'report_date': reportDate,
      'next_checkup_date': next_checkup_date,
      'status': status,
      'created_at': created_at,
      'updated_at': updated_at,
      'report_base_url': reportBaseUrl,
      'name_en': categoryName,
    };
  }

  factory ReportData.fromMap(Map<String, dynamic> map) {
    return ReportData(
      id: (map['id'] ?? 0),
      userId: (map['user_id'] ?? 0),
      familyId: (map['family_id'] ?? 0),
      categoryId: (map['category_id'] ?? 0),
      subCategoryKey: (map['sub_category_key'] ?? ''),
      reports: (map['reports'] ?? ''),
      reportDate: map['report_date'] == null
          ? ''
          : DateTime.parse(map['report_date']).format('dd-MM-yyyy'),
      next_checkup_date: (map['next_checkup_date'] ?? ''),
      status: (map['status'] ?? 0),
      created_at: (map['created_at'] ?? ''),
      updated_at: map['updated_at'] == null
          ? ''
          : DateTime.parse(map['updated_at']).format('dd-MM-yyyy'),
      reportBaseUrl: (map['report_base_url'] ?? ''),
      categoryName: (map['name_en'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportData.fromJson(String source) =>
      ReportData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(id: $id, user_id: $userId, family_id: $familyId, category_id: $categoryId, sub_category_key: $subCategoryKey, reports: $reports, report_date: $reportDate, next_checkup_date: $next_checkup_date, status: $status, created_at: $created_at, updated_at: $updated_at, report_base_url: $reportBaseUrl, name_en: $categoryName)';
  }
}
