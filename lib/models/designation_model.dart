// To parse this JSON data, do
//
//     final designationModel = designationModelFromJson(jsonString);

import 'dart:convert';

List<DesignationModel> designationModelFromJson(String str) => List<DesignationModel>.from(json.decode(str).map((x) => DesignationModel.fromJson(x)));

String designationModelToJson(List<DesignationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DesignationModel {
  String id;
  Class designationModelClass;
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

  factory DesignationModel.fromJson(Map<String, dynamic> json) => DesignationModel(
    id: json["_id"],
    designationModelClass: classValues.map[json["class"]]!,
    designation: json["designation"],
    isVerified: json["isVerified"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "class": classValues.reverse[designationModelClass],
    "designation": designation,
    "isVerified": isVerified,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

enum Class {
  THE_67308_DB1_A2060_D2_D3769_FBD9
}

final classValues = EnumValues({
  "67308db1a2060d2d3769fbd9": Class.THE_67308_DB1_A2060_D2_D3769_FBD9
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
