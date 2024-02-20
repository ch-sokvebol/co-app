import 'package:chokchey_finance/app/module/loan_arrear/screens/report_arr_follow_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/activity_log.dart';
import '../controllers/loan_arrear_controller.dart';
import '../widgets/arrear_card.dart';
import 'arrear_card_detail.dart';
import 'arrear_follow_up_new.dart';

class ParsecondScreen extends StatelessWidget {
  // final bool? tabfilter;
  ParsecondScreen({
    super.key,
    // this.tabfilter = false,
  });

  final _con = Get.put(LoanArrearController());
  final currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Obx(() => _con.isLoadingFilterNew.value == true
        ? SpinKitFadingCircle(
            color: Colors.black26,
          )
        : RefreshIndicator(
            onRefresh: () async {
              await _con.onCheckPar();
            },
            child: _con.modelNew.value.arrear14Days!.isEmpty
                ? Center(child: Text('No Arrear'))
                : ListView.builder(
                    itemCount: _con.modelNew.value.arrear14Days!.length,
                    itemBuilder: (context, index) {
                      return CustomArrearCard(
                        name: _con
                            .modelNew.value.arrear14Days![index].customerName,
                        paymentDate: _con.modelNew.value.arrear14Days![index]
                            .paymentApplyDate,
                        amount: _con
                            .modelNew.value.arrear14Days![index].totalAmount1,
                        parAmount: _con
                            .modelNew.value.arrear14Days![index].overdueDays,
                        currencyCode: _con
                            .modelNew.value.arrear14Days![index].currencyCode,
                        loanID: _con
                            .modelNew.value.arrear14Days![index].loanAccountNo,
                        empName: _con
                            .modelNew.value.arrear14Days![index].employeeName,
                        onLoanFollowUp: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArrearFollowUpNew(
                                loanId: _con.modelNew.value.arrear14Days![index]
                                    .loanAccountNo,
                                village: _con.modelNew.value
                                    .arrear14Days![index].villageName,
                                commune: _con.modelNew.value
                                    .arrear14Days![index].communeName,
                                district: _con.modelNew.value
                                    .arrear14Days![index].districtName1,
                                province: _con.modelNew.value
                                    .arrear14Days![index].provinceName,
                                customerCodes: _con.modelNew.value
                                    .arrear14Days![index].customerNo,
                                customerNames: _con.modelNew.value
                                    .arrear14Days![index].customerName,
                                loanNumber: _con.modelNew.value
                                    .arrear14Days![index].loanAccountNo,
                                loanAmount: _con.modelNew.value
                                    .arrear14Days![index].loanAmount,
                                overdueDay: _con.modelNew.value
                                    .arrear14Days![index].overdueDays,
                                coName: _con.modelNew.value.arrear14Days![index]
                                    .employeeName,
                                coId: _con.modelNew.value.arrear14Days![index]
                                    .refereneceEmployeeNo,
                                brancCode: _con.modelNew.value
                                    .arrear14Days![index].loanBranchCode,
                                brancName: _con.modelNew.value
                                    .arrear14Days![index].branchName,
                                repaymentDate: _con.modelNew.value
                                    .arrear14Days![index].paymentApplyDate,
                                loanPeriod: _con
                                    .modelNew
                                    .value
                                    .arrear14Days![index]
                                    .loanPeriodMonthlyCount!,
                                createdDate: currentDate.toString(),
                                createdBy: _con.modelNew.value
                                    .arrear14Days![index].employeeName,
                                overdueAmt: _con.modelNew.value
                                    .arrear14Days![index].totalAmount1,
                                currencyCode: _con.modelNew.value
                                    .arrear14Days![index].currencyCode,
                                loanBalance: _con.modelNew.value
                                    .arrear14Days![index].loanBalance,
                              ),
                            ),
                          );
                          onActivityLogDevice(
                            userId: _con.modelNew.value.arrear14Days![index]
                                .refereneceEmployeeNo,
                            description: "Loan Arrear Follow up par all",
                          );
                        },
                        onTabHistory: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportArrFollowUp(
                                loanNumber: _con.modelNew.value
                                    .arrear14Days![index].loanAccountNo,
                                empCode: _con.modelNew.value
                                    .arrear14Days![index].refereneceEmployeeNo,
                                branchCode: _con.modelNew.value
                                    .arrear14Days![index].loanBranchCode,
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
                                    .arrear14Days![index].overdueDays,
                                customerName: _con.modelNew.value
                                    .arrear14Days![index].customerName,
                                phoneNo: _con.modelNew.value
                                    .arrear14Days![index].cellPhoneNo,
                                totalPayment: _con.modelNew.value
                                    .arrear14Days![index].totalAmount1,
                                repaymentDate: _con.modelNew.value
                                    .arrear14Days![index].paymentApplyDate,
                                employeeName: _con.modelNew.value
                                    .arrear14Days![index].employeeName,
                                loanAmount: _con.modelNew.value
                                    .arrear14Days![index].loanAmount,
                                loanPeriod: _con
                                    .modelNew
                                    .value
                                    .arrear14Days![index]
                                    .loanPeriodMonthlyCount,
                                branchName: _con.modelNew.value
                                    .arrear14Days![index].branchLocalName,
                                employeeID: _con.modelNew.value
                                    .arrear14Days![index].refereneceEmployeeNo,
                                currency: _con.modelNew.value
                                    .arrear14Days![index].currencyCode,
                                address: _con.modelNew.value
                                    .arrear14Days![index].postalAddress,
                                interestRate: _con.modelNew.value
                                    .arrear14Days![index].overdueInterest,
                                principal: _con.modelNew.value
                                    .arrear14Days![index].repayPrincipal,
                                maintenanceFee: _con
                                    .modelNew
                                    .value
                                    .arrear14Days![index]
                                    .collateralMaintenanceFee,
                                penalty: _con.modelNew.value
                                    .arrear14Days![index].repayInterest,
                                loanId: _con.modelNew.value.arrear14Days![index]
                                    .loanAccountNo,
                                village: _con.modelNew.value
                                    .arrear14Days![index].villageName,
                                commune: _con.modelNew.value
                                    .arrear14Days![index].communeName,
                                district: _con.modelNew.value
                                    .arrear14Days![index].districtName1,
                                province: _con.modelNew.value
                                    .arrear14Days![index].provinceName,
                                customerCodes: _con.modelNew.value
                                    .arrear14Days![index].customerNo,
                                loanNumber: _con.modelNew.value
                                    .arrear14Days![index].loanAccountNo,
                                overdueDay: _con.modelNew.value
                                    .arrear14Days![index].overdueDays,
                                coName: _con.modelNew.value.arrear14Days![index]
                                    .employeeName,
                                coId: _con.modelNew.value.arrear14Days![index]
                                    .refereneceEmployeeNo,
                                brancCode: _con.modelNew.value
                                    .arrear14Days![index].loanBranchCode,
                                branName: _con.modelNew.value
                                    .arrear14Days![index].branchName,
                                createdDate: currentDate.toString(),
                                createdBy: _con.modelNew.value
                                    .arrear14Days![index].employeeName,
                                overdueAmt: _con.modelNew.value
                                    .arrear14Days![index].totalAmount1,
                              ),
                            ),
                          );
                          onActivityLogDevice(
                            userId: _con.modelNew.value.arrear14Days![index]
                                .employeeName,
                            description: "Loan Arrear Detail Par all",
                          );
                        },
                      );
                    }),
          ));
  }
}
