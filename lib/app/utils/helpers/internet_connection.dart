import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnenctivityApp extends GetxController {
  StreamSubscription? connection;
  final isoffline = false.obs;
  final getUserId = 0.obs;
  final userName = ''.obs;

  var userType = ''.obs;
  var brandCode = ''.obs;
  var employeeCode = ''.obs;
  var overDueDay = 0.0.obs;
  var bastDate = ''.obs;
  var currency = ''.obs;
  var totalAmount = 0.0.obs;

  Future<void> onConnetion() async {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        // setState(() {
        isoffline.value = true;

        // });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        // setState(() {
        isoffline.value = false;

        // });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        // setState(() {
        isoffline.value = false;

        // });
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        // setState(() {
        isoffline.value = false;

        // });
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        // setState(() {
        isoffline.value = false;

        // });
      }
    });
    debugPrint('from controller: ${isoffline}');
  }

  //
  Future<void> onConnection() async {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      debugPrint('ofline=okkk: $isoffline');
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection

        isoffline.value = true;

        debugPrint('ofline.non:$isoffline');
        debugPrint('ofline.non:${getUserId.value}');
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network

        isoffline.value = false;

        debugPrint('ofline.mobile:$isoffline');
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi

        isoffline.value = false;

        debugPrint('ofline.wifi:$isoffline');
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection

        isoffline.value = false;
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening

        isoffline..value = false;
      }
    });
  }
}
