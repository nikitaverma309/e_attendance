// To parse this JSON data, do
//
//     final leaveResponseModel = leaveResponseModelFromJson(jsonString);

import 'dart:convert';

List<LeaveResponseModel> leaveResponseModelFromJson(String str) => List<LeaveResponseModel>.from(json.decode(str).map((x) => LeaveResponseModel.fromJson(x)));

String leaveResponseModelToJson(List<LeaveResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveResponseModel {
  String? id;
  String? applicationId;
  CollegeId? collegeId;
  ApplicantId? applicantId;
  ApplicantName? applicantName;
  int? applicationType;
  EmpClass? empClass;
  WorkType? workType;
  String? reason;
  LeaveType? leaveType;
  int? leaveCode;
  DateTime? fromDate;
  DateTime? tillDate;
  int? dayCount;
  int? permission;
  String? stationAddress;
  String? remarkByUser;
  int? leaveStatus;
  DateTime? lastUpdated;
  DateTime? appliedDate;
  int? isJoined;
  int? isPrincipalAction;
  int? isDirectorAction;
  Designation? designation;
  Designationid? designationid;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  DateTime? appliedForCancelDate;
  String? reasonForCancel;
  DateTime? actionByPrincipalDate;
  int? dayTakenByPrincipal;
  String? remarkByPrincipal;
  DateTime? joiningDate;
  DateTime? canceledDate;
  String? uploadFile;
  DateTime? actionByDirectorDate;
  int? dayTakenByDirector;
  String? remarkByDirector;

  LeaveResponseModel({
    this.id,
    this.applicationId,
    this.collegeId,
    this.applicantId,
    this.applicantName,
    this.applicationType,
    this.empClass,
    this.workType,
    this.reason,
    this.leaveType,
    this.leaveCode,
    this.fromDate,
    this.tillDate,
    this.dayCount,
    this.permission,
    this.stationAddress,
    this.remarkByUser,
    this.leaveStatus,
    this.lastUpdated,
    this.appliedDate,
    this.isJoined,
    this.isPrincipalAction,
    this.isDirectorAction,
    this.designation,
    this.designationid,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.appliedForCancelDate,
    this.reasonForCancel,
    this.actionByPrincipalDate,
    this.dayTakenByPrincipal,
    this.remarkByPrincipal,
    this.joiningDate,
    this.canceledDate,
    this.uploadFile,
    this.actionByDirectorDate,
    this.dayTakenByDirector,
    this.remarkByDirector,
  });

  factory LeaveResponseModel.fromJson(Map<String, dynamic> json) => LeaveResponseModel(
    id: json["_id"],
    applicationId: json["applicationId"],
    collegeId: collegeIdValues.map[json["collegeId"]]!,
    applicantId: applicantIdValues.map[json["applicantId"]]!,
    applicantName: applicantNameValues.map[json["applicantName"]]!,
    applicationType: json["applicationType"],
    empClass: empClassValues.map[json["empClass"]]!,
    workType: workTypeValues.map[json["workType"]]!,
    reason: json["reason"],
    leaveType: leaveTypeValues.map[json["leaveType"]]!,
    leaveCode: json["leaveCode"],
    fromDate: json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
    tillDate: json["tillDate"] == null ? null : DateTime.parse(json["tillDate"]),
    dayCount: json["dayCount"],
    permission: json["permission"],
    stationAddress: json["stationAddress"],
    remarkByUser: json["remarkByUser"],
    leaveStatus: json["leaveStatus"],
    lastUpdated: json["lastUpdated"] == null ? null : DateTime.parse(json["lastUpdated"]),
    appliedDate: json["appliedDate"] == null ? null : DateTime.parse(json["appliedDate"]),
    isJoined: json["isJoined"],
    isPrincipalAction: json["isPrincipalAction"],
    isDirectorAction: json["isDirectorAction"],
    designation: designationValues.map[json["designation"]]!,
    designationid: designationidValues.map[json["designationid"]]!,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    appliedForCancelDate: json["appliedForCancelDate"] == null ? null : DateTime.parse(json["appliedForCancelDate"]),
    reasonForCancel: json["reasonForCancel"],
    actionByPrincipalDate: json["actionByPrincipalDate"] == null ? null : DateTime.parse(json["actionByPrincipalDate"]),
    dayTakenByPrincipal: json["dayTakenByPrincipal"],
    remarkByPrincipal: json["remarkByPrincipal"],
    joiningDate: json["joiningDate"] == null ? null : DateTime.parse(json["joiningDate"]),
    canceledDate: json["canceledDate"] == null ? null : DateTime.parse(json["canceledDate"]),
    uploadFile: json["uploadFile"],
    actionByDirectorDate: json["actionByDirectorDate"] == null ? null : DateTime.parse(json["actionByDirectorDate"]),
    dayTakenByDirector: json["dayTakenByDirector"],
    remarkByDirector: json["remarkByDirector"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "applicationId": applicationId,
    "collegeId": collegeIdValues.reverse[collegeId],
    "applicantId": applicantIdValues.reverse[applicantId],
    "applicantName": applicantNameValues.reverse[applicantName],
    "applicationType": applicationType,
    "empClass": empClassValues.reverse[empClass],
    "workType": workTypeValues.reverse[workType],
    "reason": reason,
    "leaveType": leaveTypeValues.reverse[leaveType],
    "leaveCode": leaveCode,
    "fromDate": fromDate?.toIso8601String(),
    "tillDate": tillDate?.toIso8601String(),
    "dayCount": dayCount,
    "permission": permission,
    "stationAddress": stationAddress,
    "remarkByUser": remarkByUser,
    "leaveStatus": leaveStatus,
    "lastUpdated": lastUpdated?.toIso8601String(),
    "appliedDate": appliedDate?.toIso8601String(),
    "isJoined": isJoined,
    "isPrincipalAction": isPrincipalAction,
    "isDirectorAction": isDirectorAction,
    "designation": designationValues.reverse[designation],
    "designationid": designationidValues.reverse[designationid],
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "appliedForCancelDate": appliedForCancelDate?.toIso8601String(),
    "reasonForCancel": reasonForCancel,
    "actionByPrincipalDate": actionByPrincipalDate?.toIso8601String(),
    "dayTakenByPrincipal": dayTakenByPrincipal,
    "remarkByPrincipal": remarkByPrincipal,
    "joiningDate": joiningDate?.toIso8601String(),
    "canceledDate": canceledDate?.toIso8601String(),
    "uploadFile": uploadFile,
    "actionByDirectorDate": actionByDirectorDate?.toIso8601String(),
    "dayTakenByDirector": dayTakenByDirector,
    "remarkByDirector": remarkByDirector,
  };
}

enum ApplicantId {
  THE_673_AE67_D5_A35_C8789_AFCA8_AB
}

final applicantIdValues = EnumValues({
  "673ae67d5a35c8789afca8ab": ApplicantId.THE_673_AE67_D5_A35_C8789_AFCA8_AB
});

enum ApplicantName {
  DR_HEMLAL_SAHU
}

final applicantNameValues = EnumValues({
  "Dr HEMLAL SAHU": ApplicantName.DR_HEMLAL_SAHU
});

enum CollegeId {
  THE_6730_A5158_DE5_D840_C51_ED6_A9
}

final collegeIdValues = EnumValues({
  "6730a5158de5d840c51ed6a9": CollegeId.THE_6730_A5158_DE5_D840_C51_ED6_A9
});

enum Designation {
  ASSISTANT_PROFESSOR
}

final designationValues = EnumValues({
  "Assistant Professor": Designation.ASSISTANT_PROFESSOR
});

enum Designationid {
  THE_6730_A0859_C441604253869_DD
}

final designationidValues = EnumValues({
  "6730a0859c441604253869dd": Designationid.THE_6730_A0859_C441604253869_DD
});

enum EmpClass {
  THE_67308_D30_A2060_D2_D3769_FBCD
}

final empClassValues = EnumValues({
  "67308d30a2060d2d3769fbcd": EmpClass.THE_67308_D30_A2060_D2_D3769_FBCD
});

enum LeaveType {
  CASUAL_LEAVE,
  EARNED_LEAVE,
  PATERNITY_LEAVE
}

final leaveTypeValues = EnumValues({
  "Casual Leave": LeaveType.CASUAL_LEAVE,
  "Earned Leave": LeaveType.EARNED_LEAVE,
  "Paternity Leave": LeaveType.PATERNITY_LEAVE
});

enum WorkType {
  TEACHING
}

final workTypeValues = EnumValues({
  "TEACHING": WorkType.TEACHING
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
