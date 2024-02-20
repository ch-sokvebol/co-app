class LoanAreaResponseModel {
  String? historyDate;
  String? customerName;
  String? currencyCode;
  double? totalAmount1;
  double? loanBalance;

  LoanAreaResponseModel({
    this.historyDate,
    this.customerName,
    this.currencyCode,
    this.totalAmount1,
    this.loanBalance,
  });

  factory LoanAreaResponseModel.fromJson(Map<String, dynamic> json) {
    return LoanAreaResponseModel(
      historyDate: json['historyDate'],
      customerName: json['customerName'],
      currencyCode: json['currencyCode'],
      totalAmount1: json['totalAmount1'],
      loanBalance: json['loanBalance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'historyDate': historyDate,
      'customerName': customerName,
      'currencyCode': currencyCode,
      'totalAmount1': totalAmount1,
      'loanBalance': loanBalance,
    };
  }
}
