// ignore_for_file: dead_code, unused_element

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chokchey_finance/app/module/log/controller/log_controller.dart';
import 'package:chokchey_finance/app/module/log/controller/par_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import '../../../../utils/storages/responsive.dart';
import '../../log/screen/login_screen.dart';
import '../../../utils/helpers/internet_connection.dart';
import '../../../utils/helpers/local_database.dart';
import '../../../../components/Listdrawer.dart';
import '../../../../components/custom_profileuser.dart';
import '../../../../localizations/appLocalizations.dart';
import '../../../../main.dart';
import '../../../../providers/manageService.dart';
import '../../../../utils/storages/colors.dart';
import '../../../../utils/storages/const.dart';
import '../../../../screens/approvalSummary/index.dart';
import '../../../../screens/disApprovalSummary/index.dart';
import '../../../../screens/historyApsara/index.dart';
import '../../../../screens/listCustomerRegistration/index.dart';
import '../../../../screens/listLoanApproval/indexs.dart';
import '../../../../screens/listLoanRegistration/index.dart';
import '../../../../screens/notificationLoanArrear/index.dart';
import '../../../../screens/report/index.dart';
import '../../../../screens/report_summary/index.dart';
import '../../../../screens/requestSummary/index.dart';
import '../../../../screens/returnSummary/index.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen();

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  double screenWidth = 0.0;
  double screenHeight = 0.0;

  @override
  void initState() {
    storage.read(key: 'lang_code').then((lang) {
      onChngaeLang(lang);
    });
    setState(() {
      getStoreUser();
    });
    fetchVersionApp();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  onPushNotificationLoanArrear() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PushNotificationLoanLoanArrear()),
    );
  }

  String version = "1.2.0";

  fetchVersionApp() async {
    PackageInfo.fromPlatform().then(
      (PackageInfo packageInfo) {
        version = packageInfo.version;
      },
    );
  }

  onLogOut() async {
    AwesomeDialog(
        width: Responsive.isMobile(context) ? screenWidth : screenWidth / 2,
        context: context,
        headerAnimationLoop: false,
        dialogType: DialogType.info,
        transitionAnimationDuration: const Duration(milliseconds: 1000),
        title: AppLocalizations.of(context)!.translate('logout') ?? 'Logout',
        desc:
            AppLocalizations.of(context)!.translate('confirm_dialog_logout') ??
                'Are you sure you want to logout?',
        btnOkOnPress: () async {
          await LocalDatabase.instance.removeOldOfflineUser();
          await storage.deleteAll();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    //Login(),
                    LoginScreenNew(),
              ),
              ModalRoute.withName("/login"));
        },
        btnCancelText: AppLocalizations.of(context)!.translate('no') ?? "No",
        btnCancelOnPress: () {},
        btnCancelIcon: Icons.close,
        btnOkIcon: Icons.check_circle,
        btnOkColor: logolightGreen,
        btnOkText: AppLocalizations.of(context)!.translate('ok') ?? 'OK')
      ..show();
  }

  String userId = '';
  String userName = '';

  onListLoanApproval() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListLoanApprovals()),
    );
  }

  final english = const AssetImage('assets/images/english.png');
  final khmer = const AssetImage('assets/images/khmer.png');
  ExpandableController? _expandableController;


  onListReport() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportScreen()),
    );
  }

  onListCustomerRegistration() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListCustomerRegistrations()),
    );
  }

  onListLoanRegistration() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListLoanRegistrations()),
    );
  }

  onChngaeLang(String? enLang) async {
    await storage.write(key: 'lang_code', value: '$enLang');
    if (enLang == 'en_US') {
      controler.isLanguge.value = false;
      englishLanguage();
    } else {
      controler.isLanguge.value = true;
      khmerLanguage();
    }
  }

  englishLanguage() {
    Locale _temp;
    _temp = Locale('en', 'US');
    MyHomePage.setLocale(context, _temp);
  }

  khmerLanguage() {
    Locale _temp;
    _temp = Locale('km', 'KH');
    MyHomePage.setLocale(context, _temp);
  }

  getStoreUser() async {
    // var langCode = AppLocalizations.of(context)!.locale.languageCode;
    String? userIds = await storage.read(key: 'user_id');
    String? userNames = await storage.read(key: 'user_name');

    setState(
      () {
        userName = '$userNames';
        userId = '$userIds';
      },
    );
  }

  bool isoffline = false;
  final controllerLog = Get.put(LogController());
  final userCon = Get.put(ConnenctivityApp());
  final controler = Get.put(ParController());

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    _expandableController = ExpandableController();
    String versionString =
        baseURLInternal == "http://119.82.252.42:2020/api/" ? "v" : "version";
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(color: logolightGreen),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 15, right: 15),
                          child: CustomProfileuser()),
                      Expanded(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.translate('name')}: ${userCon.userName.value}",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    color: logoDarkBlue,
                                    overflow: TextOverflow.clip),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.translate('your_id')} : ${userCon.getUserId.value}",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    color: logoDarkBlue,
                                    overflow: TextOverflow.clip),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              // Text(
                              //   "Branch: $branch",
                              //   style: TextStyle(
                              //       fontSize: 15.0,
                              //       fontWeight: FontWeight.w500,
                              //       color: Colors.white70),
                              // )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Material(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      ExpandablePanel(
                        controller: _expandableController,
                        collapsed: Stack(
                          children: [
                            CustomListTile(
                                Icons.report,
                                AppLocalizations.of(context)!
                                        .translate('report') ??
                                    'Report', () {
                              _expandableController?.expanded = true;
                            }, null),
                            Positioned(
                              right: 0,
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: IconButton(
                                  onPressed: () {
                                    _expandableController?.expanded = true;
                                    debugPrint(
                                        "${_expandableController?.expanded}");
                                  },
                                  icon: Icon(Icons.arrow_drop_down),
                                ),
                              ),
                            ),
                          ],
                        ),
                        expanded: Column(
                          children: [
                            Stack(
                              children: [
                                CustomListTile(
                                  Icons.report,
                                  AppLocalizations.of(context)!
                                          .translate('report') ??
                                      'Report',
                                  () {
                                    _expandableController?.expanded = false;
                                  },
                                  null,
                                  showDecoration: false,
                                ),
                                Positioned(
                                  right: 0,
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: IconButton(
                                      onPressed: () {
                                        _expandableController?.expanded = false;
                                      },
                                      icon: Icon(Icons.arrow_drop_up),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                height: 1,
                                color: logolightGreen,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Column(
                                children: [
                                  CustomListTile(
                                    Icons.payment,
                                    AppLocalizations.of(context)!
                                            .translate('report_approval') ??
                                        'Report Approval',
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ApprovalSummary(),
                                        ),
                                      );
                                    },
                                    null,
                                  ),
                                  FDottedLine(
                                    color: logolightGreen,
                                    width: MediaQuery.of(context).size.width,
                                    strokeWidth: 1.0,
                                    dottedLength: 10.0,
                                    space: 4.0,
                                  ),
                                  CustomListTile(
                                      Icons.payment,
                                      AppLocalizations.of(context)!.translate(
                                              'report_disapproval') ??
                                          'Report Disapproval', () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DisApprovalSummary()),
                                    );
                                  }, null),
                                  FDottedLine(
                                    color: logolightGreen,
                                    width: MediaQuery.of(context).size.width,
                                    strokeWidth: 1.0,
                                    dottedLength: 10.0,
                                    space: 4.0,
                                  ),
                                  CustomListTile(
                                      Icons.payment,
                                      AppLocalizations.of(context)!
                                              .translate('report_request') ??
                                          'Report Request', () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RequestSummary()),
                                    );
                                  }, null),
                                  FDottedLine(
                                    color: logolightGreen,
                                    width: MediaQuery.of(context).size.width,
                                    strokeWidth: 1.0,
                                    dottedLength: 10.0,
                                    space: 4.0,
                                  ),
                                  CustomListTile(
                                      Icons.payment,
                                      AppLocalizations.of(context)!
                                              .translate('report_return') ??
                                          'Report Return', () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReturnSummary()),
                                    );
                                  }, null),
                                  FDottedLine(
                                    color: logolightGreen,
                                    width: MediaQuery.of(context).size.width,
                                    strokeWidth: 1.0,
                                    dottedLength: 10.0,
                                    space: 4.0,
                                  ),
                                  CustomListTile(
                                      Icons.payment,
                                      AppLocalizations.of(context)!
                                              .translate('report_summary') ??
                                          'Report Summary', () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReportSummaryScreen()),
                                    );
                                  }, null),
                                  FDottedLine(
                                    color: logolightGreen,
                                    width: MediaQuery.of(context).size.width,
                                    strokeWidth: 1.0,
                                    dottedLength: 10.0,
                                    space: 4.0,
                                  ),
                                  CustomListTile(
                                      Icons.payment,
                                      AppLocalizations.of(context)!.translate(
                                              'loan_approval_history') ??
                                          'Loan Report History', () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HistoryApsara()),
                                    );
                                  }, null),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: Divider(
                          color: logolightGreen,
                          thickness: 1,
                        ),
                      ),
                      CustomListTile(
                        null,
                        AppLocalizations.of(context)!
                                .translate('english_language') ??
                            'English',
                        () => {
                          onChngaeLang('en_US'),

                          //englishLanguage()
                        },
                        english,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: Divider(
                          color: logolightGreen,
                          thickness: 1,
                        ),
                      ),
                      CustomListTile(
                        null,
                        'ភាសាខ្មែរ',
                        () => {
                          onChngaeLang('km_KH'),
                          // khmerLanguage()
                        },
                        khmer,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: Divider(
                          color: logolightGreen,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$versionString" + ' $version',
                    style: TextStyle(
                      fontSize: 16,
                      color: logoDarkBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onLogOut();
                    },
                    child: Container(
                      // height: 30,
                      // width: 68,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 0,
                              offset: Offset(0, 1),
                              color: Colors.grey.withOpacity(0.3),
                            )
                          ]),
                      child: Column(
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.translate('log_out') ?? 'Logout'}",
                            style: TextStyle(
                              fontSize: 16,
                              color: logoDarkBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SvgPicture.asset("assets/svg/login.svg"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
