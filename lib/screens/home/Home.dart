// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chokchey_finance/app/module/login/controllers/login_controller.dart';
import 'package:chokchey_finance/app/utils/helpers/local_database.dart';
import 'package:chokchey_finance/app/utils/helpers/responsive.dart';
import 'package:chokchey_finance/components/Listdrawer.dart';
import 'package:chokchey_finance/components/header.dart';
import 'package:chokchey_finance/components/menuCard.dart';
import 'package:chokchey_finance/localizations/appLocalizations.dart';
import 'package:chokchey_finance/providers/manageService.dart';
import 'package:chokchey_finance/providers/notification/index.dart';
import 'package:chokchey_finance/screens/approval/approvalList.dart';
import 'package:chokchey_finance/screens/customerRegister/customerRegister.dart';
import 'package:chokchey_finance/screens/historyApsara/index.dart';
import 'package:chokchey_finance/components/custom_profileuser.dart';
import 'package:chokchey_finance/screens/notificationLoanArrear/index.dart';
import 'package:chokchey_finance/screens/listCustomerRegistration/index.dart';
import 'package:chokchey_finance/screens/listLoanApproval/indexs.dart';
import 'package:chokchey_finance/screens/listLoanRegistration/index.dart';
import 'package:chokchey_finance/screens/loanRegistration/loanRegistration.dart';
import 'package:chokchey_finance/screens/notification/index.dart';
import 'package:chokchey_finance/screens/report/index.dart';
import 'package:chokchey_finance/screens/returnSummary/index.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expandable/expandable.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../app/module/loan_arrear/screens/loan_arrear_screen.dart';
import '../../app/module/log/controller/log_controller.dart';
import '../../app/module/log/screen/login_screen.dart';
import '../../app/module/policy/screen/policy_memo.dart';
import '../../app/utils/helpers/activity_log.dart';
import '../../app/utils/helpers/internet_connection.dart';
import '../../app/utils/helpers/sqlite_helper.dart';
import '../../main.dart';
import '../../providers/approvalHistory/index.dart';
import '../../providers/lmapProvider/index.dart';
import '../approvalSummary/index.dart';
import '../disApprovalSummary/index.dart';
import '../irr/index.dart';
import '../lMap/index.dart';
import '../report_summary/index.dart';
import '../requestSummary/index.dart';
import '../../app/module/home_new/screen/new_homescreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final loginCon = Get.put(LoginController());
  final controllerLog = Get.put(LogController());
  // int _currentIndex = 0;
  PageController? _pageController;
  ExpandableController? _expandableController;
  final storage = new FlutterSecureStorage();

  String userId = '';
  String userName = '';
  String branch = '';
  // dynamic _profleImage;

  var profile;

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  var futureNotification;

  @override
  void didChangeDependencies() {
    getStoreUser();
    // Future.delayed(Duration(microseconds: 100), () {
    loadOfflineUserInfo();
    // });

    getListBranches();
    // debugPrint('device==:${MediaQuery.of(context)}');
    // getMessageFromCEO();
    // profile = const AssetImage('assets/images/profile_create.jpg');
    super.didChangeDependencies();
  }

  var messageFromCEO;
  // var listMessageFromCEO;
  var _isLoading = false;
  var langCode;

// ConnectivityResult connectivityResult = ConnectivityResult.none;
  SqliteHelper? sqliteHelper; // = SqliteHelper();
  StreamSubscription? connection;
  bool isoffline = false;
  var idNointernet;
  var user;
  Database? database;
  Future<void> onUser() async {
    debugPrint("Hello");
    sqliteHelper = SqliteHelper();
    // ignore: unused_local_variable
    var getuserId = sqliteHelper!.getData(tableName: 'Login');
    //final db = await sqliteHelper!.GetDatabase();

    user = await sqliteHelper!
        .queryData(sql: 'Select * from Login where userId=102550');
    // final db = sqliteHelper!.getDatabase().r;
    // if(db != null){

    // }

    debugPrint("Test User" + user);

    if (user != null) {
      debugPrint('Have User======:$user');
    } else {
      debugPrint('don have user======:$user');
    }
  }

  late List<Map<String, dynamic>> getID;
  var ids;
  Future getUserId() async {
    getID = await sqliteHelper!.getData(tableName: 'Login');
    // var liat = getID[0]['userId'];
    // debugPrint('jiiii:$liat');
    getID.asMap().entries.map((e) {
      var id = e.value['userId'];
      ids = id;
      // if (ids == userId) {
      //   debugPrint('correct:');
      // } else {
      //   debugPrint('incorrect:');
      // }
      debugPrint('listt===:${ids}');
    }).toList();
    debugPrint('i get id:${ids}');
    debugPrint('jjjhhhhhh:${getID.length}');
  }

  // Future<void> openDatabases() async {
  //   var databasesPath = await getDatabasesPath();

  //   database = await openDatabase(
  //     join(await getDatabasesPath(), 'databaseName.db'),
  //     onCreate: (db, version) {},
  //     version: 2,
  //   );
  // }
  final controller = Get.put(ConnenctivityApp());
  /////////////// internet connetion
  Future<void> onConnection() async {
    connection = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        controllerLog.isoffline.value = false;
        debugPrint('ofline=okkk----------: ${controllerLog.isoffline.value}');
        // whenevery connection status is changed.
        if (result == ConnectivityResult.none) {
          //there is no any connection
          controllerLog.isoffline.value = true;
          // setState(() {
          //   isoffline = true;
          // });
          debugPrint('ofline.non:${controllerLog.isoffline.value}');
          debugPrint('ofline.non:${controller.getUserId.value}');
        } else if (result == ConnectivityResult.mobile) {
          //connection is mobile data network
          controllerLog.isoffline.value = false;
          // setState(() {
          //   isoffline = false;
          // });
          debugPrint('ofline.mobile:$isoffline');
        } else if (result == ConnectivityResult.wifi) {
          controllerLog.isoffline.value = true;
          //connection is from wifi
          // setState(() {
          //   isoffline = false;
          // });
          debugPrint('ofline.wifi:$isoffline');
        } else if (result == ConnectivityResult.ethernet) {
          //connection is from wired connection
          controllerLog.isoffline.value = false;
          // setState(() {
          //   isoffline = false;
          // });
        } else if (result == ConnectivityResult.bluetooth) {
          //connection is from bluetooth threatening
          controllerLog.isoffline.value = false;
          // setState(() {
          //   isoffline = false;
          // });
        }
      },
    );
  }

  onChngaeLang(String? enLang) async {
    await storage.write(key: 'lang_code', value: '$enLang');
    if (enLang == 'en_US') {
      englishLanguage();
    } else {
      khmerLanguage();
    }
  }

  englishLanguage() async {
    Locale _temp;
    _temp = Locale('en', 'US');
    MyHomePage.setLocale(context, _temp);
  }

  khmerLanguage() async {
    Locale _temp;
    _temp = Locale('km', 'KH');
    MyHomePage.setLocale(context, _temp);
  }

  @override
  void initState() {
    sqliteHelper = SqliteHelper();

    // setState(() {
    //   debugPrint('ofline1111111111122');
    //   if (isoffline == true) {
    //     controller.getUserId.value;
    //     debugPrint('ofline11111111');
    //   }
    //   // isoffline = true;
    onConnection();
    // });
    storage.read(key: 'lang_code').then((lang) {
      onChngaeLang(lang);
    });
    super.initState();
    _pageController = PageController();
    _expandableController = ExpandableController();
    FirebaseMessaging.instance.getNotificationSettings();
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // RemoteNotification notification = message.notification!;
      // AndroidNotification? android = message.notification?.android;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationScreen()),
      );
    });
    getNotificationLock();
    fetchVersionApp();
    getListBranches();
    getNotificationLoanArrear();
    // checkMenu();
  }

  getNotificationLoanArrear() async {
    await Provider.of<NotificationProvider>(context, listen: false)
        .pushNotificationLoanArrear()
        .then((value) {})
        .onError((error, stackTrace) {});
  }

  String version = "";
  fetchVersionApp() async {
    PackageInfo.fromPlatform().then(
      (PackageInfo packageInfo) {
        version = packageInfo.version;
        // String appName = packageInfo.appName;
        // String packageName = packageInfo.packageName;
        // String buildNumber = packageInfo.buildNumber;
      },
    );
  }
//  var listBranch = [];
//   Future getListBranches() async {
//     await ApprovalHistoryProvider()
//         .getListBranch()
//         .then(
//           (value) => {
//             setState(
//               () {
//                 listBranch = value;
//               },
//             ),
//           },
//         )
//         .catchError((onError) {
//       return onError;
//     });
  // }

  var totalMessage;
  var totalUnread;
  var totalRead;
  var listMessages;
  getNotificationLock() async {
    try {
      await Provider.of<NotificationProvider>(context, listen: false)
          .getNotification(20, 1)
          .then(
            (value) => {
              for (var item in value)
                {
                  if (this.mounted)
                    {
                      setState(
                        () {
                          totalMessage = item['totalMessage'];
                          totalUnread = item['totalUnread'];
                          totalRead = item['totalRead'];
                          listMessages = item['listMessages'];
                        },
                      )
                    }
                },
            },
          );
    } catch (e) {
      debugPrint("on catch !!$e");
    }
  }

  var listBranch = [];
  List<Object> userRoles = [];
  List<Object> userRoleses = [];
  Future getListBranches() async {
    await ApprovalHistoryProvider()
        .getListBranch()
        .then((value) => {
              setState(() {
                listBranch = value;
              }),
            })
        .catchError((onError) {
      return onError;
    });
  }

  loadOfflineUserInfo() {
    LocalDatabase.instance.getOfflineUserInfo().then(
      (value) {
        setState(
          () {
            if (value != null) {
              controller.userName.value = value.userName;
              controller.getUserId.value = int.parse(value.userID);
              debugPrint("info sql id: ${controller.userName.value}");
              debugPrint("info sql id: ${controller.getUserId.value}");
            }
          },
        );
      },
    );
  }

  getStoreUser() async {
    // var langCode = AppLocalizations.of(context)!.locale.languageCode;
    String? userIds = await storage.read(key: 'user_id');
    String? userNames = await storage.read(key: 'user_name');
    String? userBranch = await storage.read(key: 'branch');
    setState(
      () {
        userName = '$userNames';
        userId = '$userIds';
        branch = '$userBranch';
        controller.userName.value = userName;
        controller.getUserId.value = int.parse(userId);
        debugPrint("info name: ${controller.userName.value}");
        debugPrint("info id: ${controller.getUserId.value}");
        debugPrint("info connextion: ${controller.isoffline.value}");
      },
    );
  }

  onLogOut() async {
    await LocalDatabase.instance.removeOldOfflineUser();
    await storage.deleteAll();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            //Login(),
            LoginScreenNew(),
      ),
    );
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => Login()),
    //     ModalRoute.withName("/login"));
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

  // englishLanguage() {
  //   Locale _temp;
  //   _temp = Locale('en', 'US');
  //   MyHomePage.setLocale(context, _temp);
  // }

  // khmerLanguage() {
  //   Locale _temp;

  //   _temp = Locale('km', 'KH');
  //   MyHomePage.setLocale(context, _temp);
  // }

  final String image = '';
  _drawerList(context) {
    debugPrint('info internet ${controllerLog.isoffline.value}');
    String versionString =
        baseURLInternal == "http://119.82.252.42:2020/api/" ? "v" : "version";
    return Drawer(
      // backgroundColor: logolightGreen,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(color: logolightGreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // controllerLog.isoffline.value == true
                    //     ? Obx(
                    //         () => Container(
                    //           alignment: Alignment.center,
                    //           child: Text(
                    //             "id : ${controller.getUserId.value}",
                    //             style: TextStyle(
                    //                 fontSize: 15.0,
                    //                 fontWeight: FontWeight.w500,
                    //                 color: Colors.white70),
                    //           ),
                    //         ),
                    //       )
                    //     :
                    Padding(
                        padding:
                            const EdgeInsets.only(top: 15, right: 10, left: 10),
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
                              "${AppLocalizations.of(context)!.translate('name')}: ${controller.userName.value}",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${AppLocalizations.of(context)!.translate('your_id')} : ${controller.getUserId.value}",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70),
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewHomeScreen(),
                            ),
                          );
                        },
                        child: Text("new screen"),
                      ),
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
                                //width: 200,
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
                                          'Report Approval', () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ApprovalSummary()),
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
                      // CustomListTile(
                      //     Icons.report,
                      //     AppLocalizations.of(context)!.translate('report') ??
                      //         'Report',
                      //     () => {onListReport()},
                      //     null),
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
                          // englishLanguage()
                          onChngaeLang('en_US')
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
                          //khmerLanguage()
                          onChngaeLang('km_KH')
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
                      // CustomListTile(
                      //     Icons.lock,
                      //     AppLocalizations.of(context)!.translate('log_out') ??
                      //         'Log Out',
                      //     () => {(onLogOut())},
                      //     null),
                      // Padding(padding: EdgeInsets.only(top: 10)),
                      // ListTile(
                      //   title: Text("$versionString" + '$version'),
                      //   onTap: () {},
                      // ),
                      // Spacer(),
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
                  Text("$versionString" + ' $version'),
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
                              "${AppLocalizations.of(context)!.translate('log_out') ?? 'Log Out'}"),
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

  final register = const AssetImage('assets/images/register.png');
  final loanRegistration =
      const AssetImage('assets/images/loanRegistration.png');
  final list = const AssetImage('assets/images/findApproval.png');
  final policy = const AssetImage('assets/images/policy.png');

  Future<bool> _onBackPressed() async {
    AwesomeDialog(
        context: context,
        // animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.INFO,
        title: AppLocalizations.of(context)!.translate('information') ??
            'Information',
        desc: AppLocalizations.of(context)!.translate('do_you_want_to_exit') ??
            'Do you want to exit?',
        btnOkOnPress: () async {
          Future.delayed(const Duration(milliseconds: 1000), () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          });
        },
        btnCancelText: AppLocalizations.of(context)!.translate('no') ?? "No",
        btnCancelOnPress: () {},
        btnCancelIcon: Icons.close,
        btnOkIcon: Icons.check_circle,
        btnOkColor: logolightGreen,
        btnOkText: AppLocalizations.of(context)!.translate('yes') ?? 'Yes')
      ..show();
    return false;
  }

  final english = const AssetImage('assets/images/english.png');
  final khmer = const AssetImage('assets/images/khmer.png');

  @override
  Widget build(BuildContext context) {
    // var langCode = AppLocalizations.of(context)!.locale.languageCode;
    // double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onBackPressed,
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
          bodys: _isLoading
              ? Center(
                  child: Container(
                    child: CircularProgressIndicator(
                      color: logolightGreen,
                    ),
                  ),
                )
              : _isLoading
                  ? Center(
                      child: Container(
                        child: CircularProgressIndicator(
                          color: logolightGreen,
                        ),
                      ),
                    )
                  : CheckResponsive(
                      smallWidget: _menuHome(crossAxisCount: 2),
                      mediumWidget: _menuHome(crossAxisCount: 3),
                      largeWidget: _menuHome(crossAxisCount: 4),
                    )

          // bottomNavigationBars: BottomNavyBar(
          //   selectedIndex: _currentIndex,
          //   onItemSelected: (index) {
          //     setState(() => _currentIndex = index);
          //     _pageController!.jumpToPage(index);
          //   },
          //   items: <BottomNavyBarItem>[
          //     BottomNavyBarItem(
          //         title: Text(
          //             AppLocalizations.of(context)!.translate('home') ?? 'Home'),
          //         icon: Icon(Icons.home),
          //         textAlign: TextAlign.center,
          //         activeColor: logolightGreen),
          //     BottomNavyBarItem(
          //         title: Text(
          //             AppLocalizations.of(context)!.translate('irr') ?? 'IRR'),
          //         icon: Icon(Icons.calculate),
          //         textAlign: TextAlign.center,
          //         activeColor: logolightGreen),
          //     // BottomNavyBarItem(
          //     //     title: Text(AppLocalizations.of(context)!.translate('search') ??
          //     //         'Search'),
          //     //     icon: Icon(Icons.search),
          //     //     textAlign: TextAlign.center,
          //     //     activeColor: logolightGreen),
          //     // BottomNavyBarItem(
          //     //     title: Text(AppLocalizations.of(context)!.translate('setting') ??
          //     //         'Setting'),
          //     //     icon: Icon(Icons.settings),
          //     //     textAlign: TextAlign.center,
          //     //     activeColor: logolightGreen),
          //   ],
          // ),
          ),
    );
  }

  Widget _menuHome({int? crossAxisCount}) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30),
        crossAxisSpacing: 20,
        mainAxisSpacing: 15,
        crossAxisCount: crossAxisCount!,
        children: [
          MenuCard(
            onTap: () {
              onActivityLogDevice(
                userId: userId,
                description: "Laon Registration",
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoanRegister()),
              );
            },
            color: logolightGreen,
            // imageNetwork: loanRegistration,
            icons: Icon(
              Icons.edit_note,
              color: Colors.white,
              size: 45,
            ),
            text:
                AppLocalizations.of(context)!.translate('loan_registration') ??
                    'Loan Registration',
          ),
          MenuCard(
            onTap: () {
              onActivityLogDevice(
                userId: userId,
                description: "Customer Registration",
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerRegister()),
              );
            },
            color: logolightGreen,
            // imageNetwork: register,
            icons: Icon(
              Icons.person_add,
              color: Colors.white,
              size: 45,
            ),
            text: AppLocalizations.of(context)!.translate('customers') ??
                'Customer',
            text2: AppLocalizations.of(context)!.translate('registration') ??
                'Registration',
          ),
          MenuCard(
            onTap: () {
              onActivityLogDevice(
                userId: userId,
                description: "Memo and Policy",
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PolicyMemoScreen(),
                  //  PolicyScreen(),
                ),
              );
            },
            color: logolightGreen,
            // imageNetwork: policy,
            icons: Icon(
              Icons.auto_stories,
              color: Colors.white,
              size: 43,
            ),
            text: AppLocalizations.of(context)!.translate('policy') ?? 'Policy',
          ),
          MenuCard(
            onTap: () {
              onActivityLogDevice(
                userId: userId,
                description: "Loan Arrears",
              );
              Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context) => LoanArrearScreen()));
                  MaterialPageRoute(builder: (context) => LoanArrearScreens()));
            },
            color: logolightGreen,
            icons: Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 43,
            ),
            text: AppLocalizations.of(context)!.translate('loan_arrear'),
          ),
          Consumer<LmapProvider>(builder: (context, myModel, child) {
            return MenuCard(
              onTap: () {
                myModel.clearLmap();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        // LmapScreen()
                        LMapScreen(),
                  ),
                );
              },
              color: logolightGreen,
              icons: Icon(
                Icons.real_estate_agent,
                color: Colors.white,
                size: 45,
              ),
              text: AppLocalizations.of(context)!.translate('lmap_data'),
            );
          }),
          MenuCard(
            onTap: () {
              onActivityLogDevice(
                userId: userId,
                description: "Loan Approval",
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApprovalLists()),
              );
            },
            color: logolightGreen,
            // imageNetwork: list,
            icons: Icon(
              Icons.checklist,
              color: Colors.white,
              size: 45,
            ),
            text: AppLocalizations.of(context)!.translate('list_loan_approval'),
          ),
          MenuCard(
            onTap: () {
              onActivityLogDevice(
                userId: userId,
                description: "IRR",
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IRRScreen()),
              );
            },
            color: logolightGreen,
            icons: Icon(
              Icons.calculate,
              color: Colors.white,
              size: 45,
            ),
            text: 'IRR Calculator',
          ),
        ],
      ),
    );
  }
}

List<Widget> items = [
  imagePlayer(
      'https://c0.wallpaperflare.com/preview/472/832/1024/investment-finance-time-return-on-investment.jpg'),
  imagePlayer('https://c8.alamy.com/comp/H9FAN7/personal-loan-H9FAN7.jpg'),
  imagePlayer(
      'https://www.indusind.com/iblogs/wp-content/uploads/Things-to-Keep-in-Mind-Before-Taking-a-Personal-Loan.jpg')
];

Widget imagePlayer(String image) {
  return Image.network(
    '$image',
    fit: BoxFit.cover,
  );
}
