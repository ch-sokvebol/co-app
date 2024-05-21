import 'package:chokchey_finance/app/module/loan_arrear/controllers/loan_arrear_controller.dart';
import 'package:chokchey_finance/app/module/loan_arrear/models/par_arr_home_model.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../localizations/appLocalizations.dart';
import '../../../utils/helpers/activity_log.dart';
import '../../../utils/helpers/format_convert.dart';
import '../../loan_arrear/screens/loan_arrear_screen.dart';
import 'custom_defulf_arrear.dart';

class CustomCardParNew extends StatefulWidget {
  final ParArrHomeModel parArrHomeModel;
  final String? userId;
  final GestureTapCallback? onNavigat;

  CustomCardParNew(
      {super.key, this.userId, this.onNavigat, required this.parArrHomeModel});

  @override
  State<CustomCardParNew> createState() => _CustomCardParNewState();
}

class _CustomCardParNewState extends State<CustomCardParNew> {
  onValueRowPar(String? par, String? ratio) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$par",
              style: TextStyle(
                fontSize: 14,
                color: logoDarkBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "$ratio",
              style: TextStyle(
                fontSize: 14,
                color: logoDarkBlue,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  onValueTitle(String? par, String? ratio) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$par",
            style: TextStyle(
              fontSize: 14,
              color: logoDarkBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "$ratio",
            style: TextStyle(
              fontSize: 14,
              color: logoDarkBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  final controller = Get.put(LoanArrearController());

  String formattedDate = '';

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    formattedDate = DateFormat('dd-MMM-yyyy').format(yesterday);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoadingParArrHome.value
          ? CustomDefulfArrear()
          : Container(
              margin: EdgeInsets.all(8),
              //  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: widget.onNavigat,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            'Arrears',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: logoDarkBlue,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoanArrearScreens()),
                          );
                          onActivityLogDevice(
                              userId: '${widget.userId}',
                              description: 'Loan Arrears');
                        },
                        child: Container(
                          height: 30,
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 5,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                              color: logoDarkBlue,
                              borderRadius: BorderRadius.circular(10)),
                          // height: 30,
                          width: 130,
                          child: Center(
                            child: Text(
                              "${AppLocalizations.of(context)!.translate('arrear_list')}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "As of date: $formattedDate",
                      style:
                          TextStyle(color: logoPink, fontWeight: fontWeight500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(1.2),
                        3: FlexColumnWidth(1.5),
                      },
                      border: TableBorder.all(
                          width: 1,
                          color: logoDarkBlue,
                          borderRadius: BorderRadius.circular(10)),
                      //table border
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Container(
                              height: 30,
                              alignment: Alignment.centerRight,
                              child: onValueTitle('PAR', ''),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 30,
                              alignment: Alignment.centerRight,
                              child: onValueTitle('', '%'),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 30,
                              alignment: Alignment.centerRight,
                              child: onValueTitle('',
                                  '# ${AppLocalizations.of(context)!.translate('accounts')}'),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 30,
                              alignment: Alignment.centerRight,
                              child: onValueTitle('',
                                  '${AppLocalizations.of(context)!.translate('amount')}'),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: SizedBox(
                              height: 75,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LoanArrearScreens(
                                            isFromPar: true,
                                            indexOfpage: 1,
                                          ),
                                        ),
                                      );
                                    },
                                    child: onValueRowPar("PAR>1", ''),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LoanArrearScreens(
                                            isFromPar: true,
                                            indexOfpage: 2,
                                          ),
                                        ),
                                      );
                                    },
                                    child: onValueRowPar("PAR>14", ''),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LoanArrearScreens(
                                            isFromPar: true,
                                            indexOfpage: 3,
                                          ),
                                        ),
                                      );
                                    },
                                    child: onValueRowPar("PAR>30", ''),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 75,
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  onValueTitle('',
                                      '${FormatConvert.formatAmountUSD(widget.parArrHomeModel.percentagePar1 ?? 0)}'),
                                  onValueTitle('',
                                      '${FormatConvert.formatAmountUSD(widget.parArrHomeModel.percentagePar14 ?? 0)}'),
                                  onValueTitle('',
                                      '${FormatConvert.formatAmountUSD(widget.parArrHomeModel.percentagePar30 ?? 0)}')
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 75,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  onValueRowPar("",
                                      '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.accPar1 ?? 0)}'),
                                  onValueRowPar("",
                                      '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.accPar14 ?? 0)}'),
                                  onValueRowPar("",
                                      '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.accPar30 ?? 0)}')
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                              child: SizedBox(
                                  height: 75,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      onValueRowPar("",
                                          '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.amountPar1 ?? 0)}'),
                                      onValueRowPar("",
                                          '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.amountPar14 ?? 0)}'),
                                      onValueRowPar("",
                                          '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.amountPar30 ?? 0)}')
                                    ],
                                  ))),
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: SizedBox(
                              height: 45,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LoanArrearScreens(
                                            isFromPar: true,
                                            indexOfpage: 4,
                                          ),
                                        ),
                                      );
                                    },
                                    child: onValueRowPar("PAR>60", ''),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LoanArrearScreens(
                                            isFromPar: true,
                                            indexOfpage: 5,
                                          ),
                                        ),
                                      );
                                    },
                                    child: onValueRowPar("PAR>90", ''),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 45,
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  onValueTitle('',
                                      '${FormatConvert.formatAmountUSD(widget.parArrHomeModel.percentagePar60 ?? 0)}'),
                                  onValueTitle('',
                                      '${FormatConvert.formatAmountUSD(widget.parArrHomeModel.percentagePar90 ?? 0)}'),
                                  // onValueTitle('',
                                  //     '${FormatConvert.formatCurrency(controller.ratioPar30.value)}')
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                              child: SizedBox(
                            height: 45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                onValueRowPar("",
                                    '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.accPar60 ?? 0)}'),
                                onValueRowPar("",
                                    '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.accPar90 ?? 0)}'),
                              ],
                            ),
                          )),
                          TableCell(
                            child: SizedBox(
                              height: 45,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  onValueRowPar("",
                                      '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.amountPar60 ?? 0)}'),
                                  onValueRowPar("",
                                      '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.amountPar90 ?? 0)}'),
                                ],
                              ),
                            ),
                          ),
                        ]),
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                height: 30,
                                alignment: Alignment.centerRight,
                                child: onValueTitle('', 'Total'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 30,
                                alignment: Alignment.centerRight,
                                child: onValueTitle('', ''
                                    // '${FormatConvert.formatCurrency(controller.totalRaio.value)}'
                                    ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 30,
                                alignment: Alignment.centerRight,
                                child: onValueTitle(
                                  '',
                                  '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.totalAccount ?? 0)}',
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 30,
                                alignment: Alignment.centerRight,
                                child: onValueTitle('',
                                    '${FormatConvert.formatCurrencyUSD(widget.parArrHomeModel.totalAmount ?? 0)}'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '* Select on par number to go to par arrears detail',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
                // ),
              ),
            ),
    );
  }
}
