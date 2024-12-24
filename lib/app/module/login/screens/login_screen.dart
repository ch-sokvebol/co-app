import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chokchey_finance/app/module/login/controllers/login_controller.dart';
import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../localizations/appLocalizations.dart';
import '../../../../utils/storages/colors.dart';
import '../../util/widget/custom_textfield.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final focusPassword = FocusNode();

  final bool obscureText = true;

  bool isSelected = false;
  final con = Get.put(LoginController());
  final GlobalKey<ScaffoldState> _scaffoldKeySignUp =
      new GlobalKey<ScaffoldState>();

  Future<bool> _onBackPressed() async {
    AwesomeDialog(
        context: context,
        // animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.info,
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKeySignUp,
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: Image.asset('assets/images/chokchey-logo.png'),
              ),
              SizedBox(
                height: 20,
              ),
              GetBuilder<LoginController>(
                init: LoginController(),
                initState: (state) async {
                  await state.controller;
                },
                builder: (contro) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: CustomTextFieldNew(
                            onFieldSubmitted: (e) {
                              if (e.length == 6) {
                                FocusScope.of(context).unfocus();
                                FocusScope.of(context)
                                    .requestFocus(focusPassword);
                              }
                            },
                            hintText: AppLocalizations.of(context)!
                                .translate('user_id'),
                            controller: contro.idText,
                            labelText: AppLocalizations.of(context)!
                                .translate('user_id'),
                            maxLine: 6,
                            onChange: (q) {
                              if (q.length == 6) {
                                FocusScope.of(context)
                                    .requestFocus(focusPassword);
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: CustomTextFieldNew(
                          obscureText: true,
                          hintText: AppLocalizations.of(context)!
                              .translate("password"),
                          controller: contro.passwordText,
                          labelText: AppLocalizations.of(context)!
                              .translate("password"),
                          focusNode: focusPassword,
                        ),
                      ),
                    ],
                  );
                },
              ),
              Spacer(),
              GetBuilder<LoginController>(
                  init: LoginController(),
                  builder: (loginCon) {
                    return GestureDetector(
                      onTap: () {
                        loginCon.onLogin(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        margin: EdgeInsets.only(
                            top: 50, left: 20, right: 20, bottom: 30),
                        decoration: BoxDecoration(
                            color: AppColors.logolightGreen,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                              "${AppLocalizations.of(context)!.translate('log_in')}"),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
