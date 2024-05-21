import 'package:chokchey_finance/app/module/loan_arrear/models/Get_arr_follow_up_model.dart';
import 'package:chokchey_finance/app/module/loan_arrear/screens/report_arr_follow_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/activity_log.dart';
import '../controllers/loan_arrear_controller.dart';
import '../widgets/arrear_card.dart';
import 'arrear_card_detail.dart';
import 'arrear_follow_up_new.dart';

class AllParScreen extends StatefulWidget {
  // final bool? tabFilter;
  // final ArrearModel allArrear;
  final GetArrFollowUpModel? getArrFollowUpModel;
  AllParScreen({
    super.key,
    this.getArrFollowUpModel,
    // this.tabFilter = false,
    // required this.allArrear,
  });

  @override
  State<AllParScreen> createState() => _AllParScreenState();
}

class _AllParScreenState extends State<AllParScreen> {
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
            child: _con.modelNew.value.allArrear!.isEmpty
                ? ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 80),
                    children: [
                      Text(
                        'No Arrears',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: _con.modelNew.value.allArrear!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CustomArrearCard(
                            name: _con
                                .modelNew.value.allArrear![index].customerName,
                            paymentDate: _con.modelNew.value.allArrear![index]
                                .paymentApplyDate,
                            amount: _con
                                .modelNew.value.allArrear![index].totalAmount1,
                            parAmount: _con
                                .modelNew.value.allArrear![index].overdueDays,
                            currencyCode: _con
                                .modelNew.value.allArrear![index].currencyCode,
                            loanID: _con
                                .modelNew.value.allArrear![index].loanAccountNo,
                            empName: _con
                                .modelNew.value.allArrear![index].employeeName,
                            onTabHistory: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReportArrFollowUp(
                                    loanNumber: _con.modelNew.value
                                        .allArrear![index].loanAccountNo,
                                    empCode: _con.modelNew.value
                                        .allArrear![index].refereneceEmployeeNo,
                                    branchCode: _con.modelNew.value
                                        .allArrear![index].loanBranchCode,
                                  ),
                                ),
                              );
                            },
                            onLoanFollowUp: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArrearFollowUpNew(
                                    loanId: _con.modelNew.value
                                        .allArrear![index].loanAccountNo,
                                    village: _con.modelNew.value
                                        .allArrear![index].villageName,
                                    commune: _con.modelNew.value
                                        .allArrear![index].communeName,
                                    district: _con.modelNew.value
                                        .allArrear![index].districtName1,
                                    province: _con.modelNew.value
                                        .allArrear![index].provinceName,
                                    customerCodes: _con.modelNew.value
                                        .allArrear![index].customerNo,
                                    customerNames: _con.modelNew.value
                                        .allArrear![index].customerName,
                                    loanNumber: _con.modelNew.value
                                        .allArrear![index].loanAccountNo,
                                    loanAmount: _con.modelNew.value
                                        .allArrear![index].loanAmount,
                                    overdueDay: _con.modelNew.value
                                        .allArrear![index].overdueDays,
                                    coName: _con.modelNew.value
                                        .allArrear![index].employeeName,
                                    coId: _con.modelNew.value.allArrear![index]
                                        .refereneceEmployeeNo,
                                    brancCode: _con.modelNew.value
                                        .allArrear![index].loanBranchCode,
                                    brancName: _con.modelNew.value
                                        .allArrear![index].branchName,
                                    repaymentDate: _con.modelNew.value
                                        .allArrear![index].paymentApplyDate,
                                    loanPeriod: _con
                                        .modelNew
                                        .value
                                        .allArrear![index]
                                        .loanPeriodMonthlyCount!,
                                    createdDate: currentDate.toString(),
                                    createdBy: _con.modelNew.value
                                        .allArrear![index].employeeName,
                                    overdueAmt: _con.modelNew.value
                                        .allArrear![index].totalAmount1,
                                    currencyCode: _con.modelNew.value
                                        .allArrear![index].currencyCode,
                                    loanBalance: _con.modelNew.value
                                        .allArrear![index].loanBalance,
                                  ),
                                ),
                              );
                              onActivityLogDevice(
                                userId: _con.modelNew.value.allArrear![index]
                                    .refereneceEmployeeNo,
                                description: "Loan Arrears Follow up par all",
                              );
                            },
                            onTapCard: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArrearCardDetail(
                                    overDueDays: _con.modelNew.value
                                        .allArrear![index].overdueDays,
                                    customerName: _con.modelNew.value
                                        .allArrear![index].customerName,
                                    phoneNo: _con.modelNew.value
                                        .allArrear![index].cellPhoneNo,
                                    totalPayment: _con.modelNew.value
                                        .allArrear![index].totalAmount1,
                                    repaymentDate: _con.modelNew.value
                                        .allArrear![index].paymentApplyDate,
                                    employeeName: _con.modelNew.value
                                        .allArrear![index].employeeName,
                                    loanAmount: _con.modelNew.value
                                        .allArrear![index].loanAmount,
                                    loanPeriod: _con
                                        .modelNew
                                        .value
                                        .allArrear![index]
                                        .loanPeriodMonthlyCount,
                                    branchName: _con.modelNew.value
                                        .allArrear![index].branchLocalName,
                                    employeeID: _con.modelNew.value
                                        .allArrear![index].refereneceEmployeeNo,
                                    currency: _con.modelNew.value
                                        .allArrear![index].currencyCode,
                                    address: _con.modelNew.value
                                        .allArrear![index].postalAddress,
                                    interestRate: _con.modelNew.value
                                        .allArrear![index].overdueInterest,
                                    principal: _con.modelNew.value
                                        .allArrear![index].repayPrincipal,
                                    maintenanceFee: _con
                                        .modelNew
                                        .value
                                        .allArrear![index]
                                        .collateralMaintenanceFee,
                                    penalty: _con.modelNew.value
                                        .allArrear![index].repayInterest,
                                    loanId: _con.modelNew.value
                                        .allArrear![index].loanAccountNo,
                                    village: _con.modelNew.value
                                        .allArrear![index].villageName,
                                    commune: _con.modelNew.value
                                        .allArrear![index].communeName,
                                    district: _con.modelNew.value
                                        .allArrear![index].districtName1,
                                    province: _con.modelNew.value
                                        .allArrear![index].provinceName,
                                    customerCodes: _con.modelNew.value
                                        .allArrear![index].customerNo,
                                    loanNumber: _con.modelNew.value
                                        .allArrear![index].loanAccountNo,
                                    overdueDay: _con.modelNew.value
                                        .allArrear![index].overdueDays,
                                    coName: _con.modelNew.value
                                        .allArrear![index].employeeName,
                                    coId: _con.modelNew.value.allArrear![index]
                                        .refereneceEmployeeNo,
                                    brancCode: _con.modelNew.value
                                        .allArrear![index].loanBranchCode,
                                    branName: _con.modelNew.value
                                        .allArrear![index].branchName,
                                    createdDate: currentDate.toString(),
                                    createdBy: _con.modelNew.value
                                        .allArrear![index].employeeName,
                                    overdueAmt: _con.modelNew.value
                                        .allArrear![index].totalAmount1,
                                  ),
                                ),
                              );
                              onActivityLogDevice(
                                userId: _con.modelNew.value.allArrear![index]
                                    .employeeName,
                                description: "Loan Arrears Detail Par all",
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
          ));
  }
}
