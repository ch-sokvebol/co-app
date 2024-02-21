import 'dart:convert';
import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/app/utils/helpers/internet_connection.dart';
import 'package:chokchey_finance/components/maxWidthWrapper.dart';
import 'package:chokchey_finance/providers/manageService.dart';
import 'package:chokchey_finance/screens/login/defaultLogin.dart';
import 'package:chokchey_finance/screens/login/stepTwoLogin.dart';
import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:chokchey_finance/utils/storages/const.dart';
import 'package:chokchey_finance/providers/login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:provider/provider.dart';
import '../../app/utils/helpers/activity_log.dart';
import '../../app/utils/helpers/sqlite_helper.dart';
import '../../app/module/home_new/screen/new_homescreen.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final storage = new FlutterSecureStorage();

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final TextEditingController id = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstLogin = TextEditingController();

  var chokchey;
  //bool _firstLogIn = false;
  bool _isLoading = false;
  bool autofocus = false;
  final focusPassword = FocusNode();
  final focusFirstLogin = FocusNode();

  Future<void> getStore() async {
    String? ids = await storage.read(key: 'user_id');
    String? passwords = await storage.read(key: 'password');
    if (mounted) {
      setState(() {
        id.text = '$ids';
        password.text = '$passwords';
      });
    }
  }

  ///////on login from sqlLite
  onLoginSqlLite() async {
    var res = await sqlhelper!
        .queryData(sql: 'Select * from Login where userId="${id.text}"');
    var sql = await sqlhelper!.queryData(sql: 'Select * from Login');
    debugPrint('ppp:$sql');
    res.map((e) {
      userId = e['userId'];
      debugPrint('ttt:$e');
    }).toList();
    if (id.text.toString() != userId.toString()) {
      sqlhelper!.insertData(
          sql:
              'INSERT INTO Login (userId, password) VALUES ("${id.text}","${password.text}")');
      debugPrint('No have User and insert in sqlite++:$userId');
    } else {
      await sqlhelper!
          .queryData(sql: 'Select * from Login where userId = "${id.text}"');

      debugPrint('have User in sqlite++::$userId');
    }
    // var uId = res[int.parse(userId)];
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

  final controller = Get.put(ConnenctivityApp());
// Create storage Login
  onClickLogin(context) async {
    final String userId = id.text;
    final String valuePassword = password.text;
    // onActivityLogDevice(userId: id.text, description: "User Login Successee");
    setState(() {
      _isLoading = true;
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
                    debugPrint("Invalid User and Password!1"),
                    _isLoading = false
                  }
                else if (value[0]['token'] != null)
                  {
                    showInSnackBar('Welcome!', logolightGreen),
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
                    setState(() {
                      _isLoading = false;
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
                        await FirebaseMessaging.instance
                            .getToken()
                            .then((String? token) {
                          if (token == null) {
                          } else {}

                          assert(token != null);
                          postTokenPushNotification(token);
                        }).onError((error, stackTrace) {
                          logger().e("error: $error");
                          logger().e("stackTrace: $stackTrace");
                        }).catchError((onError) {
                          logger().e("onError: $onError");
                        }),

                        // already change password
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewHomeScreen()
                              // Home(),
                              ),
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
                    showInSnackBar('Invalid User and Password!', Colors.red),
                    // onActivityLogDevice(
                    //     userId: id.text,
                    //     description: "Invalid User and Password!"),
                    // debugPrint("Invalid User and Password!1"),
                  }
              })
          .catchError(
        (e) {
          setState(() {
            _isLoading = false;
          });

          showInSnackBar('Invalid User and Password!', Colors.red);
          // onActivityLogDevice(
          //     userId: id.text, description: "Invalid User and Password!");
          debugPrint("Invalid User and Password!2");
          return e;
        },
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
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

  Future<bool> onPop() async {
    return true;
  }

  /////////// Login from sqlite function

  SqliteHelper? sqlhelper;
  StreamSubscription? connection;
  bool isoffline = false;
  @override
  void initState() {
    sqlhelper = SqliteHelper();
    // controller.onConnetion();
/////////////// internet connetion
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
        });
      }
    });
    super.initState();
  }

  var userId;
  var userPassword;
  final _formKey = GlobalKey<FormState>();
// Form(key: _formKey)
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onPop,
      child: Scaffold(
        key: _scaffoldKeySignUp,
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: MaxWidthWrapper(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      width: 220.0,
                      height: 220.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(42.0),
                        image: DecorationImage(
                          image: AssetImage('assets/images/chokchey-logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    DefaultLogin(
                      onFieldSubmittedUser: (text) {
                        if (text.length == 6) {
                          FocusScope.of(context).unfocus();
                          FocusScope.of(context).requestFocus(focusPassword);
                        }
                      },
                      // hintTextUser: id.text,
                      controllerUser: id,
                      onChangedUser: (text) {
                        if (text.length == 6) {
                          FocusScope.of(context).requestFocus(focusPassword);
                        }
                      },
                      controllerPassword: password,
                      focusNodePassword: focusPassword,
                      //hintTextPassword: password.text,
                      onChangedPassword: (v) {
                        debugPrint(v);
                      },

                      onFieldSubmittedPassword: (text) async {
                        await onClickLogin(context);
                        setState(() {
                          autofocus = true;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (isoffline == true) {
                          sqlhelper!.insertData(
                              sql:
                                  'INSERT INTO Login (userId, password) VALUES ("${id.text}","${password.text}")');
                          await sqlhelper!.queryData(
                              sql:
                                  'Select * from Login where userId = ${id.text}');
                          sqlhelper!.resQuery.map((e) {
                            userId = e['userId'];
                            userPassword = e['password'];
                            controller.getUserId.value = userId;
                            debugPrint(
                                'wwwwwwwwww:${controller.getUserId.value}');
                          }).toList();

                          debugPrint('dataaaa:${id.text}');
                          if (id.text.toString() == userId.toString()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewHomeScreen(),
                                // Home(),
                              ),
                            );
                          } else {
                            showInSnackBar('Invalid User', Colors.red);
                          }
                        } else {
                          await onClickLogin(context);
                          ////// insert or get user login in sqlite
                          // onLoginSqlLite();
                          sqlhelper!.insertData(
                              sql:
                                  'INSERT INTO Login (userId, password) VALUES ("${id.text}","${password.text}")');
                          ////////
                        }
                      },
                      child: Container(
                          width: 320,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.logolightGreen),
                          margin: EdgeInsets.only(top: 40, bottom: 20),
                          child: _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: logolightGreen,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontFamily: 'roboto_regular',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ))
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //       backgroundColor: logolightGreen,
                          //       padding: const EdgeInsets.all(8.0),
                          //       textStyle: TextStyle(color: Colors.white)),
                          //   onPressed: () async {
                          //     await onClickLogin(context);
                          //   },
                          //   child: _isLoading
                          //       ? Center(
                          //           child: CircularProgressIndicator(),
                          //         )
                          //       : Text(
                          //           "Login",
                          //         ),
                          // ),
                          ),
                    ),
                    // Text(
                    //   'Forgot passwrod',
                    //   style: TextStyle(
                    //     fontFamily: 'Segoe UI',
                    //     fontSize: 12,
                    //     color: const Color(0xff39a5ef),
                    //     fontWeight: FontWeight.w700,
                    //     decoration: TextDecoration.underline,
                    //   ),
                    //   textAlign: TextAlign.left,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
