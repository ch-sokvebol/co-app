import 'package:chokchey_finance/app/module/loan_arrear/screens/report_arr_follow_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../utils/storages/const.dart';
import '../../../utils/helpers/activity_log.dart';
import '../controllers/loan_arrear_controller.dart';
import '../widgets/arrear_card.dart';
import 'arrear_card_detail.dart';
import 'arrear_follow_up_new.dart';

class ParThirtScreen extends StatelessWidget {
  ParThirtScreen({
    super.key,
  });
  final _con = Get.put(LoanArrearController());
  final currentDate = DateTime.now();

  onUserType(String? date) async {
    var type = await storage.read(key: 'user_type');
    var branchCode = await storage.read(key: 'branch');
    var empCode = await storage.read(key: 'user_ucode');
    /////condition for filter par arrear
    // if (_con.ontapFilter.value == true) {
    //   _con.onfilterArrearNew(
    //     branchCode: '${_con.txtBranceCopy.value}',
    //     employeeCode: '${_con.txtUserCodeCopy.value}',
    //     overDueday: 30,
    //     baseDate: '$date',
    //   );
    //   debugPrint('mgnn++++:');
    // } else
    if (type == "CO") {
      _con.onfilterArrearNew(
        branchCode: '$branchCode',
        employeeCode: '$empCode',
        overDueday: 30,
        baseDate: '$date',
      );
    } else if (type == "BM") {
      _con.onfilterArrearNew(
        branchCode: '$branchCode',
        employeeCode: '',
        overDueday: 30,
        baseDate: '$date',
      );
    } else {
      _con.onfilterArrearNew(
        branchCode: '',
        employeeCode: '',
        overDueday: 30,
        baseDate: '$date',
      );
    }
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
            child: _con.modelNew.value.arrear14Days!.isEmpty
                ? Center(child: Text('No Arrears'))
                : ListView.builder(
                    itemCount: _con.modelNew.value.arrear30Days!.length,
                    itemBuilder: (context, index) {
                      return CustomArrearCard(
                        name: _con
                            .modelNew.value.arrear30Days![index].customerName,
                        paymentDate: _con.modelNew.value.arrear30Days![index]
                            .paymentApplyDate,
                        amount: _con
                            .modelNew.value.arrear30Days![index].totalAmount1,
                        parAmount: _con
                            .modelNew.value.arrear30Days![index].overdueDays,
                        currencyCode: _con
                            .modelNew.value.arrear30Days![index].currencyCode,
                        loanID: _con
                            .modelNew.value.arrear30Days![index].loanAccountNo,
                        empName: _con
                            .modelNew.value.arrear30Days![index].employeeName,
                        onLoanFollowUp: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArrearFollowUpNew(
                                loanId: _con.modelNew.value.arrear30Days![index]
                                    .loanAccountNo,
                                village: _con.modelNew.value
                                    .arrear30Days![index].villageName,
                                commune: _con.modelNew.value
                                    .arrear30Days![index].communeName,
                                district: _con.modelNew.value
                                    .arrear30Days![index].districtName1,
                                province: _con.modelNew.value
                                    .arrear30Days![index].provinceName,
                                customerCodes: _con.modelNew.value
                                    .arrear30Days![index].customerNo,
                                customerNames: _con.modelNew.value
                                    .arrear30Days![index].customerName,
                                loanNumber: _con.modelNew.value
                                    .arrear30Days![index].loanAccountNo,
                                loanAmount: _con.modelNew.value
                                    .arrear30Days![index].loanAmount,
                                overdueDay: _con.modelNew.value
                                    .arrear30Days![index].overdueDays,
                                coName: _con.modelNew.value.arrear30Days![index]
                                    .employeeName,
                                coId: _con.modelNew.value.arrear30Days![index]
                                    .refereneceEmployeeNo,
                                brancCode: _con.modelNew.value
                                    .arrear30Days![index].loanBranchCode,
                                brancName: _con.modelNew.value
                                    .arrear30Days![index].branchName,
                                repaymentDate: _con.modelNew.value
                                    .arrear30Days![index].paymentApplyDate,
                                loanPeriod: _con
                                    .modelNew
                                    .value
                                    .arrear30Days![index]
                                    .loanPeriodMonthlyCount!,
                                createdDate: currentDate.toString(),
                                createdBy: _con.modelNew.value
                                    .arrear30Days![index].employeeName,
                                overdueAmt: _con.modelNew.value
                                    .arrear30Days![index].totalAmount1,
                                currencyCode: _con.modelNew.value
                                    .arrear30Days![index].currencyCode,
                                loanBalance: _con.modelNew.value
                                    .arrear30Days![index].loanBalance,
                              ),
                            ),
                          );
                          onActivityLogDevice(
                            userId: _con.modelNew.value.arrear30Days![index]
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
                                    .arrear30Days![index].loanAccountNo,
                                empCode: _con.modelNew.value
                                    .arrear30Days![index].refereneceEmployeeNo,
                                branchCode: _con.modelNew.value
                                    .arrear30Days![index].loanBranchCode,
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
                                    .arrear30Days![index].overdueDays,
                                customerName: _con.modelNew.value
                                    .arrear30Days![index].customerName,
                                phoneNo: _con.modelNew.value
                                    .arrear30Days![index].cellPhoneNo,
                                totalPayment: _con.modelNew.value
                                    .arrear30Days![index].totalAmount1,
                                repaymentDate: _con.modelNew.value
                                    .arrear30Days![index].paymentApplyDate,
                                employeeName: _con.modelNew.value
                                    .arrear30Days![index].employeeName,
                                loanAmount: _con.modelNew.value
                                    .arrear30Days![index].loanAmount,
                                loanPeriod: _con
                                    .modelNew
                                    .value
                                    .arrear30Days![index]
                                    .loanPeriodMonthlyCount,
                                branchName: _con.modelNew.value
                                    .arrear30Days![index].branchLocalName,
                                employeeID: _con.modelNew.value
                                    .arrear30Days![index].refereneceEmployeeNo,
                                currency: _con.modelNew.value
                                    .arrear30Days![index].currencyCode,
                                address: _con.modelNew.value
                                    .arrear30Days![index].postalAddress,
                                interestRate: _con.modelNew.value
                                    .arrear30Days![index].overdueInterest,
                                principal: _con.modelNew.value
                                    .arrear30Days![index].repayPrincipal,
                                maintenanceFee: _con
                                    .modelNew
                                    .value
                                    .arrear30Days![index]
                                    .collateralMaintenanceFee,
                                penalty: _con.modelNew.value
                                    .arrear30Days![index].repayInterest,
                                loanId: _con.modelNew.value.arrear30Days![index]
                                    .loanAccountNo,
                                village: _con.modelNew.value
                                    .arrear30Days![index].villageName,
                                commune: _con.modelNew.value
                                    .arrear30Days![index].communeName,
                                district: _con.modelNew.value
                                    .arrear30Days![index].districtName1,
                                province: _con.modelNew.value
                                    .arrear30Days![index].provinceName,
                                customerCodes: _con.modelNew.value
                                    .arrear30Days![index].customerNo,
                                loanNumber: _con.modelNew.value
                                    .arrear30Days![index].loanAccountNo,
                                overdueDay: _con.modelNew.value
                                    .arrear30Days![index].overdueDays,
                                coName: _con.modelNew.value.arrear30Days![index]
                                    .employeeName,
                                coId: _con.modelNew.value.arrear30Days![index]
                                    .refereneceEmployeeNo,
                                brancCode: _con.modelNew.value
                                    .arrear30Days![index].loanBranchCode,
                                branName: _con.modelNew.value
                                    .arrear30Days![index].branchName,
                                createdDate: currentDate.toString(),
                                createdBy: _con.modelNew.value
                                    .arrear30Days![index].employeeName,
                                overdueAmt: _con.modelNew.value
                                    .arrear30Days![index].totalAmount1,
                              ),
                            ),
                          );
                          onActivityLogDevice(
                            userId: _con.modelNew.value.arrear30Days![index]
                                .employeeName,
                            description: "Loan Arrears Detail Par all",
                          );
                        },
                      );
                    }),
          ));
  }
}
