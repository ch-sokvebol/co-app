class LoanArreaBodyModel {
  int overdueDay;
  String basedate;
  String employeeCode;
  String branchCode;

  LoanArreaBodyModel({
    required this.overdueDay,
    required this.basedate,
    required this.branchCode,
    required this.employeeCode,
  });

  factory LoanArreaBodyModel.fromJson(Map<String, dynamic> json) {
    return LoanArreaBodyModel(
      overdueDay: json['OverDueDays'],
      basedate: json['BaseDate'],
      branchCode: json['BranchCode'],
      employeeCode: json['EmployeeCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'OverDueDay': overdueDay,
      'BaseDate': basedate,
      'BranchCode': branchCode,
      'EmployeeCode': employeeCode,
    };
  }
}
