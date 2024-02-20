import 'dart:io';

import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/app/utils/helpers/responsive.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../localizations/appLocalizations.dart';
import '../../screens/approval/approvalList.dart';
import '../../screens/customerRegister/customerRegister.dart';
import '../../screens/irr/index.dart';
import '../../screens/lMap/index.dart';
import '../../screens/loanArrear/index.dart';
import '../../screens/loanRegistration/loanRegistration.dart';
import '../../screens/policy/index.dart';
import '../utils/helpers/activity_controller.dart';

class CustomDashBoardCard extends StatefulWidget {
  final Widget? icon;
  final String? title;
  CustomDashBoardCard({
    super.key,
    this.icon,
    this.title,
  });

  @override
  State<CustomDashBoardCard> createState() => _CustomDashBoardCardState();
}

class _CustomDashBoardCardState extends State<CustomDashBoardCard> {
  final actCon = Get.put(ActivityLogController());
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  IosDeviceInfo? iosDeviceInfo;
  var deviData = <dynamic, dynamic>{};
  Future<void> deviceData() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      print(info.device);
    }
  }

  Future<DeviceInfoPlugin> getInfo() async {
    if (Platform.isIOS) {
      // deviData = getIOSInfo(await deviceInfoPlugin.);
    } else if (Platform.isAndroid) {
      getAndroidInfo();
    }
    return deviceInfoPlugin;
  }

  Future<AndroidDeviceInfo> getAndroidInfo() async {
    return deviceInfoPlugin.androidInfo;
  }

  Future<IosDeviceInfo> getIOSInfo() async {
    return deviceInfoPlugin.iosInfo;
  }

  @override
  Widget build(BuildContext context) {
    return CheckResponsive(
      smallWidget: GridView.count(
        // primary: false,
        // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        semanticChildCount: 3,
        shrinkWrap: false,
        crossAxisCount: 3,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        children: [
          CardWidget(
            context: context,
            icon: Icons.checklist,
            title:
                '${AppLocalizations.of(context)!.translate('list_loan_approval')}',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApprovalLists()),
              );
            },
          ),
          CardWidget(
              context: context,
              icon: Icons.person_add,
              title:
                  '${AppLocalizations.of(context)!.translate('customer_registration')}',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerRegister()),
                );
              }),
          CardWidget(
            context: context,
            icon: Icons.edit_note,
            title:
                '${AppLocalizations.of(context)!.translate('loan_registration')}',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoanRegister()),
              );
            },
          ),
          CardWidget(
              context: context,
              icon: Icons.auto_stories,
              title: '${AppLocalizations.of(context)!.translate('policy')}',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PolicyScreen()),
                );
              }),
          CardWidget(
              context: context,
              icon: Icons.account_balance_wallet,
              title:
                  '${AppLocalizations.of(context)!.translate('loan_arrear')}',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoanArrearScreen()),
                );
              }),
          CardWidget(
              context: context,
              icon: Icons.real_estate_agent,
              title: '${AppLocalizations.of(context)!.translate('lmap_data')}',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LMapScreen()),
                );
              }),
          CardWidget(
              context: context,
              icon: Icons.calculate,
              title: 'IRR Calculator',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IRRScreen()),
                );
              }),
          CardWidget(
              context: context,
              icon: Icons.calculate,
              title: 'Test',
              onTap: () {
                actCon.onActivilog();
              }),
        ],
      ),
    );
  }
}

Widget CardWidget({
  final IconData? icon,
  final String? title,
  final GestureTapCallback? onTap,
  required final BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // height: MediaQuery.of(context).size.height / 6,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10),
            shape: BoxShape.circle,
            color: AppColors.logolightGreen,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                // size: 50,
              ),
            ],
          ),
        ),
        Text(
          '$title',
          style: TextStyle(
            color: AppColors.logolightGreen,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class MenuModel {
  final Widget? icon;
  final String? title;
  MenuModel({this.icon, this.title});
}

List<MenuModel> menuList = [
  MenuModel(
    icon: Icon(Icons.edit_note),
    title: 'tt',
  ),
  MenuModel(
    icon: Icon(Icons.person_add),
    title: 'Customer Registeration',
  ),
  MenuModel(
    icon: Icon(Icons.auto_stories),
    title: 'Policy',
  ),
  MenuModel(
    icon: Icon(Icons.account_balance_wallet),
    title: 'Loan Arrer',
  ),
  MenuModel(
    icon: Icon(Icons.edit_note),
    title: 'LMAP Data',
  ),
  MenuModel(
    icon: Icon(Icons.edit_note),
    title: 'Loan Approval',
  ),
  MenuModel(
    icon: Icon(Icons.edit_note),
    title: 'IRR Caculator',
  ),
  // MenuModel(
  //   icon: Icon(Icons.edit_note),
  //   title: 'Loan Registration',
  // ),
  // MenuModel(
  //   icon: Icon(Icons.edit_note),
  //   title: 'Loan Registration',
  // ),
];
