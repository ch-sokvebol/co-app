class FilterUserModel {
  String? ucode;
  String? uid;
  String? upassword;
  int? ulevel;

  String? bcode;
  String? datecreate;
  String? isapprover;
  String? ustatus;
  String? exdate;

  String? uname;
  String? u1;

  FilterUserModel({
    this.ucode,
    this.uid,
    this.upassword,
    this.ulevel,
    this.bcode,
    this.datecreate,
    this.isapprover,
    this.ustatus,
    this.exdate,
    this.uname,
    this.u1,
  });

  FilterUserModel.fromJson(Map<String, dynamic> json) {
    ucode = json['ucode'];
    uid = json['uid'];
    upassword = json['upassword'];
    ulevel = json['ulevel'];

    bcode = json['bcode'];
    datecreate = json['datecreate'];
    isapprover = json['isapprover'];
    ustatus = json['ustatus'];
    exdate = json['exdate'];

    uname = json['uname'];
    u1 = json['u1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ucode'] = this.ucode;
    data['uid'] = this.uid;
    data['upassword'] = this.upassword;
    data['ulevel'] = this.ulevel;

    data['bcode'] = this.bcode;
    data['datecreate'] = this.datecreate;
    data['isapprover'] = this.isapprover;
    data['ustatus'] = this.ustatus;
    data['exdate'] = this.exdate;

    return data;
  }
}
