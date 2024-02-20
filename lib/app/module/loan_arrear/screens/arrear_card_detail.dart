import 'package:chokchey_finance/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../localizations/appLocalizations.dart';
import '../../../utils/colors/app_color.dart';
import '../../../utils/helpers/format_convert.dart';
import '../../../utils/helpers/format_date.dart';
import 'arrear_follow_up_new.dart';

class ArrearCardDetail extends StatelessWidget {
  final String? customerName,
      phoneNo,
      repaymentDate,
      employeeName,
      branchName,
      employeeID,
      currency,
      address,
      loanId,
      village,
      commune,
      district,
      province,
      branName,
      customerCodes,
      loanNumber,
      coName,
      coId,
      brancCode,
      createdDate,
      createdBy,
      currentDate;
  final num? totalPayment,
      loanAmount,
      overDueDays,
      loanPeriod,
      penalty,
      principal,
      interestRate,
      maintenanceFee,
      overdueDay,
      overdueAmt;
  // final int? loanPeriod;
  const ArrearCardDetail({
    super.key,
    this.customerName,
    this.phoneNo,
    this.totalPayment,
    this.repaymentDate,
    this.employeeName,
    this.loanAmount,
    this.loanPeriod,
    this.overDueDays,
    this.branchName,
    this.employeeID,
    this.currency,
    this.address,
    this.penalty,
    this.principal,
    this.interestRate,
    this.maintenanceFee,
    this.loanId,
    this.village,
    this.commune,
    this.district,
    this.province,
    this.customerCodes,
    this.loanNumber,
    this.coName,
    this.brancCode,
    this.createdDate,
    this.createdBy,
    this.overdueDay,
    this.overdueAmt,
    this.coId,
    this.currentDate,
    this.branName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title:
            '${AppLocalizations.of(context)!.translate('arrear_detail') ?? 'Loan Arrear Detail'}',
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    padding: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        // border: Border.all(width: 1.5, color: AppColors.logolightGreen),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 5,
                              color: Colors.grey[200]!),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    overDueDays == 1.0
                                        ? '${AppLocalizations.of(context)!.translate('arrear_day')} ${FormatDate.formatDigit(overDueDays ?? 0)} ${AppLocalizations.of(context)!.translate('day')}'
                                        : '${AppLocalizations.of(context)!.translate('arrear_day')} ${FormatDate.formatDigit(overDueDays ?? 0)} ${AppLocalizations.of(context)!.translate('days')}',
                                    style: theme.titleMedium!.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${AppLocalizations.of(context)!.translate('employee_name')}: $employeeName',
                                    style: theme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '$branchName',
                                    style: theme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${AppLocalizations.of(context)!.translate('employee_id')}: $employeeID',
                                    style: theme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Divider(
                          thickness: 1.2,
                          color: AppColors.logolightGreen.withOpacity(0.3),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${AppLocalizations.of(context)!.translate('total_repayment')}',
                                style: theme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  '${FormatConvert.formatCurrencyNew(totalPayment ?? 0)} $currency',
                                  style: theme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red,
                                      fontSize: 22)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 20, bottom: 20, right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Container(
                              //   padding: EdgeInsets.all(10),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     color: AppColors.logolightGreen.withOpacity(0.2),
                              //   ),
                              //   child: FaIcon(
                              //     FontAwesomeIcons.moneyCheckDollar,
                              //     size: 40,
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: 50,
                              // ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('arr_interest_rate')}',
                                        style: theme.titleSmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${FormatConvert.formatCurrencyUSD(interestRate ?? 0)} $currency',
                                          style: theme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('panaty')}',
                                        style: theme.titleSmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${FormatConvert.formatCurrencyNew(penalty!)} $currency',
                                          style: theme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('principal')}',
                                        style: theme.titleSmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${FormatConvert.formatCurrencyNew(principal!)} $currency',
                                          style: theme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('mainten_fee')}',
                                        style: theme.titleSmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${FormatConvert.formatCurrencyNew(maintenanceFee!)} $currency',
                                          style: theme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('loan_amt')}',
                                        style: theme.titleSmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${FormatConvert.formatCurrencyNew(loanAmount!)} $currency',
                                          style: theme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('loan_period')}',
                                        style: theme.titleSmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${FormatDate.formatDigit(loanPeriod ?? 0)} ${AppLocalizations.of(context)!.translate('month')}',
                                          style: theme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ////row 1
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('customer_name')}',
                                        style: theme.titleSmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('${customerName}',
                                          style: theme.titleMedium!.copyWith(
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  ////row 2
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('phone_no')}',
                                        style: theme.titleSmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('${phoneNo}',
                                          style: theme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ////row 3

                                  ////row 4
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('repay_date')}',
                                        style: theme.titleSmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${FormatDate.investmentDate('$repaymentDate')}',
                                          style: theme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ), ///////////////
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.translate('address')}',
                                  style: theme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  // width: 200,
                                  child: Text('$address',
                                      maxLines: 4,
                                      style: theme.titleMedium!.copyWith(
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArrearFollowUpNew(
                    loanId: loanId,
                    village: village,
                    commune: commune,
                    district: district,
                    province: province,
                    customerCodes: customerCodes,
                    customerNames: customerName,
                    loanNumber: loanNumber,
                    loanAmount: loanAmount,
                    overdueDay: overDueDays,
                    coName: coName,
                    coId: coId,
                    brancCode: brancCode,
                    brancName: branName,
                    repaymentDate: repaymentDate,
                    loanPeriod: loanPeriod,
                    createdDate: currentDate.toString(),
                    createdBy: createdBy,
                    overdueAmt: overdueAmt,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.logoDarkBlue),
              child: Center(
                child: Text(
                  '${AppLocalizations.of(context)!.translate('arr_loan_follow_up')}',
                  style: theme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
