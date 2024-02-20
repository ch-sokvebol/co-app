import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/storages/const.dart';
import '../../loan_arrear/controllers/loan_arrear_controller.dart';
import '../custom/custom_card_par_new.dart';

class ViewArrearScreen extends StatefulWidget {
  final String? uid;
  const ViewArrearScreen({
    super.key,
    this.uid,
  });

  @override
  State<ViewArrearScreen> createState() => _ViewArrearScreenState();
}

class _ViewArrearScreenState extends State<ViewArrearScreen> {
  @override
  void initState() {
    // onCheckPar();
    super.initState();
  }

  final con = Get.put(LoanArrearController());
  onCheckPar() async {
    final currentDate = DateTime.now();
    var date = DateFormat("yyyyMMdd").format(
        DateTime(currentDate.year, currentDate.month, currentDate.day - 1));
    var type = await storage.read(key: 'user_type');
    var branchCode = await storage.read(key: 'branch');
    var empCode = await storage.read(key: 'user_ucode');
    if (type == "CO") {
      con.getParArrHome(
        baseDate: '$date',
        employeeCode: '$empCode',
        overdueDay: 0,
        branchCode: '',
      );
    } else if (type == "BM" || type == "BTL") {
      con.getParArrHome(
        baseDate: '$date',
        employeeCode: '',
        overdueDay: 0,
        branchCode: '$branchCode',
      );
    } else {
      // For MNG
      con.getParArrHome(
        baseDate: '$date',
        employeeCode: '',
        overdueDay: 0,
        branchCode: '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: logolightGreen,
        elevation: 0.2,
        centerTitle: true,
        title: Text(
          "View Arrear",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Obx(
              () => CustomCardParNew(
                  parArrHomeModel: con.parArrHomeModel.value,
                  userId: widget.uid,
                  onNavigat: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
