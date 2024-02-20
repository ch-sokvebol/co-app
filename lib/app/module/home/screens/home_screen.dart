import 'dart:convert';

import 'package:chokchey_finance/app/module/login/controllers/login_controller.dart';
import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/components/header.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import '../../../../components/Listdrawer.dart';
import '../../../../localizations/appLocalizations.dart';
import '../../../../main.dart';
import '../../../../providers/manageService.dart';
import '../../../../providers/notification/index.dart';

import '../../../../screens/approvalSummary/index.dart';
import '../../../../screens/disApprovalSummary/index.dart';
import '../../../../screens/historyApsara/index.dart';
import '../../../../screens/listCustomerRegistration/index.dart';
import '../../../../screens/listLoanApproval/indexs.dart';
import '../../../../screens/listLoanRegistration/index.dart';
import '../../../../screens/notification/index.dart';
import '../../../../screens/notificationLoanArrear/index.dart';
import '../../../../screens/report/index.dart';
import '../../../../screens/report_summary/index.dart';
import '../../../../screens/requestSummary/index.dart';
import '../../../../screens/returnSummary/index.dart';
import '../../../widgets/custom_dashboard_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? totalUnread;
  @override
  void initState() {
    getNotificationLock();
    fetchVersionApp();
    getNotificationLoanArrear();
    checkMenu();
    super.initState();
  }

  final english = const AssetImage('assets/images/english.png');
  final khmer = const AssetImage('assets/images/khmer.png');
  checkMenu() {
    var test = storage.read(key: 'roles');
    test.then(
      (value) {
        if (value == null) {
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => Login()),
          //     ModalRoute.withName("/login"));
        } else {
          userRoleses = jsonDecode(value);
          userRoleses.add("99");
          userRoleses.add("98");
          userRoleses.add("97");

          for (var element in userRoleses) {
            if (element == 100003) {
              userRoles.insert(0, 100003);
            }
            if (element == 100002) {
              userRoles.insert(1, 100002);
            }
            if (element == 100004) {
              userRoles.add(100004);
            }
            if (element == "99") {
              userRoles.add(99);
            }

            if (element == "98") {
              userRoles.add(98);
            }
            if (element == "97") {
              userRoles.add(97);
            }
            if (element == 100001) {
              userRoles.add(100001);
            }
          }
        }

        // userRoleses = jsonDecode(value);
      },
    );
  }

  // PageController? _pageController;
  ExpandableController? _expandableController;
  final storage = new FlutterSecureStorage();

  Future<bool> _willPopCallback() async {
    // exit(0);
    return true; // return true if the route to be popped
  }

  getNotificationLoanArrear() async {
    await Provider.of<NotificationProvider>(context, listen: false)
        .pushNotificationLoanArrear()
        .then((value) {})
        .onError((error, stackTrace) {});
  }

  String version = "";
  fetchVersionApp() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
      // String appName = packageInfo.appName;
      // String packageName = packageInfo.packageName;
      // String buildNumber = packageInfo.buildNumber;
    });
  }

  var totalMessage;
  var totalRead;
  var listMessages;
  getNotificationLock() async {
    await Provider.of<NotificationProvider>(context, listen: false)
        .getNotification(20, 1)
        .then((value) => {
              for (var item in value)
                {
                  setState(() {
                    totalMessage = item['totalMessage'];
                    totalUnread = item['totalUnread'];
                    totalRead = item['totalRead'];
                    listMessages = item['listMessages'];
                  })
                },
            })
        .catchError((onError) {
      return onError;
    });
  }

  List<Object> userRoles = [];
  List<Object> userRoleses = [];
  String userId = '';
  String userName = '';
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

  onPushNotificationLoanArrear() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PushNotificationLoanLoanArrear()),
    );
  }

  onListLoanApproval() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListLoanApprovals()),
    );
  }

  onListCustomerRegistration() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListCustomerRegistrations()),
    );
  }

  onListReport() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportScreen()),
    );
  }

  onListLoanRegistration() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListLoanRegistrations()),
    );
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

  _drawerList(context) {
    String versionString =
        baseURLInternal == "http://119.82.252.42:2020/api/" ? "v" : "version";
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.logolightGreen),
              child: Column(
                children: <Widget>[
                  Flexible(
                      child: Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ProfileUploadImage()),
                              // );
                            },
                            color: Colors.grey,
                            icon: Icon(
                              Icons.person,
                              size: 100,
                            ))
                      ],
                    ),

                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   image: DecorationImage(image: profile, fit: BoxFit.fill),
                    // ),
                  )),
                  // Text(
                  //   userName != "" ? userName : "",
                  //   style: TextStyle(
                  //       fontSize: 18.0,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.white),
                  // ),
                  Center(
                    child: Text(
                      "${AppLocalizations.of(context)!.translate('your_id')} : ${userId}",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70),
                    ),
                  ),
                ],
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
                        CustomListTile(
                            Icons.notification_add,
                            "Notification Loan Arrear",
                            () => {onPushNotificationLoanArrear()},
                            null),
                        CustomListTile(
                            Icons.monetization_on,
                            AppLocalizations.of(context)!
                                    .translate('approval_list') ??
                                'Approval List',
                            () => {onListLoanApproval()},
                            null),
                        CustomListTile(
                            Icons.face,
                            AppLocalizations.of(context)!
                                    .translate('customer_list') ??
                                'Customer List',
                            () => {onListCustomerRegistration()},
                            null),
                        CustomListTile(
                            Icons.payment,
                            AppLocalizations.of(context)!
                                    .translate('loan_register_list') ??
                                'Loan Register List',
                            () => {onListLoanRegistration()},
                            null),
                        ExpandablePanel(
                          controller: _expandableController,
                          collapsed: Stack(
                            children: [
                              Expanded(
                                child: CustomListTile(
                                    Icons.report,
                                    AppLocalizations.of(context)!
                                            .translate('report') ??
                                        'Report', () {
                                  _expandableController?.expanded = true;
                                }, null),
                              ),
                              Positioned(
                                right: 0,
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: IconButton(
                                    onPressed: () {
                                      _expandableController?.expanded = true;
                                    },
                                    icon: Icon(Icons.arrow_drop_down),
                                  ),
                                ),
                              )
                            ],
                          ),
                          expanded: Column(
                            children: [
                              Stack(
                                children: [
                                  Expanded(
                                    child: CustomListTile(
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
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: IconButton(
                                        onPressed: () {
                                          _expandableController?.expanded =
                                              false;
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
                                  color: AppColors.logolightGreen,
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
                                            'Report Approval', () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ApprovalSummary()),
                                      );
                                    }, null),
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
                                    CustomListTile(
                                      Icons.payment,
                                      AppLocalizations.of(context)!.translate(
                                              'loan_approval_history') ??
                                          'Loan Report History',
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HistoryApsara(),
                                          ),
                                        );
                                      },
                                      null,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomListTile(
                            Icons.report,
                            AppLocalizations.of(context)!.translate('report') ??
                                'Report',
                            () => {onListReport()},
                            null),
                        CustomListTile(
                          null,
                          AppLocalizations.of(context)!
                                  .translate('english_language') ??
                              'English',
                          () => {englishLanguage()},
                          english,
                        ),
                        CustomListTile(
                          null,
                          'ភាសាខ្មែរ',
                          () => {khmerLanguage()},
                          khmer,
                        ),
                        CustomListTile(
                            Icons.lock,
                            AppLocalizations.of(context)!
                                    .translate('log_out') ??
                                'Log Out',
                            () => {con.onSignOut(context)},
                            null),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        ListTile(
                          title: Text("$versionString" + '$version'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Header(
          drawers: new Drawer(
            child: _drawerList(context),
          ),
          headerTexts: AppLocalizations.of(context)!.translate('home'),
          actionsNotification: <Widget>[
            // Using Stack to show Notification Badge
            new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new IconButton(
                    icon: Icon(
                      Icons.notifications,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()),
                      );
                    }),
                //
                totalUnread != 0
                    ? new Positioned(
                        right: 11,
                        top: 14,
                        child: new Container(
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            totalUnread.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : new Container()
              ],
            ),
          ],
          bodys: CustomDashBoardCard(),
        )
        // Scaffold(
        //     appBar: AppBar(
        //       backgroundColor: AppColors.logolightGreen,
        //       title: Text('Home'),
        //       actions: [],
        //     ),
        //     // CustomAppBar(
        //     //     centerTitle: true,
        //     //     context: context,
        //     //     title: 'Home',
        //     //     action: [
        //     //       Stack(
        //     //         alignment: Alignment.center,
        //     //         children: <Widget>[
        //     //           new IconButton(
        //     //               icon: Icon(
        //     //                 Icons.notifications,
        //     //                 size: 25,
        //     //               ),
        //     //               onPressed: () {
        //     //                 Navigator.push(
        //     //                   context,
        //     //                   MaterialPageRoute(
        //     //                       builder: (context) => NotificationScreen()),
        //     //                 );
        //     //               }),
        //     //           totalUnread != 0
        //     //               ? new Positioned(
        //     //                   right: 11,
        //     //                   top: 14,
        //     //                   child: new Container(
        //     //                     padding: EdgeInsets.all(2),
        //     //                     decoration: new BoxDecoration(
        //     //                       color: Colors.red,
        //     //                       borderRadius: BorderRadius.circular(6),
        //     //                     ),
        //     //                     constraints: BoxConstraints(
        //     //                       minWidth: 14,
        //     //                       minHeight: 14,
        //     //                     ),
        //     //                     child: Text(
        //     //                       totalUnread.toString(),
        //     //                       style: TextStyle(
        //     //                         color: Colors.white,
        //     //                         fontSize: 8,
        //     //                       ),
        //     //                       textAlign: TextAlign.center,
        //     //                     ),
        //     //                   ),
        //     //                 )
        //     //               : new Container()
        //     //         ],
        //     //       ),
        //     //     ]),
        //     drawer: Drawer(
        //       child: ListView(
        //         // Important: Remove any padding from the ListView.
        //         padding: EdgeInsets.zero,
        //         children: [
        //           const DrawerHeader(
        //             decoration: BoxDecoration(
        //               color: Colors.blue,
        //             ),
        //             child: Text('Drawer Header'),
        //           ),
        //           ListTile(
        //             leading: Icon(
        //               Icons.home,
        //             ),
        //             title: const Text('Page 1'),
        //             onTap: () {
        //               Navigator.pop(context);
        //             },
        //           ),
        //           ListTile(
        //             leading: Icon(
        //               Icons.train,
        //             ),
        //             title: const Text('Page 2'),
        //             onTap: () {
        //               Navigator.pop(context);
        //             },
        //           ),
        //         ],
        //       ),
        //     ),
        //     body:
        //         // Container(
        //         //     margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        //         //     child: GridView.count(
        //         //         primary: false,
        //         //         // padding:
        //         //         //     const EdgeInsets.only(left: 45.0, right: 45.0, top: 20),
        //         //         crossAxisSpacing: 15,
        //         //         mainAxisSpacing: 15,
        //         //         crossAxisCount: 2,
        //         //         children: [
        //         //           MenuCard(
        //         //             onTap: () => Navigator.push(
        //         //               context,
        //         //               MaterialPageRoute(builder: (context) => ApprovalLists()),
        //         //             ),
        //         //             color: AppColors.logolightGreen,
        //         //             // imageNetwork: list,
        //         //             icons: Icon(
        //         //               Icons.note_add,
        //         //               color: Colors.white,
        //         //               size: 50,
        //         //             ),
        //         //             text: AppLocalizations.of(context)!
        //         //                 .translate('list_loan_approval'),
        //         //           ),
        //         //           MenuCard(
        //         //             onTap: () => Navigator.push(
        //         //               context,
        //         //               MaterialPageRoute(
        //         //                   builder: (context) => CustomerRegister()),
        //         //             ),
        //         //             color: AppColors.logolightGreen,
        //         //             // imageNetwork: register,
        //         //             icons: Icon(
        //         //               Icons.person_add,
        //         //               color: Colors.white,
        //         //               size: 50,
        //         //             ),
        //         //           ),
        //         //           MenuCard(
        //         //             onTap: () => Navigator.push(
        //         //               context,
        //         //               MaterialPageRoute(
        //         //                   builder: (context) => CustomerRegister()),
        //         //             ),
        //         //             color: AppColors.logolightGreen,
        //         //             // imageNetwork: register,
        //         //             icons: Icon(
        //         //               Icons.person_add,
        //         //               color: Colors.white,
        //         //               size: 50,
        //         //             ),
        //         //             text: AppLocalizations.of(context)!
        //         //                     .translate('customer_registration') ??
        //         //                 'Customer',
        //         //           ),
        //         //           MenuCard(
        //         //             onTap: () => Navigator.push(
        //         //               context,
        //         //               MaterialPageRoute(builder: (context) => LoanRegister()),
        //         //             ),
        //         //             color: AppColors.logolightGreen,
        //         //             // imageNetwork: loanRegistration,
        //         //             icons: Icon(
        //         //               Icons.edit_note,
        //         //               color: Colors.white,
        //         //               size: 50,
        //         //             ),
        //         //             text: AppLocalizations.of(context)!
        //         //                     .translate('loan_registration') ??
        //         //                 'Loan Registration',
        //         //           ),
        //         //           Container(
        //         //             width: 10,
        //         //             height: 20,
        //         //             child: MenuCard(
        //         //               onTap: () => Navigator.push(
        //         //                 context,
        //         //                 MaterialPageRoute(builder: (context) => PolicyScreen()),
        //         //               ),
        //         //               color: AppColors.logolightGreen,
        //         //               // imageNetwork: policy,
        //         //               icons: Icon(
        //         //                 Icons.auto_stories,
        //         //                 color: Colors.white,
        //         //                 size: 50,
        //         //               ),
        //         //               text: AppLocalizations.of(context)!.translate('policy') ??
        //         //                   'Policy',
        //         //             ),
        //         //           ),
        //         //           Container(
        //         //             width: 10,
        //         //             height: 20,
        //         //             child: MenuCard(
        //         //               onTap: () => Navigator.push(
        //         //                 context,
        //         //                 MaterialPageRoute(
        //         //                     builder: (context) => LoanArrearScreen()),
        //         //               ),
        //         //               color: AppColors.logolightGreen,
        //         //               icons: Icon(
        //         //                 Icons.account_balance_wallet,
        //         //                 color: Colors.white,
        //         //                 size: 50,
        //         //               ),
        //         //               text: AppLocalizations.of(context)!
        //         //                   .translate('loan_arrear'),
        //         //             ),
        //         //           ),
        //         //           Container(
        //         //             width: 10,
        //         //             height: 20,
        //         //             child: MenuCard(
        //         //               onTap: () => Navigator.push(
        //         //                 context,
        //         //                 MaterialPageRoute(builder: (context) => LMapScreen()),
        //         //               ),
        //         //               color: AppColors.logolightGreen,
        //         //               icons: Icon(
        //         //                 Icons.real_estate_agent,
        //         //                 color: Colors.white,
        //         //                 size: 50,
        //         //               ),
        //         //               text:
        //         //                   AppLocalizations.of(context)!.translate('lmap_data'),
        //         //             ),
        //         //           ),
        //         //           Container(
        //         //             width: 10,
        //         //             height: 20,
        //         //             child: MenuCard(
        //         //               onTap: () => Navigator.push(
        //         //                 context,
        //         //                 MaterialPageRoute(builder: (context) => IRRScreen()),
        //         //               ),
        //         //               color: AppColors.logolightGreen,
        //         //               icons: Icon(
        //         //                 Icons.calculate,
        //         //                 color: Colors.white,
        //         //                 size: 50,
        //         //               ),
        //         //               text: 'IRR Calculator',
        //         //             ),
        //         //           ),
        //         //         ]))

        //         CustomDashBoardCard(
        //             // icon: Icon(Icons.menu),
        //             // title: 'Test',
        //             )
        //     // ListView.builder(

        //     //   itemCount: menuList.length,
        //     //   itemBuilder: (context, index) {
        //     //     return CustomDashBoardCard(
        //     //       icon: menuList[index].icon,
        //     //       title: menuList[index].title,
        //     //     );
        //     //   },
        //     // ),
        //     //     GridView.count(
        //     //   physics: NeverScrollableScrollPhysics(),
        //     //   // padding: EdgeInsets.all(20),
        //     //   semanticChildCount: 3,
        //     //   shrinkWrap: true,
        //     //   crossAxisCount: 2,
        //     //   crossAxisSpacing: 20.0,
        //     //   mainAxisSpacing: 20.0,
        //     //   children: List.generate(menuList.length, (index) {
        //     //     return CustomDashBoardCard(
        //     //       icon: menuList[index].icon,
        //     //       title: menuList[index].title,
        //     //     );
        //     //   }),
        //     // ),

        //     ),
        );
  }
}
