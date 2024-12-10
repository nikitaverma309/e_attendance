
// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool? activeStatus;
  String? id;
  String? name;
  String? empCode;
  String? email;
  int? contact;
  int? divison;
  int? district;
  int? vidhansabha;
  String? college;
  String? designation;
  String? workType;
  String? classData;
  String? address;
  bool? verified;
  String? districtName;
  String? vidhansabhaName;
  bool? isPassChangeFirst;
  bool? faceVerified;
  bool? reRegisteredFace;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? password;
  String? encodedImage;
  String? image;

  ProfileModel({
    this.activeStatus,
    this.id,
    this.name,
    this.empCode,
    this.email,
    this.contact,
    this.divison,
    this.district,
    this.vidhansabha,
    this.college,
    this.designation,
    this.workType,
    this.classData,
    this.address,
    this.verified,
    this.districtName,
    this.vidhansabhaName,
    this.isPassChangeFirst,
    this.faceVerified,
    this.reRegisteredFace,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.password,
    this.encodedImage,
    this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    activeStatus: json["activeStatus"],
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
    workType: json["workType"],
    classData: json["classData"],
    address: json["address"],
    verified: json["verified"],
    districtName: json["districtName"],
    vidhansabhaName: json["vidhansabhaName"],
    isPassChangeFirst: json["isPassChangeFirst"],
    faceVerified: json["faceVerified"],
    reRegisteredFace: json["reRegisteredFace"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    password: json["password"],
    encodedImage: json["encodedImage"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "activeStatus": activeStatus,
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
    "workType": workType,
    "classData": classData,
    "address": address,
    "verified": verified,
    "districtName": districtName,
    "vidhansabhaName": vidhansabhaName,
    "isPassChangeFirst": isPassChangeFirst,
    "faceVerified": faceVerified,
    "reRegisteredFace": reRegisteredFace,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "password": password,
    "encodedImage": encodedImage,
    "image": image,
  };
}
