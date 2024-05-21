// ignore_for_file: deprecated_member_use
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chokchey_finance/app/module/home_new/screen/drawer_screen.dart';
import 'package:chokchey_finance/app/module/memo_policy/screen/memo_policy_screen.dart';
import 'package:chokchey_finance/app/module/notifications/controllers/notification_controller.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';
import '../../../../screens/approval/approvalList.dart';
import '../../../../screens/customerRegister/customerRegister.dart';
import '../../../../screens/irr/index.dart';
import '../../../../screens/lMap/index.dart';
import '../../../../screens/loanRegistration/loanRegistration.dart';
import '../../../../utils/storages/responsive.dart';
import '../../../utils/helpers/activity_log.dart';
import '../../../utils/helpers/sqlite_helper.dart';
import '../../loan_arrear/controllers/loan_arrear_controller.dart';
import '../../loan_follow_up/screen/loan_followup.dart';
import '../../log/controller/log_controller.dart';
import '../../log/controller/par_controller.dart';
import '../../../utils/helpers/internet_connection.dart';
import '../../../utils/helpers/local_database.dart';
import '../../../utils/helpers/map_helper.dart';
import '../../../../localizations/appLocalizations.dart';
import '../../../../providers/notification/index.dart';
import 'dart:io' show Platform;

import '../../notifications/Screens/main_notification.dart';
import '../../policy/screen/policy_memo.dart';
import '../../up_comming_feature/index.dart';
import '../../util/widget/custom_category.dart';
import '../custom/custom_card_par_new.dart';
import '../custom/custom_defulf_arrear.dart';
import '../model/arrear_model_new.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  double screenWidth = 0.0;
  double screenHeight = 0.0;

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

  Future<void> getData() async {
    setState(() {
      Future.delayed(Duration(seconds: 1), () async {
        await sqliteHelper!.queryData(sql: "Select * from HomeParArrear");
      });
    });
  }

  final notiCon = Get.put(NotificationController());
  String release = "";
  SqliteHelper? sqliteHelper;
  int index = 0;

  onNavigateDetail() {
    notiCon.getNotiDetail(notiCon.notiArrDetail.value.id);
  }

  @override
  void initState() {
    onCheckPar();
    sqliteHelper = SqliteHelper();
    onNavigateDetail();
    onParArrear();
    mapCon.determinePosition();
    controllerArrear.isLanguge.value = true;
    getStoreUser();
    storage.read(key: 'lang_code').then((lang) {
      onChngaeLang(lang);
    });

    loadOfflineUserInfo();
    getNotificationLock();

    //onLoanArrear();
    controllerLog.onConnection();
    super.initState();
    FirebaseMessaging.instance.getNotificationSettings();
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {},
    );

    LocalDatabase.instance.checkTableCreation();

    onCheckDevice();
  }

  basicStatusCheck(NewVersionPlus newVersion) async {
    final version = await newVersion.getVersionStatus();
    if (version!.canUpdate == true) {
      release = version.releaseNotes ?? "";
      advancedStatusCheck(newVersion);
      setState(() {});
    }
    newVersion.showAlertIfNecessary(
      context: context,
      launchModeVersion: LaunchModeVersion.external,
    );
  }

  advancedStatusCheck(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Update Available',
        dialogText:
            'You can now update this app from ${status.localVersion} to ${status.storeVersion}',
        // dismissButtonText: ,
        launchModeVersion: LaunchModeVersion.external,
        allowDismissal: true,
      );
    }
  }

  // final controllerResArrear = Get.put(ResArrearController());
  final controllerArrear = Get.put(ParController());
  final controllerLog = Get.put(LogController());
  final con = Get.put(LoanArrearController());
  final controller = Get.put(ConnenctivityApp());
  final mapCon = Get.put(MapHelperController());
  bool? isSelect = false;
  String userId = '';
  String userName = '';
  String branch = '';
  String typeUser = '';
  double? hightLine = 0;
  double? hightLineKH = 0;

  onCheckDevice() {
    if (Platform.isAndroid) {
      hightLine = 140;
      hightLineKH = 140;
    } else if (Platform.isIOS) {
      hightLine = 160;
      hightLineKH = 170;
    }
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

  loadOfflineLaonArrearInfo() async {
    await LocalDatabase.instance.getOfflineLoanArrearInfo().then(
      (value) {
        controllerArrear.userName.value = value!.uname;
        controllerArrear.userId.value = value.userId;
        setState(
          () {},
        );
      },
    );
  }

  getStoreUser() async {
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
      },
    );
  }

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
    } catch (e) {}
  }

  Future<bool> _onBackPressed() async {
    AwesomeDialog(
        context: context,
        width: Responsive.isMobile(context) ? screenWidth : screenWidth / 2,
        headerAnimationLoop: false,
        dialogType: DialogType.INFO,
        transitionAnimationDuration: const Duration(milliseconds: 1000),
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

  onCheckPar() async {
    final currentDate = DateTime.now();
    var date = DateFormat("yyyyMMdd").format(
      DateTime(currentDate.year, currentDate.month, currentDate.day - 1),
    );
    print("Base Date : ${date}");
    var type = await storage.read(key: 'user_type');
    var branchCode = await storage.read(key: 'branch');
    var empCode = await storage.read(key: 'user_ucode');
    if (type == "CO") {
      con.getParArrHome(
        baseDate: '$date',
        employeeCode: '$empCode',
        overdueDay: 0,
        branchCode: '',
      );
    } else if (type == "BM" || type == "BTL") {
      con.getParArrHome(
        baseDate: '$date',
        employeeCode: '',
        overdueDay: 0,
        branchCode: '$branchCode',
      );
    } else {
      // For MNG
      con.getParArrHome(
        baseDate: '$date',
        employeeCode: '',
        overdueDay: 0,
        branchCode: '',
      );
    }
  }

  onParArrear() async {
    final currentDate = DateTime.now();
    var date = DateFormat("yyyyMMdd").format(
        DateTime(currentDate.year, currentDate.month, currentDate.day - 1));
    var type = await storage.read(key: 'user_type');
    var branchCode = await storage.read(key: 'branch');
    var empCode = await storage.read(key: 'user_ucode');
    if (type == "CO") {
      con.onfilterArrearNew(
        baseDate: '$date',
        employeeCode: '$empCode',
        overDueday: 0,
        branchCode: '',
      );
    } else if (type == "BM" || type == "BTL") {
      con.onfilterArrearNew(
        baseDate: '$date',
        employeeCode: '',
        overDueday: 0,
        branchCode: '$branchCode',
      );
    } else {
      // For MNG

      con.onfilterArrearNew(
        baseDate: '$date',
        employeeCode: '',
        overDueday: 0,
        branchCode: '',
      );
    }
  }

  onRefreshData() async {
    await onCheckPar();
  }

  bool isViewPar = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    final hightLines = MediaQuery.of(context).size.height * 0.16;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.2,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: logolightGreen,
          title: GestureDetector(
            child: Text(
              "Operation",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainNotificationScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(
                      "assets/svg/bell.svg",
                      color: Colors.white,
                      height: 30,
                    ),
                  ),
                ),
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
                            "$totalUnread",
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
        ),
        drawer: DrawerScreen(),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: RefreshIndicator(
                onRefresh: () {
                  return onRefreshData();
                },
                child: ListView(
                  children: [
                    isViewPar == false
                        ? CustomDefulfArrear()
                        : Obx(
                            () => CustomCardParNew(
                              parArrHomeModel: con.parArrHomeModel.value,
                              userId: userId,
                              onNavigat: () {},
                            ),
                          ),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          onRefreshData();
                          if (con.isLoadingParArrHome.value == false) {
                            setState(() {
                              isViewPar = true;
                            });
                          }
                        },
                        child: con.isLoadingParArrHome.value == true
                            ? Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: logoDarkBlue,
                                ),
                                child: Center(
                                  child: DefaultTextStyle(
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Loading',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 5.0),
                                        AnimatedTextKit(
                                          animatedTexts: [
                                            WavyAnimatedText(
                                              '...',
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                          isRepeatingAnimation: true,
                                          onTap: () {
                                            print("Tap Event");
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: logoDarkBlue,
                                ),
                                child: Center(
                                  child: Text(
                                    "View Arrears",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: fontWeight700),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              child: CustomCategory(
                                ontap: () {
                                  onActivityLogDevice(
                                    userId: userId,
                                    description: "Policy",
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PolicyMemoScreen(),
                                      //  PolicyScreen(),
                                    ),
                                  );
                                },
                                title: AppLocalizations.of(context)!
                                        .translate('policy') ??
                                    'Policy & Memo',
                                icon: Icons.auto_stories,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            height: hightLines,
                            width: 1.4,
                            color: logoPink,
                          ),
                          Expanded(
                            child: Container(
                              // width: 100,
                              child: CustomCategory(
                                ontap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LMapScreen(),
                                    ),
                                  );
                                },
                                title: AppLocalizations.of(context)!
                                        .translate('lmap_data') ??
                                    'LMAP Data',
                                icon: Icons.real_estate_agent,
                                // svg: "assets/svg/location-med-2.svg",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1.4,
                      margin: EdgeInsets.only(left: 8, right: 8),
                      width: MediaQuery.of(context).size.width,
                      color: logoPink,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CustomCategory(
                              ontap: () {
                                onActivityLogDevice(
                                  userId: userId,
                                  description: "IRR",
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IRRScreen(),
                                  ),
                                );
                              },
                              title: AppLocalizations.of(context)!
                                  .translate('Irr'),
                              icon: Icons.calculate,
                            ),
                          ),
                          Container(
                            height: hightLines,
                            width: 1.4,
                            color: logoPink,
                          ),
                          Expanded(
                            child: CustomCategory(
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        //HomePage()
                                        LaonFollowUpScren(),
                                  ),
                                );
                              },
                              title: AppLocalizations.of(context)!
                                      .translate('loan_follow_up') ??
                                  'Loan Follow-Up',
                              icon: Icons.home_work,
                            ),
                          ),
                          Container(
                            height: hightLines,
                            width: 1.4,
                            color: logoPink,
                          ),
                          Expanded(
                            child: CustomCategory(
                              ontap: () {
                                onActivityLogDevice(
                                  userId: userId,
                                  description: "Loan Approval",
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ApprovalLists()),
                                );
                              },
                              title: AppLocalizations.of(context)!
                                      .translate('list_loan_approval') ??
                                  'Loan Approval',
                              icon: Icons.checklist,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isSelect == true
                ? Positioned.fill(
                    child: GestureDetector(
                      child: Center(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 2.0,
                            sigmaY: 2.0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelect = false;
                              });
                            },
                            child: Container(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            isSelect == true
                ? Positioned(
                    bottom: 30,
                    right: 20,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      height: 60,
                      width: 180,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                        color: logolightGreen,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              onActivityLogDevice(
                                userId: userId,
                                description: "Laon Registration",
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoanRegister(),
                                ),
                              );
                              setState(() {
                                isSelect = false;
                              });
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                      .translate('loans') ??
                                  'Loan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: fontWeight700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.white,
                          ),
                          GestureDetector(
                            onTap: () {
                              onActivityLogDevice(
                                userId: userId,
                                description: "Customer Registration",
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerRegister()),
                              );
                              setState(() {
                                isSelect = false;
                              });
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                      .translate('customers') ??
                                  'Customer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: fontWeight700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 10),
          height: 90,
          color: logolightGreen,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MemoPolicyScreen()),
                  );
                },
                child: SvgPicture.asset(
                  'assets/svg/home.svg',
                  height: 40,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      isSelect = !isSelect!;
                      // debugPrint("===> $isSelect");
                    },
                  );
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: logolightGreen,
                    shape: BoxShape.circle,
                    //border: Border.all(width: 1, color: Colors.grey),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(0, 1),
                        color: Color.fromARGB(255, 112, 110, 110),
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/plus.svg',
                    height: 40,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpcomingFeaturesScreen(),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  'assets/svg/star.svg',
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onInsertArrear(List<ArrearModelNew> arrList) async {
    arrList.map((e) async {
      await sqliteHelper!.runQuery('''INSERT INTO ParArrearDetail(
        overdueDays, 
        customerName,
        cellPhoneNo, 
        totalAmount1,
        paymentApplyDate, 
        employeeName, 
        loanAmount, 
        loanPeriodMonthlyCount,
        branchLocalName, 
        refereneceEmployeeNo, 
        currencyCode,
        postalAddress,
        overdueInterest, 
        repayPrincipal, 
        collateralMaintenanceFee, 
        repayInterest, 
        loanAccountNo,
        villageName, 
        communeName,
        districtName1,
        provinceName, 
        customerNo, 
        loanBranchCode, 
        branchName) VALUES (
        "${e.overdueDays}",
        "${e.customerName}", 
       "${e.cellPhoneNo}", 
        ${e.totalAmount1}, 
       "${e.paymentApplyDate}", 
        "${e.employeeName}", 
        ${e.loanAmount}, 
        ${e.loanPeriodMonthlyCount},
        "${e.branchLocalName}", 
        "${e.refereneceEmployeeNo}",
       "${e.currencyCode}", 
        "${e.postalAddress}", 
        ${e.overdueInterest}, 
        ${e.repayPrincipal}, 
        ${e.collateralMaintenanceFee}, 
        ${e.repayInterest}, 
        "${e.loanAccountNo}",
        "${e.villageName}",
        "${e.communeName}", 
        "${e.districtName1}", 
        "${e.provinceName}", 
        "${e.customerNo}", 
        "${e.loanBranchCode}", 
        "${e.branchName}")''');
    }).toList();
  }
}
