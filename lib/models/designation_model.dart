// To parse this JSON data, do
//
//     final designationModel = designationModelFromMap(jsonString);

import 'dart:convert';

List<DesignationModel> designationModelFromMap(String str) => List<DesignationModel>.from(json.decode(str).map((x) => DesignationModel.fromMap(x)));

String designationModelToMap(List<DesignationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DesignationModel {
  String id;
  String designationModelClass;
  String designation;
  int isVerified;
  DateTime createdAt;
  DateTime updatedAt;

  DesignationModel({
    required this.id,
    required this.designationModelClass,
    required this.designation,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  DesignationModel copyWith({
    String? id,
    String? designationModelClass,
    String? designation,
    int? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      DesignationModel(
        id: id ?? this.id,
        designationModelClass: designationModelClass ?? this.designationModelClass,
        designation: designation ?? this.designation,
        isVerified: isVerified ?? this.isVerified,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DesignationModel.fromMap(Map<String, dynamic> json) => DesignationModel(
    id: json["_id"],
    designationModelClass: json["class"],
    designation: json["designation"],
    isVerified: json["isVerified"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "class": designationModelClass,
    "designation": designation,
    "isVerified": isVerified,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
class Designation {
  final String id;
  final String classId;
  final String designation;
  final int isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  Designation({
    required this.id,
    required this.classId,
    required this.designation,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      id: json['_id'],
      classId: json['class'],
      designation: json['designation'],
      isVerified: json['isVerified'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
