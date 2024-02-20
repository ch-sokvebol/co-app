import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'check_deveice.dart';

Future<void> onActivityLogDevice({
  String? userId,
  String? description,
}) async {
  String url = dotenv.get('urlInternal');
  String device = await DeviceInfo.getInfoDevice().then((res) {
    // device = res;
    return res;
  });

  try {
    var body = json.encode(
        {"user_id": userId, "description": description, "device_name": device});

    await http
        .post(Uri.parse('${url}activitylog'),
            headers: {'content-type': 'application/json'}, body: body)
        .then((res) {
      if (res.statusCode == 200) {
        // debugPrint("======Activity Log 200==== $userId");
        // debugPrint("======Activity Log 200==== $description");
        // debugPrint("======Activity Log 200==== $device");
      } else {
        // debugPrint("======Error Activity Log======");
        // debugPrint("======Error Activity Log ${res.statusCode}");
      }
    });
  } catch (e) {
    debugPrint("======Error catch======= ${e.toString()}");
  } finally {}
}
