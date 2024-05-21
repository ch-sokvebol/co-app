import 'package:chokchey_finance/app/module/loan_arrear/screens/report_arr_follow_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/activity_log.dart';
import '../controllers/loan_arrear_controller.dart';
import '../widgets/arrear_card.dart';
import 'arrear_card_detail.dart';
import 'arrear_follow_up_new.dart';

class ParLargerOneScreen extends StatelessWidget {
  // final bool? tabfilter;

  ParLargerOneScreen({
    super.key,
  });

  final _con = Get.put(LoanArrearController());
  final currentDate = DateTime.now();
  onUserType(String? date) async {
    // var type = await storage.read(key: 'user_type');
    // var branchCode = await storage.read(key: 'branch');
    // var empCode = await storage.read(key: 'user_ucode');
    _con.onfilterArrearNew(
      branchCode: '${_con.txtBranceCopy.value}',
      employeeCode: '${_con.txtUserCodeCopy.value}',
      overDueday: 0,
      baseDate: '$date',
    );
    /////condition for filter par arrear
    // if (tabfilter == true) {
    //   _con.onfilterArrearNew(
    //     branchCode: '${_con.txtBranceCopy.value}',
    //     employeeCode: '${_con.txtUserCodeCopy.value}',
    //     overDueday: 0,
    //     baseDate: '$date',
    //   );
    // }
    // else
    // if (type == "CO") {
    //   _con.onfilterArrearNew(
    //     branchCode: '$branchCode',
    //     employeeCode: '$empCode',
    //     overDueday: 0,
    //     baseDate: '$date',
    //   );
    // } else if (type == "BM") {
    //   _con.onfilterArrearNew(
    //     branchCode: '$branchCode',
    //     employeeCode: '',
    //     overDueday: 0,
    //     baseDate: '$date',
    //   );
    // } else {
    //   _con.onfilterArrearNew(
    //     branchCode: '',
    //     employeeCode: '',
    //     overDueday: 0,
    //     baseDate: '$date',
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    // var date = DateFormat("yyyyMMdd").format(
    //     DateTime(currentDate.year, currentDate.month, currentDate.day - 1));
    // onUserType(date);
    return Obx(() => _con.isLoadingFilterNew.value == true
        ? SpinKitFadingCircle(
            color: Colors.black26,
          )
        : RefreshIndicator(
            onRefresh: () async {
              await _con.onCheckPar();
            },
            child: _con.modelNew.value.arrear1Day!.isEmpty
                ? Center(child: Text('No Arrears'))
                : ListView.builder(
                    itemCount: _con.modelNew.value.arrear1Day!.length,
                    itemBuilder: (context, index) {
                      return CustomArrearCard(
                        name:
                            _con.modelNew.value.arrear1Day![index].customerName,
                        paymentDate: _con
                            .modelNew.value.arrear1Day![index].paymentApplyDate,
                        amount:
                            _con.modelNew.value.arrear1Day![index].totalAmount1,
                        parAmount:
                            _con.modelNew.value.arrear1Day![index].overdueDays,
                        currencyCode:
                            _con.modelNew.value.arrear1Day![index].currencyCode,
                        loanID: _con
                            .modelNew.value.arrear1Day![index].loanAccountNo,
                        empName:
                            _con.modelNew.value.arrear1Day![index].employeeName,
                        onLoanFollowUp: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArrearFollowUpNew(
                                loanId: _con.modelNew.value.arrear1Day![index]
                                    .loanAccountNo,
                                village: _con.modelNew.value.arrear1Day![index]
                                    .villageName,
                                commune: _con.modelNew.value.arrear1Day![index]
                                    .communeName,
                                district: _con.modelNew.value.arrear1Day![index]
                                    .districtName1,
                                province: _con.modelNew.value.arrear1Day![index]
                                    .provinceName,
                                customerCodes: _con.modelNew.value
                                    .arrear1Day![index].customerNo,
                                customerNames: _con.modelNew.value
                                    .arrear1Day![index].customerName,
                                loanNumber: _con.modelNew.value
                                    .arrear1Day![index].loanAccountNo,
                                loanAmount: _con.modelNew.value
                                    .arrear1Day![index].loanAmount,
                                overdueDay: _con.modelNew.value
                                    .arrear1Day![index].overdueDays,
                                coName: _con.modelNew.value.arrear1Day![index]
                                    .employeeName,
                                coId: _con.modelNew.value.arrear1Day![index]
                                    .refereneceEmployeeNo,
                                brancCode: _con.modelNew.value
                                    .arrear1Day![index].loanBranchCode,
                                brancName: _con.modelNew.value
                                    .arrear1Day![index].branchName,
                                repaymentDate: _con.modelNew.value
                                    .arrear1Day![index].paymentApplyDate,
                                loanPeriod: _con.modelNew.value
                                    .arrear1Day![index].loanPeriodMonthlyCount!,
                                createdDate: currentDate.toString(),
                                createdBy: _con.modelNew.value
                                    .arrear1Day![index].employeeName,
                                overdueAmt: _con.modelNew.value
                                    .arrear1Day![index].totalAmount1,
                                currencyCode: _con.modelNew.value
                                    .arrear1Day![index].currencyCode,
                                loanBalance: _con.modelNew.value
                                    .arrear1Day![index].loanBalance,
                              ),
                            ),
                          );
                          onActivityLogDevice(
                            userId: _con.modelNew.value.arrear1Day![index]
                                .refereneceEmployeeNo,
                            description: "Loan Arrears Follow up par all",
                          );
                        },
                        onTabHistory: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportArrFollowUp(
                                loanNumber: _con.modelNew.value
                                    .arrear1Day![index].loanAccountNo,
                                empCode: _con.modelNew.value.arrear1Day![index]
                                    .refereneceEmployeeNo,
                                branchCode: _con.modelNew.value
                                    .arrear1Day![index].loanBranchCode,
                              ),
                            ),
                          );
                        },
                        onTapCard: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArrearCardDetail(
                                overDueDays: _con.modelNew.value
                                    .arrear1Day![index].overdueDays,
                                customerName: _con.modelNew.value
                                    .arrear1Day![index].customerName,
                                phoneNo: _con.modelNew.value.arrear1Day![index]
                                    .cellPhoneNo,
                                totalPayment: _con.modelNew.value
                                    .arrear1Day![index].totalAmount1,
                                repaymentDate: _con.modelNew.value
                                    .arrear1Day![index].paymentApplyDate,
                                employeeName: _con.modelNew.value
                                    .arrear1Day![index].employeeName,
                                loanAmount: _con.modelNew.value
                                    .arrear1Day![index].loanAmount,
                                loanPeriod: _con.modelNew.value
                                    .arrear1Day![index].loanPeriodMonthlyCount,
                                branchName: _con.modelNew.value
                                    .arrear1Day![index].branchLocalName,
                                employeeID: _con.modelNew.value
                                    .arrear1Day![index].refereneceEmployeeNo,
                                currency: _con.modelNew.value.arrear1Day![index]
                                    .currencyCode,
                                address: _con.modelNew.value.arrear1Day![index]
                                    .postalAddress,
                                interestRate: _con.modelNew.value
                                    .arrear1Day![index].overdueInterest,
                                principal: _con.modelNew.value
                                    .arrear1Day![index].repayPrincipal,
                                maintenanceFee: _con
                                    .modelNew
                                    .value
                                    .arrear1Day![index]
                                    .collateralMaintenanceFee,
                                penalty: _con.modelNew.value.arrear1Day![index]
                                    .repayInterest,
                                loanId: _con.modelNew.value.arrear1Day![index]
                                    .loanAccountNo,
                                village: _con.modelNew.value.arrear1Day![index]
                                    .villageName,
                                commune: _con.modelNew.value.arrear1Day![index]
                                    .communeName,
                                district: _con.modelNew.value.arrear1Day![index]
                                    .districtName1,
                                province: _con.modelNew.value.arrear1Day![index]
                                    .provinceName,
                                customerCodes: _con.modelNew.value
                                    .arrear1Day![index].customerNo,
                                loanNumber: _con.modelNew.value
                                    .arrear1Day![index].loanAccountNo,
                                overdueDay: _con.modelNew.value
                                    .arrear1Day![index].overdueDays,
                                coName: _con.modelNew.value.arrear1Day![index]
                                    .employeeName,
                                coId: _con.modelNew.value.arrear1Day![index]
                                    .refereneceEmployeeNo,
                                brancCode: _con.modelNew.value
                                    .arrear1Day![index].loanBranchCode,
                                branName: _con.modelNew.value.arrear1Day![index]
                                    .branchName,
                                createdDate: currentDate.toString(),
                                createdBy: _con.modelNew.value
                                    .arrear1Day![index].employeeName,
                                overdueAmt: _con.modelNew.value
                                    .arrear1Day![index].totalAmount1,
                              ),
                            ),
                          );
                          onActivityLogDevice(
                            userId: _con
                                .modelNew.value.arrear1Day![index].employeeName,
                            description: "Loan Arrears Detail Par all",
                          );
                        },
                      );
                    },
                  ),
          ));
  }
}
