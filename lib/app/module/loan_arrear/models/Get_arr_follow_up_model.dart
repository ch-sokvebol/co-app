class GetArrFollowUpModel {
  num? id;
  String? reason;
  String? solvingStatus;
  String? clientCommitment;
  String? clientPayDate;
  num? clientPayAmt;
  String? revolvingDate;
  String? disburseDate;
  String? sellDate;
  num? sellAmt;
  String? status;
  num? completPartialAmt;
  String? completPartialDate;
  String? remark;
  String? imageUrl;
  String? village;
  String? commune;
  String? district;
  String? province;
  String? customercode;
  String? customername;
  String? loannumber;
  String? loanamount;
  String? overdueday;
  String? overdueamount;
  String? coname;
  String? coid;
  String? latitude;
  String? longitude;
  String? branchcode;
  String? branchname;
  String? repaymentdate;
  String? loanperiod;
  String? createddate;
  String? createdby;
  String? jobName;
  String? workPlace;
  String? type;
  String? currencyCode;
  num? loanBalance;
  GetArrFollowUpModel({
    this.id,
    this.reason,
    this.solvingStatus,
    this.clientCommitment,
    this.clientPayDate,
    this.clientPayAmt,
    this.revolvingDate,
    this.disburseDate,
    this.sellDate,
    this.sellAmt,
    this.status,
    this.completPartialAmt,
    this.completPartialDate,
    this.remark,
    this.imageUrl,
    this.village,
    this.commune,
    this.district,
    this.province,
    this.customercode,
    this.customername,
    this.loannumber,
    this.loanamount,
    this.overdueday,
    this.overdueamount,
    this.coname,
    this.coid,
    this.latitude,
    this.longitude,
    this.branchcode,
    this.branchname,
    this.repaymentdate,
    this.loanperiod,
    this.createddate,
    this.createdby,
    this.jobName,
    this.workPlace,
    this.type,
    this.currencyCode,
    this.loanBalance,
  });

  GetArrFollowUpModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    solvingStatus = json['solvingStatus'];
    clientCommitment = json['clientCommitment'];
    clientPayDate = json['clientPayDate'];
    clientPayAmt = json['clientPayAmt'];
    revolvingDate = json['revolvingDate'];
    disburseDate = json['disburseDate'];
    sellDate = json['sellDate'];
    sellAmt = json['sellAmt'];
    status = json['status'];
    completPartialAmt = json['completPartialAmt'];
    completPartialDate = json['completPartialDate'];
    remark = json['remark'];
    imageUrl = json['imageUrl'];
    village = json['village'];
    commune = json['commune'];
    district = json['district'];
    province = json['province'];
    customercode = json['customercode'];
    customername = json['customername'];
    loannumber = json['loannumber'];
    loanamount = json['loanamount'];
    overdueday = json['overdueday'];
    overdueamount = json['overdueamount'];
    coname = json['coname'];
    coid = json['coid'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    branchcode = json['branchcode'];
    branchname = json['branchname'];
    repaymentdate = json['repaymentdate'];
    loanperiod = json['loanperiod'];
    createddate = json['createddate'];
    createdby = json['createdby'];
    jobName = json['jobName'];
    workPlace = json['workPlace'];
    type = json['type'];
    currencyCode = json['currencyCode'];
    loanBalance = json['loanBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reason'] = this.reason;
    data['solvingStatus'] = this.solvingStatus;
    data['clientCommitment'] = this.clientCommitment;
    data['clientPayDate'] = this.clientPayDate;
    data['clientPayAmt'] = this.clientPayAmt;
    data['revolvingDate'] = this.revolvingDate;
    data['disburseDate'] = this.disburseDate;
    data['sellDate'] = this.sellDate;
    data['sellAmt'] = this.sellAmt;
    data['status'] = this.status;
    data['completPartialAmt'] = this.completPartialAmt;
    data['completPartialDate'] = this.completPartialDate;
    data['remark'] = this.remark;
    data['imageUrl'] = this.imageUrl;
    data['village'] = this.village;
    data['commune'] = this.commune;
    data['district'] = this.district;
    data['province'] = this.province;
    data['customercode'] = this.customercode;
    data['customername'] = this.customername;
    data['loannumber'] = this.loannumber;
    data['loanamount'] = this.loanamount;
    data['overdueday'] = this.overdueday;
    data['overdueamount'] = this.overdueamount;
    data['coname'] = this.coname;
    data['coid'] = this.coid;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['branchcode'] = this.branchcode;
    data['branchname'] = this.branchname;
    data['repaymentdate'] = this.repaymentdate;
    data['loanperiod'] = this.loanperiod;
    data['createddate'] = this.createddate;
    data['createdby'] = this.createdby;
    data['jobName'] = this.jobName;
    data['workPlace'] = this.workPlace;
    data['type'] = this.type;
    data['currencyCode'] = this.currencyCode;
    data['loanBalance'] = this.loanBalance;
    return data;
  }
}
