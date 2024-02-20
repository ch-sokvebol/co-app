import 'dart:convert';

import 'package:chokchey_finance/app/module/login/screens/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

import '../../home_new/screen/new_homescreen.dart';
import '../../../utils/helpers/local_storage.dart';

class LoginController extends GetxController {
  final isLoadingLogin = false.obs;
  final TextEditingController idText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();

  Future<void> onLogin(BuildContext context) async {
    // final token = await storage.read(key: 'token');
    isLoadingLogin(true);
    String url = dotenv.get('urlInternal');
    // var token = await storage.read(key: 'user_token');
    final _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    try {
      var body = json.encode({
        "uid": idText.text,
        "upassword": passwordText.text,
        "mtoken": fCMToken
      });
      await http
          .post(Uri.parse('${url}token'),
              headers: {'Content-Type': 'application/json'}, body: body)
          .then((res) {
        if (res.statusCode == 200) {
          var jsontoken = json.decode(res.body);
          var token = jsontoken[0]['token'];
          // jsontoken.map((e) {
          debugPrint('okkkk=$token');
          // }).toList();
          LocalStorage.storeData(key: 'token', value: '$token');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NewHomeScreen()
                  // Home()
                  ));

          // storage.write(key: 'token', value: jsontoken);
          update();
          refresh();
        } else {
          Get.snackbar('Login Failed', 'Please check a id or password again');
        }
      });
    } catch (e) {
      debugPrint("error $e");
    } finally {
      isLoadingLogin(false);
    }
  }

  onSignOut(BuildContext context) async {
    await LocalStorage.storeData(value: '', key: 'token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => LogInScreen()),
      ),
    );
  }
}
