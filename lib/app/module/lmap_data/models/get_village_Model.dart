class VillageModelClass {
  String? zoneCode;
  String? province;
  String? district;
  String? commune;
  String? village;
  String? familyNo;
  String? population;
  String? status;
  String? dates;

  VillageModelClass(
      {this.zoneCode,
      this.province,
      this.district,
      this.commune,
      this.village,
      this.familyNo,
      this.population,
      this.status,
      this.dates});

  VillageModelClass.fromJson(Map<String, dynamic> json) {
    zoneCode = json['zone_code'];
    province = json['province'];
    district = json['district'];
    commune = json['commune'];
    village = json['village'];
    familyNo = json['family_no'];
    population = json['population'];
    status = json['status'];
    dates = json['dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zone_code'] = this.zoneCode;
    data['province'] = this.province;
    data['district'] = this.district;
    data['commune'] = this.commune;
    data['village'] = this.village;
    data['family_no'] = this.familyNo;
    data['population'] = this.population;
    data['status'] = this.status;
    data['dates'] = this.dates;
    return data;
  }
}
