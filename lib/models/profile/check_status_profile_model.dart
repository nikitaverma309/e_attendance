// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

CheckStatusModelProfile profileModelFromJson(String str) => CheckStatusModelProfile.fromJson(json.decode(str));

String profileModelToJson(CheckStatusModelProfile data) => json.encode(data.toJson());

class CheckStatusModelProfile {
  String id;
  String name;
  String empCode;
  String email;
  int contact;
  int divison;
  int district;
  int vidhansabha;
  String college;
  String designation;
  String classData;
  String address;
  bool verified;
  String districtName;
  String vidhansabhaName;
  bool isPassChangeFirst;
  String workType;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String password;
  String image;

  CheckStatusModelProfile({
    required this.id,
    required this.name,
    required this.empCode,
    required this.email,
    required this.contact,
    required this.divison,
    required this.district,
    required this.vidhansabha,
    required this.college,
    required this.designation,
    required this.classData,
    required this.address,
    required this.verified,
    required this.districtName,
    required this.vidhansabhaName,
    required this.isPassChangeFirst,
    required this.workType,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.password,
    required this.image,
  });

  factory CheckStatusModelProfile.fromJson(Map<String, dynamic> json) => CheckStatusModelProfile(
    id: json["_id"],
    name: json["name"],
    empCode: json["empCode"],
    email: json["email"],
    contact: json["contact"],
    divison: json["divison"],
    district: json["district"],
    vidhansabha: json["vidhansabha"],
    college: json["college"],
    designation: json["designation"],
    classData: json["classData"],
    address: json["address"],
    verified: json["verified"],
    districtName: json["districtName"],
    vidhansabhaName: json["vidhansabhaName"],
    isPassChangeFirst: json["isPassChangeFirst"],
    workType: json["workType"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    password: json["password"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "empCode": empCode,
    "email": email,
    "contact": contact,
    "divison": divison,
    "district": district,
    "vidhansabha": vidhansabha,
    "college": college,
    "designation": designation,
    "classData": classData,
    "address": address,
    "verified": verified,
    "districtName": districtName,
    "vidhansabhaName": vidhansabhaName,
    "isPassChangeFirst": isPassChangeFirst,
    "workType": workType,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "password": password,
    "image": image,
  };
}
