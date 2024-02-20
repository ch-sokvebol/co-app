import 'dart:io';

import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/app/utils/helpers/format_convert.dart';
import 'package:chokchey_finance/app/widgets/custom_app_bar.dart';
import 'package:chokchey_finance/localizations/appLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class LoanCollectionDetailScreen extends StatelessWidget {
  final num? amount;
  final String? customerName;
  final String? loanAccNo;
  final String? date;
  final String? branch;
  final String? coName;
  final String? messageId;
  // final ArrearNotiModel? notiModel;

  LoanCollectionDetailScreen({
    super.key,
    this.amount,
    this.customerName,
    this.loanAccNo,
    this.date,
    this.branch,
    this.coName,
    this.messageId,
  });
  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    // final con = Get.put(NotificationController());
    final theme = Theme.of(context).textTheme;
    // final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    // final timer = Time
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: "${AppLocalizations.of(context)!.translate('notification')}" "",
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Platform.isIOS
              ? Icon(Icons.arrow_back_ios)
              : Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5, spreadRadius: 3, color: Colors.black12),
                ],
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(message.data[con.notiArrDetail.value.branchName]),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                  child: Text(
                    'Loan Account No: $loanAccNo',
                    style: theme.bodyMedium,
                  ),
                ),
                Divider(
                  thickness: 1.2,
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.logoDarkBlue.withOpacity(0.2)),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.receipt,
                          color: AppColors.logoDarkBlue,
                          size: 20,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Amount: ${FormatConvert.formatAmountUSD(amount ?? 0.0)}',
                              style: theme.bodySmall!.copyWith(fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: Text(
                              'Customer Name: $customerName',
                              style: theme.bodySmall!.copyWith(fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: Text(
                              "Date: ${date}",
                              // 'Date: ${FormatDate.investmentDateDisplay("$date")}',
                              style: theme.bodySmall!.copyWith(fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: Text(
                              'Branch: ${branch}',
                              style: theme.bodySmall!.copyWith(fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: Text(
                              'CO Name: ${coName}',
                              style: theme.bodySmall!.copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => HomeScreen(),
              //   ),
              // );
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
              margin: EdgeInsets.only(bottom: 30, top: 30, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.logoDarkBlue),
              alignment: Alignment.center,
              child: Text(
                'Close',
                style: theme.titleLarge!
                    .copyWith(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
