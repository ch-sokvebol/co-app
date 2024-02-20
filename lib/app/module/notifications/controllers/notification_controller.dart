import 'dart:convert';

import 'package:chokchey_finance/app/module/notifications/models/all_notifi_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../../providers/manageService.dart';
import '../../../../utils/storages/const.dart';
import 'package:http/http.dart' as http;

import '../models/arr_noti_model.dart';

class NotificationController extends GetxController {
  final isloadingAllNoti = false.obs;
  final allnotiModel = AllNotificationModel().obs;
  final allnotiList = <AllNotificationModel>[].obs;
  // List listMessage= <ListMessages>[].obs;

  final totalMessage = 0.obs;
  final totalRead = 0.obs;
  final totalUnread = 0.obs;

  Future<List<AllNotificationModel>> getAllnotification(
      {int? pageSize, int? pageNumber}) async {
    isloadingAllNoti.value = true;
    var token = await storage.read(key: 'user_token');
    var userUcode = await storage.read(key: "user_ucode");

    final url = Uri.parse(baseURLInternal + "messages/byuser");
    // final url = Uri.parse('https://localhost:5001/api/messages/byuser');
    final header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    final body = {
      "pageSize": "$pageSize",
      "pageNumber": "$pageNumber",
      "ucode": "$userUcode",
    };
    var res = await http.post(url, headers: header, body: json.encode(body));
    try {
      if (res.statusCode == 200) {
        var resJson = json.decode(res.body);
        // debugPrint('heloooo++++++:${allnotiModel.value.listMessages!.length}');

        allnotiList.clear();
        resJson.map((e) {
          allnotiModel.value = AllNotificationModel.fromJson(e);
          allnotiList.add(allnotiModel.value);
          totalMessage.value = e['totalMessage'];
          totalRead.value = e['totalRead'];
          totalUnread.value = e['totalUnread'];
        }).toList();
      } else {}
    } catch (e) {
      isloadingAllNoti.value = false;
    } finally {
      isloadingAllNoti.value = false;
    }
    return allnotiList;
  }

  final isLoandingReadNoti = false.obs;
  final getKey = ''.obs;
  Future<void> onReadnotification(String messageId) async {
    isLoandingReadNoti.value = true;
    var token = await storage.read(key: 'user_token');
    final url = Uri.parse(baseURLInternal + 'messages/read/$messageId');
    final header = {
      "contentType": "application/json",
      "Authorization": "Bearer $token"
    };
    try {
      final res = await http.post(url, headers: header);
      if (res.statusCode == 200) {
        var resJson = json.decode(res.body);
        getKey.value = resJson['key'];
      } else {}
    } catch (e) {
      isLoandingReadNoti.value = false;
    } finally {
      isLoandingReadNoti.value = false;
    }
  }

  final isLoadingArrNoti = false.obs;
  final arrNotiModel = ArrearNotiModel().obs;
  final arrNotiList = <ArrearNotiModel>[].obs;
  Future<List<ArrearNotiModel>> getArrNoti(String empCode) async {
    isLoadingArrNoti.value = true;
    // var token = await storage.read(key: 'user_token');
    final url =
        Uri.parse(baseURLInternal + "ArrNotifi/get_msg_collection/$empCode");
    // final url = Uri.parse(
    //     'https://localhost:5001/api/ArrNotifi/get_msg_collection/$empCode');
    final header = {
      "Content-Type": "application/json"
      // "Authorization": "Bearer $token"
    };
    try {
      await http
          .get(
        url,
        headers: header,
      )
          .then((res) {
        if (res.statusCode == 200) {
          var resJson = json.decode(res.body);
          debugPrint("helooo:$resJson");
          arrNotiList.clear();
          resJson.map((e) {
            arrNotiModel.value = ArrearNotiModel.fromJson(e);
            arrNotiList.add(arrNotiModel.value);
          }).toList();
        }
      });
    } catch (e) {
      isLoadingArrNoti.value = false;
    } finally {
      isLoadingArrNoti.value = false;
    }
    return arrNotiList;
  }

  final notiArrDetail = ArrearNotiModel().obs;
  final notiArrDetailList = <ArrearNotiModel>[].obs;
  final isLoadingNotiDetail = false.obs;
  final customerName = ''.obs;
  final message = RemoteMessage;
  Future<List<ArrearNotiModel>> getNotiDetail(int? id) async {
    try {
      isLoadingNotiDetail.value = true;
      final url =
          Uri.parse(baseURLInternal + 'ArrNotifi/msg_colletion_detail/$id');
      // Uri.parse(
      //     'https://localhost:5001/api/ArrNotifi/msg_colletion_detail/$id');
      final header = {"Content-Type": "application/json"};
      await http.get(url, headers: header).then((res) {
        if (res.statusCode == 200) {
          var resJson = json.decode(res.body);
          debugPrint("ok==========:$resJson");
          // customerName.value = resJson['customerName'];

          notiArrDetailList.clear();

          resJson.map((e) {
            notiArrDetail.value = ArrearNotiModel.fromJson(resJson);
            notiArrDetailList.add(notiArrDetail.value);
          }).toList();
          // message.['customerName'] = resJson['customerName'];
        } else {
          // debugPrint('He;ooo===:${res.body}');
          // debugPrint('He;ooo===:${res.statusCode}');
        }
      });
    } catch (e) {
    } finally {
      isLoadingNotiDetail.value = false;
    }
    return notiArrDetailList;
  }

  // final amount = 0.0.obs;
  // final customerName = ''.obs;
  // final coName = ''.obs;
  // final loanAccNo = ''.obs;
  // final date = ''.obs;
  // final branchCode = ''.obs;

  final isLoadingMsgCo = false.obs;
  Future<void> onReadMsgCollection(int id) async {
    isLoadingMsgCo.value = true;
    try {
      final url = Uri.parse(baseURLInternal + "ArrNotifi/read_msg/$id");
      // final url =
      //     Uri.parse("https://localhost:5001/api/ArrNotifi/read_msg/$id");
      final header = {"Content-Type": "application/json"};
      await http.post(url, headers: header);
      // if (res.statusCode == 200) {
      // }
    } catch (e) {}
  }

  Future<void> showNotification(v, flp) async {
    var android = AndroidNotificationDetails(
        'high_importance_chnnel', 'High Importance Notifications',
        priority: Priority.high, importance: Importance.max);
    var iOS = DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flp.show(0, 'Virtual intelligent solution', '$v', platform,
        payload: 'VIS \n $v');
  }

  @override
  void onInit() {
    // getNotiDetail(13292);
    super.onInit();
  }
}
