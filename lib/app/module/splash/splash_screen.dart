import 'package:chokchey_finance/app/module/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_new/screen/new_homescreen.dart';
import '../../../utils/storages/const.dart';
import '../../utils/helpers/activity_log.dart';
import '../log/screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final token = LocalStorage.getStringValue(key: 'token');
  final con = Get.put(LoginController());

  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () async {
        final userId = await storage.read(key: 'user_id');
        var token = await storage.read(key: 'user_token');
        if (token == '' || token == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  // Login()
                  LoginScreenNew(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NewHomeScreen(),
              // Home(),
            ),
          );
          onActivityLogDevice(userId: '$userId', description: 'Home Screen');
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Image.asset('assets/images/chokchey-logo.png'),
      ),
    );
  }
}
