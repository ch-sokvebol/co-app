import 'package:chokchey_finance/app/module/notifications/Screens/notification_list.dart';
import 'package:chokchey_finance/app/module/notifications/controllers/notification_controller.dart';
import 'package:chokchey_finance/app/widgets/custom_app_bar.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../localizations/appLocalizations.dart';
import 'loan_collection.dart';

class MainNotificationScreen extends StatefulWidget {
  const MainNotificationScreen({super.key});

  @override
  State<MainNotificationScreen> createState() => _MainNotificationScreenState();
}

class _MainNotificationScreenState extends State<MainNotificationScreen> {
  int segmentedControlValue = 0;
  PageController pageCon = PageController();
  // final PageController _pageViewController = PageController();
  // List<Widget> widgetList = [NotificationListScreen(), LoanCollectionScreen()];
  final con = Get.put(NotificationController());
  onGetMsgLoanCollection() async {
    final userCode = await storage.read(key: 'user_ucode');
    con.getArrNoti(userCode.toString());
  }

  @override
  void initState() {
    onGetMsgLoanCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return CupertinoScaffold(
      body: Builder(
        builder: (BuildContext context) => CupertinoPageScaffold(
          child: Scaffold(
            appBar: CustomAppBar(
                context: context,
                title:
                    '${AppLocalizations.of(context)!.translate('notification')}',
                centerTitle: true),
            body: Container(
              padding: const EdgeInsets.only(top: 20),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl(
                        groupValue: segmentedControlValue,
                        backgroundColor:
                            const Color(0xff252552).withOpacity(0.1),
                        children: <int, Widget>{
                          0: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '${AppLocalizations.of(context)!.translate('notification')}',
                              style: theme.labelMedium!.copyWith(fontSize: 14),
                            ),
                          ),
                          1: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '${AppLocalizations.of(context)!.translate('loan_collection')}',
                              style: theme.labelMedium!.copyWith(fontSize: 14),
                            ),
                          ),
                        },
                        onValueChanged: (int? value) {
                          segmentedControlValue = value!;
                          pageCon.animateToPage(segmentedControlValue,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.fastOutSlowIn);
                          setState(() {});
                        }),
                  ),
                  Expanded(
                    child: PageView(
                      controller: pageCon,
                      onPageChanged: (value) {
                        segmentedControlValue = value;
                        setState(() {});
                      },
                      children: [
                        NotificationListScreen(),
                        LoanCollectionScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
