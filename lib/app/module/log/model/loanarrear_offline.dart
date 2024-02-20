class LoanArrearOfflineModel {
  final String userId;
  final String uname;
  final String userType;
  final String branchCode;
  final String employeeCode;
  final int overDueday;
  final String baseDate;
  final double totalAmoun;
  final String currencyCode;
  final int amount;
  LoanArrearOfflineModel(
    this.userId,
    this.uname,
    this.userType,
    this.branchCode,
    this.employeeCode,
    this.overDueday,
    this.baseDate,
    this.totalAmoun,
    this.currencyCode,
    this.amount,
  );
}
