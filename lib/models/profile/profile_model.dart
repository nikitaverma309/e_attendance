
import 'dart:convert';

AttendanceProfileModel profileModelFromJson(String str) => AttendanceProfileModel.fromJson(json.decode(str));

String profileModelToJson(AttendanceProfileModel data) => json.encode(data.toJson());

class AttendanceProfileModel {
  String? msg;
  Attendance? attendance;
  EmployeeData? employeeData;

  AttendanceProfileModel({
    this.msg,
    this.attendance,
    this.employeeData,
  });

  factory AttendanceProfileModel.fromJson(Map<String, dynamic> json) => AttendanceProfileModel(
    msg: json["msg"],
    attendance: json["attendance"] == null ? null : Attendance.fromJson(json["attendance"]),
    employeeData: json["employeeData"] == null ? null : EmployeeData.fromJson(json["employeeData"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "attendance": attendance?.toJson(),
    "employeeData": employeeData?.toJson(),
  };
}

class Attendance {
  String? id;
  String? name;
  String? empId;
  String? empCode;
  String? college;
  DateTime? loginTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  DateTime? logoutTime;

  Attendance({
    this.id,
    this.name,
    this.empId,
    this.empCode,
    this.college,
    this.loginTime,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.logoutTime,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    id: json["_id"],
    name: json["name"],
    empId: json["empId"],
    empCode: json["empCode"],
    college: json["college"],
    loginTime: json["loginTime"] == null ? null : DateTime.parse(json["loginTime"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    logoutTime: json["logoutTime"] == null ? null : DateTime.parse(json["logoutTime"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "empId": empId,
    "empCode": empCode,
    "college": college,
    "loginTime": loginTime?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "logoutTime": logoutTime?.toIso8601String(),
  };
}

class EmployeeData {
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

  EmployeeData({
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

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
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
