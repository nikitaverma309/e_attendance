// To parse this JSON data, do
//
//     final collegeModel = collegeModelFromJson(jsonString);

import 'dart:convert';

List<CollegeModel> collegeModelFromJson(String str) => List<CollegeModel>.from(json.decode(str).map((x) => CollegeModel.fromJson(x)));

String collegeModelToJson(List<CollegeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CollegeModel {
  String id;
  String name;
  University university;
  String collegeEmail;
  String contactPerson;
  int contactNumber;
  int divison;
  int establishYear;
  int district;
  int vidhansabha;
  String aisheCode;
  String collegeType;
  DateTime regDate;
  String address;
  bool status;
  String collegeUrl;
  String districtName;
  String vidhansabhaName;
  UniversityName universityName;
  int isLead;
  bool isPassChangeFirst;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String password;
  String username;

  CollegeModel({
    required this.id,
    required this.name,
    required this.university,
    required this.collegeEmail,
    required this.contactPerson,
    required this.contactNumber,
    required this.divison,
    required this.establishYear,
    required this.district,
    required this.vidhansabha,
    required this.aisheCode,
    required this.collegeType,
    required this.regDate,
    required this.address,
    required this.status,
    required this.collegeUrl,
    required this.districtName,
    required this.vidhansabhaName,
    required this.universityName,
    required this.isLead,
    required this.isPassChangeFirst,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.password,
    required this.username,
  });

  factory CollegeModel.fromJson(Map<String, dynamic> json) => CollegeModel(
    id: json["_id"],
    name: json["name"],
    university: universityValues.map[json["university"]]!,
    collegeEmail: json["collegeEmail"],
    contactPerson: json["contactPerson"],
    contactNumber: json["contactNumber"],
    divison: json["divison"],
    establishYear: json["establishYear"],
    district: json["district"],
    vidhansabha: json["vidhansabha"],
    aisheCode: json["aisheCode"],
    collegeType: json["collegeType"],
    regDate: DateTime.parse(json["regDate"]),
    address: json["address"],
    status: json["status"],
    collegeUrl: json["collegeUrl"],
    districtName: json["districtName"],
    vidhansabhaName: json["vidhansabhaName"],
    universityName: universityNameValues.map[json["universityName"]]!,
    isLead: json["isLead"],
    isPassChangeFirst: json["isPassChangeFirst"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    password: json["password"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "university": universityValues.reverse[university],
    "collegeEmail": collegeEmail,
    "contactPerson": contactPerson,
    "contactNumber": contactNumber,
    "divison": divison,
    "establishYear": establishYear,
    "district": district,
    "vidhansabha": vidhansabha,
    "aisheCode": aisheCode,
    "collegeType": collegeType,
    "regDate": regDate.toIso8601String(),
    "address": address,
    "status": status,
    "collegeUrl": collegeUrl,
    "districtName": districtName,
    "vidhansabhaName": vidhansabhaName,
    "universityName": universityNameValues.reverse[universityName],
    "isLead": isLead,
    "isPassChangeFirst": isPassChangeFirst,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "password": password,
    "username": username,
  };
}

enum University {
  THE_672_B0_A617_C6432458_C0_D0_C8_D,
  THE_672_B0_C697_C6432458_C0_D0_CAA,
  THE_672_B0_F7_E7_C6432458_C0_D0_CCC,
  THE_672_B12777_C6432458_C0_D0_CEE,
  THE_672_B13287_C6432458_C0_D0_CFF
}

final universityValues = EnumValues({
  "672b0a617c6432458c0d0c8d": University.THE_672_B0_A617_C6432458_C0_D0_C8_D,
  "672b0c697c6432458c0d0caa": University.THE_672_B0_C697_C6432458_C0_D0_CAA,
  "672b0f7e7c6432458c0d0ccc": University.THE_672_B0_F7_E7_C6432458_C0_D0_CCC,
  "672b12777c6432458c0d0cee": University.THE_672_B12777_C6432458_C0_D0_CEE,
  "672b13287c6432458c0d0cff": University.THE_672_B13287_C6432458_C0_D0_CFF
});

enum UniversityName {
  ATAL_BIHARI_VAJPAYEE_UNIVERSITY,
  HEMCHAND_YADAV_UNIVERSITY_DURG_C_G,
  PT_RAVISHANKAR_SHUKLA_UNIVERSITY_RAIPUR,
  SANT_GAHIRA_GURU_UNIVERSITY_SURGUJA_AMBIKAPUR_C_G,
  SHAHEED_NANDKUMAR_PATEL_VISHWAVIDYALAYA_RAIGARH
}

final universityNameValues = EnumValues({
  "Atal Bihari Vajpayee University": UniversityName.ATAL_BIHARI_VAJPAYEE_UNIVERSITY,
  "Hemchand Yadav University Durg C.G.": UniversityName.HEMCHAND_YADAV_UNIVERSITY_DURG_C_G,
  "Pt. Ravishankar Shukla University Raipur": UniversityName.PT_RAVISHANKAR_SHUKLA_UNIVERSITY_RAIPUR,
  "Sant Gahira Guru University Surguja Ambikapur C.G.": UniversityName.SANT_GAHIRA_GURU_UNIVERSITY_SURGUJA_AMBIKAPUR_C_G,
  "Shaheed Nandkumar Patel Vishwavidyalaya Raigarh": UniversityName.SHAHEED_NANDKUMAR_PATEL_VISHWAVIDYALAYA_RAIGARH
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
