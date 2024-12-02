
import 'dart:convert';

List<DesignationModel> designationModelFromJson(String str) => List<DesignationModel>.from(json.decode(str).map((x) => DesignationModel.fromJson(x)));

String designationModelToJson(List<DesignationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DesignationModel {
  String? id;
  Class? designationModelClass;
  String? designation;
  int? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  DesignationModel({
    this.id,
    this.designationModelClass,
    this.designation,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DesignationModel.fromJson(Map<String, dynamic> json) => DesignationModel(
    id: json["_id"],
    designationModelClass: classValues.map[json["class"]]!,
    designation: json["designation"],
    isVerified: json["isVerified"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "class": classValues.reverse[designationModelClass],
    "designation": designation,
    "isVerified": isVerified,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

enum Class {
  THE_67308_DB6_A2060_D2_D3769_FBDE
}

final classValues = EnumValues({
  "67308db6a2060d2d3769fbde": Class.THE_67308_DB6_A2060_D2_D3769_FBDE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
