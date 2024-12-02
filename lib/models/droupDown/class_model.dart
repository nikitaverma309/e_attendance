
import 'dart:convert';

List<ClassModel> classModelFromJson(String str) => List<ClassModel>.from(json.decode(str).map((x) => ClassModel.fromJson(x)));

String classModelToJson(List<ClassModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassModel {
  String? id;
  String? className;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ClassModel({
    this.id,
    this.className,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
    id: json["_id"],
    className: json["className"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "className": className,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
