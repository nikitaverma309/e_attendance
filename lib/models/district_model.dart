// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

List<DistrictModel> districtModelFromJson(String str) => List<DistrictModel>.from(json.decode(str).map((x) => DistrictModel.fromJson(x)));

String districtModelToJson(List<DistrictModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DistrictModel {
  String id;
  String sName;
  String districtName;
  String districtNameEng;
  int lgdCode;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int division;

  DistrictModel({
    required this.id,
    required this.sName,
    required this.districtName,
    required this.districtNameEng,
    required this.lgdCode,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.division,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    id: json["_id"],
    sName: json["sName"],
    districtName: json["districtName"],
    districtNameEng: json["districtNameEng"],
    lgdCode: json["LGDCode"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    division: json["division"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sName": sName,
    "districtName": districtName,
    "districtNameEng": districtNameEng,
    "LGDCode": lgdCode,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "division": division,
  };
}
