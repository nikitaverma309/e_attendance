// To parse this JSON data, do
//
//     final classModel = classModelFromJson(jsonString);

import 'dart:convert';

List<ClassModel> classModelFromJson(String str) => List<ClassModel>.from(json.decode(str).map((x) => ClassModel.fromJson(x)));

String classModelToJson(List<ClassModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassModel {
  String id;
  String className;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ClassModel({
    required this.id,
    required this.className,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  ClassModel copyWith({
    String? id,
    String? className,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      ClassModel(
        id: id ?? this.id,
        className: className ?? this.className,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
    id: json["_id"],
    className: json["className"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "className": className,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
