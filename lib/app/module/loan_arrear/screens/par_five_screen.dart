import 'package:chokchey_finance/app/module/loan_arrear/screens/report_arr_follow_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/activity_log.dart';
import '../controllers/loan_arrear_controller.dart';
import '../widgets/arrear_card.dart';
import 'arrear_card_detail.dart';
import 'arrear_follow_up_new.dart';

class ParFiveScreen extends StatelessWidget {
  ParFiveScreen({
    super.key,
  });
  final _con = Get.put(LoanArrearController());
  final currentDate = DateTime.now();

  onUserType(String? date) async {
    // var type = await storage.read(key: 'user_type');
    // var branchCode = await storage.read(key: 'branch');
    // var empCode = await storage.read(key: 'user_ucode');
    /////condition for filter par arrear
    if (_con.ontapFilter.value == true) {
      _con.onfilterArrearNew(
        branchCode: '${_con.txtBranceCopy.value}',
        employeeCode: '${_con.txtUserCodeCopy.value}',
        overDueday: 90,
        baseDate: '$date',
      );
    }
    // else

    // if (type == "CO") {
    //   _con.onfilterArrearNew(
    //     branchCode: '$branchCode',
    //     employeeCode: '$empCode',
    //     overDueday: 90,
    //     baseDate: '$date',
    //   );
    // } else if (type == "BM") {
    //   _con.onfilterArrearNew(
    //     branchCode: '$branchCode',
    //     employeeCode: '',
    //     overDueday: 90,
    //     baseDate: '$date',
    //   );
    // } else {
    //   _con.onfilterArrearNew(
    //     branchCode: '',
    //     employeeCode: '',
    //     overDueday: 90,
    //     baseDate: '$date',
    //   );
    // }
  }

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
            child: _con.modelNew.value.arrear90Days!.isEmpty
                ? Center(child: Text('No Arrear'))
                : ListView.builder(
                    itemCount: _con.modelNew.value.arrear90Days!.length,
                    itemBuilder: (context, index) {
                      return CustomArrearCard(
                        name: _con
                            .modelNew.value.arrear90Days![index].customerName,
                        paymentDate: _con.modelNew.value.arrear90Days![index]
                            .paymentApplyDate,
                        amount: _con
                            .modelNew.value.arrear90Days![index].totalAmount1,
                        parAmount: _con
                            .modelNew.value.arrear90Days![index].overdueDays,
                        currencyCode: _con
                            .modelNew.value.arrear90Days![index].currencyCode,
                        loanID: _con
                            .modelNew.value.arrear90Days![index].loanAccountNo,
                        empName: _con
                            .modelNew.value.arrear90Days![index].employeeName,
                        onLoanFollowUp: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArrearFollowUpNew(
                                loanId: _con.modelNew.value.arrear90Days![index]
                                    .loanAccountNo,
                                village: _con.modelNew.value
                                    .arrear90Days![index].villageName,
                                commune: _con.modelNew.value
                                    .arrear90Days![index].communeName,
                                district: _con.modelNew.value
                                    .arrear90Days![index].districtName1,
                                province: _con.modelNew.value
                                    .arrear90Days![index].provinceName,
                                customerCodes: _con.modelNew.value
                                    .arrear90Days![index].customerNo,
                                customerNames: _con.modelNew.value
                                    .arrear90Days![index].customerName,
                                loanNumber: _con.modelNew.value
                                    .arrear90Days![index].loanAccountNo,
                                loanAmount: _con.modelNew.value
                                    .arrear90Days![index].loanAmount,
                                overdueDay: _con.modelNew.value
                                    .arrear90Days![index].overdueDays,
                                coName: _con.modelNew.value.arrear90Days![index]
                                    .employeeName,
                                coId: _con.modelNew.value.arrear90Days![index]
                                    .refereneceEmployeeNo,
                                brancCode: _con.modelNew.value
                                    .arrear90Days![index].loanBranchCode,
                                brancName: _con.modelNew.value
                                    .arrear90Days![index].branchName,
                                repaymentDate: _con.modelNew.value
                                    .arrear90Days![index].paymentApplyDate,
                                loanPeriod: _con
                                    .modelNew
                                    .value
                                    .arrear90Days![index]
                                    .loanPeriodMonthlyCount!,
                                createdDate: currentDate.toString(),
                                createdBy: _con.modelNew.value
                                    .arrear90Days![index].employeeName,
                                overdueAmt: _con.modelNew.value
                                    .arrear90Days![index].totalAmount1,
                                currencyCode: _con.modelNew.value
                                    .arrear90Days![index].currencyCode,
                                loanBalance: _con.modelNew.value
                                    .arrear90Days![index].loanBalance,
                              ),
                            ),
                          );
                          onActivityLogDevice(
                            userId: _con.modelNew.value.arrear90Days![index]
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
                                    .arrear90Days![index].loanAccountNo,
                                empCode: _con.modelNew.value
                                    .arrear90Days![index].refereneceEmployeeNo,
                                branchCode: _con.modelNew.value
                                    .arrear90Days![index].loanBranchCode,
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
                                    .arrear90Days![index].overdueDays,
                                customerName: _con.modelNew.value
                                    .arrear90Days![index].customerName,
                                phoneNo: _con.modelNew.value
                                    .arrear90Days![index].cellPhoneNo,
                                totalPayment: _con.modelNew.value
                                    .arrear90Days![index].totalAmount1,
                                repaymentDate: _con.modelNew.value
                                    .arrear90Days![index].paymentApplyDate,
                                employeeName: _con.modelNew.value
                                    .arrear90Days![index].employeeName,
                                loanAmount: _con.modelNew.value
                                    .arrear90Days![index].loanAmount,
                                loanPeriod: _con
                                    .modelNew
                                    .value
                                    .arrear90Days![index]
                                    .loanPeriodMonthlyCount,
                                branchName: _con.modelNew.value
                                    .arrear90Days![index].branchLocalName,
                                employeeID: _con.modelNew.value
                                    .arrear90Days![index].refereneceEmployeeNo,
                                currency: _con.modelNew.value
                                    .arrear90Days![index].currencyCode,
                                address: _con.modelNew.value
                                    .arrear90Days![index].postalAddress,
                                interestRate: _con.modelNew.value
                                    .arrear90Days![index].overdueInterest,
                                principal: _con.modelNew.value
                                    .arrear90Days![index].repayPrincipal,
                                maintenanceFee: _con
                                    .modelNew
                                    .value
                                    .arrear90Days![index]
                                    .collateralMaintenanceFee,
                                penalty: _con.modelNew.value
                                    .arrear90Days![index].repayInterest,
                                loanId: _con.modelNew.value.arrear90Days![index]
                                    .loanAccountNo,
                                village: _con.modelNew.value
                                    .arrear90Days![index].villageName,
                                commune: _con.modelNew.value
                                    .arrear90Days![index].communeName,
                                district: _con.modelNew.value
                                    .arrear90Days![index].districtName1,
                                province: _con.modelNew.value
                                    .arrear90Days![index].provinceName,
                                customerCodes: _con.modelNew.value
                                    .arrear90Days![index].customerNo,
                                loanNumber: _con.modelNew.value
                                    .arrear90Days![index].loanAccountNo,
                                overdueDay: _con.modelNew.value
                                    .arrear90Days![index].overdueDays,
                                coName: _con.modelNew.value.arrear90Days![index]
                                    .employeeName,
                                coId: _con.modelNew.value.arrear90Days![index]
                                    .refereneceEmployeeNo,
                                brancCode: _con.modelNew.value
                                    .arrear90Days![index].loanBranchCode,
                                branName: _con.modelNew.value
                                    .arrear90Days![index].branchName,
                                createdDate: currentDate.toString(),
                                createdBy: _con.modelNew.value
                                    .arrear90Days![index].employeeName,
                                overdueAmt: _con.modelNew.value
                                    .arrear90Days![index].totalAmount1,
                              ),
                            ),
                          );
                          onActivityLogDevice(
                            userId: _con.modelNew.value.arrear90Days![index]
                                .employeeName,
                            description: "Loan Arrear Detail Par all",
                          );
                        },
                      );
                    }),
          ));
  }
}
