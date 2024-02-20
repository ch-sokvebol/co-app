import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfo {
  static Future<String> getInfoDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return (androidDeviceInfo.device);
      // debugPrint('IOS+++:${info.device}');
    } else if (Platform.isIOS) {
      final iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
      final name = iosDeviceInfo.name;
      final deviceName = '$name';
      // debugPrint('okkkkkk:$deviceName');
      return deviceName;
      // debugPrint('android+++:${info.name}');
    } else if (Platform.isMacOS) {
      final macOsDeviceInfo = await deviceInfo.macOsInfo;
      // debugPrint('android+++:${info.model}');
      return macOsDeviceInfo.model;
    }

    final info = await deviceInfo.deviceInfo;
    debugPrint("test:$info");
    return '';
  }
}
