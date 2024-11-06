class Division {
  String? sId;
  int? divisionCode;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Division(
      {this.sId,
        this.divisionCode,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Division.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    divisionCode = json['divisionCode'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['divisionCode'] = this.divisionCode;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
