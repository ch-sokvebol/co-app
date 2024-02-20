import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/storages/const.dart';
import '../../log/controller/par_controller.dart';

final controllerArrear = Get.put(ParController());
onLoanArrear() async {
  final currentDate = DateTime.now();
  var date = DateFormat("yyyyMMdd").format(
      DateTime(currentDate.year, currentDate.month, currentDate.day - 1));
  var type = await storage.read(key: 'user_type');
  debugPrint("1234 type $type");
  var branchCode = await storage.read(key: 'branch');
  var empCode = await storage.read(key: 'user_ucode');

  if (type == "CO") {
    debugPrint("loan arrear===>>> CO");
    controllerArrear.getLoanArrear(
      branchCode: '$branchCode',
      baseDate: '$date',
      employeeCode: '$empCode',
      overDueDay: 0,
    );
    controllerArrear.getLoanArrear1(
      branchCode: '$branchCode',
      baseDate: '$date',
      employeeCode: '$empCode',
      overDueDay: 14,
    );
    controllerArrear.getLoanArrear2(
      branchCode: '$branchCode',
      baseDate: '$date',
      employeeCode: '$empCode',
      overDueDay: 30,
    );
    controllerArrear.getLoanArrear3(
      branchCode: '$branchCode',
      baseDate: '$date',
      employeeCode: '$empCode',
      overDueDay: 60,
    );
    controllerArrear.getLoanArrear4(
      branchCode: '$branchCode',
      baseDate: '$date',
      employeeCode: '$empCode',
      overDueDay: 90,
    );
  } else if (type == "BM" || type == "BTL") {
    debugPrint("flutter 12345 =====///");
    controllerArrear.getLoanArrear(
      branchCode: '$branchCode',
      baseDate: '$date',
      employeeCode: '',
      overDueDay: 0,
    );
    controllerArrear.getLoanArrear1(
      branchCode: '$branchCode',
      baseDate: '$date',
      employeeCode: '',
      overDueDay: 14,
    );
    controllerArrear.getLoanArrear2(
      branchCode: '$branchCode',
      baseDate: '$date',
      employeeCode: '',
      overDueDay: 30,
    );
    controllerArrear.getLoanArrear3(
      branchCode: '$branchCode',
      baseDate: '$date',
      employeeCode: '',
      overDueDay: 60,
    );
    controllerArrear.getLoanArrear4(
      branchCode: '$branchCode',
      baseDate: '$date',
      employeeCode: ' ',
      overDueDay: 90,
    );
  } else {
    // debugPrint("1234em=====>>>>> code $empCode");
    controllerArrear.getLoanArrear(
      branchCode: '',
      baseDate: '$date',
      employeeCode: '',
      overDueDay: 0,
    );
    controllerArrear.getLoanArrear1(
      branchCode: '',
      baseDate: '$date',
      employeeCode: '',
      overDueDay: 14,
    );
    controllerArrear.getLoanArrear2(
      branchCode: '',
      baseDate: '$date',
      employeeCode: '',
      overDueDay: 30,
    );
    controllerArrear.getLoanArrear3(
      branchCode: '',
      baseDate: '$date',
      employeeCode: '',
      overDueDay: 60,
    );
    controllerArrear.getLoanArrear4(
      branchCode: '',
      baseDate: '$date',
      employeeCode: '',
      overDueDay: 90,
    );
  }
}
