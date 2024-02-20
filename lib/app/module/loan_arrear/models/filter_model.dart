// class FilterModel {
//   List<ArrearList>? arrearList;
//   int? arrearListCount;

//   FilterModel({this.arrearList, this.arrearListCount});

//   FilterModel.fromJson(Map<String, dynamic> json) {
//     if (json['arrearList'] != null) {
//       arrearList = <ArrearList>[];
//       json['arrearList'].forEach((v) {
//         arrearList!.add(new ArrearList.fromJson(v));
//       });
//     }
//     arrearListCount = json['arrearListCount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.arrearList != null) {
//       data['arrearList'] = this.arrearList!.map((v) => v.toJson()).toList();
//     }
//     data['arrearListCount'] = this.arrearListCount;
//     return data;
//   }
// }

// class ArrearList {
//   double? overdueInterest;
//   String? loanProductCode;
//   int? provisionAmountRatio;
//   String? homeNo;
//   int? previousOverdueMonth6;
//   String? branchLocalName;
//   String? loanExpiryDate;
//   int? previousOverdueMonth5;
//   int? previousOverdueMonth4;
//   String? industry;
//   int? previousOverdueMonth3;
//   String? villageName;
//   int? previousOverdueMonth2;
//   int? previousOverdueMonth1;
//   String? productName;
//   String? cellPhoneNo;
//   double? availableBalance;
//   double? loanBalance;
//   String? districtName1;
//   double? totalAmount1;
//   String? historyDate;
//   String? alternativeTransferAccountNo;
//   String? repaymentDate;
//   int? overdueDays;
//   String? refereneceEmployeeNo;
//   String? loanBranchCode;
//   double? repayInterest;
//   String? employeeName;
//   int? loanPeriodMonthlyCount;
//   double? repayPrincipal;
//   String? communeName;
//   String? branchName;
//   String? customerName;
//   int? loanAmount;
//   int? currentMonthOverdue;
//   String? loanAccountNo;
//   String? paymentApplyDate;
//   String? productCode;
//   String? postalAddress;
//   String? occupationCode;
//   String? customerListCodeName;
//   String? branchShortName;
//   String? loanDate;
//   String? provinceName;
//   double? collateralMaintenanceFee;
//   String? currencyCode;
//   String? customerNo;

//   ArrearList(
//       {this.overdueInterest,
//       this.loanProductCode,
//       this.provisionAmountRatio,
//       this.homeNo,
//       this.previousOverdueMonth6,
//       this.branchLocalName,
//       this.loanExpiryDate,
//       this.previousOverdueMonth5,
//       this.previousOverdueMonth4,
//       this.industry,
//       this.previousOverdueMonth3,
//       this.villageName,
//       this.previousOverdueMonth2,
//       this.previousOverdueMonth1,
//       this.productName,
//       this.cellPhoneNo,
//       this.availableBalance,
//       this.loanBalance,
//       this.districtName1,
//       this.totalAmount1,
//       this.historyDate,
//       this.alternativeTransferAccountNo,
//       this.repaymentDate,
//       this.overdueDays,
//       this.refereneceEmployeeNo,
//       this.loanBranchCode,
//       this.repayInterest,
//       this.employeeName,
//       this.loanPeriodMonthlyCount,
//       this.repayPrincipal,
//       this.communeName,
//       this.branchName,
//       this.customerName,
//       this.loanAmount,
//       this.currentMonthOverdue,
//       this.loanAccountNo,
//       this.paymentApplyDate,
//       this.productCode,
//       this.postalAddress,
//       this.occupationCode,
//       this.customerListCodeName,
//       this.branchShortName,
//       this.loanDate,
//       this.provinceName,
//       this.collateralMaintenanceFee,
//       this.currencyCode,
//       this.customerNo});

//   ArrearList.fromJson(Map<String, dynamic> json) {
//     overdueInterest = json['overdueInterest'];
//     loanProductCode = json['loanProductCode'];
//     provisionAmountRatio = json['provisionAmountRatio'];
//     homeNo = json['homeNo'];
//     previousOverdueMonth6 = json['previousOverdueMonth6'];
//     branchLocalName = json['branchLocalName'];
//     loanExpiryDate = json['loanExpiryDate'];
//     previousOverdueMonth5 = json['previousOverdueMonth5'];
//     previousOverdueMonth4 = json['previousOverdueMonth4'];
//     industry = json['industry'];
//     previousOverdueMonth3 = json['previousOverdueMonth3'];
//     villageName = json['villageName'];
//     previousOverdueMonth2 = json['previousOverdueMonth2'];
//     previousOverdueMonth1 = json['previousOverdueMonth1'];
//     productName = json['productName'];
//     cellPhoneNo = json['cellPhoneNo'];
//     availableBalance = json['availableBalance'];
//     loanBalance = json['loanBalance'];
//     districtName1 = json['districtName1'];
//     totalAmount1 = json['totalAmount1'];
//     historyDate = json['historyDate'];
//     alternativeTransferAccountNo = json['alternativeTransferAccountNo'];
//     repaymentDate = json['repaymentDate'];
//     overdueDays = json['overdueDays'];
//     refereneceEmployeeNo = json['refereneceEmployeeNo'];
//     loanBranchCode = json['loanBranchCode'];
//     repayInterest = json['repayInterest'];
//     employeeName = json['employeeName'];
//     loanPeriodMonthlyCount = json['loanPeriodMonthlyCount'];
//     repayPrincipal = json['repayPrincipal'];
//     communeName = json['communeName'];
//     branchName = json['branchName'];
//     customerName = json['customerName'];
//     loanAmount = json['loanAmount'];
//     currentMonthOverdue = json['currentMonthOverdue'];
//     loanAccountNo = json['loanAccountNo'];
//     paymentApplyDate = json['paymentApplyDate'];
//     productCode = json['productCode'];
//     postalAddress = json['postalAddress'];
//     occupationCode = json['occupationCode'];
//     customerListCodeName = json['customerListCodeName'];
//     branchShortName = json['branchShortName'];
//     loanDate = json['loanDate'];
//     provinceName = json['provinceName'];
//     collateralMaintenanceFee = json['collateralMaintenanceFee'];
//     currencyCode = json['currencyCode'];
//     customerNo = json['customerNo'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['overdueInterest'] = this.overdueInterest;
//     data['loanProductCode'] = this.loanProductCode;
//     data['provisionAmountRatio'] = this.provisionAmountRatio;
//     data['homeNo'] = this.homeNo;
//     data['previousOverdueMonth6'] = this.previousOverdueMonth6;
//     data['branchLocalName'] = this.branchLocalName;
//     data['loanExpiryDate'] = this.loanExpiryDate;
//     data['previousOverdueMonth5'] = this.previousOverdueMonth5;
//     data['previousOverdueMonth4'] = this.previousOverdueMonth4;
//     data['industry'] = this.industry;
//     data['previousOverdueMonth3'] = this.previousOverdueMonth3;
//     data['villageName'] = this.villageName;
//     data['previousOverdueMonth2'] = this.previousOverdueMonth2;
//     data['previousOverdueMonth1'] = this.previousOverdueMonth1;
//     data['productName'] = this.productName;
//     data['cellPhoneNo'] = this.cellPhoneNo;
//     data['availableBalance'] = this.availableBalance;
//     data['loanBalance'] = this.loanBalance;
//     data['districtName1'] = this.districtName1;
//     data['totalAmount1'] = this.totalAmount1;
//     data['historyDate'] = this.historyDate;
//     data['alternativeTransferAccountNo'] = this.alternativeTransferAccountNo;
//     data['repaymentDate'] = this.repaymentDate;
//     data['overdueDays'] = this.overdueDays;
//     data['refereneceEmployeeNo'] = this.refereneceEmployeeNo;
//     data['loanBranchCode'] = this.loanBranchCode;
//     data['repayInterest'] = this.repayInterest;
//     data['employeeName'] = this.employeeName;
//     data['loanPeriodMonthlyCount'] = this.loanPeriodMonthlyCount;
//     data['repayPrincipal'] = this.repayPrincipal;
//     data['communeName'] = this.communeName;
//     data['branchName'] = this.branchName;
//     data['customerName'] = this.customerName;
//     data['loanAmount'] = this.loanAmount;
//     data['currentMonthOverdue'] = this.currentMonthOverdue;
//     data['loanAccountNo'] = this.loanAccountNo;
//     data['paymentApplyDate'] = this.paymentApplyDate;
//     data['productCode'] = this.productCode;
//     data['postalAddress'] = this.postalAddress;
//     data['occupationCode'] = this.occupationCode;
//     data['customerListCodeName'] = this.customerListCodeName;
//     data['branchShortName'] = this.branchShortName;
//     data['loanDate'] = this.loanDate;
//     data['provinceName'] = this.provinceName;
//     data['collateralMaintenanceFee'] = this.collateralMaintenanceFee;
//     data['currencyCode'] = this.currencyCode;
//     data['customerNo'] = this.customerNo;
//     return data;
//   }
// }

class FilterModel {
  int? overdueInterest;
  String? loanProductCode;
  double? provisionAmountRatio;
  String? homeNo;
  int? previousOverdueMonth6;
  String? branchLocalName;
  String? loanExpiryDate;
  int? previousOverdueMonth5;
  int? previousOverdueMonth4;
  String? industry;
  int? previousOverdueMonth3;
  String? villageName;
  int? previousOverdueMonth2;
  int? previousOverdueMonth1;
  String? productName;
  String? cellPhoneNo;
  double? availableBalance;
  double? loanBalance;
  String? districtName1;
  double? totalAmount1;
  String? historyDate;
  String? alternativeTransferAccountNo;
  String? repaymentDate;
  int? overdueDays;
  String? refereneceEmployeeNo;
  String? loanBranchCode;
  double? repayInterest;
  String? employeeName;
  int? loanPeriodMonthlyCount;
  double? repayPrincipal;
  String? communeName;
  String? branchName;
  String? customerName;
  double? loanAmount;
  int? currentMonthOverdue;
  String? loanAccountNo;
  String? paymentApplyDate;
  String? productCode;
  String? postalAddress;
  String? occupationCode;
  String? customerListCodeName;
  String? branchShortName;
  String? loanDate;
  String? provinceName;
  double? collateralMaintenanceFee;
  String? currencyCode;
  String? customerNo;

  FilterModel(
      {this.overdueInterest,
      this.loanProductCode,
      this.provisionAmountRatio,
      this.homeNo,
      this.previousOverdueMonth6,
      this.branchLocalName,
      this.loanExpiryDate,
      this.previousOverdueMonth5,
      this.previousOverdueMonth4,
      this.industry,
      this.previousOverdueMonth3,
      this.villageName,
      this.previousOverdueMonth2,
      this.previousOverdueMonth1,
      this.productName,
      this.cellPhoneNo,
      this.availableBalance,
      this.loanBalance,
      this.districtName1,
      this.totalAmount1,
      this.historyDate,
      this.alternativeTransferAccountNo,
      this.repaymentDate,
      this.overdueDays,
      this.refereneceEmployeeNo,
      this.loanBranchCode,
      this.repayInterest,
      this.employeeName,
      this.loanPeriodMonthlyCount,
      this.repayPrincipal,
      this.communeName,
      this.branchName,
      this.customerName,
      this.loanAmount,
      this.currentMonthOverdue,
      this.loanAccountNo,
      this.paymentApplyDate,
      this.productCode,
      this.postalAddress,
      this.occupationCode,
      this.customerListCodeName,
      this.branchShortName,
      this.loanDate,
      this.provinceName,
      this.collateralMaintenanceFee,
      this.currencyCode,
      this.customerNo});

  FilterModel.fromJson(Map<String, dynamic> json) {
    overdueInterest = json['overdueInterest'];
    loanProductCode = json['loanProductCode'];
    provisionAmountRatio = json['provisionAmountRatio'];
    homeNo = json['homeNo'];
    previousOverdueMonth6 = json['previousOverdueMonth6'];
    branchLocalName = json['branchLocalName'];
    loanExpiryDate = json['loanExpiryDate'];
    previousOverdueMonth5 = json['previousOverdueMonth5'];
    previousOverdueMonth4 = json['previousOverdueMonth4'];
    industry = json['industry'];
    previousOverdueMonth3 = json['previousOverdueMonth3'];
    villageName = json['villageName'];
    previousOverdueMonth2 = json['previousOverdueMonth2'];
    previousOverdueMonth1 = json['previousOverdueMonth1'];
    productName = json['productName'];
    cellPhoneNo = json['cellPhoneNo'];
    availableBalance = json['availableBalance'];
    loanBalance = json['loanBalance'];
    districtName1 = json['districtName1'];
    totalAmount1 = json['totalAmount1'];
    historyDate = json['historyDate'];
    alternativeTransferAccountNo = json['alternativeTransferAccountNo'];
    repaymentDate = json['repaymentDate'];
    overdueDays = json['overdueDays'];
    refereneceEmployeeNo = json['refereneceEmployeeNo'];
    loanBranchCode = json['loanBranchCode'];
    repayInterest = json['repayInterest'];
    employeeName = json['employeeName'];
    loanPeriodMonthlyCount = json['loanPeriodMonthlyCount'];
    repayPrincipal = json['repayPrincipal'];
    communeName = json['communeName'];
    branchName = json['branchName'];
    customerName = json['customerName'];
    loanAmount = json['loanAmount'];
    currentMonthOverdue = json['currentMonthOverdue'];
    loanAccountNo = json['loanAccountNo'];
    paymentApplyDate = json['paymentApplyDate'];
    productCode = json['productCode'];
    postalAddress = json['postalAddress'];
    occupationCode = json['occupationCode'];
    customerListCodeName = json['customerListCodeName'];
    branchShortName = json['branchShortName'];
    loanDate = json['loanDate'];
    provinceName = json['provinceName'];
    collateralMaintenanceFee = json['collateralMaintenanceFee'];
    currencyCode = json['currencyCode'];
    customerNo = json['customerNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overdueInterest'] = this.overdueInterest;
    data['loanProductCode'] = this.loanProductCode;
    data['provisionAmountRatio'] = this.provisionAmountRatio;
    data['homeNo'] = this.homeNo;
    data['previousOverdueMonth6'] = this.previousOverdueMonth6;
    data['branchLocalName'] = this.branchLocalName;
    data['loanExpiryDate'] = this.loanExpiryDate;
    data['previousOverdueMonth5'] = this.previousOverdueMonth5;
    data['previousOverdueMonth4'] = this.previousOverdueMonth4;
    data['industry'] = this.industry;
    data['previousOverdueMonth3'] = this.previousOverdueMonth3;
    data['villageName'] = this.villageName;
    data['previousOverdueMonth2'] = this.previousOverdueMonth2;
    data['previousOverdueMonth1'] = this.previousOverdueMonth1;
    data['productName'] = this.productName;
    data['cellPhoneNo'] = this.cellPhoneNo;
    data['availableBalance'] = this.availableBalance;
    data['loanBalance'] = this.loanBalance;
    data['districtName1'] = this.districtName1;
    data['totalAmount1'] = this.totalAmount1;
    data['historyDate'] = this.historyDate;
    data['alternativeTransferAccountNo'] = this.alternativeTransferAccountNo;
    data['repaymentDate'] = this.repaymentDate;
    data['overdueDays'] = this.overdueDays;
    data['refereneceEmployeeNo'] = this.refereneceEmployeeNo;
    data['loanBranchCode'] = this.loanBranchCode;
    data['repayInterest'] = this.repayInterest;
    data['employeeName'] = this.employeeName;
    data['loanPeriodMonthlyCount'] = this.loanPeriodMonthlyCount;
    data['repayPrincipal'] = this.repayPrincipal;
    data['communeName'] = this.communeName;
    data['branchName'] = this.branchName;
    data['customerName'] = this.customerName;
    data['loanAmount'] = this.loanAmount;
    data['currentMonthOverdue'] = this.currentMonthOverdue;
    data['loanAccountNo'] = this.loanAccountNo;
    data['paymentApplyDate'] = this.paymentApplyDate;
    data['productCode'] = this.productCode;
    data['postalAddress'] = this.postalAddress;
    data['occupationCode'] = this.occupationCode;
    data['customerListCodeName'] = this.customerListCodeName;
    data['branchShortName'] = this.branchShortName;
    data['loanDate'] = this.loanDate;
    data['provinceName'] = this.provinceName;
    data['collateralMaintenanceFee'] = this.collateralMaintenanceFee;
    data['currencyCode'] = this.currencyCode;
    data['customerNo'] = this.customerNo;
    return data;
  }
}
