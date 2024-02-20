// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../localizations/appLocalizations.dart';
import '../../../utils/helpers/format_convert.dart';
import '../../loan_arrear/screens/loan_arrear_screen.dart';
import '../controller/res_arrear_controller.dart';
import 'custom_shimmer.dart';

class CustomCardPar extends StatelessWidget {
  CustomCardPar({super.key});

  double? sizeFont;
  double? dataTableHight;
  onTitle({String? title}) {
    return Text(
      "$title",
      style: TextStyle(
        fontSize: 17,
        color: logoDarkBlue,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  onValue({String? value}) {
    return Padding(
      padding: EdgeInsets.only(
        top: 4,
        bottom: 6,
      ),
      child: Text(
        "$value",
        style: TextStyle(
          fontSize: 14,
          // 25,
          color: logoDarkBlue,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  onValueToal({
    String? value,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 6),
      child: Text(
        "$value",
        style: TextStyle(
          fontSize: 15,
          color: logoDarkBlue,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  final controller = Get.put(ResArrearController());

  @override
  Widget build(BuildContext context) {
    double witdths = MediaQuery.of(context).size.width;

    return Obx(
      () => Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.35,
            height: 290,
            padding: EdgeInsets.all(10),
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
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    "Arrear",
                    style: TextStyle(
                      fontSize: 20,
                      color: logoDarkBlue,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 4,
                // ),
                controller.isLoading.value
                    ? Column(
                        children: [
                          CustomShimmer(),
                          CustomShimmer(),
                          CustomShimmer(),
                          CustomShimmer(),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                onTitle(title: "PAR"),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoanArrearScreens(
                                                    isFromPar: true,
                                                    indexOfpage: 1,
                                                  )));
                                    },
                                    child: onValue(value: "PAR>1")),
                                onValue(value: "PAR>14"),
                                onValue(value: "PAR>30"),
                                onValue(value: "PAR>60"),
                                onValue(value: "PAR>90"),
                                onValueToal(value: ""),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                onTitle(title: "%"),
                                onValue(
                                    value:
                                        "${FormatConvert.formatCurrency(controller.ratio1.value)}%"),
                                onValue(
                                    value:
                                        "${FormatConvert.formatCurrency(controller.ratio14.value)}%"),
                                onValue(
                                    value:
                                        "${FormatConvert.formatCurrency(controller.ratio30.value)}%"),
                                onValue(
                                    value:
                                        "${FormatConvert.formatCurrency(controller.ratio60.value)}%"),
                                onValue(
                                    value:
                                        "${FormatConvert.formatCurrency(controller.ratio90.value)}%"),
                                onValueToal(value: "Total"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                onTitle(title: "Account"),
                                onValue(
                                    value: "${controller.listArrear1.length}"),
                                onValue(
                                    value: "${controller.listArrear14.length}"),
                                onValue(
                                    value: "${controller.listArrear30.length}"),
                                onValue(
                                    value: "${controller.listArrear60.length}"),
                                onValue(
                                    value: "${controller.listArrear90.length}"),
                                onValueToal(
                                    value: "${controller.listArrear0.length}"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                onTitle(title: "Amount"),
                                onValue(
                                    value:
                                        "${FormatConvert.formatCurrencyUSD(controller.amount1.value)}"),
                                onValue(
                                    value:
                                        "${FormatConvert.formatCurrencyUSD(controller.amount14.value)}"),
                                onValue(
                                    value:
                                        "${FormatConvert.formatCurrencyUSD(controller.amount30.value)}"),
                                onValue(
                                    value:
                                        "${FormatConvert.formatCurrencyUSD(controller.amount60.value)}"),
                                onValue(
                                    value:
                                        "${FormatConvert.formatCurrencyUSD(controller.amount90.value)}"),
                                onValueToal(
                                    value:
                                        "\$${FormatConvert.formatCurrencyUSD(controller.amount0.value)}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                // Divider(
                //   thickness: 1,
                //   color: logoDarkBlue,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoanArrearScreens()),
                        );
                      },
                      child: Container(
                        height: 30,
                        padding: EdgeInsets.only(top: 3, bottom: 3),
                        margin: EdgeInsets.only(
                          top: 10,
                          right: 20,
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
              ],
            ),
          ),
          controller.isLoading.value
              ? SizedBox()
              : Positioned(
                  top: 65,
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.25,
                  bottom: Platform.isIOS ? 55 : 65,
                  child: VerticalDivider(
                    thickness: 1.4,
                    color: logoDarkBlue,
                  ),
                ),
          controller.isLoading.value
              ? SizedBox()
              : Positioned(
                  top: 65,
                  left: MediaQuery.of(context).size.width * 0.45,
                  right: MediaQuery.of(context).size.width * 0.0,
                  bottom: Platform.isIOS ? 55 : 65,
                  child: VerticalDivider(
                    thickness: 1.4,
                    color: logoDarkBlue,
                  ),
                ),
          controller.isLoading.value
              ? SizedBox()
              : Positioned(
                  top: 65,
                  left: 7,
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    width: witdths > 500
                        ? MediaQuery.of(context).size.width * 0.965
                        : MediaQuery.of(context).size.width * 0.928,
                    height: Platform.isIOS ? 170 : 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: logoDarkBlue,
                      ),
                    ),
                  ),
                ),
          controller.isLoading.value
              ? SizedBox()
              : Positioned(
                  top: Platform.isIOS ? 135 : 132,
                  left: 8,
                  right: 8,
                  child: Divider(
                    color: logoDarkBlue,
                    thickness: 1,
                  ),
                ),
          controller.isLoading.value
              ? SizedBox()
              : Positioned(
                  top: Platform.isIOS ? 192 : 186,
                  left: 8,
                  right: 8,
                  child: Divider(
                    color: logoDarkBlue,
                    thickness: 1,
                  ),
                )
        ],
      ),
    );
  }
}
