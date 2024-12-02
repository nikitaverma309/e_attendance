

import 'dart:convert';

List<VidhanModel> vidhanModelFromJson(String str) => List<VidhanModel>.from(json.decode(str).map((x) => VidhanModel.fromJson(x)));

String vidhanModelToJson(List<VidhanModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VidhanModel {
  String id;
  int slno;
  int constituencyNumber;
  String constituencyName;
  String constituencyNameHindi;
  int distCode;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  VidhanModel({
    required this.id,
    required this.slno,
    required this.constituencyNumber,
    required this.constituencyName,
    required this.constituencyNameHindi,
    required this.distCode,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory VidhanModel.fromJson(Map<String, dynamic> json) => VidhanModel(
    id: json["_id"],
    slno: json["Slno"],
    constituencyNumber: json["ConstituencyNumber"],
    constituencyName: json["ConstituencyName"],
    constituencyNameHindi: json["ConstituencyNameHindi"],
    distCode: json["DistCode"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Slno": slno,
    "ConstituencyNumber": constituencyNumber,
    "ConstituencyName": constituencyName,
    "ConstituencyNameHindi": constituencyNameHindi,
    "DistCode": distCode,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
