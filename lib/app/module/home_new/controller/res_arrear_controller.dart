import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/loan_arrear_body_model.dart';
import '../model/loan_arrear_model_new.dart';
import '../model/loan_arrear_respone_model.dart';
import '../restrofit/restrofit_arrear.dart';

class ResArrearController extends GetxController {
  final ApiServiceArrear apiService = ApiServiceArrear(Dio());
  final listArrear = [].obs;
  final list = <LoanAreaResponseModel>[].obs;
  final isLoading = false.obs;
  final listArrear0 = [].obs;
  final listArrear1 = [].obs;
  final listArrear14 = [].obs;
  final listArrear30 = [].obs;
  final listArrear60 = [].obs;
  final listArrear90 = [].obs;
  //
  final amount0 = 0.0.obs;
  final amount1 = 0.0.obs;
  final amount14 = 0.0.obs;
  final amount30 = 0.0.obs;
  final amount60 = 0.0.obs;
  final amount90 = 0.0.obs;
  //
  final ratio0 = 0.0.obs;
  final ratio1 = 0.0.obs;
  final ratio14 = 0.0.obs;
  final ratio30 = 0.0.obs;
  final ratio60 = 0.0.obs;
  final ratio90 = 0.0.obs;
  final totalRaio = 0.0.obs;

  //
  final totalOverdayUSD = 0.0.obs;
  final totalOverdayKHM = 0.0.obs;
  final loanBalanceUSD = 0.0.obs;
  final loanBalanceKHM = 0.0.obs;
  final totalBalance = 0.0.obs;
  final amount = [];
  // final modelArrear = LoanAreaResponseModel().obs;
  final totalUSD = 0.0.obs;
  final ratio = 0.0.obs;
  //final modelListArrear = LoanArrearLisModel().obs;
  final modelNew = LoanArrearModelNew().obs;
  final listAllArrear = [].obs;
  // Arrears All
  final totalAmountAll = 0.0.obs;
  final totalUSDAll = 0.0.obs;
  final totalKHMAll = 0.0.obs;
  // Arrears 1
  final totalAmount1 = 0.0.obs;
  final totalUSD1 = 0.0.obs;
  final totalKHM1 = 0.0.obs;
  // Arrears 2
  final totalAmount2 = 0.0.obs;
  final totalUSD2 = 0.0.obs;
  final totalKHM2 = 0.0.obs;
  // Arrears 3
  final totalAmount3 = 0.0.obs;
  final totalUSD3 = 0.0.obs;
  final totalKHM3 = 0.0.obs;
  // Arrears 4
  final totalAmount4 = 0.0.obs;
  final totalUSD4 = 0.0.obs;
  final totalKHM4 = 0.0.obs;
  // Arrears 5
  final totalAmount5 = 0.0.obs;
  final totalUSD5 = 0.0.obs;
  final totalKHM5 = 0.0.obs;

  // ratio
  final ratioParAll = 0.0.obs;
  final ratioPar1 = 0.0.obs;
  final ratioPar14 = 0.0.obs;
  final ratioPar30 = 0.0.obs;
  final ratioPar60 = 0.0.obs;
  final ratioPar90 = 0.0.obs;
  clearData() {
    ratioParAll.value = 0.0;
    ratioPar1.value = 0.0;
    ratioPar14.value = 0.0;
    ratioPar30.value = 0.0;
    ratioPar60.value = 0.0;
    ratioPar90.value = 0.0;
    //
    totalAmount1.value = 0;
    totalAmount2.value = 0;
    totalAmount3.value = 0;
    totalAmount4.value = 0;
    totalAmount5.value = 0;
    totalAmountAll.value = 0;
    //----->

    totalUSDAll.value = 0;
    totalKHMAll.value = 0;
    totalUSD1.value = 0;
    totalKHM1.value = 0;
    totalUSD2.value = 0;
    totalKHM2.value = 0;
    totalUSD3.value = 0;
    totalKHM3.value = 0;
    totalUSD4.value = 0;
    totalKHM4.value = 0;
    totalUSD5.value = 0;
    totalKHM5.value = 0;
    //
    modelNew.value.allArrear = null;
    modelNew.value.arrear14Days = null;
    modelNew.value.arrear1Day = null;
    modelNew.value.arrear30Days = null;
    modelNew.value.arrear60Days = null;
    modelNew.value.arrear90Days = null;
  }

  Future<LoanArrearModelNew> getListPAR({
    String? BranchCode,
    String? EmployeeCode,
    String? BaseDate,
    double? OverDueDay,
  }) async {
    isLoading.value = true;
    final url = Uri.parse('http://45.115.209.191:2020/api/LoanArrearCopy/arr');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = json.encode({
      'BranchCode': BranchCode,
      'EmployeeCode': EmployeeCode,
      'BaseDate': BaseDate,
      'OverDueDay': OverDueDay,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        clearData();
        final responeData = jsonDecode(response.body);
        modelNew.value = LoanArrearModelNew.fromJson(responeData);

        Future.delayed(Duration(seconds: 1), () {
          parAll();
          isLoading.value = false;
        });

        update();
        return modelNew.value;
      } else {
        return modelNew.value;
      }
    } catch (e) {
      debugPrint('statues code error ====> $e ');
    }
    return modelNew.value;
  }

  Future<List<LoanAreaResponseModel>> searchArrear(
      LoanArreaBodyModel areaBody) async {
    isLoading(true);
    try {
      final jsonBody = areaBody.toJson();
      final response = await apiService.searchArea(jsonBody);
      listArrear.value = response;
      Future.delayed(Duration(seconds: 2), () {
        isLoading(false);
      });
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return Future.value([]);
    }
  }

  Future<List<LoanAreaResponseModel>> totalArrear(
      LoanArreaBodyModel areaBody) async {
    isLoading(true);
    try {
      final jsonBody = areaBody.toJson();
      final response = await apiService.searchArea(jsonBody);
      listArrear.value = response;
      totalOverdayUSD.value = 0.0;
      list.value = response;
      totalOverdayKHM.value = 0.0;

      list.forEach(
        (e) {
          if (e.currencyCode == "USD") {
            totalOverdayUSD.value += e.totalAmount1!;
          } else {
            totalOverdayKHM.value += e.totalAmount1!;
          }
        },
      );

      list.forEach(
        (e) {
          if (e.currencyCode == "USD") {
            loanBalanceUSD.value += e.loanBalance!;
          } else {
            loanBalanceKHM.value += e.loanBalance!;
          }
        },
      );

      var balance = loanBalanceKHM.value / 4100;
      totalBalance.value = loanBalanceUSD.value + balance;
      var amount = totalOverdayKHM.value / 4100;
      totalUSD.value = totalOverdayUSD.value + amount;
      ratio.value = totalUSD.value * 100 / totalBalance.value;
      // debugPrint("---->>>>> ${ratio.value}");

      update();
      Future.delayed(Duration(seconds: 2), () {
        isLoading(false);
      });
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return Future.value([]);
    }
  }

  parAll() {
    modelNew.value.allArrear!.forEach(
      (e) {
        if (e.currencyCode == "USD") {
          totalUSDAll.value += e.totalAmount1!;
        } else {
          totalKHMAll.value += e.totalAmount1!;
        }
      },
    );
    var amountKHM = totalKHMAll.value / 4100;
    totalAmountAll.value = amountKHM + totalUSDAll.value;

    // PAR 1
    modelNew.value.arrear1Day!.forEach(
      (e) {
        if (e.currencyCode == "USD") {
          totalUSD1.value += e.totalAmount1!;
        } else {
          totalKHM1.value += e.totalAmount1!;
        }
      },
    );
    var amountKHM1 = totalKHM1.value / 4100;
    totalAmount1.value = amountKHM1 + totalUSD1.value;
    debugPrint('totalAmount1: ${totalAmount1.value}');

    // PAR 2
    modelNew.value.arrear14Days!.forEach((e) {
      if (e.currencyCode == "USD") {
        totalUSD2.value += e.totalAmount1!;
      } else {
        totalKHM2.value += e.totalAmount1!;
      }
    });
    var amountKHM2 = totalKHM2.value / 4100;
    totalAmount2.value = amountKHM2 + totalUSD2.value;

    // PAR 3
    modelNew.value.arrear30Days!.forEach((e) {
      if (e.currencyCode == "USD") {
        totalUSD3.value += e.totalAmount1!;
      } else {
        totalKHM3.value += e.totalAmount1!;
      }
    });
    var amount3 = totalKHM3.value / 4100;
    totalAmount3.value = amount3 + totalUSD3.value;

    //4
    modelNew.value.arrear60Days!.forEach((e) {
      if (e.currencyCode == "USD") {
        totalUSD4.value += e.totalAmount1!;
      } else {
        totalKHM4.value += e.totalAmount1!;
      }
    });
    var amount4 = totalKHM4.value / 4100;
    totalAmount4.value = amount4 + totalUSD4.value;

    //5
    modelNew.value.arrear90Days!.forEach((e) {
      if (e.currencyCode == "USD") {
        totalUSD5.value += e.totalAmount1!;
      } else {
        totalKHM5.value += e.totalAmount1!;
      }
    });
    var amount5 = totalKHM5.value / 4100;
    totalAmount5.value = amount5 + totalUSD5.value;

    /// Ratio

    if (modelNew.value.outstandingBalance == '') {
      ratioParAll.value = 0.0;
      ratioPar1.value == 0.0;
      ratioPar14.value == 0.0;
      ratioPar30.value == 0.0;
      ratioPar60.value == 0.0;
      ratioPar90.value == 0.0;
    } else {
      ratioParAll.value = totalAmountAll.value *
          100 /
          double.parse(' ${modelNew.value.outstandingBalance}');
      ratioPar1.value = totalAmount1.value *
          100 /
          double.parse(' ${modelNew.value.outstandingBalance}');
      ratioPar14.value = totalAmount2.value *
          100 /
          double.parse(' ${modelNew.value.outstandingBalance}');
      ratioPar30.value = totalAmount3.value *
          100 /
          double.parse(' ${modelNew.value.outstandingBalance}');
      ratioPar60.value = totalAmount4.value *
          100 /
          double.parse(' ${modelNew.value.outstandingBalance}');
      ratioPar90.value = totalAmount5.value *
          100 /
          double.parse(' ${modelNew.value.outstandingBalance}');
    }
    var raioList = [
      ratioPar1.value,
      ratioPar14.value,
      ratioPar30.value,
      ratioPar60.value,
      ratioPar90.value
    ];
    totalRaio.value = raioList.reduce((value, element) => value + element);
  }

  //  List<double> raioList = [
  //      ratioPar1.value,
  //     FormatConvert.formatCurrency(controller.ratioPar14.value),
  //     FormatConvert.formatCurrency(controller.ratioPar30.value),
  //     FormatConvert.formatCurrency(controller.ratioPar60.value),
  //     FormatConvert.formatCurrency(controller.ratioPar90.value),
  //   ];
  //   int totalRaio = raioList.reduce((value, element) => value + element);
}
