class BranceModel {
  String? bcode;
  String? bname;
  String? odate;
  String? bmname;
  String? u1;
  BranceModel({
    this.bcode,
    this.bname,
    this.odate,
    this.bmname,
    this.u1,
  });

  BranceModel.fromJson(Map<String, dynamic> json) {
    bcode = json['bcode'];
    bname = json['bname'];
    odate = json['odate'];
    bmname = json['bmname'];
    u1 = json['u1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bcode'] = this.bcode;
    data['bname'] = this.bname;
    data['odate'] = this.odate;
    data['bmname'] = this.bmname;
    data['u1'] = this.u1;
    ;
    return data;
  }
}
