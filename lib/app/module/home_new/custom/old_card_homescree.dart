  //  Obx(
  //                     () => Container(
  //                       //height: 200,
  //                       padding: EdgeInsets.only(
  //                           left: 8, right: 2, bottom: 8, top: 8),
  //                       // padding: EdgeInsets.all(8),
  //                       width: MediaQuery.of(context).size.width,
  //                       decoration: BoxDecoration(
  //                         color: logolightGreen,
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             AppLocalizations.of(context)!
  //                                     .translate('loan_arrear') ??
  //                                 'Loan Arrears',
  //                             style: TextStyle(
  //                               fontSize: 20,
  //                               color: logoDarkBlue,
  //                               fontWeight: FontWeight.bold,
  //                               decoration: TextDecoration.underline,
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Expanded(
  //                                 child: Padding(
  //                                   padding: EdgeInsets.only(
  //                                       left: 2,
  //                                       right:
  //                                           controllerArrear.isLanguge.value ==
  //                                                   true
  //                                               ? 10
  //                                               : 4),
  //                                   child: Column(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.spaceAround,
  //                                     children: [
  //                                       Text(
  //                                         "PAR",
  //                                         style: TextStyle(
  //                                           fontSize: 20,
  //                                           fontWeight: fontWeight800,
  //                                           color: logoDarkBlue,
  //                                           decoration:
  //                                               TextDecoration.underline,
  //                                         ),
  //                                       ),
  //                                       SizedBox(
  //                                         height: 10,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           Navigator.push(
  //                                             context,
  //                                             MaterialPageRoute(
  //                                               builder: (context) =>
  //                                                   LoanArrearScreens(
  //                                                 isFromPar: true,
  //                                                 indexOfpage: 1,
  //                                               ),
  //                                             ),
  //                                           );
  //                                         },
  //                                         child: Row(
  //                                           children: [
  //                                             Expanded(
  //                                               child: Container(
  //                                                 child: Text(
  //                                                   //  "PAR>14 - ${controllerArrear.listPar1.length}",
  //                                                   "PAR>14 - ${controllerResArrear.listArrear14.length}",
  //                                                   style: TextStyle(
  //                                                     fontSize: 14,
  //                                                     color: logoDarkBlue,
  //                                                     fontWeight:
  //                                                         FontWeight.w500,
  //                                                   ),
  //                                                   overflow:
  //                                                       TextOverflow.ellipsis,
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                             Row(
  //                                               children: [
  //                                                 SvgPicture.asset(
  //                                                   'assets/svg/arrow-small-right.svg',
  //                                                   height: 26,
  //                                                   color: logoDarkBlue,
  //                                                 ),
  //                                                 Text(
  //                                                   "${AppLocalizations.of(context)!.translate('accounts')}",
  //                                                   style: TextStyle(
  //                                                     fontSize: 14,
  //                                                     color: logoDarkBlue,
  //                                                     fontWeight:
  //                                                         FontWeight.w500,
  //                                                     overflow:
  //                                                         TextOverflow.ellipsis,
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       SizedBox(
  //                                         height: 8,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           Navigator.push(
  //                                               context,
  //                                               MaterialPageRoute(
  //                                                   builder: (context) =>
  //                                                       LoanArrearScreens(
  //                                                         isFromPar: true,
  //                                                         indexOfpage: 2,
  //                                                       )));
  //                                         },
  //                                         child: Row(
  //                                           children: [
  //                                             Expanded(
  //                                               child: Container(
  //                                                 child: Text(
  //                                                   //  "PAR>30 - ${controllerArrear.listPar2.length}",
  //                                                   "PAR>30 - ${controllerResArrear.listArrear30.length}",
  //                                                   style: TextStyle(
  //                                                     fontSize: 14,
  //                                                     color: logoDarkBlue,
  //                                                     fontWeight:
  //                                                         FontWeight.w500,
  //                                                     overflow:
  //                                                         TextOverflow.ellipsis,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                             Row(
  //                                               children: [
  //                                                 SvgPicture.asset(
  //                                                   'assets/svg/arrow-small-right.svg',
  //                                                   height: 26,
  //                                                   color: logoDarkBlue,
  //                                                 ),
  //                                                 Text(
  //                                                   "${AppLocalizations.of(context)!.translate('accounts')}",
  //                                                   style: TextStyle(
  //                                                     fontSize: 14,
  //                                                     color: logoDarkBlue,
  //                                                     fontWeight:
  //                                                         FontWeight.w500,
  //                                                     overflow:
  //                                                         TextOverflow.ellipsis,
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       SizedBox(
  //                                         height: 8,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           Navigator.push(
  //                                             context,
  //                                             MaterialPageRoute(
  //                                               builder: (context) =>
  //                                                   LoanArrearScreens(
  //                                                 isFromPar: true,
  //                                                 indexOfpage: 3,
  //                                               ),
  //                                             ),
  //                                           );
  //                                         },
  //                                         child: Row(
  //                                           children: [
  //                                             Expanded(
  //                                               child: Container(
  //                                                 width: 100,
  //                                                 child: Text(
  //                                                   //"PAR>60 - ${controllerArrear.listPar3.length}",
  //                                                   "PAR>60 - ${controllerResArrear.listArrear60.length}",
  //                                                   style: TextStyle(
  //                                                     fontSize: 14,
  //                                                     color: logoDarkBlue,
  //                                                     fontWeight:
  //                                                         FontWeight.w500,
  //                                                     overflow:
  //                                                         TextOverflow.ellipsis,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                             Row(
  //                                               children: [
  //                                                 SvgPicture.asset(
  //                                                   'assets/svg/arrow-small-right.svg',
  //                                                   height: 26,
  //                                                   color: logoDarkBlue,
  //                                                 ),
  //                                                 Text(
  //                                                   "${AppLocalizations.of(context)!.translate('accounts')}",
  //                                                   style: TextStyle(
  //                                                     fontSize: 14,
  //                                                     color: logoDarkBlue,
  //                                                     fontWeight:
  //                                                         FontWeight.w500,
  //                                                     overflow:
  //                                                         TextOverflow.ellipsis,
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       SizedBox(
  //                                         height: 8,
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           Navigator.push(
  //                                             context,
  //                                             MaterialPageRoute(
  //                                               builder: (context) =>
  //                                                   LoanArrearScreens(
  //                                                 isFromPar: true,
  //                                                 indexOfpage: 4,
  //                                               ),
  //                                             ),
  //                                           );
  //                                         },
  //                                         child: Row(
  //                                           children: [
  //                                             Expanded(
  //                                               child: Container(
  //                                                 child: Text(
  //                                                   // "PAR>90 - ${controllerArrear.listPar4.length}",
  //                                                   "PAR>90 - ${controllerResArrear.listArrear90.length}",
  //                                                   style: TextStyle(
  //                                                     fontSize: 14,
  //                                                     color: logoDarkBlue,
  //                                                     fontWeight:
  //                                                         FontWeight.w500,
  //                                                     overflow:
  //                                                         TextOverflow.ellipsis,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                             Row(
  //                                               children: [
  //                                                 SvgPicture.asset(
  //                                                   'assets/svg/arrow-small-right.svg',
  //                                                   height: 26,
  //                                                   color: logoDarkBlue,
  //                                                 ),
  //                                                 Text(
  //                                                   "${AppLocalizations.of(context)!.translate('accounts')}",
  //                                                   style: TextStyle(
  //                                                     fontSize: 14,
  //                                                     color: logoDarkBlue,
  //                                                     fontWeight:
  //                                                         FontWeight.w500,
  //                                                     overflow:
  //                                                         TextOverflow.ellipsis,
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                               Container(
  //                                 margin: EdgeInsets.only(right: 8, left: 0),
  //                                 height:
  //                                     controllerArrear.isLanguge.value == true
  //                                         ? hightLineKH
  //                                         : hightLine,
  //                                 width: 1.4,
  //                                 color: logoDarkBlue,
  //                               ),
  //                               Expanded(
  //                                 child: Column(
  //                                   children: [
  //                                     Text(
  //                                       '${AppLocalizations.of(context)!.translate('total')}',
  //                                       // "Total",
  //                                       style: TextStyle(
  //                                         fontSize: 20,
  //                                         fontWeight: fontWeight800,
  //                                         color: logoDarkBlue,
  //                                         decoration: TextDecoration.underline,
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 15,
  //                                     ),
  //                                     Row(
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.start,
  //                                       children: [
  //                                         Container(
  //                                           width: 70,
  //                                           child: Text(
  //                                             // 'Amount: USD $amount',
  //                                             "${AppLocalizations.of(context)!.translate('amount')}",
  //                                             style: TextStyle(
  //                                               fontSize: 14,
  //                                               color: logoDarkBlue,
  //                                               fontWeight: FontWeight.w600,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         Expanded(
  //                                           child: Text(
  //                                             " : \$${FormatConvert.formatCurrency(controllerResArrear.totalUSD.value)}",
  //                                             style: TextStyle(
  //                                                 fontSize: 14,
  //                                                 color: logoDarkBlue,
  //                                                 fontWeight: FontWeight.w600,
  //                                                 overflow: TextOverflow.clip),
  //                                             textAlign: TextAlign.start,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     SizedBox(
  //                                       height: 8,
  //                                     ),
  //                                     Row(
  //                                       children: [
  //                                         Container(
  //                                           width: 70,
  //                                           child: Text(
  //                                             "${AppLocalizations.of(context)!.translate('accounts')}",
  //                                             style: TextStyle(
  //                                               fontSize: 14,
  //                                               color: logoDarkBlue,
  //                                               fontWeight: FontWeight.w600,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         Container(
  //                                           width: 100,
  //                                           child: Text(
  //                                             " : ${controllerResArrear.listArrear0.length}",
  //                                             style: TextStyle(
  //                                                 fontSize: 14,
  //                                                 color: logoDarkBlue,
  //                                                 fontWeight: FontWeight.w500,
  //                                                 overflow:
  //                                                     TextOverflow.ellipsis),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     GestureDetector(
  //                                       onTap: () {
  //                                         Navigator.push(
  //                                           context,
  //                                           MaterialPageRoute(
  //                                               builder: (context) =>
  //                                                   LoanArrearScreens()),
  //                                         );
  //                                       },
  //                                       child: Container(
  //                                         alignment: Alignment.center,
  //                                         padding: EdgeInsets.only(
  //                                             top: 3, bottom: 3),
  //                                         margin: EdgeInsets.only(
  //                                           top: 10,
  //                                           left: 30,
  //                                           right: 5,
  //                                         ),
  //                                         decoration: BoxDecoration(
  //                                             color: logoDarkBlue,
  //                                             borderRadius:
  //                                                 BorderRadius.circular(10)),
  //                                         // height: 30,
  //                                         width: 130,
  //                                         child: Center(
  //                                           child: Row(
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.center,
  //                                             mainAxisAlignment:
  //                                                 MainAxisAlignment.center,
  //                                             children: [
  //                                               SizedBox(
  //                                                 width: 3,
  //                                               ),
  //                                               Text(
  //                                                 "${AppLocalizations.of(context)!.translate('arrear_list')}",
  //                                                 style: TextStyle(
  //                                                     fontSize: 14,
  //                                                     fontWeight:
  //                                                         FontWeight.w600,
  //                                                     color: Colors.white),
  //                                               ),
  //                                               SvgPicture.asset(
  //                                                 'assets/svg/arrow-small-right.svg',
  //                                                 height: 28,
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),