class ParArrDetailLocal {
  String? historyDate;
  String? repaymentDate;
  String? loanAccountNo;
  String? customerName;
  String? alternativeTransferAccountNo;
  String? customerNo;
  String? customerName1;
  String? cellPhoneNo;
  String? loanBranchCode;
  String? branchShortName;
  String? branchName;
  String? branchLocalName;
  String? currencyCode;
  String? loanDate;
  String? loanExpiryDate;
  num? loanPeriodMonthlyCount;
  String? loanProductCode;
  String? productCode;
  String? productName;
  num? loanAmount;
  num? overdueDays;
  num? availableBalance;
  num? loanBalance;
  num? provisionAmountRatio;
  num? repayPrincipal;
  num? repayInterest;
  num? overdueInterest;
  num? collateralMaintenanceFee;
  num? totalAmount1;
  String? refereneceEmployeeNo;
  String? employeeName;
  String? homeNo;
  String? villageName;
  String? communeName;
  String? districtName1;
  String? provinceName;
  String? postalAddress;
  String? occupationCode;
  String? customerListCodeName;
  num? currentMonthOverdue;
  num? previousOverdueMonth1;
  num? previousOverdueMonth2;
  num? previousOverdueMonth3;
  num? previousOverdueMonth4;
  num? previousOverdueMonth5;
  num? previousOverdueMonth6;
  String? paymentApplyDate;
  String? industry;

  ParArrDetailLocal(
      {this.historyDate,
      this.repaymentDate,
      this.loanAccountNo,
      this.customerName,
      this.alternativeTransferAccountNo,
      this.customerNo,
      this.customerName1,
      this.cellPhoneNo,
      this.loanBranchCode,
      this.branchShortName,
      this.branchName,
      this.branchLocalName,
      this.currencyCode,
      this.loanDate,
      this.loanExpiryDate,
      this.loanPeriodMonthlyCount,
      this.loanProductCode,
      this.productCode,
      this.productName,
      this.loanAmount,
      this.overdueDays,
      this.availableBalance,
      this.loanBalance,
      this.provisionAmountRatio,
      this.repayPrincipal,
      this.repayInterest,
      this.overdueInterest,
      this.collateralMaintenanceFee,
      this.totalAmount1,
      this.refereneceEmployeeNo,
      this.employeeName,
      this.homeNo,
      this.villageName,
      this.communeName,
      this.districtName1,
      this.provinceName,
      this.postalAddress,
      this.occupationCode,
      this.customerListCodeName,
      this.currentMonthOverdue,
      this.previousOverdueMonth1,
      this.previousOverdueMonth2,
      this.previousOverdueMonth3,
      this.previousOverdueMonth4,
      this.previousOverdueMonth5,
      this.previousOverdueMonth6,
      this.paymentApplyDate,
      this.industry});

  ParArrDetailLocal.fromJson(Map<String, dynamic> json) {
    historyDate = json['historyDate'];
    repaymentDate = json['repaymentDate'];
    loanAccountNo = json['loanAccountNo'];
    customerName = json['customerName'];
    alternativeTransferAccountNo = json['alternativeTransferAccountNo'];
    customerNo = json['customerNo'];
    customerName1 = json['customerName1'];
    cellPhoneNo = json['cellPhoneNo'];
    loanBranchCode = json['loanBranchCode'];
    branchShortName = json['branchShortName'];
    branchName = json['branchName'];
    branchLocalName = json['branchLocalName'];
    currencyCode = json['currencyCode'];
    loanDate = json['loanDate'];
    loanExpiryDate = json['loanExpiryDate'];
    loanPeriodMonthlyCount = json['loanPeriodMonthlyCount'];
    loanProductCode = json['loanProductCode'];
    productCode = json['productCode'];
    productName = json['productName'];
    loanAmount = json['loanAmount'];
    overdueDays = json['overdueDays'];
    availableBalance = json['availableBalance'];
    loanBalance = json['loanBalance'];
    provisionAmountRatio = json['provisionAmountRatio'];
    repayPrincipal = json['repayPrincipal'];
    repayInterest = json['repayInterest'];
    overdueInterest = json['overdueInterest'];
    collateralMaintenanceFee = json['collateralMaintenanceFee'];
    totalAmount1 = json['totalAmount1'];
    refereneceEmployeeNo = json['refereneceEmployeeNo'];
    employeeName = json['employeeName'];
    homeNo = json['homeNo'];
    villageName = json['villageName'];
    communeName = json['communeName'];
    districtName1 = json['districtName1'];
    provinceName = json['provinceName'];
    postalAddress = json['postalAddress'];
    occupationCode = json['occupationCode'];
    customerListCodeName = json['customerListCodeName'];
    currentMonthOverdue = json['currentMonthOverdue'];
    previousOverdueMonth1 = json['previousOverdueMonth1'];
    previousOverdueMonth2 = json['previousOverdueMonth2'];
    previousOverdueMonth3 = json['previousOverdueMonth3'];
    previousOverdueMonth4 = json['previousOverdueMonth4'];
    previousOverdueMonth5 = json['previousOverdueMonth5'];
    previousOverdueMonth6 = json['previousOverdueMonth6'];
    paymentApplyDate = json['paymentApplyDate'];
    industry = json['industry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['historyDate'] = this.historyDate;
    data['repaymentDate'] = this.repaymentDate;
    data['loanAccountNo'] = this.loanAccountNo;
    data['customerName'] = this.customerName;
    data['alternativeTransferAccountNo'] = this.alternativeTransferAccountNo;
    data['customerNo'] = this.customerNo;
    data['customerName1'] = this.customerName1;
    data['cellPhoneNo'] = this.cellPhoneNo;
    data['loanBranchCode'] = this.loanBranchCode;
    data['branchShortName'] = this.branchShortName;
    data['branchName'] = this.branchName;
    data['branchLocalName'] = this.branchLocalName;
    data['currencyCode'] = this.currencyCode;
    data['loanDate'] = this.loanDate;
    data['loanExpiryDate'] = this.loanExpiryDate;
    data['loanPeriodMonthlyCount'] = this.loanPeriodMonthlyCount;
    data['loanProductCode'] = this.loanProductCode;
    data['productCode'] = this.productCode;
    data['productName'] = this.productName;
    data['loanAmount'] = this.loanAmount;
    data['overdueDays'] = this.overdueDays;
    data['availableBalance'] = this.availableBalance;
    data['loanBalance'] = this.loanBalance;
    data['provisionAmountRatio'] = this.provisionAmountRatio;
    data['repayPrincipal'] = this.repayPrincipal;
    data['repayInterest'] = this.repayInterest;
    data['overdueInterest'] = this.overdueInterest;
    data['collateralMaintenanceFee'] = this.collateralMaintenanceFee;
    data['totalAmount1'] = this.totalAmount1;
    data['refereneceEmployeeNo'] = this.refereneceEmployeeNo;
    data['employeeName'] = this.employeeName;
    data['homeNo'] = this.homeNo;
    data['villageName'] = this.villageName;
    data['communeName'] = this.communeName;
    data['districtName1'] = this.districtName1;
    data['provinceName'] = this.provinceName;
    data['postalAddress'] = this.postalAddress;
    data['occupationCode'] = this.occupationCode;
    data['customerListCodeName'] = this.customerListCodeName;
    data['currentMonthOverdue'] = this.currentMonthOverdue;
    data['previousOverdueMonth1'] = this.previousOverdueMonth1;
    data['previousOverdueMonth2'] = this.previousOverdueMonth2;
    data['previousOverdueMonth3'] = this.previousOverdueMonth3;
    data['previousOverdueMonth4'] = this.previousOverdueMonth4;
    data['previousOverdueMonth5'] = this.previousOverdueMonth5;
    data['previousOverdueMonth6'] = this.previousOverdueMonth6;
    data['paymentApplyDate'] = this.paymentApplyDate;
    data['industry'] = this.industry;
    return data;
  }
}

// final String coumlhistoryDate='';
// final String? coumlrepaymentDate;
// final String? coumlloanAccountNo;
// final String? coumlcustomerName;
// final String? coumlalternativeTransferAccountNo;
// final String? coumlcustomerNo;
// final String? coumlcustomerName1;
// final String? coumlcellPhoneNo;
// final String? coumlloanBranchCode;
// final String? coumlbranchShortName;
// final String? coumlbranchName;
// final String? coumlbranchLocalName;
// final String? coumlcurrencyCode;
// final String? coumlloanDate;
// final String? coumlloanExpiryDate;
// final num? columnloanPeriodMonthlyCount;
// final String? coumlloanProductCode;
// final String? coumlproductCode;
// final String? coumlproductName;
// final num? columnloanAmount;
// final num? columnoverdueDays;
// final num? columnavailableBalance;
// final num? columnloanBalance;
// final num? columnprovisionAmountRatio;
// final num? columnrepayPrincipal;
// final num? columnrepayInterest;
// final num? columnoverdueInterest;
// final num? columncollateralMaintenanceFee;
// final num? columntotalAmount1;
// final String? coumlrefereneceEmployeeNo;
// final String? coumlemployeeName;
// final String? coumlhomeNo;
// final String? coumlvillageName;
// final String? coumlcommuneName;
// final String? coumldistrictName1;
// final String? coumlprovinceName;
// final String? coumlpostalAddress;
// final String? coumloccupationCode;
// final String? coumlcustomerListCodeName;
// final num? columncurrentMonthOverdue;
// final num? columnpreviousOverdueMonth1;
// final num? columnpreviousOverdueMonth2;
// final num? columnpreviousOverdueMonth3;
// final num? columnpreviousOverdueMonth4;
// final num? columnpreviousOverdueMonth5;
// final num? columnpreviousOverdueMonth6;
// final String? coumlpaymentApplyDate;
// final String? coumlindustry;

// class GetArrearLocal {
//   Database? db;

//   Future createTable(String path) async {
//     db = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//       await db.execute('''
// create table ParArrearDetail()
// ''');
//     });
//   }
// }
