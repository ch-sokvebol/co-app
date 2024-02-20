import 'package:chokchey_finance/app/module/notifications/controllers/notification_controller.dart';
import 'package:chokchey_finance/app/module/notifications/widgets/custom_notifi_card.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'loan_collection_detail.dart';

class LoanCollectionScreen extends StatelessWidget {
  const LoanCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(NotificationController());
    // con.getNotiDetail();
    return Obx(
      () => con.isLoadingArrNoti.value == true
          ? Center(
              child: CircularProgressIndicator(
              color: logolightGreen,
            ))
          : con.arrNotiList.isEmpty
              ? Center(
                  child: Text(
                  "No Notification",
                  style: Theme.of(context).textTheme.bodyLarge,
                ))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: con.arrNotiList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ////use for read message
                        con.onReadMsgCollection(con.arrNotiList[index].id!);
                        ////
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoanCollectionDetailScreen(
                              amount: con.arrNotiList[index].amount,
                              customerName: con.arrNotiList[index].customerName,
                              coName: con.arrNotiList[index].coName,
                              loanAccNo: con.arrNotiList[index].loanAccount,
                              date: con.arrNotiList[index].datecreated,
                              branch: con.arrNotiList[index].branchName,
                            ),
                          ),
                        );
                      },
                      child: CustomNotifiCard(
                        title: '${con.arrNotiList[index].title}',
                        body: '${con.arrNotiList[index].contents}',
                        icon: FaIcon(
                          FontAwesomeIcons.moneyCheckDollar,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    );
                  }),
    );
  }
}
