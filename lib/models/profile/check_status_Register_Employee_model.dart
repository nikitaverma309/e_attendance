// To parse this JSON data, do
//
//     final checkStatusModelProfileLatLong = checkStatusModelProfileLatLongFromJson(jsonString);

import 'dart:convert';

List<UserProfileModel> checkStatusModelProfileLatLongFromJson(String str) => List<UserProfileModel>.from(json.decode(str).map((x) => UserProfileModel.fromJson(x)));

String checkStatusModelProfileLatLongToJson(List<UserProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfileModel {
  String? id;
  String? name;
  String? empCode;
  String? email;
  int? contact;
  String? address;
  bool? verified;
  String? districtName;
  String? vidhansabhaName;
  String? workType;
  bool? faceVerified;
  bool? reRegisteredFace;
  CollegeDetails? collegeDetails;

  UserProfileModel({
    this.id,
    this.name,
    this.empCode,
    this.email,
    this.contact,
    this.address,
    this.verified,
    this.districtName,
    this.vidhansabhaName,
    this.workType,
    this.faceVerified,
    this.reRegisteredFace,
    this.collegeDetails,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    id: json["_id"],
    name: json["name"],
    empCode: json["empCode"],
    email: json["email"],
    contact: json["contact"],
    address: json["address"],
    verified: json["verified"],
    districtName: json["districtName"],
    vidhansabhaName: json["vidhansabhaName"],
    workType: json["workType"],
    faceVerified: json["faceVerified"],
    reRegisteredFace: json["reRegisteredFace"],
    collegeDetails: json["collegeDetails"] == null ? null : CollegeDetails.fromJson(json["collegeDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "empCode": empCode,
    "email": email,
    "contact": contact,
    "address": address,
    "verified": verified,
    "districtName": districtName,
    "vidhansabhaName": vidhansabhaName,
    "workType": workType,
    "faceVerified": faceVerified,
    "reRegisteredFace": reRegisteredFace,
    "collegeDetails": collegeDetails?.toJson(),
  };
}

class CollegeDetails {
  String? name;
  String? lat;
  String? long;
  String? homeLat;
  String? homeLong;

  CollegeDetails({
    this.name,
    this.lat,
    this.long,
    this.homeLat,
    this.homeLong,
  });

  factory CollegeDetails.fromJson(Map<String, dynamic> json) => CollegeDetails(
    name: json["name"],
    lat: json["lat"],
    long: json["long"],
    homeLat: json["homeLat"],
    homeLong: json["homeLong"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "lat": lat,
    "long": long,
    "homeLat": homeLat,
    "homeLong": homeLong,
  };
}
