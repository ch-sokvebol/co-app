// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../../providers/manageService.dart';

class ParController extends GetxController {
  var userName = ''.obs;
  var userId = ''.obs;
  var parlist = [].obs;
  var isLoandingPar = false.obs;
  var isLanguge = false.obs;
  var formatDays = ''.obs;
  var currencyUSD = 0.obs;
  var currencyKhmer = 0.obs;
  var totalOverdayUSD = 0.0.obs;
  var totalOverdayKHM = 0.0.obs;
  var totalUSD = 0.0.obs;
  var totalAcc = 0.obs;
  var totalAccounts = 0.obs;
  var datetime = DateTime.now();
  var par1 = 14.obs;
  var par2 = 30.obs;
  var par3 = 60.obs;
  var par4 = 90.obs;
  var listPar1 = [].obs;
  var listPar2 = [].obs;
  var listPar3 = [].obs;
  var listPar4 = [].obs;
  var listPar = [].obs;
  // test

  var overdueDay = 0.0.obs;
  var branchCode = ''.obs;
  var employeeCode = ''.obs;
  var baseData = ''.obs;

  // test
  Future<void> getLoanArrear({
    String? branchCode,
    String? employeeCode,
    int? overDueDay,
    String? baseDate,
  }) async {
    isLoandingPar.value = true;
    debugPrint('isLoandingPar: $isLoandingPar');
    String getDateTimeNow = DateFormat("yyyyMMdd").format(datetime);
    formatDays.value = getDateTimeNow;
    var body = json.encode({
      "BranchCode": "$branchCode",
      "EmployeeCode": "$employeeCode",
      "OverDueDay": "$overDueDay",
      "BaseDate": "$baseDate",
    });
    try {
      await http
          .post(
        Uri.parse(baseURLInternal + 'LoanArrear/arrear'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      )
          .then(
        (res) {
          if (res.statusCode == 200) {
            isLoandingPar(false);
            debugPrint("statst code ====> ${res.statusCode}");
            var resJson = json.decode(res.body);
            listPar.value = resJson;
            totalAcc.value = listPar.length;
            totalOverdayUSD.value = 0.00;
            totalOverdayKHM.value = 0.00;
            listPar.forEach(
              (e) {
                if (e['currencyCode'] == "USD") {
                  totalOverdayUSD.value += e['totalAmount1'];
                } else {
                  totalOverdayKHM.value += e['totalAmount1'];
                }
              },
            );

            var amount = totalOverdayKHM.value / 4100;
            totalUSD.value = totalOverdayUSD.value + amount;

            update();
          } else {
            isLoandingPar.value = false;
            debugPrint('error =====> par list ');
          }
        },
      );
    } catch (e) {
      update();
      isLoandingPar.value = false;
      debugPrint('erro =====> $e}');
    } finally {
      isLoandingPar.value = false;
    }
  }

  Future<void> getLoanArrear1({
    String? branchCode,
    String? employeeCode,
    int? overDueDay,
    String? baseDate,
  }) async {
    isLoandingPar.value = true;
    String getDateTimeNow = DateFormat("yyyyMMdd").format(datetime);
    formatDays.value = getDateTimeNow;
    var body = json.encode({
      "BranchCode": "$branchCode",
      "EmployeeCode": "$employeeCode",
      "OverDueDay": "$overDueDay",
      "BaseDate": "$baseDate",
    });
    try {
      await http
          .post(
        Uri.parse(baseURLInternal + 'LoanArrear/arrear'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      )
          .then((res) {
        if (res.statusCode == 200) {
          var resJson = json.decode(res.body);
          listPar1.value = resJson;
          totalAcc.value = listPar1.length;
          totalOverdayUSD.value = 0.0;
          totalOverdayKHM.value = 0.0;
          listPar1.forEach((e) {
            if (e['currencyCode'] == "USD") {
              totalOverdayUSD.value += e['totalAmount1'];
            } else {
              totalOverdayKHM.value += e['totalAmount1'];
            }
          });

          update();
        } else {
          isLoandingPar.value = false;
          debugPrint('error =====> par list ');
        }
      });
    } catch (e) {
      update();
      isLoandingPar.value = false;
      debugPrint('erro =====> $e}');
    } finally {
      isLoandingPar.value = false;
    }
  }

  Future<void> getLoanArrear2({
    String? branchCode,
    String? employeeCode,
    int? overDueDay,
    String? baseDate,
  }) async {
    isLoandingPar.value = true;
    String getDateTimeNow = DateFormat("yyyyMMdd").format(datetime);
    formatDays.value = getDateTimeNow;
    var body = json.encode({
      "BranchCode": "$branchCode",
      "EmployeeCode": "$employeeCode",
      "OverDueDay": "$overDueDay",
      "BaseDate": "$baseDate",
    });
    try {
      await http
          .post(
        Uri.parse(baseURLInternal + 'LoanArrear/arrear'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      )
          .then((res) {
        if (res.statusCode == 200) {
          var resJson = json.decode(res.body);
          listPar2.value = resJson;
          totalAcc.value = listPar2.length;
          totalOverdayUSD.value = 0.0;
          totalOverdayKHM.value = 0.0;
          parlist.forEach((e) {
            if (e['currencyCode'] == "USD") {
              totalOverdayUSD.value += e['totalAmount1'];
            } else {
              totalOverdayKHM.value += e['totalAmount1'];
            }
          });

          update();
        } else {
          isLoandingPar.value = false;
          debugPrint('error =====> par list ');
        }
      });
    } catch (e) {
      update();
      isLoandingPar.value = false;
      debugPrint('erro =====> $e}');
    } finally {
      isLoandingPar.value = false;
    }
  }

  Future<void> getLoanArrear3({
    String? branchCode,
    String? employeeCode,
    int? overDueDay,
    String? baseDate,
  }) async {
    isLoandingPar.value = true;
    String getDateTimeNow = DateFormat("yyyyMMdd").format(datetime);
    formatDays.value = getDateTimeNow;
    var body = json.encode({
      "BranchCode": "$branchCode",
      "EmployeeCode": "$employeeCode",
      "OverDueDay": "$overDueDay",
      "BaseDate": "$baseDate",
    });
    try {
      await http
          .post(
        Uri.parse(baseURLInternal + 'LoanArrear/arrear'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      )
          .then((res) {
        if (res.statusCode == 200) {
          var resJson = json.decode(res.body);
          listPar3.value = resJson;
          totalAcc.value = listPar3.length;
          totalOverdayUSD.value = 0.0;
          totalOverdayKHM.value = 0.0;
          parlist.forEach((e) {
            if (e['currencyCode'] == "USD") {
              totalOverdayUSD.value += e['totalAmount1'];
            } else {
              totalOverdayKHM.value += e['totalAmount1'];
            }
          });
          // debugPrint('test===:${parlist.length}');

          update();
        } else {
          isLoandingPar.value = false;
          debugPrint('error =====> par list ');
        }
      });
    } catch (e) {
      update();
      isLoandingPar.value = false;
      debugPrint('erro =====> $e}');
    } finally {
      isLoandingPar.value = false;
    }
  }

  Future<void> getLoanArrear4({
    String? branchCode,
    String? employeeCode,
    int? overDueDay,
    String? baseDate,
  }) async {
    isLoandingPar.value = true;
    String getDateTimeNow = DateFormat("yyyyMMdd").format(datetime);
    formatDays.value = getDateTimeNow;
    var body = json.encode({
      "BranchCode": "$branchCode",
      "EmployeeCode": "$employeeCode",
      "OverDueDay": "$overDueDay",
      "BaseDate": "$baseDate",
    });
    try {
      await http
          .post(
        Uri.parse(baseURLInternal + 'LoanArrear/arrear'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      )
          .then((res) {
        if (res.statusCode == 200) {
          var resJson = json.decode(res.body);
          listPar4.value = resJson;

          totalAcc.value = listPar4.length;

          totalOverdayUSD.value = 0.0;
          totalOverdayKHM.value = 0.0;
          parlist.forEach((e) {
            if (e['currencyCode'] == "USD") {
              totalOverdayUSD.value += e['totalAmount1'];
            } else {
              totalOverdayKHM.value += e['totalAmount1'];
            }
          });
          // debugPrint('test===:${parlist.length}');

          update();
        } else {
          isLoandingPar.value = false;
          debugPrint('error =====> par list ');
        }
      });
    } catch (e) {
      update();
      isLoandingPar.value = false;
      debugPrint('erro =====> $e}');
    } finally {
      isLoandingPar.value = false;
    }
  }
}
