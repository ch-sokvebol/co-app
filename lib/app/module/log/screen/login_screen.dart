import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chokchey_finance/app/module/log/controller/log_controller.dart';
import 'package:chokchey_finance/app/module/util/widget/custom_textfield.dart';
import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/app/utils/helpers/local_database.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../localizations/appLocalizations.dart';
import '../../../../providers/login.dart';
import '../../../../providers/manageService.dart';
import '../../home_new/screen/new_homescreen.dart';
import '../../../../screens/login/stepTwoLogin.dart';
import '../../../../utils/storages/colors.dart';
import '../../../utils/helpers/activity_log.dart';
import '../../../utils/helpers/internet_connection.dart';
import '../../../utils/helpers/sqlite_helper.dart';
import '../../loan_arrear/controllers/loan_arrear_controller.dart';

class UserInfoLocalModel {
  String userID;
  String userName;

  UserInfoLocalModel(this.userID, this.userName);
}

class LoginScreenNew extends StatefulWidget {
  const LoginScreenNew({super.key});

  @override
  State<LoginScreenNew> createState() => _LoginScreenNewState();
}

class _LoginScreenNewState extends State<LoginScreenNew> {
  final storage = new FlutterSecureStorage();

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final TextEditingController id = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstLogin = TextEditingController();

  var chokchey;
  //bool _firstLogIn = false;
  bool isLoading = false;
  bool autofocus = false;
  final focusPassword = FocusNode();
  final focusFirstLogin = FocusNode();
  final controllerLog = Get.put(LogController());
  final controller = Get.put(ConnenctivityApp());
  final con = Get.put(LoanArrearController());
  bool isvalidateId = false;
  bool isvalidatePassword = false;
  Future<void> getStore() async {
    String? ids = await storage.read(key: 'user_id');
    String? passwords = await storage.read(key: 'password');
    if (mounted) {
      setState(
        () {
          id.text = '$ids';
          password.text = '$passwords';
        },
      );
    }
  }

  // var _login;
  var _roles;

  final GlobalKey<ScaffoldState> _scaffoldKeySignUp =
      new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value, colorsBackground) {
    SnackBar snackBar = SnackBar(
      content: Text(value),
      backgroundColor: colorsBackground,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // Activity Log //
  }

  saveUserInfoLocal(UserInfoLocalModel userInfo) {
    final sqlStatement =
        'INSERT INTO Login (userId, uname) VALUES ("${userInfo.userID}", "${userInfo.userName}")';
    sqlhelper!.insertData(sql: sqlStatement);
    controller.userName.value = userInfo.userName;

    debugPrint('info name1111 : ${controller.userName.value}');
  }

  onClickLogin(context) async {
    final String userId = id.text;
    final String valuePassword = password.text;
    onActivityLogDevice(userId: id.text, description: "User Login Success");
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<LoginProvider>(context, listen: false)
          .fetchLogin(userId, valuePassword)
          .then((value) async => {
                if (isoffline == true)
                  {
                    showInSnackBar('You have no internet!', Colors.red),
                    onActivityLogDevice(
                        userId: id.text,
                        description: "Your internet have no connected"),
                    debugPrint("Invalid User ID and Password!1"),
                    isLoading = false
                  }
                else if (value[0]['token'] != null)
                  {
                    saveUserInfoLocal(
                        UserInfoLocalModel(value[0]['uid'], value[0]['uname'])),
                    LocalDatabase.instance.insertUser({
                      'userID': value[0]['uid'],
                      'userName': value[0]['uname']
                    }),
                    showInSnackBar('Successful', logolightGreen),
                    await storage.write(
                        key: "user_ucode", value: value[0]['ucode']),
                    await storage.write(
                        key: "user_token", value: value[0]['token']),
                    await storage.write(
                        key: "branch", value: value[0]['branch']),
                    await storage.write(
                        key: "level", value: value[0]['level'].toString()),
                    await storage.write(
                        key: "isapprover",
                        value: value[0]['isapprover'].toString()),
                    await storage.write(
                        key: "roles", value: value[0]['roles'].toString()),
                    await storage.write(
                        key: "user_type", value: value[0]['userType']),
                    setState(() {
                      isLoading = false;
                    }),
                    if (value[0]['roles'] != null)
                      {
                        _roles = value[0]['roles'],
                        await storage.write(
                            key: "roles", value: _roles.toString()),
                      },
                    if (value[0]['token'] != null &&
                        (value[0]['changePassword'] == null ||
                            value[0]['changePassword'] == 'N'))
                      {
                        // user need to change password
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StepTwoLogin(
                                  storeUser: value,
                                  valuePassword: valuePassword)),
                        )
                      }
                    else
                      {
                        await storage.write(
                            key: "user_id", value: value[0]['uid']),
                        await storage.write(
                            key: "password", value: valuePassword),
                        await storage.write(
                            key: "user_token", value: value[0]['token']),
                        await storage.write(
                            key: "user_name", value: value[0]['uname']),
                        await storage.write(
                            key: "user_ucode", value: value[0]['ucode']),
                        await storage.write(
                            key: "branch", value: value[0]['branch']),
                        await storage.write(
                            key: "level", value: value[0]['level'].toString()),
                        await storage.write(
                            key: "isapprover",
                            value: value[0]['isapprover'].toString()),
                        await storage.write(
                            key: "user_type", value: value[0]['userType']),
                        await FirebaseMessaging.instance
                            .getToken()
                            .then((String? token) {
                          if (token == null) {
                            debugPrint('no token=======>:$token');
                          } else {}

                          assert(token != null);
                          postTokenPushNotification(token);
                        }).onError((error, stackTrace) {
                          debugPrint("onErrorrr -----> $error");
                          //logger().e("error: $error");
                          // logger().e("stackTrace: $stackTrace");
                        }).catchError((onError) {
                          debugPrint("catchError -----> $onError");
                          // logger().e("onError: $onError");
                        }),
                        debugPrint("name12345"),
                        // already change password
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewHomeScreen()),
                          // Home()),
                        ),
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Home()),
                        //   ModalRoute.withName("/login"),
                        // )
                      },
                  }
                else
                  {
                    isvalidateId = true,
                    isvalidatePassword = true,
                    showInSnackBar(
                        '${AppLocalizations.of(context)!.translate('invalid_login')}',
                        Colors.red),
                    onActivityLogDevice(
                        userId: id.text,
                        description: "Invalid User ID and Password!"),
                    debugPrint("Invalid User ID and Password!1"),
                  },
                con.userType = value[0]['userType'],
              })
          .catchError(
        (e) {
          setState(() {
            isLoading = false;
          });
          isvalidateId = true;
          isvalidatePassword = true;
          showInSnackBar(
              '${AppLocalizations.of(context)!.translate('invalid_login')}',
              Colors.red);
          onActivityLogDevice(
              userId: id.text, description: "Invalid User ID and Password!");
          debugPrint("Invalid User ID and Password!2");
          return e;
        },
      );
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  postTokenPushNotification(tokens) async {
    var token = await storage.read(key: 'user_token');
    var userUcode = await storage.read(key: "user_ucode");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    final Map<String, dynamic> bodyRow = {"mtoken": "$tokens"};
    try {
      http.post(
          Uri.parse(baseURLInternal + 'users/' + '$userUcode' + '/mtoken'),
          headers: headers,
          body: json.encode(bodyRow));
    } catch (error) {
      print('error:: $error');
    }
  }

  Future<void> onDeviceToken(String userCode) async {
    // var userUcode = await storage.read(key: "user_ucode");
    var deviceId = await FirebaseMessaging.instance.getToken();
    final headers = {
      "Content-Type": "application/json",
    };
    final bodyRow =
        json.encode({"userCode": "$userCode", "deviceId": deviceId});
    try {
      await http.post(Uri.parse(baseURLInternal + 'Users/get_deviceId'),
          headers: headers, body: bodyRow);
      // if (res.statusCode == 200) {
      //   debugPrint("get device id===:$deviceId");
      //   debugPrint('heiii_____:${res.body}');
      // } else {
      //   debugPrint('errorrr______:${res.statusCode}');
      // }
    } catch (error) {
      print('error:: $error');
    }
  }

  Future<bool> onPop() async {
    return true;
  }

// Login from sqlite function

  SqliteHelper? sqlhelper;
  StreamSubscription? connection;
  bool isoffline = false;
  @override
  void initState() {
    controllerLog.onConnection();
    sqlhelper = SqliteHelper();
    // controller.onConnetion();
/////////////// internet connetion
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      debugPrint('no connexttion : $isoffline');
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
        debugPrint('no connexttion true : $isoffline');
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(
          () {
            isoffline = false;
          },
        );
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        setState(
          () {
            isoffline = false;
          },
        );
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        setState(
          () {
            isoffline = false;
          },
        );
      }
    });

    super.initState();
  }

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

  var userId;
  var userPassword;
  var userNames;
  final _formKey = GlobalKey<FormState>();

  String? passWord = '';
  Focus? focus;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKeySignUp,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  child: Image.asset('assets/images/chokchey-logo.png'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: CustomTextFieldNew(
                      onFieldSubmitted: (e) {
                        if (e.length == 6) {
                          FocusScope.of(context).unfocus();
                          FocusScope.of(context).requestFocus(focusPassword);
                        }
                      },
                      labelText:
                          AppLocalizations.of(context)!.translate('user_id'),
                      hintText:
                          AppLocalizations.of(context)!.translate('user_id'),
                      controller: id,
                      // labelText: 'User ID',
                      onChange: (q) {
                        if (q.length == 6) {
                          FocusScope.of(context).requestFocus(focusPassword);
                        }
                        // debugPrint('ooi: ${q.length}');
                      }),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: CustomTextFieldNew(
                    labelText:
                        AppLocalizations.of(context)!.translate("password"),
                    obscureText: true,
                    hintText:
                        AppLocalizations.of(context)!.translate("password"),
                    controller: password,
                    // labelText: 'Password',
                    focusNode: focusPassword,
                    // suffixIcon: contro.passwordText.text != ''
                    //     ? IconButton(
                    //         onPressed: () {
                    //           isSelected = !isSelected;
                    //           contro.update();
                    //           // con.refresh();
                    //         },
                    //         icon: isSelected == true
                    //             ? Icon(Icons.visibility)
                    //             : Icon(Icons.visibility_off))
                    //     : null,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: isLoading == true
                      ? null
                      : () async {
                          ////////// sqlite store local
                          // debugPrint("login app");
                          // debugPrint(
                          //     "is connextion :${controllerLog.isoffline.value}");
                          // final nameLocal = await storage.read(key: 'userId');
                          // debugPrint('name+++++: $nameLocal');
                          // if (controllerLog.isoffline.value == true) {
                          //   debugPrint("offline login123456");
                          //   sqlhelper!.insertData(
                          //       sql:
                          //           'INSERT INTO Login (userId, password,uname) VALUES ("${id.text}","${password.text}","${controller.userName.value}")');
                          //   await sqlhelper!.queryData(
                          //       sql:
                          //           'Select * from Login where userId = ${id.text}');
                          //   sqlhelper!.resQuery.map((e) {
                          //     userId = e['userId'];
                          //     userPassword = e['password'];
                          //     userNames = e['uname'];
                          //     controller.getUserId.value = userId;
                          //     controllerLog.userName.value = userNames;
                          //     debugPrint(
                          //         "offline login name: ${controllerLog.userName.value}");
                          //     debugPrint(
                          //         "offline login ${controller.getUserId.value}");
                          //   }).toList();

                          //   if (id.text.toString() == userId.toString()) {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => NewHomeScreen()
                          //           // Home(),
                          //           ),
                          //     );
                          //   } else {
                          //     isvalidateId = true;
                          //     isvalidatePassword = true;
                          //     showInSnackBar('Invalid User', Colors.red);
                          //   }
                          // } else {
                          await onClickLogin(context);
                          await onDeviceToken(id.text);

                          // debugPrint('user typ-fff-----> ${con.userType}');
                          // //  insert user login in sqlite
                          // sqlhelper!.insertData(
                          //     sql:
                          //         'INSERT INTO Login (userId, password, uname) VALUES ("${id.text}","${password.text}","${controller.userName.value}")');

                          // debugPrint('flutter123----------------------');
                          // }
                        },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.logoDarkBlue,
                    ),
                    child: isLoading == true
                        ? SpinKitThreeBounce(
                            color: Colors.white70,
                            size: 25,
                          )
                        : Text(
                            //  "Login",
                            "${AppLocalizations.of(context)!.translate('log_in')}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // Text(
                //   "${AppLocalizations.of(context)!.translate("forget_password")}",
                //   style: TextStyle(
                //     color: Color.fromARGB(255, 30, 120, 194),
                //     fontSize: 14,
                //     fontWeight: FontWeight.w500,
                //     decoration: TextDecoration.underline,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
