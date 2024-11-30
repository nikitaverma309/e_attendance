

import 'dart:convert';

CheckUserRegisterModel checkUserRegisterModelFromJson(String str) => CheckUserRegisterModel.fromJson(json.decode(str));

String checkUserRegisterModelToJson(CheckUserRegisterModel data) => json.encode(data.toJson());

class CheckUserRegisterModel {
  String? msg;
  GetEmployeeDetails? getEmployeeDetails;

  CheckUserRegisterModel({
    this.msg,
    this.getEmployeeDetails,
  });

  factory CheckUserRegisterModel.fromJson(Map<String, dynamic> json) => CheckUserRegisterModel(
    msg: json["msg"],
    getEmployeeDetails: json["getEmployeeDetails"] == null ? null : GetEmployeeDetails.fromJson(json["getEmployeeDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "getEmployeeDetails": getEmployeeDetails?.toJson(),
  };
}

class GetEmployeeDetails {
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
  String? classData;
  String? address;
  bool? verified;
  String? districtName;
  String? vidhansabhaName;
  bool? isPassChangeFirst;
  String? workType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? password;
  String? image;
  bool? faceVerified;
  String? encodedImage;
  bool? reRegisteredFace;

  GetEmployeeDetails({
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
    this.classData,
    this.address,
    this.verified,
    this.districtName,
    this.vidhansabhaName,
    this.isPassChangeFirst,
    this.workType,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.password,
    this.image,
    this.faceVerified,
    this.encodedImage,
    this.reRegisteredFace,
  });

  factory GetEmployeeDetails.fromJson(Map<String, dynamic> json) => GetEmployeeDetails(
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
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    password: json["password"],
    image: json["image"],
    faceVerified: json["faceVerified"],
    encodedImage: json["encodedImage"],
    reRegisteredFace: json["reRegisteredFace"],
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "password": password,
    "image": image,
    "faceVerified": faceVerified,
    "encodedImage": encodedImage,
    "reRegisteredFace": reRegisteredFace,
  };
}
