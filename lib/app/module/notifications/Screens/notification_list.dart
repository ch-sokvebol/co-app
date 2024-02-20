import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../localizations/appLocalizations.dart';
import '../../../../screens/approval/approvalList.dart';
import '../../../../screens/groupLoanApprove/index.dart';
import '../../../../screens/listLoanApproval/tebBarDetail.dart';
import '../../../../screens/loanArrear/detail.dart';
import '../../../../screens/notification/messageFromCEO.dart';
import '../../../utils/colors/app_color.dart';
import '../controllers/notification_controller.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  final con = Get.put(NotificationController());

  onTapDetail(String? messageId) async {
    await con.onReadnotification('$messageId').then((value) {
      if (con.getKey == '200') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetailLoan(messageId),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.translate('failed') ?? 'Failed',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ),
            dismissDirection: DismissDirection.up,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            showCloseIcon: true,
            closeIconColor: Colors.white,
          ),
        );
      }
    });
  }

  navigatorGroupLoan(String messageId) async {
    await con.onReadnotification(messageId).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => GroupLoanApprove(
            isRefresh: true,
          ),
        ),
      );
    });
  }

  int pageSize = 10;
  int pageNumber = 1;
  bool isLoadingRefresh = false;
  Future<void> refreshData() async {
    setState(() {
      isLoadingRefresh = true;
    });
    await con
        .getAllnotification(pageSize: pageSize, pageNumber: pageNumber)
        .then((value) {
      isLoadingRefresh = false;
    }).catchError((onError) {
      isLoadingRefresh = false;
    });
  }

  @override
  void initState() {
    con.getAllnotification(pageNumber: pageNumber, pageSize: pageSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold(
        body: Obx(() => con.allnotiList.isEmpty
            ? Center(child: Text("No Notification"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (con.isloadingAllNoti.value == false &&
                            scrollNotification.metrics.pixels ==
                                scrollNotification.metrics.maxScrollExtent) {
                          con.isloadingAllNoti.value = true;
                          pageSize += 10;
                          con.getAllnotification(
                              pageSize: pageSize, pageNumber: pageNumber);
                        } else {
                          con.isloadingAllNoti.value = false;
                        }
                        return true;
                      },
                      child: RefreshIndicator(
                        onRefresh: refreshData,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              con.allnotiModel.value.listMessages!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                con.onReadnotification(con.allnotiModel.value
                                    .listMessages![index].id!);
                                var groupLoanCode;
                                var rcodeGroup;
                                if (con.allnotiModel.value.listMessages![index]
                                        .rcode !=
                                    '') {
                                  rcodeGroup = con.allnotiModel.value
                                      .listMessages![index].rcode!
                                      .substring(0, 1);
                                  groupLoanCode = '6';
                                }
                                if (con.allnotiModel.value.listMessages![index]
                                        .title ==
                                    'Apsara System') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ApprovalLists(),
                                    ),
                                  );
                                } else if (groupLoanCode == rcodeGroup) {
                                  navigatorGroupLoan(
                                    con.allnotiModel.value.listMessages![index]
                                        .id!,
                                  );
                                } else if (con.allnotiModel.value
                                        .listMessages![index].data ==
                                    'announcement') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AnnouncementDetail(
                                              list: con.allnotiModel.value
                                                  .listMessages![index],
                                            )),
                                  );
                                } else if (con.allnotiModel.value
                                        .listMessages![index].title ==
                                    'Loan Arrears') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DetailLoanArrear(
                                              loanAccountNo: con
                                                  .allnotiModel
                                                  .value
                                                  .listMessages![index]
                                                  .lcode!),
                                    ),
                                  );
                                } else {
                                  onTapDetail(
                                    con.allnotiModel.value.listMessages![index]
                                        .id,
                                  );
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Text(
                                  //     '${con.allnotiModel.value.listMessages![index].id}'),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 15,
                                        top: 10,
                                        bottom: 10,
                                        right: 15),
                                    // color: Colors.blueGrey,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.logoDarkBlue),
                                            child: Center(
                                              child: FaIcon(
                                                FontAwesomeIcons
                                                    .moneyCheckDollar,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            )),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${con.allnotiModel.value.listMessages![index].title}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(fontSize: 16),
                                                ),
                                                Text(
                                                  '${con.allnotiModel.value.listMessages![index].body}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(fontSize: 16),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Spacer(),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(right: 20),
                                        //   child: Text(
                                        //     '12m',
                                        //     style: Theme.of(context)
                                        //         .textTheme
                                        //         .bodySmall!
                                        //         .copyWith(
                                        //           fontSize: 14,
                                        //           // color: AppColors.logoDarkBlue,
                                        //         ),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        if (con.allnotiModel.value
                                                .listMessages![index].mstatus ==
                                            1)
                                          Icon(
                                            Icons.done_all,
                                            size: 15,
                                          ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: AppColors.logoDarkBlue,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  con.isloadingAllNoti.value == true
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Loading',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black87),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SpinKitThreeBounce(
                                size: 14,
                                color: AppColors.logoDarkBlue,
                              ),
                            ],
                          ),
                        )
                      : Container()
                ],
              )));
  }
}
