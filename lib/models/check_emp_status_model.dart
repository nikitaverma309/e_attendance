

import 'dart:convert';

CheckStatusModel checkStatusModelFromJson(String str) => CheckStatusModel.fromJson(json.decode(str));

String checkStatusModelToJson(CheckStatusModel data) => json.encode(data.toJson());

class CheckStatusModel {
  String msg;
  GetEmployeeCode getEmployeeCode;

  CheckStatusModel({
    required this.msg,
    required this.getEmployeeCode,
  });

  CheckStatusModel copyWith({
    String? msg,
    GetEmployeeCode? getEmployeeCode,
  }) =>
      CheckStatusModel(
        msg: msg ?? this.msg,
        getEmployeeCode: getEmployeeCode ?? this.getEmployeeCode,
      );

  factory CheckStatusModel.fromJson(Map<String, dynamic> json) => CheckStatusModel(
    msg: json["msg"],
    getEmployeeCode: GetEmployeeCode.fromJson(json["getEmployeeCode"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "getEmployeeCode": getEmployeeCode.toJson(),
  };
}

class GetEmployeeCode {
  String id;
  String empCode;
  String name;
  int contact;
  String college;
  bool status;
  DateTime updatedAt;

  GetEmployeeCode({
    required this.id,
    required this.empCode,
    required this.name,
    required this.contact,
    required this.college,
    required this.status,
    required this.updatedAt,
  });

  GetEmployeeCode copyWith({
    String? id,
    String? empCode,
    String? name,
    int? contact,
    String? college,
    bool? status,
    DateTime? updatedAt,
  }) =>
      GetEmployeeCode(
        id: id ?? this.id,
        empCode: empCode ?? this.empCode,
        name: name ?? this.name,
        contact: contact ?? this.contact,
        college: college ?? this.college,
        status: status ?? this.status,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory GetEmployeeCode.fromJson(Map<String, dynamic> json) => GetEmployeeCode(
    id: json["_id"],
    empCode: json["empCode"],
    name: json["name"],
    contact: json["contact"],
    college: json["college"],
    status: json["status"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "empCode": empCode,
    "name": name,
    "contact": contact,
    "college": college,
    "status": status,
    "updatedAt": updatedAt.toIso8601String(),
  };
}
