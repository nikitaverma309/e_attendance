

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  bool? status;
  String? id;
  String? username;
  String? userType;
  String? empCode;
  int? type;
  String? token;

  LoginResponseModel({
    this.status,
    this.id,
    this.username,
    this.userType,
    this.empCode,
    this.type,
    this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    id: json["id"],
    username: json["username"],
    userType: json["userType"],
    empCode: json["empCode"],
    type: json["type"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "id": id,
    "username": username,
    "userType": userType,
    "empCode": empCode,
    "type": type,
    "token": token,
  };
}
