class ArrearNotiModel {
  int? id;
  String? title;
  String? contents;
  int? status;
  String? datecreated;
  String? customerName;
  double? amount;
  String? loanAccount;
  String? branchName;
  String? coName;
  String? currencyCode;

  ArrearNotiModel(
      {this.id,
      this.title,
      this.contents,
      this.status,
      this.datecreated,
      this.customerName,
      this.amount,
      this.loanAccount,
      this.branchName,
      this.coName,
      this.currencyCode});

  ArrearNotiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    contents = json['contents'];
    status = json['status'];
    datecreated = json['datecreated'];
    customerName = json['customerName'];
    amount = json['amount'];
    loanAccount = json['loanAccount'];
    branchName = json['branchName'];
    coName = json['coName'];
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['contents'] = this.contents;
    data['status'] = this.status;
    data['datecreated'] = this.datecreated;
    data['customerName'] = this.customerName;
    data['amount'] = this.amount;
    data['loanAccount'] = this.loanAccount;
    data['branchName'] = this.branchName;
    data['coName'] = this.coName;
    data['currencyCode'] = this.currencyCode;
    return data;
  }
}
