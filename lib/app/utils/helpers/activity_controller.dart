import 'dart:convert';

import 'package:chokchey_finance/app/utils/helpers/check_deveice.dart';
import 'package:chokchey_finance/app/utils/helpers/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ActivityLogController extends GetxController {
  Future<void> onActivilog() async {
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // deviceInfo = await DeviceInfo().getDeviceInfo();
    // if (Platform.isIOS) {
    //   IosDeviceInfo info = await deviceInfo.iosInfo;
    // } else if (Platform.isAndroid) {
    //   AndroidDeviceInfo info = await deviceInfo.androidInfo;
    // }
    String url = 'http://localhost:4000/api/activitylog/activity';
    debugPrint('okkkk=========>111:');
    try {
      String device = await DeviceInfo.getInfoDevice().then((res) {
        // device = res;

        return res;
      });
      LocalStorage.storeData(value: '$device', key: 'deviceName');
      final storeDevice = await LocalStorage.getStringValue(key: 'deviceName');
      debugPrint('storeDevice:${storeDevice}');
      var body = json.encode(
          {"user_id": "2", "description": "testt22", "device_name": 'test'});
      debugPrint('okkkk=========>222:$device');

      await http
          .post(Uri.parse(url),
              headers: {'content-type': 'application/json'}, body: body)
          .then((res) {
        debugPrint('okkkk=========>333:');
        if (res.statusCode == 200) {
          debugPrint('okkkk=========>:${res.body}');
        } else {
          debugPrint('error=========>111:${res.body}');
          debugPrint('error status=========>2222:${res.statusCode}');
        }
      });
    } finally {}
  }
}
