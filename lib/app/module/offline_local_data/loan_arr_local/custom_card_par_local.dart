import 'package:chokchey_finance/app/module/loan_arrear/controllers/loan_arrear_controller.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../localizations/appLocalizations.dart';
import '../../../utils/helpers/activity_log.dart';
import '../../../utils/helpers/format_convert.dart';
import '../../../utils/helpers/sqlite_helper.dart';
import '../../loan_arrear/screens/loan_arrear_screen.dart';
import 'loan_arrear_list_local.dart';

class CustomCardParLocal extends StatefulWidget {
  final String? userId;
  CustomCardParLocal({super.key, this.userId});

  @override
  State<CustomCardParLocal> createState() => _CustomCardParLocalState();
}

class _CustomCardParLocalState extends State<CustomCardParLocal> {
  List<dynamic> arrearlist = [];
  SqliteHelper? sqliteHelper;
  Future<void> getData() async {
    setState(() {
      Future.delayed(Duration(seconds: 1), () async {
        arrearlist =
            await sqliteHelper!.queryData(sql: "Select * from HomeParArrear");
      });
    });
  }

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

  onGetParDetail() async {
    Future.delayed(Duration(seconds: 1), () async {
      await sqliteHelper!.queryData(sql: 'Select * from ParArrearDetail');
    });
  }

  final controller = Get.put(LoanArrearController());
  @override
  void initState() {
    sqliteHelper = SqliteHelper();
    // getData();

    setState(() {
      controller.onGetHomePar();
    });

    debugPrint('accc:${controller.acc1.value}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
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
                Text(
                  'Arrear',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: logoDarkBlue,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onGetParDetail().then((e) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoanArrearListLocal()),
                      );
                      onActivityLogDevice(
                          userId: '${widget.userId}',
                          description: 'Loan Arrear');
                    });
                  },
                  child: Container(
                    height: 30,
                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 5,
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
            SizedBox(height: 6),
            // Obx(
            // () => controller.isLoadingFilterNew.value
            // Column(
            //     children: [
            //       CustomShimmer(),
            //       CustomShimmer(),
            //       CustomShimmer(),
            //       CustomShimmer(),
            //     ],
            //   )
            // :
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                // 1: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(1.2),
                3: FlexColumnWidth(1.5),
                // 3: FlexColumnWidth(),
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
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoanArrearScreens(
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
                                  builder: (context) => LoanArrearScreens(
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
                                  builder: (context) => LoanArrearScreens(
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
                      height: 90,
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          onValueTitle('',
                              '${FormatConvert.formatCurrency(controller.radio1.value)}'),
                          onValueTitle('',
                              '${FormatConvert.formatCurrency(controller.radio14.value)}'),
                          onValueTitle('',
                              '${FormatConvert.formatCurrency(controller.radio30.value)}')
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                    child: SizedBox(
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          onValueRowPar("",
                              '${controller.acc1.value == 0 ? 0 : FormatConvert.formatdigit(controller.acc1.value)}'),
                          onValueRowPar("",
                              '${controller.acc14.value == 0 ? 0 : FormatConvert.formatdigit(controller.acc14.value)}'),
                          onValueRowPar("",
                              '${controller.acc30.value == 0 ? 0 : FormatConvert.formatdigit(controller.acc30.value)}')
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                      child: SizedBox(
                          height: 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              onValueRowPar("",
                                  '${FormatConvert.formatCurrencyUSD(controller.amt1.value)}'),
                              onValueRowPar("",
                                  '${FormatConvert.formatCurrencyUSD(controller.amt14.value)}'),
                              onValueRowPar("",
                                  '${FormatConvert.formatCurrencyUSD(controller.amt30.value)}')
                            ],
                          ))),
                ]),
                TableRow(children: [
                  TableCell(
                    child: SizedBox(
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoanArrearScreens(
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
                                  builder: (context) => LoanArrearScreens(
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
                      height: 60,
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          onValueTitle('',
                              '${FormatConvert.formatCurrency(controller.radio60.value)}'),
                          onValueTitle('',
                              '${FormatConvert.formatCurrency(controller.radio90.value)}'),
                          // onValueTitle('',
                          //     '${FormatConvert.formatCurrency(controller.ratioPar30.value)}')
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                      child: SizedBox(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        onValueRowPar("",
                            '${controller.acc60.value == 0 ? 0 : FormatConvert.formatdigit(controller.acc60.value)}'),
                        onValueRowPar("",
                            '${controller.acc90.value == 0 ? 0 : FormatConvert.formatdigit(controller.acc90.value)}'),
                      ],
                    ),
                  )),
                  TableCell(
                    child: SizedBox(
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          onValueRowPar("",
                              '${FormatConvert.formatCurrencyUSD(controller.amt60.value)}'),
                          onValueRowPar("",
                              '${FormatConvert.formatCurrencyUSD(controller.amt90.value)}'),
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
                        child: onValueTitle('',
                            '${controller.totalAmt.value == 0 ? 0 : FormatConvert.formatdigit(controller.totalAcc.value)}'),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        height: 30,
                        alignment: Alignment.centerRight,
                        child: onValueTitle('',
                            '${FormatConvert.formatCurrencyUSD(controller.totalAmt.value)}'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '* Select on par number to go to par arrear detail',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
    //////////////////////////
    // Container(
    //   margin: EdgeInsets.all(8),
    //   padding: const EdgeInsets.all(10),
    //   decoration: BoxDecoration(
    //     border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(20),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey.withOpacity(0.1),
    //         blurRadius: 1.0,
    //         spreadRadius: 1.0,
    //         offset: Offset(0, 0),
    //       )
    //     ],
    //   ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           GestureDetector(
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(builder: (context) => LocalDataScreen()
    //                     // PdfScreen(),
    //                     ),
    //               );
    //             },
    //             child: Text(
    //               'Arrear',
    //               style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.w800,
    //                 color: logoDarkBlue,
    //               ),
    //             ),
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => LoanArrearScreens()),
    //               );
    //               onActivityLogDevice(
    //                   userId: '${widget.userId}', description: 'Loan Arrear');
    //             },
    //             child: Container(
    //               height: 30,
    //               padding: EdgeInsets.only(top: 3, bottom: 3),
    //               margin: EdgeInsets.only(
    //                 top: 10,
    //                 bottom: 5,
    //               ),
    //               decoration: BoxDecoration(
    //                   color: logoDarkBlue,
    //                   borderRadius: BorderRadius.circular(10)),
    //               // height: 30,
    //               width: 130,
    //               child: Center(
    //                 child: Text(
    //                   "${AppLocalizations.of(context)!.translate('arrear_list')}",
    //                   style: TextStyle(
    //                       fontSize: 14,
    //                       fontWeight: FontWeight.w600,
    //                       color: Colors.white),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       SizedBox(height: 6),
    //       Obx(
    //         () => controller.isLoadingFilterNew.value
    //             ? Column(
    //                 children: [
    //                   CustomShimmer(),
    //                   CustomShimmer(),
    //                   CustomShimmer(),
    //                   CustomShimmer(),
    //                 ],
    //               )
    //             : Table(
    //                 columnWidths: const <int, TableColumnWidth>{
    //                   0: FlexColumnWidth(),
    //                   // 1: IntrinsicColumnWidth(),
    //                   1: FlexColumnWidth(),
    //                   2: FlexColumnWidth(1.2),
    //                   3: FlexColumnWidth(1.5),
    //                   // 3: FlexColumnWidth(),
    //                 },
    //                 border: TableBorder.all(
    //                     width: 1,
    //                     color: logoDarkBlue,
    //                     borderRadius: BorderRadius.circular(10)),
    //                 //table border
    //                 children: [
    //                   TableRow(children: [
    //                     TableCell(
    //                       child: Container(
    //                         height: 30,
    //                         alignment: Alignment.centerRight,
    //                         child: onValueTitle('PAR', ''),
    //                       ),
    //                     ),
    //                     TableCell(
    //                       child: Container(
    //                         height: 30,
    //                         alignment: Alignment.centerRight,
    //                         child: onValueTitle('', '%'),
    //                       ),
    //                     ),
    //                     TableCell(
    //                       child: Container(
    //                         height: 30,
    //                         alignment: Alignment.centerRight,
    //                         child: onValueTitle('',
    //                             '# ${AppLocalizations.of(context)!.translate('accounts')}'),
    //                       ),
    //                     ),
    //                     TableCell(
    //                       child: Container(
    //                         height: 30,
    //                         alignment: Alignment.centerRight,
    //                         child: onValueTitle('',
    //                             '${AppLocalizations.of(context)!.translate('amount')}'),
    //                       ),
    //                     ),
    //                   ]),
    //                   TableRow(children: [
    //                     TableCell(
    //                       child: SizedBox(
    //                         height: 90,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                           children: [
    //                             GestureDetector(
    //                               onTap: () {
    //                                 Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                     builder: (context) => LoanArrearScreens(
    //                                       isFromPar: true,
    //                                       indexOfpage: 1,
    //                                     ),
    //                                   ),
    //                                 );
    //                               },
    //                               child: onValueRowPar("PAR>1", ''),
    //                             ),
    //                             GestureDetector(
    //                               onTap: () {
    //                                 Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                     builder: (context) => LoanArrearScreens(
    //                                       isFromPar: true,
    //                                       indexOfpage: 2,
    //                                     ),
    //                                   ),
    //                                 );
    //                               },
    //                               child: onValueRowPar("PAR>14", ''),
    //                             ),
    //                             GestureDetector(
    //                               onTap: () {
    //                                 Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                     builder: (context) => LoanArrearScreens(
    //                                       isFromPar: true,
    //                                       indexOfpage: 3,
    //                                     ),
    //                                   ),
    //                                 );
    //                               },
    //                               child: onValueRowPar("PAR>30", ''),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     TableCell(
    //                       child: Container(
    //                         height: 90,
    //                         alignment: Alignment.centerRight,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                           children: [
    //                             onValueTitle('',
    //                                 '${FormatConvert.formatCurrency(arrearlist[0]['parRatio1'])}'),
    //                             onValueTitle('',
    //                                 '${FormatConvert.formatCurrency(arrearlist[0]['parRatio14'])}'),
    //                             onValueTitle('',
    //                                 '${FormatConvert.formatCurrency(arrearlist[0]['parRatio30'])}')
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     TableCell(
    //                       child: SizedBox(
    //                         height: 90,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                           children: [
    //                             onValueRowPar("",
    //                                 '${arrearlist.isEmpty ? 0 : FormatConvert.formatdigit(arrearlist[0]['parAcc1'])}'),
    //                             onValueRowPar("",
    //                                 '${arrearlist.isEmpty ? 0 : FormatConvert.formatdigit(arrearlist[0]['parAcc14'])}'),
    //                             onValueRowPar("",
    //                                 '${arrearlist.isEmpty ? 0 : FormatConvert.formatdigit(arrearlist[0]['parAcc30'])}')
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     TableCell(
    //                         child: SizedBox(
    //                             height: 90,
    //                             child: Column(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceAround,
    //                               children: [
    //                                 onValueRowPar("",
    //                                     '${FormatConvert.formatCurrencyUSD(arrearlist[0]['parAmt1'])}'),
    //                                 onValueRowPar("",
    //                                     '${FormatConvert.formatCurrencyUSD(arrearlist[0]['parAmt14'])}'),
    //                                 onValueRowPar("",
    //                                     '${FormatConvert.formatCurrencyUSD(arrearlist[0]['parAmt30'])}')
    //                               ],
    //                             ))),
    //                   ]),
    //                   TableRow(children: [
    //                     TableCell(
    //                       child: SizedBox(
    //                         height: 60,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                           children: [
    //                             GestureDetector(
    //                               onTap: () {
    //                                 Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                     builder: (context) => LoanArrearScreens(
    //                                       isFromPar: true,
    //                                       indexOfpage: 4,
    //                                     ),
    //                                   ),
    //                                 );
    //                               },
    //                               child: onValueRowPar("PAR>60", ''),
    //                             ),
    //                             GestureDetector(
    //                               onTap: () {
    //                                 Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                     builder: (context) => LoanArrearScreens(
    //                                       isFromPar: true,
    //                                       indexOfpage: 5,
    //                                     ),
    //                                   ),
    //                                 );
    //                               },
    //                               child: onValueRowPar("PAR>90", ''),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     TableCell(
    //                       child: Container(
    //                         height: 60,
    //                         alignment: Alignment.centerRight,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                           children: [
    //                             onValueTitle('',
    //                                 '${FormatConvert.formatCurrency(arrearlist[0]['parRatio60'])}'),
    //                             onValueTitle('',
    //                                 '${FormatConvert.formatCurrency(arrearlist[0]['parRatio90'])}'),
    //                             // onValueTitle('',
    //                             //     '${FormatConvert.formatCurrency(controller.ratioPar30.value)}')
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     TableCell(
    //                         child: SizedBox(
    //                       height: 60,
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                         children: [
    //                           onValueRowPar("",
    //                               '${controller.modelNew.value.arrear60Days == null ? 0 : FormatConvert.formatdigit(arrearlist[0]['parAcc60'])}'),
    //                           onValueRowPar("",
    //                               '${controller.modelNew.value.arrear90Days == null ? 0 : FormatConvert.formatdigit(arrearlist[0]['parAcc90'])}'),
    //                         ],
    //                       ),
    //                     )),
    //                     TableCell(
    //                       child: SizedBox(
    //                         height: 60,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                           children: [
    //                             onValueRowPar("",
    //                                 '${FormatConvert.formatCurrencyUSD(arrearlist[0]['parAmt60'])}'),
    //                             onValueRowPar("",
    //                                 '${FormatConvert.formatCurrencyUSD(arrearlist[0]['parAmt90'])}'),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ]),
    //                   TableRow(
    //                     children: [
    //                       TableCell(
    //                         child: Container(
    //                           height: 30,
    //                           alignment: Alignment.centerRight,
    //                           child: onValueTitle('', 'Total'),
    //                         ),
    //                       ),
    //                       TableCell(
    //                         child: Container(
    //                           height: 30,
    //                           alignment: Alignment.centerRight,
    //                           child: onValueTitle('', ''
    //                               // '${FormatConvert.formatCurrency(controller.totalRaio.value)}'
    //                               ),
    //                         ),
    //                       ),
    //                       TableCell(
    //                         child: Container(
    //                           height: 30,
    //                           alignment: Alignment.centerRight,
    //                           child: onValueTitle('',
    //                               '${controller.modelNew.value.allArrear == null ? 0 : FormatConvert.formatdigit(arrearlist[0]['totalParAcc'])}'),
    //                         ),
    //                       ),
    //                       TableCell(
    //                         child: Container(
    //                           height: 30,
    //                           alignment: Alignment.centerRight,
    //                           child: onValueTitle('',
    //                               '${FormatConvert.formatCurrencyUSD(arrearlist[0]['totalParAmt'])}'),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(top: 10),
    //         child: Text(
    //           '* Select on par number to go to par arrear detail',
    //           style: Theme.of(context)
    //               .textTheme
    //               .titleMedium!
    //               .copyWith(fontSize: 13, fontWeight: FontWeight.w700),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
