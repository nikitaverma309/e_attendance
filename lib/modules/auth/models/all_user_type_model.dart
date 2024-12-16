// To parse this JSON data, do
//
//     final allUserTypeModel = allUserTypeModelFromJson(jsonString);

import 'dart:convert';

AllUserTypeModel allUserTypeModelFromJson(String str) => AllUserTypeModel.fromJson(json.decode(str));

String allUserTypeModelToJson(AllUserTypeModel data) => json.encode(data.toJson());

class AllUserTypeModel {
  List<GetAllUserType>? getAllUserType;

  AllUserTypeModel({
    this.getAllUserType,
  });

  factory AllUserTypeModel.fromJson(Map<String, dynamic> json) => AllUserTypeModel(
    getAllUserType: json["getAllUserType"] == null ? [] : List<GetAllUserType>.from(json["getAllUserType"]!.map((x) => GetAllUserType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "getAllUserType": getAllUserType == null ? [] : List<dynamic>.from(getAllUserType!.map((x) => x.toJson())),
  };
}

class GetAllUserType {
  String? id;
  String? userType;
  int? userTypeCode;
  String? userTypeHin;

  GetAllUserType({
    this.id,
    this.userType,
    this.userTypeCode,
    this.userTypeHin,
  });

  factory GetAllUserType.fromJson(Map<String, dynamic> json) => GetAllUserType(
    id: json["_id"],
    userType: json["UserType"],
    userTypeCode: json["UserTypeCode"],
    userTypeHin: json["UserTypeHin"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "UserType": userType,
    "UserTypeCode": userTypeCode,
    "UserTypeHin": userTypeHin,
  };
}
