import 'arrear_model_new.dart';

class LoanArrearModelNew {
  String? outstandingBalance;
  List<ArrearModelNew>? allArrear;
  List<ArrearModelNew>? arrear1Day;
  List<ArrearModelNew>? arrear14Days;
  List<ArrearModelNew>? arrear30Days;
  List<ArrearModelNew>? arrear60Days;
  List<ArrearModelNew>? arrear90Days;
  LoanArrearModelNew({
    this.outstandingBalance,
    this.allArrear,
    this.arrear14Days,
    this.arrear1Day,
    this.arrear30Days,
    this.arrear60Days,
    this.arrear90Days,
  });

  LoanArrearModelNew.fromJson(Map<String, dynamic> json) {
    outstandingBalance = json['outstandingBalance'];
    if (json['allArrear'] != null) {
      allArrear = <ArrearModelNew>[];
      json['allArrear'].forEach((v) {
        allArrear!.add(new ArrearModelNew.fromJson(v));
      });
    }
    if (json['arrear1Day'] != null) {
      arrear1Day = <ArrearModelNew>[];
      json['arrear1Day'].forEach((v) {
        arrear1Day!.add(new ArrearModelNew.fromJson(v));
      });
    }
    if (json['arrear14Days'] != null) {
      arrear14Days = <ArrearModelNew>[];
      json['arrear14Days'].forEach((v) {
        arrear14Days!.add(new ArrearModelNew.fromJson(v));
      });
    }
    if (json['arrear30Days'] != null) {
      arrear30Days = <ArrearModelNew>[];
      json['arrear30Days'].forEach((v) {
        arrear30Days!.add(new ArrearModelNew.fromJson(v));
      });
    }
    if (json['arrear60Days'] != null) {
      arrear60Days = <ArrearModelNew>[];
      json['arrear60Days'].forEach((v) {
        arrear60Days!.add(new ArrearModelNew.fromJson(v));
      });
    }
    if (json['arrear90Days'] != null) {
      arrear90Days = <ArrearModelNew>[];
      json['arrear90Days'].forEach((v) {
        arrear90Days!.add(new ArrearModelNew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outstandingBalance'] = this.outstandingBalance;
    if (this.allArrear != null) {
      data['allArrear'] = this.allArrear!.map((v) => v.toJson()).toList();
    }
    if (this.arrear1Day != null) {
      data['arrear1Day'] = this.arrear1Day!.map((v) => v.toJson()).toList();
    }
    if (this.arrear14Days != null) {
      data['arrear14Days'] = this.arrear14Days!.map((v) => v.toJson()).toList();
    }
    if (this.arrear30Days != null) {
      data['arrear30Days'] = this.arrear14Days!.map((v) => v.toJson()).toList();
    }
    if (this.arrear60Days != null) {
      data['arrear60Days'] = this.arrear60Days!.map((v) => v.toJson()).toList();
    }
    if (this.arrear90Days != null) {
      data['arrear90Days'] = this.arrear90Days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
