import 'package:chokchey_finance/app/module/loan_arrear/controllers/loan_arrear_controller.dart';
import 'package:chokchey_finance/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../loan_arr_local/custom_card_par_local.dart';

class HomeLocalScreen extends StatefulWidget {
  const HomeLocalScreen({super.key});

  @override
  State<HomeLocalScreen> createState() => _HomeLocalScreenState();
}

class _HomeLocalScreenState extends State<HomeLocalScreen> {
  // onGetHomePar() async {
  //   var res = await sqliteHelper!.queryData(sql: 'select * from HomeParArrear');
  //   debugPrint('get:$res');
  // }

  @override
  void initState() {
    setState(() {
      con.onstoreLocal();
      // onGetHomePar();
    });
    super.initState();
  }

  final con = Get.put(LoanArrearController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'ChokChey CO',
        centerTitle: true,
      ),
      // drawer: DrawerScreen(),
      body: Column(
        children: [
          CustomCardParLocal(),
          // Text('${}'),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Memo & Policy'),
              Text('LMap Data'),
              Text('IRR Calculator'),
            ],
          )
        ],
      ),
    );
  }
}
