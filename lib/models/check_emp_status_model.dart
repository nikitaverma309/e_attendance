// To parse this JSON data, do
//
//     final checkStatusModel = checkStatusModelFromJson(jsonString);

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

  GetEmployeeCode({
    required this.id,
    required this.empCode,
    required this.name,
    required this.contact,
    required this.college,
    required this.status,
  });

  factory GetEmployeeCode.fromJson(Map<String, dynamic> json) => GetEmployeeCode(
    id: json["_id"],
    empCode: json["empCode"],
    name: json["name"],
    contact: json["contact"],
    college: json["college"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "empCode": empCode,
    "name": name,
    "contact": contact,
    "college": college,
    "status": status,
  };
}
