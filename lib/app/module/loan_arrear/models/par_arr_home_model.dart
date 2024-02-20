class ParArrHomeModel {
  num? accPar1;
  num? accPar14;
  num? accPar30;
  num? accPar60;
  num? accPar90;
  num? amountPar1;
  num? amountPar14;
  num? amountPar30;
  num? amountPar60;
  num? amountPar90;
  num? percentagePar1;
  num? percentagePar14;
  num? percentagePar30;
  num? percentagePar60;
  num? percentagePar90;
  num? totalAmount;
  num? totalAccount;

  ParArrHomeModel(
      {this.accPar1,
      this.accPar14,
      this.accPar30,
      this.accPar60,
      this.accPar90,
      this.amountPar1,
      this.amountPar14,
      this.amountPar30,
      this.amountPar60,
      this.amountPar90,
      this.percentagePar1,
      this.percentagePar14,
      this.percentagePar30,
      this.percentagePar60,
      this.percentagePar90,
      this.totalAmount,
      this.totalAccount});

  ParArrHomeModel.fromJson(Map<String, dynamic> json) {
    accPar1 = json['accPar1'];
    accPar14 = json['accPar14'];
    accPar30 = json['accPar30'];
    accPar60 = json['accPar60'];
    accPar90 = json['accPar90'];
    amountPar1 = json['amountPar1'];
    amountPar14 = json['amountPar14'];
    amountPar30 = json['amountPar30'];
    amountPar60 = json['amountPar60'];
    amountPar90 = json['amountPar90'];
    percentagePar1 = json['percentagePar1'];
    percentagePar14 = json['percentagePar14'];
    percentagePar30 = json['percentagePar30'];
    percentagePar60 = json['percentagePar60'];
    percentagePar90 = json['percentagePar90'];
    totalAmount = json['totalAmount'];
    totalAccount = json['totalAccount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accPar1'] = this.accPar1;
    data['accPar14'] = this.accPar14;
    data['accPar30'] = this.accPar30;
    data['accPar60'] = this.accPar60;
    data['accPar90'] = this.accPar90;
    data['amountPar1'] = this.amountPar1;
    data['amountPar14'] = this.amountPar14;
    data['amountPar30'] = this.amountPar30;
    data['amountPar60'] = this.amountPar60;
    data['amountPar90'] = this.amountPar90;
    data['percentagePar1'] = this.percentagePar1;
    data['percentagePar14'] = this.percentagePar14;
    data['percentagePar30'] = this.percentagePar30;
    data['percentagePar60'] = this.percentagePar60;
    data['percentagePar90'] = this.percentagePar90;
    data['totalAmount'] = this.totalAmount;
    data['totalAccount'] = this.totalAccount;
    return data;
  }
}
