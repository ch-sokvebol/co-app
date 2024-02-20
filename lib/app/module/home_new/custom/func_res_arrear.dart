import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/storages/const.dart';
import '../controller/res_arrear_controller.dart';
import '../model/loan_arrear_body_model.dart';

final controllerResArrear = Get.put(ResArrearController());
onSearchArrear() async {
  final currentDate = DateTime.now();
  var date = DateFormat("yyyyMMdd").format(
      DateTime(currentDate.year, currentDate.month, currentDate.day - 1));
  var type = await storage.read(key: 'user_type');
  var branchCode = await storage.read(key: 'branch');
  var empCode = await storage.read(key: 'user_ucode');
  if (type == "CO") {
    final model0 = LoanArreaBodyModel(
      overdueDay: 0,
      basedate: '$date',
      branchCode: '$branchCode',
      employeeCode: '$empCode',
    );
    final model14 = LoanArreaBodyModel(
      overdueDay: 14,
      basedate: '$date',
      branchCode: '$branchCode',
      employeeCode: '$empCode',
    );
    final model30 = LoanArreaBodyModel(
      overdueDay: 30,
      basedate: '$date',
      branchCode: '$branchCode',
      employeeCode: '$empCode',
    );
    final model60 = LoanArreaBodyModel(
      overdueDay: 60,
      basedate: '$date',
      branchCode: '$branchCode',
      employeeCode: '$empCode',
    );
    final model90 = LoanArreaBodyModel(
      overdueDay: 90,
      basedate: '$date',
      branchCode: '$branchCode',
      employeeCode: '$empCode',
    );

    controllerResArrear.searchArrear(model14).then(
      (e) {
        controllerResArrear.listArrear14.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model30).then(
      (e) {
        controllerResArrear.listArrear30.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model60).then(
      (e) {
        controllerResArrear.listArrear60.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model90).then(
      (e) {
        controllerResArrear.listArrear90.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model0).then(
      (e) {
        controllerResArrear.listArrear0.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model0).then(
      (e) {
        controllerResArrear.listArrear0.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.totalArrear(model0).then((value) {
      controllerResArrear.amount0.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio0.value = controllerResArrear.ratio.value;
    });
    controllerResArrear.totalArrear(model14).then((value) {
      controllerResArrear.amount14.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio14.value = controllerResArrear.ratio.value;
    });
    controllerResArrear.totalArrear(model30).then((value) {
      controllerResArrear.amount30.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio30.value = controllerResArrear.ratio.value;
    });
    controllerResArrear.totalArrear(model60).then((value) {
      controllerResArrear.amount60.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio60.value = controllerResArrear.ratio.value;
    });
    controllerResArrear.totalArrear(model90).then((value) {
      controllerResArrear.amount90.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio90.value = controllerResArrear.ratio.value;
    });
  } else if (type == "BM" || type == 'BTL') {
    final model0 = LoanArreaBodyModel(
      overdueDay: 0,
      basedate: '$date',
      branchCode: '$branchCode',
      employeeCode: '',
    );
    final model14 = LoanArreaBodyModel(
      overdueDay: 14,
      basedate: '$date',
      branchCode: '$branchCode',
      employeeCode: '',
    );
    final model30 = LoanArreaBodyModel(
      overdueDay: 30,
      basedate: '$date',
      branchCode: '$branchCode',
      employeeCode: '',
    );
    final model60 = LoanArreaBodyModel(
      overdueDay: 60,
      basedate: '$date',
      branchCode: '$branchCode',
      employeeCode: '',
    );
    final model90 = LoanArreaBodyModel(
      overdueDay: 90,
      basedate: '$date',
      branchCode: '$branchCode',
      employeeCode: '',
    );

    controllerResArrear.searchArrear(model14).then(
      (e) {
        controllerResArrear.listArrear14.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model30).then(
      (e) {
        controllerResArrear.listArrear30.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model60).then(
      (e) {
        controllerResArrear.listArrear60.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model90).then(
      (e) {
        controllerResArrear.listArrear90.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model0).then(
      (e) {
        controllerResArrear.listArrear0.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model0).then(
      (e) {
        controllerResArrear.listArrear0.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.totalArrear(model0).then((value) {
      controllerResArrear.amount0.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio0.value = controllerResArrear.ratio.value;
    });
    controllerResArrear.totalArrear(model14).then((value) {
      controllerResArrear.amount14.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio14.value = controllerResArrear.ratio.value;
    });
    controllerResArrear.totalArrear(model30).then((value) {
      controllerResArrear.amount30.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio30.value = controllerResArrear.ratio.value;
    });
    controllerResArrear.totalArrear(model60).then((value) {
      controllerResArrear.amount60.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio60.value = controllerResArrear.ratio.value;
    });
    controllerResArrear.totalArrear(model90).then((value) {
      controllerResArrear.amount90.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio90.value = controllerResArrear.ratio.value;
    });
  } else {
    final model0 = LoanArreaBodyModel(
      overdueDay: 0,
      basedate: '$date',
      branchCode: '',
      employeeCode: '',
    );
    final model1 = LoanArreaBodyModel(
      overdueDay: 1,
      basedate: '$date',
      branchCode: '',
      employeeCode: '',
    );
    final model14 = LoanArreaBodyModel(
      overdueDay: 14,
      basedate: '$date',
      branchCode: '',
      employeeCode: '',
    );
    final model30 = LoanArreaBodyModel(
      overdueDay: 30,
      basedate: '$date',
      branchCode: '',
      employeeCode: '',
    );
    final model60 = LoanArreaBodyModel(
      overdueDay: 60,
      basedate: '$date',
      branchCode: '',
      employeeCode: '',
    );
    final model90 = LoanArreaBodyModel(
      overdueDay: 90,
      basedate: '$date',
      branchCode: '',
      employeeCode: '',
    );
    controllerResArrear.searchArrear(model1).then(
      (e) {
        controllerResArrear.listArrear1.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model14).then(
      (e) {
        controllerResArrear.listArrear14.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model30).then(
      (e) {
        controllerResArrear.listArrear30.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model60).then(
      (e) {
        controllerResArrear.listArrear60.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model90).then(
      (e) {
        controllerResArrear.listArrear90.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.searchArrear(model0).then(
      (e) {
        controllerResArrear.listArrear0.length =
            controllerResArrear.listArrear.length;
      },
    );
    controllerResArrear.totalArrear(model0).then((value) {
      controllerResArrear.amount0.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio0.value = controllerResArrear.ratio.value;
      // debugPrint("Ratio0 : ${controllerResArrear.ratio0.value}");
      // debugPrint("amount0 : ${controllerResArrear.totalUSD.value}");
    });
    controllerResArrear.totalArrear(model1).then((value) {
      controllerResArrear.amount1.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio1.value = controllerResArrear.ratio.value;
      // debugPrint("Ratio1 : ${controllerResArrear.ratio1.value}");
      // debugPrint("amount1 : ${controllerResArrear.totalUSD.value}");
    });
    controllerResArrear.totalArrear(model14).then((value) {
      controllerResArrear.amount14.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio14.value = controllerResArrear.ratio.value;
      debugPrint("ratio14 ==>> ${controllerResArrear.ratio.value}");
      //  debugPrint("Ratio14 : ${controllerResArrear.ratio14.value}");
      // debugPrint("amount14 : ${controllerResArrear.totalUSD.value}");
    });
    controllerResArrear.totalArrear(model30).then((value) {
      controllerResArrear.amount30.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio30.value = controllerResArrear.ratio.value;
      // debugPrint("Ratio30 : ${controllerResArrear.ratio30.value}");
    });
    controllerResArrear.totalArrear(model60).then((value) {
      controllerResArrear.amount60.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio60.value = controllerResArrear.ratio.value;
      // debugPrint("Ratio60 : ${controllerResArrear.ratio60.value}");
    });
    controllerResArrear.totalArrear(model90).then((value) {
      controllerResArrear.amount90.value = controllerResArrear.totalUSD.value;
      controllerResArrear.ratio90.value = controllerResArrear.ratio.value;
      // debugPrint("Ratio90 : ${controllerResArrear.ratio90.value}");
    });
  }

  ;
}
