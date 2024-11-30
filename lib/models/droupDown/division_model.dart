import 'dart:convert';

List<DivisionModel> divisionModelFromJson(String str) =>
    List<DivisionModel>.from(
        json.decode(str).map((x) => DivisionModel.fromJson(x)));

String divisionModelToJson(List<DivisionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DivisionModel {
  String id;
  int divisionCode;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  DivisionModel({
    required this.id,
    required this.divisionCode,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory DivisionModel.fromJson(Map<String, dynamic> json) => DivisionModel(
        id: json["_id"],
        divisionCode: json["divisionCode"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "divisionCode": divisionCode,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
