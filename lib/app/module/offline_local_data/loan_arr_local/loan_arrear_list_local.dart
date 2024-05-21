import 'package:chokchey_finance/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../localizations/appLocalizations.dart';
import '../../../utils/helpers/sqlite_helper.dart';
import '../../loan_arrear/widgets/arrear_card.dart';

class LoanArrearListLocal extends StatefulWidget {
  const LoanArrearListLocal({super.key});

  @override
  State<LoanArrearListLocal> createState() => _LoanArrearListLocalState();
}

class _LoanArrearListLocalState extends State<LoanArrearListLocal> {
  SqliteHelper? sqliteHelper;
  List<dynamic> allArrListLocal = [];
  onGetParDetail() async {
    Future.delayed(Duration(seconds: 1), () async {
      allArrListLocal =
          await sqliteHelper!.queryData(sql: 'Select * from ParArrearDetail');
      // debugPrint('test:$res');
    });
  }

  @override
  void initState() {
    sqliteHelper = SqliteHelper();
    setState(() {
      onGetParDetail();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    onGetParDetail();
    return Scaffold(
      appBar: CustomAppBar(
          centerTitle: true,
          context: context,
          action: [
            TextButton(
                onPressed: () {
                  setState(() {
                    onGetParDetail();
                  });
                },
                child: Text('get'))
          ],
          title:
              '${AppLocalizations.of(context)!.translate('loan_arrear') ?? 'Loan Arrears'}'),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: allArrListLocal.length,
          itemBuilder: (context, index) {
            return CustomArrearCard(
              name: allArrListLocal[index]['customerName'],
              paymentDate: allArrListLocal[index]['paymentApplyDate'],
              amount: allArrListLocal[index]['totalAmount1'],
              parAmount: allArrListLocal[index]['overdueDays'],
              currencyCode: allArrListLocal[index]['currencyCode'],
              loanID: allArrListLocal[index]['loanAccountNo'],
              empName: allArrListLocal[index]['employeeName'],
            );
          }),
    );
  }
}
